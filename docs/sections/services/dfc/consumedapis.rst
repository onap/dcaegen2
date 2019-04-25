.. This work is licensed under a Creative Commons Attribution 4.0 International License.
.. http://creativecommons.org/licenses/by/4.0

Paths
=====

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



POST /publish
-------------

Description
~~~~~~~~~~~

Publish the collected file/s as a stream to DataRouter
    - file as stream
    - compression
    - fileFormatType
    - fileFormatVersion


Responses
~~~~~~~~~

+-----------+---------------------+
| HTTP Code | Description         |
+===========+=====================+
| **200**   | successful response |
+-----------+---------------------+