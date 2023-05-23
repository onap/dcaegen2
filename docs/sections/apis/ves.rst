.. This work is licensed under a
   Creative Commons Attribution 4.0 International License.
   http://creativecommons.org/licenses/by/4.0

VES-Collector
=============

.. toctree::
    :maxdepth: 3

Description
~~~~~~~~~~~

Virtual Event Streaming (VES) Collector is RESTful collector for processing
JSON messages. The collector verifies the source and validates the events
against VES schema before distributing to DMAAP MR topics.

.. csv-table::
   :header: "API name", "Swagger JSON", "Swagger YAML"
   :widths: 10,5,5

   "VES Collector", ":download:`link <swagger_vescollector.json>`", ":download:`link <swagger_vescollector.yaml>`"

Contact Information
~~~~~~~~~~~~~~~~~~~

onap-discuss@lists.onap.org

Security
~~~~~~~~

`VES Authentication Types <https://docs.onap.org/projects/onap-dcaegen2/en/latest/sections/services/ves-http/tls-authentication.html>`_


VES Specification
~~~~~~~~~~~~~~~~~

- `VES 7.1.1 Data Model <https://docs.onap.org/projects/onap-vnfrqts-requirements/en/latest/Chapter8/ves7_1spec.html#common-event-format>`_
- `VES 5.4 Data Model <https://docs.onap.org/projects/onap-vnfrqts-requirements/en/latest/Chapter8/ves_5_4_1/VESEventListener.html#common-event-format>`_


Response Code
~~~~~~~~~~~~~

+-----+--------------+--------------------------------------------------------+
| Code| Reason Phrase| Description                                            |
+=====+==============+========================================================+
| 202 | Accepted     | The request has been accepted for processing           |
+-----+--------------+--------------------------------------------------------+
| 400 | Bad Request  | Many possible reasons not specified by the other codes |
|     |              | (e.g., missing required parameters or incorrect format)|
|     |              | . The response body may include a further exception    |
|     |              | code and text. HTTP 400 errors may be mapped to SVC0001|
|     |              | (general service error), SVC0002 (bad parameter),      |
|     |              | SVC2000 (general service error with details) or PO9003 |
|     |              | (message content size exceeds the allowable limit).    |
+-----+--------------+--------------------------------------------------------+
| 401 | Unauthorized | Authentication failed or was not provided. HTTP 401    |
|     |              | errors may be mapped to POL0001 (general policy error) |
|     |              | or POL2000 (general policy error with details).        |
+-----+--------------+--------------------------------------------------------+
| 404 | Not Found    | The server has not found anything matching the         |
|     |              | Request-URI. No indication is given of whether the     |
|     |              | condition is temporary or permanent.                   |
+-----+--------------+--------------------------------------------------------+
| 405 | Method Not   | A request was made of a resource using a request method|
|     | Allowed      | not supported by that resource (e.g., using PUT on a   |
|     |              | REST resource that only supports POST).                |
+-----+--------------+--------------------------------------------------------+
| 500 | Internal     | The server encountered an internal error or timed out; |
|     | Server Error | please retry (general catch-all server-side error).HTTP|
|     |              | 500 errors may be mapped to SVC1000 (no server         |
|     |              | resources).                                            |
+-----+--------------+--------------------------------------------------------+

Sample Request and Response
---------------------------

Request Example


.. code-block:: http

    POST  /eventListener/v7 HTTP/1.1
    Authorization: Basic QWxhZGRpbjpvcGVuIHNlc2FtZQ==
    content-type: application/json
    content-length: 12345
    X-MinorVersion: 1

    {
        "event": {
            "commonEventHeader": {
                "version": "4.1",
                "vesEventListenerVersion": "7.1.1",
                "domain": "fault",
                "eventName": "Fault_Vscf:Acs-Ericcson_PilotNumberPoolExhaustion",
                "eventId": "fault0000245",
                "sequence": 1,
                "priority": "High",
                "reportingEntityId": "cc305d54-75b4-431b-adb2-eb6b9e541234",
                "reportingEntityName": "ibcx0001vm002oam001",
                "sourceId": "de305d54-75b4-431b-adb2-eb6b9e546014",
                "sourceName": "scfx0001vm002cap001",
                "nfVendorName": "Ericsson",
                "nfNamingCode": "scfx",
                "nfcNamingCode": "ssc",
                "startEpochMicrosec": 1413378172000000,
                "lastEpochMicrosec": 1413378172000000,
                "timeZoneOffset": "UTC-05:30"
            },
            "faultFields": {
                "faultFieldsVersion": 4.0,
                "alarmCondition": "PilotNumberPoolExhaustion",
                "eventSourceType": "other",
                "specificProblem": "Calls cannot complete - pilot numbers are unavailable",
                "eventSeverity": "CRITICAL",
                "vfStatus": "Active",
                "alarmAdditionalInformation": {
                    "PilotNumberPoolSize": "1000"
                }
            }
        }
    }



Response Example

.. code-block:: http

    HTTPS/1.1 202 Accepted
    X-MinorVersion: 1
    X-PatchVersion: 1
    X-LatestVersion: 7.1.1
