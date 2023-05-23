.. This work is licensed under a Creative Commons Attribution 4.0 International License.
.. http://creativecommons.org/licenses/by/4.0

API
===

GET /events/unauthenticated.VES_NOTIFICATION_OUTPUT
---------------------------------------------------

Description
~~~~~~~~~~~

Reads fileReady events from DMaaP (Data Movement as a Platform)


Responses
~~~~~~~~~

+-----------+---------------------+
| HTTP Code | Description         |
+===========+=====================+
| **200**   | successful response |
+-----------+---------------------+

GET /FEEDLOG_TOPIC/DEFAULT_FEED_ID?type=pub&filename=FILENAME
-------------------------------------------------------------

Description
~~~~~~~~~~~

Querying the Data Router to check whether a file has been published previously.

Responses
~~~~~~~~~

+-----------+------------+-----------------------+
| HTTP Code | Body       | Description           |
+===========+============+=======================+
| **400**   | NA         |   error in query      |
+-----------+------------+-----------------------+
| **200**   | []         |  Not published yet    |
+-----------+------------+-----------------------+
| **200**   | [$FILENAME]|  Already published    |
+-----------+------------+-----------------------+

POST /publish
-------------

Description
~~~~~~~~~~~

Publish the collected file/s as a stream to DataRouter
    - file as stream
    - compression
    - fileFormatType
    - fileFormatVersion
    - productName
    - vendorName
    - lastEpochMicrosec
    - sourceName
    - startEpochMicrosec
    - timeZoneOffset


Responses
~~~~~~~~~

+-----------+---------------------+
| HTTP Code | Description         |
+===========+=====================+
| **200**   | successful response |
+-----------+---------------------+
