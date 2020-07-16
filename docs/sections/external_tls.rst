.. This work is licensed under a Creative Commons Attribution 4.0 International License.
.. http://creativecommons.org/licenses/by/4.0

External TLS Support
===========

External TLS support was introduced in order to integrate DCAE with CertService to acquire operator certificates meant to protect external traffic between DCAE's components (VES collector, HV-VES, RestConf collector and DFC) and xNFs. For that reason K8s plugin which creates K8s resources from Cloudify blueprints was enhanced with new TLS properties support. New TLS properties are meant to control CertService's client call in init containers section and environment variables which are passed to it.

This external TLS support doesn't influence ONAP internal traffic which is protected by certificates issued by AAF's CertMan. External TLS Support was introduced in k8splugin 3.1.0.

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

   When a DCAE component that needs a external TLS certificate is launched, a Kubernetes init container runs before the main
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
    The blueprint for a component that needs a external TLS certificate needs to include the node property called "external_cert" in
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
            external_cert_directory: /opt/app/dcae-certificate/external_cert
            use_external_tls: true
            ca_name: "RA"
            cert_type: "P12"
            external_certificate_parameters:
                common_name: "simpledemo.onap.org"
                sans: "simpledemo.onap.org;ves.simpledemo.onap.org;ves.onap.org"

(Note that the ``cert_directory`` value does not include a trailing ``/``.)

For this example the certificates are mounted into ``/opt/app/dcae-certificate/external_cert`` directory within the container.

    During deployment Kubernetes plugin (referenced in blueprint) will check if the ``external_cert`` property is set and ``use_external_tls`` is set to true, then the plugin will add some elements to the Kubernetes Deployment for the component:
          * A Kubernetes volume (``tls-volume``) that will hold the certificate artifacts
          * A Kubernetes initContainer (``cert-service-client``)
          * A Kubernetes volumeMount for the initContainer that mounts the ``tls-volume`` volume at ``/etc/onap/aaf/certservice/certs/``.
          * A Kubernetes volumeMount for the main container that mounts the ``tls-info`` volume at the mount point specified in the ``external_cert_directory`` property.

4. Certificate artifacts

    The certificate directory mounted on the container will include the following:
        * Directory ``external`` with files:
            * ``keystore.p12``: A keystore containing the DCAE certificate.
            * ``keystore.pass``: A text file with a single line that contains the password for the ``keystore.p12`` keystore.
            * ``truststore.p12``: A truststore containing the AAF CA certificate.  (Needed by clients that access TLS-protected servers in external traffic.)
            * ``truststore.pass``: A text file with a single line that contains the password for the ``truststore.p12`` keystore.
        * Files: 
        * ``trust.jks``: The DCAE certificate and private key packaged in Java form.
        * ``trust.pass``: A text file with a single line that contains the password for ``trust.jks`` file.
        * ``cacert.pem``: The AAF CA certificate, in PEM form.  (Needed by clients that access TLS-protected servers.)
