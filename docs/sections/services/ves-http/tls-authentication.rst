.. This work is licensed under a Creative Commons Attribution 4.0 International License.
.. http://creativecommons.org/licenses/by/4.0

Certificates as authentication method for PNFs/VNFs
===================================================

VES supports mutual TLS authentication via X.509 certificates. If VES is deployed via docker image then VES configuration can be modified by editing */opt/app/VESCollector/etc/collector.properties* which is present on the docker container. VES detects changes made to the mentioned file automatically and restarts the application.

The authentication can be enabled by *collector.service.secure.clientauth* property. When *collector.service.secure.clientauth=1* VES uses additional properties:

    * *collector.truststore.file.location* - a path to jks trust store containing certificates of clients or certificate authorities
    * *collector.truststore.passwordfile* - a path to file containing password for the trust store

Of course, mutual TLS authentication requires also server certificates, so following properties have to be set to valid values:

    * *collector.keystore.file.location* - a path to jks key store containing certificates which can be used for TLS handshake
    * *collector.keystore.passwordfile* - a path to file containing a password for the key store
    * *collector.keystore.alias* - a name of a certificate from a key store which VES will use during TLS handshake

Property *header.authflag=1* may by used along *collector.service.secure.clientauth=1* in order to enable mutual TLS authentication and basic HTTP authentication.
