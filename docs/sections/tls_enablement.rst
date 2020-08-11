.. This work is licensed under a Creative Commons Attribution 4.0 International License.
.. http://creativecommons.org/licenses/by/4.0

TLS Support
===========

To comply with ONAP security requirement, all services exposing external API required TLS support using AAF generated certificates. DCAE Platform was updated in R3 to enable certificate distribution mechanism for services needing TLS support. For R6, we have moved from generating certificates manually to retrieving certificates from AAF at deployment time.

Solution overview
-----------------
1. Certificate setup:

    AAF requires setting up certificate details in AAF manually before a certificate is generated.
    This step is currently done using a test AAF instance in POD25.
    Required namespace,  DCAE identity (dcae@dcae.onap.org), roles and Subject Alternative Names for all components are set in the test instance.
    We use a single certificate for all DCAE components, with a long list of Subject Alternative Names (SANs).

    Current SAN listing::

        bbs-event-processor, bbs-event-processor.onap, bbs-event-processor.onap.svc.cluster.local, config-binding-service, config-binding-service.onap, config-binding-service.onap.svc.cluster.local, dcae-cloudify-manager, dcae-cloudify-manager.onap, dcae-cloudify-manager.onap.svc.cluster.local, dcae-datafile-collector, dcae-datafile-collector.onap, dcae-datafile-collector.onap.svc.cluster.local, dcae-hv-ves-collector, dcae-hv-ves-collector.onap, dcae-hv-ves-collector.onap.svc.cluster.local, dcae-pm-mapper, dcae-pm-mapper.onap, dcae-pm-mapper.onap.svc.cluster.local, dcae-prh, dcae-prh.onap, dcae-prh.onap.svc.cluster.local, dcae-tca-analytics, dcae-tca-analytics.onap, dcae-tca-analytics.onap.svc.cluster.local, dcae-ves-collector, dcae-ves-collector.onap, dcae-ves-collector.onap.svc.cluster.local, deployment-handler, deployment-handler.onap, deployment-handler.onap.svc.cluster.local, holmes-engine-mgmt, holmes-engine-mgmt.onap, holmes-engine-mgmt.onap.svc.cluster.local, holmes-rule-mgmt, holmes-rules-mgmt.onap, holmes-rules-mgmt.onap.svc.cluster.local, inventory, inventory.onap, inventory.onap.svc.cluster.local, policy-handler, policy-handler.onap, policy-handler.onap.svc.cluster.local

2. Certificate generation and retrieval:

   When a DCAE component that needs a TLS certificate is launched, a Kubernetes init container runs before the main
   component container is launched.  The init container contacts the AAF certificate manager server.  The AAF certificate
   management server generates a certificate based on the information previously set up in step 1 above and sends the certificate
   (in several formats) along with keys and passwords to the init container.  The init container renames the files to conform to
   DCAE naming conventions and creates some additional formats.  It stores the results into a volume that's shared with
   the main component container.

   DCAE platform components are deployed via ONAP OOM.  The Helm chart for each deployment includes the init container
   and sets up the shared volume.

   DCAE service components (sometimes called "microservices") are deployed via Cloudify using blueprints.  This is described
   in more detail in the next section.

3. Plugin and Blueprint:
    The blueprint for a component that needs a TLS certificate needs to include the node property called "tls_info" in
    the node properties for the component. The property is a dictionary with two elements:

        * A boolean (``use_tls``) that indicates whether the component uses TLS.
        * A string (``cert_directory``) that indicates where the component expects to find certificate artifacts.

        Example

.. code-block:: yaml

        tls_info:
           cert_directory: '/opt/app/dh/etc/cert'
           use_tls: true

(Note that the ``cert_directory`` value does not include a trailing ``/``.)

For this example the certificates are mounted into ``/opt/app/dh/etc/cert`` directory within the container.

    During deployment Kubernetes plugin (referenced in blueprint) will check if the ``tls_info`` property is set and ``use_tls`` is set to true, then the plugin will add some elements to the Kubernetes Deployment for the component:
          * A Kubernetes volume (``tls-info``) that will hold the certificate artifacts
          * A Kubernetes initContainer (``tls-init``)
          * A Kubernetes volumeMount for the initContainer that mounts the ``tls-info`` volume at ``/opt/app/osaaf``.
          * A Kubernetes volumeMount for the main container that mounts the ``tls-info`` volume at the mount point specified in the ``cert_directory`` property.

