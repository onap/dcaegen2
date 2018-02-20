.. This work is licensed under a Creative Commons Attribution 4.0 International License.
.. http://creativecommons.org/licenses/by/4.0

.. _streams-grid:

Streams Formatting Quick Reference
==================================

Each of the following tables represents an example of a publisher and
its subscriber, which are of course, different components. This focuses
on the fields that are ‘different’ for each of these TYPEs, to
illustrate the relationship between ``config_key``, dmaap connection
object, and the generated configuration. Some notes on specific
properties:

-  ``config_key`` is an arbitrary string, chosen by the component
   developer. It is returned in the generated configuration where it
   contains specific values for the target connection
-  ``format``, ``version``, and ``type`` properties in the subscriber
   would match these properties in the publisher
-  ``aaf_username`` and ``aaf_password`` may be different between the
   publisher and the subscriber

Using http
~~~~~~~~~~

*Publishing Component*
^^^^^^^^^^^^^^^^^^^^^^

+-----------------------------+----------------------------------------+
| component \                 | runtime platform generated config      |
| spec                        |                                        |
+=============================+========================================+
| "streams":{                 | "streams_publishes":{                  |
| "publishes":[{              | "prediction":"10.100.1.100:32567/data" |
| "config_key":"prediction",  |                                        |
| "format":"some-format",     |                                        |
| "type":"http",              |                                        |
| "version":"0.1.0"   }       |                                        |
| ]}                          |                                        |
+-----------------------------+----------------------------------------+

*Subscribing Component*
^^^^^^^^^^^^^^^^^^^^^^^

+-----------------------------+----------------------------------------+
| component                   | runtime platform generated config      |
| spec                        |                                        |
+=============================+========================================+
| “streams”:{                 | "N/A"                                  | 
| "subscribes":[{             |                                        |
| "route":"/data",            |                                        |
| "format":"some-format",     |                                        |
| "type":"http"               |                                        |
| "version":"0.1.0"   }       |                                        |
| ]}                          |                                        |
+-----------------------------+----------------------------------------+

Using Message Router
~~~~~~~~~~~~~~~~~~~~

.. publishing-component-1:

*Publishing Component*
^^^^^^^^^^^^^^^^^^^^^^

Note: When deploying, this component should be deployed first so satisfy
downstream dependencies. Refer to the –force option in component ‘run’
command for more information.

+---------------+------------------------+-----------------------------------------------------------------------------+
| component \   | Dmaap Connection \     | runtime platform generated \                                                |
| spec          | Object                 | config                                                                      |
+===============+========================+=============================================================================+
| “streams”:{   | {     “dmaap_info”:    | “streams_publishes”:{                                                       |
|     “config_k\| {} \ *Note: For \      | “aaf_username”:“pub-user”,                                                  |
| ey”:“mr_out\  | message router, this \ |   “type”:“message_router”,                                                  |
| put”,     “t\ | object is identical \  |      “topic_url”:"https://we-are-message-router.us:3905/events/some-topic"\ |
| ype”:“messag\ | for the publisher and \| "streams_subscribes":{...}                                                  |
| e_router”,    | the subscriber*        |                                                                             |
|  }]}          |                        |                                                                             |
+---------------+------------------------+-----------------------------------------------------------------------------+

*Subscribing Component*
^^^^^^^^^^^^^^^^^^^^^^^

+---------------+------------------------+-----------------------------------------------------------------------------+
| component \   | Dmaap Connection \     | runtime platform generated \                                                |
| spec          | Object                 | config                                                                      |
+===============+========================+=============================================================================+
| “streams”:{   | {     “dmaap_info”:    | “streams_publishes”:{…},                                                    |
|     “config_k\| {} \ *Note: For \      | “streams_subscribes”:{                                                      |
| ey”:“mr_inp\  | message router, this \ | “aaf_username”:“sub-user”,                                                  |
| ut”,     “ty\ | object is identical \  |   “type”:“message_router”,                                                  |
| pe”:“message\ | for the publisher and \|      “topic_url”:“https://we-are-message-router.us:3905/events/some-topic"  |
| _router”,     | the subscriber*        |                                                                             |
| }]}           |                        |                                                                             |
+---------------+------------------------+-----------------------------------------------------------------------------+

Using Data Router
~~~~~~~~~~~~~~~~~

.. publishing-component-2:

*Publishing Component*
^^^^^^^^^^^^^^^^^^^^^^

+---------------+-----------------------------------------------+-----------------------------------------------+
| component spec| Dmaap Connection Object                       | runtime platform generated config             |
+===============+===============================================+===============================================+
| “streams”:{   | {    “dmaap_info”: {                          | streams_publishes“:{    ”typ\                 |
| “config_key:  |      “location”:                              | e“:”data_router“,       "location":"mtc00"    |
| “dr_output"   | “mtc00”,                                      | ,                                             |
| , "type":     | “publish_url”:                                | "publish_url“:                                |
| “data_r\      | "https://we-are-data-router.us/feed/xyz"\     | "http://we-are-data-router.us/feed/xyz"       |
| outer”,   }]  | ,                                             | ,                                             |
| }             | “log_url”:\                                   | "log_url“:\                                   |
|               | \                                             | ”https://we-are-data-router.us/feed/xyz/logs" |
|               | "https://we-are-data-router.us/feed/xyz/logs"\| ,                                             |
|               | ,                                             | ”username“:”pub-user“,                        |
|               | “username”:                                   | ”publisher_id“:”123456\                       |
|               | “pub-user”,                                   | “}},                                          |
|               | “password”:                                   |  ”streams_subscribes“:{                       |
|               | “pub-password”,                               | … }                                           |
|               | “publisher_id”:                               |                                               |
|               | “123456”}}                                    |                                               |
+---------------+-----------------------------------------------+-----------------------------------------------+

.. subscribing-component-1:

*Subscribing Component*
^^^^^^^^^^^^^^^^^^^^^^^

+---------------+---------------------------------------------------+---------------------------------------------------------------------------+
| component \   | Dmaap Connection \                                | runtime platform generated \                                              |
| spec          | Object                                            | config                                                                    |
+===============+===================================================+===========================================================================+
| “streams”:{   | {      “dmaap_info”:                              | “streams_publishes”:{ … },                                                |
|     “config_k\| {      “location”:                                | “streams_subscribes”:{                                                    |
| ey”:“dr_inp\  | “mtc00”,                                          | “type”:“data_router”,                                                     |
| ut”,     “ty\ | “delivery_url”:                                   |   “location”:“mtc00”,                                                     |
| pe”:“data_ro\ | "https://my-subscriber-app.dcae:8080/target-path"\|          “delivery_url”:"https://my-subscriber-app.dcae:8080/target-path"\|
| uter”,        | \                                                 | \                                                                         | 
|     “route”:  | ,                                                 | ,                                                                         |
| “/target-pat\ |      “password”:                                  | \                                                                         |
| h”}           | “sub-password”,                                   | “username”:“sub-user”,                                                    |
|               | “subscriber_id”:                                  |                                                                           |
|               | “789012”}}                                        | “subscriber_id”:“789012”}}                                                |
+---------------+---------------------------------------------------+---------------------------------------------------------------------------+
