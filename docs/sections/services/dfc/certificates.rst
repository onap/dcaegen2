.. This work is licensed under a Creative Commons Attribution 4.0 International License.
.. http://creativecommons.org/licenses/by/4.0

Certificates
============

Configuration of Certificates in test environment(For FTP over TLS):

DFC supports two protocols: FTPES and SFTP.
For FTPES, it is mutual authentication with certificates.
In our test environment, we use vsftpd to simulate xNF, and we generate self-signed
keys & certificates on both vsftpd server and DFC.

1. Generate key/certificate with openssl for DFC:
-------------------------------------------------
.. code:: bash

    openssl genrsa -out dfc.key 2048
    openssl req -new -out dfc.csr -key dfc.key
    openssl x509 -req -days 365 -in dfc.csr -signkey dfc.key -out dfc.crt

2. Generate key & certificate with openssl for vsftpd:
------------------------------------------------------
.. code:: bash

   openssl genrsa -out ftp.key 2048
   openssl req -new -out ftp.csr -key ftp.key
   openssl x509 -req -days 365 -in ftp.csr -signkey ftp.key -out ftp.crt

3. Configure java keystore in DFC:
----------------------------------
We have two keystore files, one for TrustManager, one for KeyManager.

**For TrustManager:**

1. First, convert your certificate in a DER format :

 .. code:: bash

   openssl x509 -outform der -in ftp.crt -out ftp.der

2. And after, import it in the keystore :

 .. code:: bash

   keytool -import -alias ftp -keystore ftp.jks -file ftp.der

**For KeyManager:**

1. First, create a jks keystore:

 .. code:: bash

    keytool -keystore dfc.jks -genkey -alias dfc

2. Second, import dfc.crt and dfc.key to dfc.jks. This is a bit troublesome.

 1). Step one: Convert x509 Cert and Key to a pkcs12 file

 .. code:: bash

    openssl pkcs12 -export -in dfc.crt -inkey dfc.key -out dfc.p12 -name [some-alias]

 Note: Make sure you put a password on the p12 file - otherwise you'll get a null reference exception when you try to import it.

 Note 2: You might want to add the -chainoption to preserve the full certificate chain.

 2). Step two: Convert the pkcs12 file to a java keystore:

 .. code:: bash

    keytool -importkeystore -deststorepass [changeit] -destkeypass [changeit] -destkeystore dfc.jks -srckeystore dfc.p12 -srcstoretype PKCS12 -srcstorepass [some-password] -alias [some-alias]

4. Update existing jks.b64 files
---------------------------------

Copy the existing jks from the DFC container to a local environment.

 .. code:: bash
 
   docker cp <DFC container>:/opt/app/datafile/config/ftp.jks .
   docker cp <DFC container>:/opt/app/datafile/config/dfc.jks .

 .. code:: bash
 
   openssl base64 -in ftp.jks -out ftp.jks.b64
   openssl base64 -in dfc.jks -out dfc.jks.b64

 .. code:: bash
 
   chmod 755 ftp.jks.b64
   chmod 755 dfc.jks.b64

Copy the new jks.64 files from local environment to the DFC container.

 .. code:: bash
 
   docker cp ftp.jks.b64 <DFC container>:/opt/app/datafile/config/
   docker cp dfc.jks.b64 <DFC container>:/opt/app/datafile/config/

Finally

 .. code:: bash
 
   docker restart <DFC container>

5. Configure vsftpd:
--------------------
    update /etc/vsftpd/vsftpd.conf:

  .. code-block:: bash

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

6. Configure config/datafile_endpoints.json:
--------------------------------------------
   Update the file accordingly:

  .. code-block:: javascript

            "ftpesConfiguration": {
                "keyCert": "/config/dfc.jks",
                "keyPassword": "[yourpassword]",
                "trustedCA": "/config/ftp.jks",
                "trustedCAPassword": "[yourpassword]"
            }

7. Other conditions
---------------------------------------------------------------------------
   This has been tested with vsftpd and dfc, with self-signed certificates.
   In real deployment, we should use ONAP-CA signed certificate for DFC, and vendor-CA signed certificate for xNF
