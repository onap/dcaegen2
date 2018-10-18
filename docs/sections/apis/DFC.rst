==============================
DFC (DataFile Collector)
==============================

:Date: 2018-09-21

.. contents::
    :depth: 3
..

Overview
========

DFC will orchestrate the collection of bulk PM data flow:
    1. Subscribes to fileReady DMaaP topic
    2. Collects the file from the xNF
    3. Sends new event to DataRouter with file.

Introduction
============

DFC is delivered as one **Docker container** which hosts application server and can be started by `docker-compose`.

Functionality
=============
.. image:: ../images/DFC.png


Paths
=====

GET /events/unauthenticated.VES_NOTIFICATION_OUTPUT
-----------------------------------------------

Description
~~~~~~~~~~~

Reads fileReady events from DMaaP (Data Movement as a Platform)


Responses
~~~~~~~~~

+-----------+-------------------------------------------+
| HTTP Code | Description                               |
+===========+===========================================+
| **200**   | successful response                       |
+-----------+-------------------------------------------+



POST /publish
--------------------------------------

Description
~~~~~~~~~~~

Publish the collected file/s as a stream to DataRouter
    - file as stream
    - compression
    - fileFormatType
    - fileFormatVersion


Responses
~~~~~~~~~

+-----------+-------------------------------------------+
| HTTP Code | Description                               |
+===========+===========================================+
| **200**   | successful response                       |
+-----------+-------------------------------------------+

Compiling DFC
=============

Whole project (top level of DFC directory) and each module (sub module directory) can be compiled using
`mvn clean install` command.

Configuration file: Config/datafile_endpoints.json

Main API Endpoints
==================

Running with dev-mode of DFC
    - Heartbeat: **http://<container_address>:8100/heartbeat** or **https://<container_address>:8433/heartbeat**
    - Start DFC: **http://<container_address>:8100/start** or **https://<container_address>:8433/start**
    - Stop DFC: **http://<container_address>:8100/stopDatafile** or **https://<container_address>:8433/stopDatafile**

The external port allocated for 8100 (http) is 30245.

Maven GroupId:
==============

org.onap.dcaegen2.collectors

Maven Parent ArtifactId:
========================

dcae-collectors

Maven Children Artifacts:
=========================

1. datafile-app-server: DFC server
2. datafile-dmaap-client: Contains implementation of DmaaP client
3. datafile-commons: Common code for whole DFC modules
4. docker-compose: Contains the docker-compose

Configuration of Certificates in test environment(For FTP over TLS):
====================================================================
DFC supports two protocals: FTPES and SFTP.
For FTPES, it is mutual authentication with certificates.
In our test environment, we use vsftpd to simulate xNF, and we generate self-signed
keys & certifcates on both vsftpd server and DFC.
1. generate key & certificate with openssl for DFC：
    openssl genrsa -out dfc.key 2048
    openssl req -new -out dfc.csr -key dfc.key
    openssl x509 -req -days 365 -in dfc.csr -signkey dfc.key -out dfc.crt
2. generate key & certificate with openssl for vsftpd:
    openssl genrsa -out ftp.key 2048
    openssl req -new -out ftp.csr -key ftp.key
    openssl x509 -req -days 365 -in ftp.csr -signkey ftp.key -out ftp.crt
3. configure java keystore in DFC:
    We have two keystore files, one for TrustManager, one for KeyManager.
    First, create a jks keystore for TrustManager:
      keytool -keystore ftp.jks -genkey -alias ftp
    Second, convert your certificate in a DER format :
      openssl x509 -outform der -in ftp.crt -out ftp.der
    And after, import it in the keystore :
      keytool -import -alias ftp -keystore ftp.jks -file ftp.der

    For KeyManager:
    First, create a jks keystore:
      keytool -keystore dfc.jks -genkey -alias dfc
    Second, import dfc.crt and dfc.key to dfc.jks. This is a bit troublesome.
      Step one: Convert x509 Cert and Key to a pkcs12 file
      openssl pkcs12 -export -in dfc.crt -inkey dfc.key \
               -out dfc.p12 -name [some-alias] \
      Note: Make sure you put a password on the p12 file - otherwise you'll get
      a null reference exception when you try to import it. (In case anyone else had this headache).
      Note 2: You might want to add the -chainoption to preserve the full certificate chain.
      Step two: Convert the pkcs12 file to a java keystore
      keytool -importkeystore \
        -deststorepass [changeit] -destkeypass [changeit] -destkeystore dfc.jks \
        -srckeystore dfc.p12 -srcstoretype PKCS12 -srcstorepass some-password \
        -alias [some-alias]
    Finished

4. configure vsftpd:
    update /etc/vsftpd/vsftpd.conf:
      rsa_cert_file=/etc/ssl/private/ftp.crt
      rsa_private_key_file=/etc/ssl/private/ftp.key
      ssl_enable=YES
      allow_anon_ssl=NO
      force_local_data_ssl=YES
      force_local_logins_ssl=YES

      ssl_tlsv1=YES
      ssl_sslv2=YES
      ssl_sslv3=YES

      require_ssl_reuse=NO
      ssl_ciphers=HIGH

      require_cert=YES
      ssl_request_cert=YES
      ca_certs_file=/home/vsftpd/myuser/dfc.crt

5. configure config/datafile_endpoints.json:
   Update the filed accordingly:
            "ftpesConfiguration": {
                "keyCert": "/config/dfc.jks",
                "keyPassword": "[yourpassword]",
                "trustedCA": "/config/ftp.jks",
                "trustedCAPassword": "[yourpassword]"
            }
6. This has been tested with vsftpd and dfc, with self-signed certificates.
   In real deployment, we should use ONAP-CA signed certifcate for DFC, and vendor-CA signed
   certifcate for xNF.