Service components that act as HTTPS clients only need access to the root CA certificate used by AAF.  For R6, such
components should set up a tls_info property as described above.  See below for a note about an alternative approach
that is available in R6 but is not currently being used.

4. Certificate artifacts

    The certificate directory mounted on the container will include the following files:
        * ``cert.jks``: A Java keystore containing the DCAE certificate.
        * ``jks.pass``: A text file with a single line that contains the password for the ``cert.jks`` keystore.
        * ``trust.jks``: A Java truststore containing the AAF CA certificate.  (Needed by clients that access TLS-protected servers.)
        * ``trust.pass``: A text file with a single line that contains the password for the ``trust.jks`` keystore.
        * ``cert.p12``: The DCAE certificate and private key packaged in PKCS12 form.
        * ``p12.pass``: A text file with a single line that contains the password for ``cert.p12`` file.
        * ``cert.pem``: The DCAE certificate concatenated with the intermediate CA certficate from AAF, in PEM form.
        * ``key.pem``: The private key for the DCAE certificate. The key is not encrypted.
        * ``cacert.pem``: The AAF CA certificate, in PEM form.  (Needed by clients that access TLS-protected servers.)

5. Alternative for getting CA certificate only

    The certificates generated by AAF are signed by AAF, not by a recognized certificate authority (CA).  If a component acts
    as a client and makes an HTTPS request to another component, it will not be able to validate the other component's
    server certificate because it will not recognize the CA.  Most HTTPS client library software will raise an error
    and drop the connection.  To prevent this, the client component needs to have a copy of the AAF CA certificate.
    As noted in section 3 above, one way to do this is to set up the tls_info property as described in section 3 above.

    There are alternatives.  In R6, two versions of the DCAE k8splugin are available: version 1.7.2 and version 2.0.0.
    They behave differently with respect to setting up the CA certs.

    * k8splugin version 1.7.2 will automatically mount the CA certificate, in PEM format, at ``/opt/dcae/cacert/cacert.pem``.
      It is not necessary to add anything to the blueprint.  To get the CA certificate in PEM format in a different directory,
      add a  ``tls_info`` property to the blueprint, set ``use_tls`` to ``false``, and set ``cert_directory`` to the directory
      where the CA cert is needed.  For example:

      .. code-block:: yaml

            tls_info:
               cert_directory: '/opt/app/certs'
               use_tls: false

      For this example, the CA certificate would be mounted at ``/opt/app/certs/cacert.pem``.

      k8splugin version 1.7.2 uses a configmap, rather than an init container, to supply the CA certificate.

    * k8splugin version 2.0.0 will automatically mount the CA certificate, in PEM and JKS formats, in the directory ``/opt/dcae/cacert``.
      It is not necessary to add anything to the blueprint.  To get the CA certificates in a different directory, add a ``tls_info`` property to the blueprint, set ``use_tls`` to ``false``, and set ``cert_directory`` to the directory
      where the CA certs are needed.  Whatever directory is used, the following files will be available:

      * ``trust.jks``: A Java truststore containing the AAF CA certificate.  (Needed by clients that access TLS-protected servers.)
      * ``trust.pass``: A text file with a single line that contains the password for the ``trust.jks`` keystore.
      * ``cacert.pem``: The AAF CA certificate, in PEM form.  (Needed by clients that access TLS-protected servers.)

      k8splugin version 2.0.0 uses an init container to supply the CA certificates.

External TLS Support
--------------------

External TLS support was introduced in order to integrate DCAE with CertService to acquire operator certificates meant to protect external traffic between DCAE's components (VES collector, HV-VES, RestConf collector and DFC) and xNFs. For that reason K8s plugin which creates K8s resources from Cloudify blueprints was enhanced with new TLS properties support. New TLS properties are meant to control CertService's client call in init containers section and environment variables which are passed to it.

This external TLS support doesn't influence ONAP internal traffic which is protected by certificates issued by AAF's CertMan. External TLS Support was introduced in k8splugin 3.1.0.

