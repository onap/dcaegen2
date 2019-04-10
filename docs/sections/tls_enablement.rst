.. This work is licensed under a Creative Commons Attribution 4.0 International License.
.. http://creativecommons.org/licenses/by/4.0

TLS Support
===========

To comply with ONAP security requirement, all services exposing external API required TLS support using AAF generated certificates. DCAE Platform was updated in R3 to enable certificate distribution mechanism for services needing TLS support.

Solution overview
-----------------
1. Certificate generation:
    This step is done manually currently using Test AAF instance in POD25. Required namespace,  DCAE identity (dcae@dcae.onap.org), roles and Subject Alternative Names for all components are preset. Using the procedure desribed by AAF (using ``agent.sh``), the certificates are generated. Using the Java keystore file  (``.jks``)  generated from AAF, create the .pem files and load them into tls-init-container under dcaegen2/deployment repository. The image has a script that runs when the image is deployed. The script copies the certificate artifacts into a Kubernetes volume. The container is used as an "init-container" included in the Kubernetes pod for a component that needs to use TLS.

    Current SAN listing::

        bbs-event-processor, bbs-event-processor.onap, bbs-event-processor.onap.svc.cluster.local, config-binding-service, config-binding-service.onap, config-binding-service.onap.svc.cluster.local, dcae-cloudify-manager, dcae-cloudify-manager.onap, dcae-cloudify-manager.onap.svc.cluster.local, dcae-datafile-collector, dcae-datafile-collector.onap, dcae-datafile-collector.onap.svc.cluster.local, dcae-hv-ves-collector, dcae-hv-ves-collector.onap, dcae-hv-ves-collector.onap.svc.cluster.local, dcae-pm-mapper, dcae-pm-mapper.onap, dcae-pm-mapper.onap.svc.cluster.local, dcae-prh, dcae-prh.onap, dcae-prh.onap.svc.cluster.local, dcae-tca-analytics, dcae-tca-analytics.onap, dcae-tca-analytics.onap.svc.cluster.local, dcae-ves-collector, dcae-ves-collector.onap, dcae-ves-collector.onap.svc.cluster.local, deployment-handler, deployment-handler.onap, deployment-handler.onap.svc.cluster.local, holmes-engine-mgmt, holmes-engine-mgmt.onap, holmes-engine-mgmt.onap.svc.cluster.local, holmes-rule-mgmt, holmes-rules-mgmt.onap, holmes-rules-mgmt.onap.svc.cluster.local, inventory, inventory.onap, inventory.onap.svc.cluster.local, policy-handler, policy-handler.onap, policy-handler.onap.svc.cluster.local
 
2. Plugin and Blueprint:
    Update blueprint to include new (optional) node property (tls_info) to the type definitions for the Kubernetes component types. The property is a dictionary with two elements:

        * A boolean (``use_tls``) that indicates whether the component uses TLS. 
        * A string (``cert_directory``) that indicates where the component expects to find certificate artifacts.
    
        Example
.. code-block:: yaml

        tls_info:
           cert_directory: '/opt/app/dh/etc/cert/'
           use_tls: true

For this example the certificates are mounted into /opt/app/dh/etc/cert directory within the conainer.
        
    
    During deployment Kubernetes plugin (referenced in blueprint) will check if the ``tls_info`` property is set and ``use_tls`` is set to true, then the plugin will add some elements to the Kubernetes Deployment for the component:
          * A Kubernetes volume (``tls-info``) that will hold the certificate artifacts
          * A Kubernetes initContainer (``tls-init``)
          * A Kubernetes volumeMount for the initContainer that mounts the ``tls-info`` volume at ``/opt/tls/shared``.
          * A Kubernetes volumeMount for the main container that mounts the ``tls-info`` volume at the mount point specified in the ``cert_directory`` property.
    
3. Certificate Artifacts 

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
