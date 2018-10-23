.. This work is licensed under a Creative Commons Attribution 4.0 International License.
.. http://creativecommons.org/licenses/by/4.0

TLS Support
===========

To comply with ONAP security requirement, all services exposing external API required TLS support using AAF generated certificates. DCAE Platform was updated in R3 to enable certificate distribution mechanism for services needing TLS support  

Solution overview
-----------------
1. Certificate generation:
    This step is done manually currently using Test AAF instance in POD25. Required namespace,  DCAE identity (dcae@dcae.onap.org), roles and Subject Alternative Names for all components are preset. Using the procedure desribed by AAF (using agent.sh), the certificates are generated. Using .jks generated from AAF, create the .pem files and load them into tls-init-container under dcaegen2/deployment repository. The im age has a script that runs when theim age is deployed. The script copies the certificate artifacts into a Kubernetesvolume. The container is used as an "init-container" included in the Kubernetes pod for a component that needs to use TLS.
 
2. Plugin and Blueprint:
    Update blueprint to include new (optional) node property (tls_info) to the type definitions for the Kubernetes component types. The property is a dictionary with two elements: A boolean (use_tls) that indicates whether the com ponent uses TLS. A string (cert_directory) that indicates where the component expects to find certificate artifacts 
    
    During deployment Kubernetes plugin (referenced in blueprint) will check if the tls_info property is set and use_tls is set to true, then the plugin will add some elements to the Kubernetes Deployment for the component:
          * A Kubernetes volume (tls-info) that will hold the certificate artifacts
          * A Kubernetes initContainer (tls-init)
          * A Kubernetes volumeMount for the initContainer that mounts the tlsinit volume at /opt/tls/shared.
          * A Kubernetes volumeMount for the main container that mounts the tlsinit volume at the mount point specified in the cert_directory property.
          * If the component has an HTTP healthcheck specified, the plugin will setup the corresponding Kubernetes readiness probe with same endpoint.
    
3. Certificate Artifacts 

    The certificate directory m ounted on the container will include the following files:
    - cert.jks: A Java keystore containing the DCAE certificate.
    - jks.pass: A text file with a single line that contains the password for the cert.jks keystore.
    - trust.jks: A Jave truststore containing the AAF CA certificate (needed by clients)
    - trust.pass: A text file with a single line that contains the password for the trust.jks keystore.
    - cert.p12: The DCAE certificate and private key package in PKCS12 form at.
    - p12.pass: A text file with a single line that contains the password for cert.p12 file.
    - cert.pem: The DCAE certificate, in PEM form at.
    - key.pem: The private key for the DCAE certificate. The key is not encrypted.
