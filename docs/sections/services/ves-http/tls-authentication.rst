.. This work is licensed under a Creative Commons Attribution 4.0 International License.
.. http://creativecommons.org/licenses/by/4.0

.. raw:: html

    <style> .red {color:red} </style>
    <style> .green {color:green} </style>
.. role:: red
.. role:: green

Authentication Types
====================

VES supports mutual TLS authentication via X.509 certificates. If VES is deployed via docker image then VES configuration can be modified by editing */opt/app/VESCollector/etc/collector.properties* which is present on the docker container. VES detects changes made to the mentioned file automatically and restarts the application.

The authentication can be enabled by *collector.service.secure.clientauth* property. When *collector.service.secure.clientauth=1* VES uses additional properties:

    * *collector.truststore.file.location* - a path to jks trust store containing certificates of clients or certificate authorities
    * *collector.truststore.passwordfile* - a path to file containing password for the trust store

Of course, mutual TLS authentication requires also server certificates, so following properties have to be set to valid values:

    * *collector.keystore.file.location* - a path to jks key store containing certificates which can be used for TLS handshake
    * *collector.keystore.passwordfile* - a path to file containing a password for the key store

Property *auth.method* is used to manage security mode, possible configuration: noAuth, certBasicAuth

    * *auth.method=noAuth* default option - no security (http)

    * *auth.method=certBasicAuth* is used to enable mutual TLS authentication or/and basic HTTPs authentication

     * client without cert and without basic auth = :red:`Authentication failure`
     * client without cert and wrong basic auth = :red:`Authentication failure`
     * client without cert and correct basic auth = :green:`Authentication successful`
     * client with cert and without/wrong basic auth = :green:`Authentication successful`
     * client with cert and correct basic auth = :green:`Authentication successful`

When application is in certBasicAuth mode then certificates are also validated by regexp in /etc/certSubjectMatcher.properties,
only SubjectDn field in certificate description are checked. Default regexp value is .* means that we approve all SubjectDN values.
