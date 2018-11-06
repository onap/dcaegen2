.. This work is licensed under a Creative Commons Attribution 4.0 International License.
.. http://creativecommons.org/licenses/by/4.0

Installation
============

Following docker-compose-yaml file shows default configuration and can be run using `docker compose up` command:

.. code-block:: yaml

version: '2'
services:
  prh:
    image: nexus3.onap.org:10003/onap/org.onap.dcaegen2.services.prh.prh-app-server
    command: >
      --dmaap.dmaapConsumerConfiguration.dmaapHostName=10.42.111.36
      --dmaap.dmaapConsumerConfiguration.dmaapPortNumber=8904
      --dmaap.dmaapConsumerConfiguration.dmaapTopicName=/events/unauthenticated.SEC_OTHER_OUTPUT
      --dmaap.dmaapConsumerConfiguration.dmaapProtocol=http
      --dmaap.dmaapConsumerConfiguration.dmaapUserName=admin
      --dmaap.dmaapConsumerConfiguration.dmaapUserPassword=admin
      --dmaap.dmaapConsumerConfiguration.dmaapContentType=application/json
      --dmaap.dmaapConsumerConfiguration.consumerId=c12
      --dmaap.dmaapConsumerConfiguration.consumerGroup=OpenDCAE-c12
      --dmaap.dmaapConsumerConfiguration.timeoutMS=-1
      --dmaap.dmaapConsumerConfiguration.message-limit=-1
      --dmaap.dmaapProducerConfiguration.dmaapHostName=10.42.111.36
      --dmaap.dmaapProducerConfiguration.dmaapPortNumber=8904
      --dmaap.dmaapProducerConfiguration.dmaapTopicName=/events/unauthenticated.PNF_READY
      --dmaap.dmaapProducerConfiguration.dmaapProtocol=http
      --dmaap.dmaapProducerConfiguration.dmaapUserName=admin
      --dmaap.dmaapProducerConfiguration.dmaapUserPassword=admin
      --dmaap.dmaapProducerConfiguration.dmaapContentType=application/json
      --aai.aaiClientConfiguration.aaiHostPortNumber=30233
      --aai.aaiClientConfiguration.aaiHost=10.42.111.45
      --aai.aaiClientConfiguration.aaiProtocol=https
      --aai.aaiClientConfiguration.aaiUserName=admin
      --aai.aaiClientConfiguration.aaiUserPassword=admin
      --aai.aaiClientConfiguration.aaiIgnoreSSLCertificateErrors=true
      --aai.aaiClientConfiguration.aaiBasePath=/aai/v11
      --aai.aaiClientConfiguration.aaiPnfPath=/network/pnfs/pnf
    entrypoint:
      - java
      - -Dspring.profiles.active=dev
      - -jar
      - /opt/prh-app-server.jar
    ports:
      - "8100:8100"
      - "8433:8433"
    restart: always


Running with dev-mode of PRH
==============================

Heartbeat: http://<container_address>:8100/heartbeat or https://<container_address>:8443/heartbeat

Start prh: http://<container_address>:8100/start or https://<container_address>:8433/start

Stop prh: http://<container_address>:8100/stopPrh or https://<container_address>:8433/stopPrh