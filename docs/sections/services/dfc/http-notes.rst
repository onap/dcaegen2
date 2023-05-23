.. This work is licensed under a Creative Commons Attribution 4.0 International License.
.. http://creativecommons.org/licenses/by/4.0

HTTP/HTTPS notes
================

HTTP Basic Authentication in FileReady messages
"""""""""""""""""""""""""""""""""""""""""""""""
File ready message for http server is the same like in other protocols. The only difference is scheme set to
"http". Processed uri is in the form of:

.. code-block:: bash

   scheme://userinfo@host:port/path
   i.e.
   http://demo:demo123456!@example.com:80/C20200502.1830+0200-20200502.1845+0200_195500.xml.gz

If port number was not provided, port 80 is used by default.

Example file ready message is as follows:

.. code-block:: bash

   curl --location --request POST 'https://portal.api.simpledemo.onap.org:30417/eventListener/v7' \
   --header 'Content-Type: application/json' \
   --header 'Authorization: Basic c2FtcGxlMTpzYW1wbGUx' \
   --data-raw '{
     "event": {
       "commonEventHeader": {
         "version": "4.0.1",
         "vesEventListenerVersion": "7.0.1",
         "domain": "notification",
         "eventName": "Notification_gnb-Nokia_FileReady",
         "eventId": "FileReady_1797490e-10ae-4d48-9ea7-3d7d790b25e1",
         "lastEpochMicrosec": 8745745764578,
         "priority": "Normal",
         "reportingEntityName": "NOK6061ZW3",
         "sequence": 0,
         "sourceName": "NOK6061ZW3",
         "startEpochMicrosec": 8745745764578,
         "timeZoneOffset": "UTC+05.30"
       },
       "notificationFields": {
         "changeIdentifier": "PM_MEAS_FILES",
         "changeType": "FileReady",
         "notificationFieldsVersion": "2.0",
         "arrayOfNamedHashMap": [
           {
             "name": "C_28532_measData_file.xml",
             "hashMap": {
               "location": "http://login:password@server.com:80/C20200502.1830+0200-20200502.1845+0200_195500.xml.gz",
               "compression": "gzip",
               "fileFormatType": "org.3GPP.32.435#measCollec",
               "fileFormatVersion": "V10"
             }
           }
         ]
       }
     }
   }'

Note, more than one file from the same location can be added to the "arrayOfNamedHashMap". If so, they are downloaded
from the endpoint through single http connection.

HTTPS connection with DFC
"""""""""""""""""""""""""
The file ready message for https server is the same as used in other protocols and http. The only difference is that the scheme is set to
"https":

.. code-block:: json

   {"arrayOfNamedHashMap": [
           {
             "name": "C_28532_measData_file.xml",
             "hashMap": {
               "location": "https://login:password@server.com:443/file.xml.gz"
   }}]}

The processed uri depends on the https connection type that has to be established (client certificate authentication, basic
authentication, and no authentication).

For client certificate authentication:

.. code-block:: bash

   scheme://host:port/path
   i.e.
   https://example.com:443/C20200502.1830+0200-20200502.1845+0200_195500.xml.gz

Authentication is based on the certificate used by the DFC.

For basic authentication:

.. code-block:: bash

   scheme://userinfo@host:port/path
   i.e.
   https://demo:demo123456!@example.com:443/C20200502.1830+0200-20200502.1845+0200_195500.xml.gz

Authentication is based on the "userinfo" applied within the link.

If no authentication is required:

.. code-block:: bash

   scheme://host:port/path
   i.e.
   https://example.com:443/C20200502.1830+0200-20200502.1845+0200_195500.xml.gz

Note, effective way of authentication depends of uri provided and http server configuration.

If port number was not supplied , port 443 is used by default.
Every file is sent through separate https connection.

JWT token in HTTP/HTTPS connection
""""""""""""""""""""""""""""""""""

JWT token is processed, if it is provided as a ``access_token`` in the query part of the **location** entry:

.. code-block:: bash

   scheme://host:port/path?access_token=<token>
   i.e.
   https://example.com:443/C20200502.1830+0200-20200502.1845+0200_195500.xml.gz?access_token=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJkZW1vIiwiaWF0IjoxNTE2MjM5MDIyfQ.MWyG1QSymi-RtG6pkiYrXD93ZY9NJzaPI-wS4MEpUto

JWT tokens are consumed both in HTTP and HTTPS connections. Using JWT token is optional. If it is provided, its
**validity is not verified**. Token is extracted to the HTTP header as ``Authorization: Bearer <token>`` and is **NOT**
used in URL in HTTP GET call. Only single JWT token entry in the query is acceptable. If more than one ''access_token''
entry is found in the query, such situation is reported as error and DFC tries to download file without token. Another
query parameters are not modified at all and are used in URL in HTTP GET call.

If both JWT token and basic authentication are provided, JWT token has the priority. Such situation is considered
as fault and is logged on warning level.
