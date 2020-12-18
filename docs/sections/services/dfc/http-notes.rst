.. This work is licensed under a Creative Commons Attribution 4.0 International License.
.. http://creativecommons.org/licenses/by/4.0

HTTP notes
==========

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
