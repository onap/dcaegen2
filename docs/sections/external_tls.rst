.. This work is licensed under a Creative Commons Attribution 4.0 International License.
.. http://creativecommons.org/licenses/by/4.0

External TLS Support
===========

External TLS support was introduced in order to integrate DCAE with CertService to acquire operator certificates meant to protect external traffic between DCAE's components (VES collector, HV-VES, RestConf collector and DFC) and xNFs. For that reason K8s plugin which creates K8s resources from Cloudify blueprints was enhanced with new TLS properties support. New TLS properties are meant to control CertService's client call in init containers section and environment variables which are passed to it.

This external TLS support doesn't influence ONAP internal traffic which is protected by certificates issued by AAF's CertMan. External TLS Support was introduced in k8splugin 3.1.0.

Solution overview
-----------------
1. Certificate setup:

   To create certificate artifacts, AAF CertService must obtain the certificate details. Common name and list of Subject Alternative Names (SANs) are set in blueprint as described in step 3.
   The following parameters with default values are stored in OOM in k8splugin configuration file (k8splugin.json) in group ``external_cert``:

       * A string ``image_tag`` that indicates CertService client image name and version
       * A string ``request_url`` that indicates URL to Cert Service API
       * A string ``timeout`` that indicates request timeout. 
       * A string ``country`` that indicates country name in ISO 3166-1 alpha-2 format, for which certificate will be created
       * A string ``organization`` that indicates organization name, for which certificate will be created.
       * A string ``state`` that indicates state name, for which certificate will be created.
       * A string ``organizational_unit`` that indicates organizational unit name, for which certificate will be created. 
       * A string ``location`` that indicates location name, for which certificate will be created.

   Group ``external_cert`` from k8splugin.json with default values:

   .. code-block:: JSON

        {
          "image_tag": "nexus3.onap.org:10001/onap/org.onap.aaf.certservice.aaf-certservice-client:$VERSION",
          "request_url": "https://aaf-cert-service:8443/v1/certificate/",
          "timeout":  "30000",
          "country": "US",
          "organization": "Linux-Foundation",
          "state": "California",
          "organizational_unit": "ONAP",
          "location": "San-Francisco"
        }


   Parameters configured in k8splugin are propagated via Helm Charts to Kubernetes ConfigMap and finally they are transfered to Consul.
   Blueprint, during start of execution, reads k8splugin.json configuration from Consul and applies it. 

2. Certificate generation and retrieval:

   When a DCAE component that needs a external TLS certificate is launched, a Kubernetes init container runs before the main
   component container is launched.  The init container contacts the AAF CertService.

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
            external_cert_directory: /opt/app/dcae-certificate/
            use_external_tls: true
            ca_name: "RA"
            cert_type: "P12"
            external_certificate_parameters:
                common_name: "simpledemo.onap.org"
                sans: "simpledemo.onap.org;ves.simpledemo.onap.org;ves.onap.org"

   For this example the certificates are mounted into ``/opt/app/dcae-certificate/`` directory within the container.

   During deployment Kubernetes plugin (referenced in blueprint) will check if the ``external_cert`` property is set and ``use_external_tls`` is set to true, then the plugin will add some elements to the Kubernetes Deployment for the component:
          * A Kubernetes volume (``tls-volume``) that will hold the certificate artifacts
          * A Kubernetes initContainer (``cert-service-client``)
          * A Kubernetes volumeMount for the initContainer that mounts the ``tls-volume`` volume at ``/etc/onap/aaf/certservice/certs/``.
          * A Kubernetes volumeMount for the main container that mounts the ``tls-info`` volume at the mount point specified in the ``external_cert_directory`` property.

   Kurbernetes volumeMount tls-info is shared with TLS init container for internal traffic. 

4. Certificate artifacts

    The certificate directory mounted on the container will include the following:
        * Directory ``external`` with files:
            * ``keystore.p12``: A keystore containing the operator certificate.
            * ``keystore.pass``: A text file with a single line that contains the password for the ``keystore.p12`` keystore.
            * ``truststore.p12``: A truststore containing the operator certificate.  (Needed by clients that access TLS-protected servers in external traffic.)
            * ``truststore.pass``: A text file with a single line that contains the password for the ``truststore.p12`` keystore.
        * Files: 
            * ``trust.jks``: The DCAE certificate and private key packaged in Java form.
            * ``trust.pass``: A text file with a single line that contains the password for ``trust.jks`` file.
            * ``cacert.pem``: The DCAE certificate, in PEM form.
