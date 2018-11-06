.. This work is licensed under a Creative Commons Attribution 4.0 International License.
.. http://creativecommons.org/licenses/by/4.0

Configuration
=============

**datafile** configuration is controlled via a single JSON file called datafile_endpoints.json.
This is located under datafile-app-server/config.

JSON CONFIGURATION EXPLAINED
^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Variables of interest (e.g. variables that should be inspected/modifed for a specific runtime environment) are listed below for convenience.  The entire file is provided later in this page for reference.

dmaapConsumerConfiguration
""""""""""""""""""""""""""

.. code-block:: json

  "dmaapHostName": <name of DMaaP/MR host>
  "dmaapPortNumber": <DMaaP/MR host port>
  "dmaapTopicName": "/events/unauthenticated.VES_NOTIFICATION_OUTPUT"
  "dmaapProtocol": "http"
  "dmaapUserName": ""
  "dmaapUserPassword": ""
  "dmaapContentType": "application/json"
  "consumerId": "C12"
  "consumerGroup": "OpenDcae-c12"
  "timeoutMS": -1
  "messageLimit": 1

dmaapProducerConfiguration
""""""""""""""""""""""""""

.. code-block:: json

  "dmaapHostName": <name of DMaaP/DR host>
  "dmaapPortNumber": <DMaaP/DR host port>
  "dmaapTopicName": "publish"
  "dmaapProtocol": "httpa"
  "dmaapUserName": "dradmin"
  "dmaapUserPassword": "dradmin"
  "dmaapContentType": "application/octet-stream"

ftpesConfiguration
""""""""""""""""""

.. code-block:: json

  "keyCert": <path to DFC certificate>
  "keyPassword": <pssword for DFC certificate>
  "trustedCA": <path to xNF certificate>
  "trustedCAPassword": <password for xNF certificate>


Sample JSON configuration
"""""""""""""""""""""""""

The format of the JSON configuration that drives all behavior of DFC is probably best described using an example:

.. code-block:: json

  {
    "configs": {
      "dmaap": {
        "dmaapConsumerConfiguration": {
          "dmaapHostName": "localhost",
          "dmaapPortNumber": 2222,
          "dmaapTopicName": "/events/unauthenticated.VES_NOTIFICATION_OUTPUT",
          "dmaapProtocol": "http",
          "dmaapUserName": "",
          "dmaapUserPassword": "",
          "dmaapContentType": "application/json",
          "consumerId": "C12",
          "consumerGroup": "OpenDcae-c12",
          "timeoutMS": -1,
          "messageLimit": 1
        },
        "dmaapProducerConfiguration": {
          "dmaapHostName": "localhost",
          "dmaapPortNumber": 3907,
          "dmaapTopicName": "publish",
          "dmaapProtocol": "https",
          "dmaapUserName": "dradmin",
          "dmaapUserPassword": "dradmin",
          "dmaapContentType": "application/octet-stream"
        }
      },
      "ftp": {
        "ftpesConfiguration": {
          "keyCert": "config/ftpKey.jks",
          "keyPassword": "secret",
          "trustedCA": "config/cacerts",
          "trustedCAPassword": "secret"
        }
      }
    }
  }
