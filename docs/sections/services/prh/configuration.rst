.. This work is licensed under a Creative Commons Attribution 4.0 International License.
.. http://creativecommons.org/licenses/by/4.0

.. _prh_configuration:

Configuration
=============

PRH fetches configuration directly from Consul service in the following JSON format:

.. code-block:: json

  {
    "aai": {
      "aaiClientConfiguration": {
        "aaiHost": "aai.onap.svc.cluster.local",
        "aaiHostPortNumber": 8443,
        "aaiIgnoreSslCertificateErrors": true,
        "aaiProtocol": "https",
        "aaiUserName": "AAI",
        "aaiUserPassword": "AAI",
        "aaiBasePath": "/aai/v12",
        "aaiPnfPath": "/network/pnfs/pnf",
      }
    },
    "dmaap": {
      "dmaapConsumerConfiguration": {
        "consumerGroup": "OpenDCAE-c12",
        "consumerId": "c12",
        "dmaapContentType": "application/json",
        "dmaapHostName": "message-router.onap.svc.cluster.local",
        "dmaapPortNumber": 3904,
        "dmaapProtocol": "http",
        "dmaapTopicName": "/events/unauthenticated.VES_PNFREG_OUTPUT",
        "dmaapUserName": "admin",
        "dmaapUserPassword": "admin",
        "messageLimit": -1,
        "timeoutMs": -1
      },
      "dmaapProducerConfiguration": {
        "dmaapContentType": "application/json",
        "dmaapHostName": "message-router.onap.svc.cluster.local",
        "dmaapPortNumber": 3904,
        "dmaapProtocol": "http",
        "dmaapTopicName": "/events/unauthenticated.PNF_READY",
        "dmaapUserName": "admin",
        "dmaapUserPassword": "admin"
      }
    },
    "security": {
      "trustStorePath": "/opt/app/prh/etc/cert/trust.jks",
      "trustStorePasswordPath": "/opt/app/prh/etc/cert/trust.pass",
      "keyStorePath": "/opt/app/prh/etc/cert/cert.jks",
      "keyStorePasswordPath": "/opt/app/prh/etc/cert/jks.pass",
      "enableAaiCertAuth": "false",
      "enableDmaapCertAuth": "false"
    }
  }

The configuration is created from PRH Cloudify blueprint by specifying **application_config** node during ONAP OOM/Kubernetes deployment.
