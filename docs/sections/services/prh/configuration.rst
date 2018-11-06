.. This work is licensed under a Creative Commons Attribution 4.0 International License.
.. http://creativecommons.org/licenses/by/4.0

Configuration
=============

PRH expects to be able to fetch configuration directly from consul service in following JSON format:

.. code-block:: json

    {
        "dmaap.dmaapProducerConfiguration.dmaapTopicName":"/events/unauthenticated.PNF_READY",
        "dmaap.dmaapConsumerConfiguration.dmaapHostName":"message-router.onap.svc.cluster.local",
        "aai.aaiClientConfiguration.aaiPnfPath":"/network/pnfs/pnf",
        "aai.aaiClientConfiguration.aaiUserPassword":"AAI",
        "dmaap.dmaapConsumerConfiguration.dmaapUserName":"admin",
        "aai.aaiClientConfiguration.aaiBasePath":"/aai/v12",
        "dmaap.dmaapConsumerConfiguration.timeoutMs":-1,
        "dmaap.dmaapProducerConfiguration.dmaapPortNumber":3904,
        "aai.aaiClientConfiguration.aaiHost":"aai.onap.svc.cluster.local",
        "dmaap.dmaapConsumerConfiguration.dmaapUserPassword":"admin",
        "dmaap.dmaapProducerConfiguration.dmaapProtocol":"http",
        "aai.aaiClientConfiguration.aaiIgnoreSslCertificateErrors":true,
        "dmaap.dmaapProducerConfiguration.dmaapContentType":"application/json",
        "dmaap.dmaapConsumerConfiguration.dmaapTopicName":"/events/unauthenticated.VES_PNFREG_OUTPUT",
        "dmaap.dmaapConsumerConfiguration.dmaapPortNumber":3904,
        "dmaap.dmaapConsumerConfiguration.dmaapContentType":"application/json",
        "dmaap.dmaapConsumerConfiguration.messageLimit":-1,
        "dmaap.dmaapConsumerConfiguration.dmaapProtocol":"http",
        "aai.aaiClientConfiguration.aaiUserName":"AAI",
        "dmaap.dmaapConsumerConfiguration.consumerId":"c12",
        "dmaap.dmaapProducerConfiguration.dmaapHostName":"message-router.onap.svc.cluster.local",
        "aai.aaiClientConfiguration.aaiHostPortNumber":8443,
        "dmaap.dmaapConsumerConfiguration.consumerGroup":"OpenDCAE-c12",
        "aai.aaiClientConfiguration.aaiProtocol":"https",
        "dmaap.dmaapProducerConfiguration.dmaapUserName":"admin",
        "dmaap.dmaapProducerConfiguration.dmaapUserPassword":"admin"
    }