1. Certificate setup:

   To create certificate artifacts, OOM CertService must obtain the certificate details. Common name and list of Subject Alternative Names (SANs) are set in blueprint as described in step 3.
   The following parameters with default values are stored in OOM in k8splugin configuration file (k8splugin.json) in group ``external_cert``:

       * A string ``image_tag`` that indicates CertService client image name and version
       * A string ``request_url`` that indicates URL to Cert Service API
       * A string ``timeout`` that indicates request timeout.
       * A string ``country`` that indicates country name in ISO 3166-1 alpha-2 format, for which certificate will be created
       * A string ``organization`` that indicates organization name, for which certificate will be created.
       * A string ``state`` that indicates state name, for which certificate will be created.
       * A string ``organizational_unit`` that indicates organizational unit name, for which certificate will be created.
       * A string ``location`` that indicates location name, for which certificate will be created.
       * A string ``keystore_password`` that indicates keystore password.
       * A string ``truststore_password`` that indicates truststore password.

   Group ``external_cert`` from k8splugin.json with default values:

   .. code-block:: JSON

        {
          "image_tag": "nexus3.onap.org:10001/onap/org.onap.oom.platform.certservice.oom-certservice-client:$VERSION",
          "request_url": "https://oom-cert-service:8443/v1/certificate/",
          "timeout":  "30000",
          "country": "US",
          "organization": "Linux-Foundation",
          "state": "California",
          "organizational_unit": "ONAP",
          "location": "San-Francisco",
          "keystore_password": "secret",
          "truststore_password": "secret"
        }


   Parameters configured in k8splugin are propagated via Helm Charts to Kubernetes ConfigMap and finally they are transfered to Consul.
   Blueprint, during start of execution, reads k8splugin.json configuration from Consul and applies it.

2. Certificate generation and retrieval:

   When a DCAE component that needs an external TLS certificate is launched, a Kubernetes init container runs before the main
   component container is launched.  The init container contacts the OOM CertService.

   DCAE service components (sometimes called "microservices") are deployed via Cloudify using blueprints.  This is described
   in more detail in the next section.

3. Plugin and Blueprint:
   The blueprint for a component that needs an external TLS certificate needs to include the node property called "external_cert" in
   the node properties for the component. The property is a dictionary with following elements:

       * A boolean (``use_external_tls``) that indicates whether the component uses TLS in external traffic.
       * A string (``external_cert_directory``) that indicates where the component expects to find  operator certificate and trusted certs.
       * A string (``ca_name``) that indicates name of Certificate Authority configured on CertService side (in cmpServers.json).
       * A string (``output_type``) that indicates certificate output type.
       * A dictionary (``external_certificate_parameters``) with two elements:
           * A string (``common_name``) that indicates common name which should be present in certificate. Specific for every blueprint (e.g. dcae-ves-collector for VES).
           * A string (``sans``) that indicates list of Subject Alternative Names (SANs) which should be present in certificate. Delimiter - : Should contain common_name value and other FQDNs under which given component is accessible.

   Example

   .. code-block:: yaml

        external_cert:
            external_cert_directory: /opt/app/dcae-certificate/
            use_external_tls: true
            ca_name: "RA"
            cert_type: "P12"
            external_certificate_parameters:
                common_name: "simpledemo.onap.org"
                sans: "simpledemo.onap.org;ves.simpledemo.onap.org;ves.onap.org"

   For this example the certificates are mounted into ``/opt/app/dcae-certificate/external`` directory within the container.

   During deployment Kubernetes plugin (referenced in blueprint) will check if the ``external_cert`` property is set and ``use_external_tls`` is set to true, then the plugin will add some elements to the Kubernetes Deployment for the component:
          * A Kubernetes volume (``tls-volume``) that will hold the certificate artifacts
          * A Kubernetes initContainer (``cert-service-client``)
          * A Kubernetes volumeMount for the initContainer that mounts the ``tls-volume`` volume at ``/etc/onap/oom/certservice/certs/``.
          * A Kubernetes volumeMount for the main container that mounts the ``tls-info`` volume at the mount point specified in the ``external_cert_directory`` property.

   Kurbernetes volumeMount tls-info is shared with TLS init container for internal traffic.

4. Certificate artifacts

    The certificate directory mounted on the container will include the following:
        * Directory ``external`` with files:
            * ``keystore.p12``: A keystore containing the operator certificate.
            * ``keystore.pass``: A text file with a single line that contains the password for the ``keystore.p12`` keystore.
            * ``truststore.p12``: A truststore containing the operator certificate.  (Needed by clients that access TLS-protected servers in external traffic.)
            * ``truststore.pass``: A text file with a single line that contains the password for the ``truststore.p12`` keystore.
        * ``trust.jks``: The AAF CA certificate and private key packaged in Java form.
        * ``trust.pass``: A text file with a single line that contains the password for ``trust.jks`` file.
        * ``cacert.pem``: The AAF CA certificate, in PEM form.
