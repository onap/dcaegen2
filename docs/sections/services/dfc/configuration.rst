.. This work is licensed under a Creative Commons Attribution 4.0 International License.
.. http://creativecommons.org/licenses/by/4.0

Configuration and Performance
=============================

**datafile** configuration is controlled via a single JSON file called datafile_endpoints.json.
This is located under datafile-app-server/config.

Json Configuration Explained
^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Variables of interest (e.g. variables that should be inspected/modified for a specific runtime environment) are listed below for convenience.  The entire file is provided later in this page for reference.

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
  "dmaapProtocol": "https"
  "dmaapUserName": "dradmin"
  "dmaapUserPassword": "dradmin"
  "dmaapContentType": "application/octet-stream"

ftpesConfiguration
""""""""""""""""""

.. code-block:: json

  "keyCert": <path to DFC certificate>
  "keyPassword": <password for DFC certificate>
  "trustedCa": <path to xNF certificate>
  "trustedCaPassword": <password for xNF certificate>

securityConfiguration
"""""""""""""""""""""

.. code-block:: json

  "trustStorePath": <path to trust store>
  "trustStorePasswordPath": <path to trust store password>
  "keyStorePath": <path to key store>
  "keyStorePasswordPath": <path to key store password>
  "enableDmaapCertAuth": <boolean>. If false, all information above are ignored.



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
                "keyCert": "config/dfc.jks",
                "keyPassword": "secret",
                "trustedCa": "config/ftp.jks",
                "trustedCaPassword": "secret"
            }
      },
        "security": {
            "trustStorePath" : "change it",
            "trustStorePasswordPath" : "change it",
            "keyStorePath" : "change it",
            "keyStorePasswordPath" : "change it",
            "enableDmaapCertAuth" : "false"
        }
    }
  }

Performance
^^^^^^^^^^^

To see the performance of DFC, see "`Datafile Collector (DFC) performance baseline results`_".

.. _Datafile Collector (DFC) performance baseline results: https://wiki.onap.org/display/DW/Datafile+Collector+%28DFC%29+performance+baseline+results