.. This work is licensed under a Creative Commons Attribution 4.0 International License.
.. http://creativecommons.org/licenses/by/4.0

Installation
============

The following docker-compose-yaml file shows a default configuration. The file can be run using `docker compose up` command:

.. code-block:: yaml

  version: '3'
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
        --security.enableAaiCertAuth=false
        --security.enableDmaapCertAuth=false
        --security.keyStorePath=/opt/app/prh/etc/cert/cert.jks
        --security.keyStorePasswordPath=/opt/app/prh/etc/cert/jks.pass
        --security.trustStorePath=/opt/app/prh/etc/cert/trust.jks
        --security.trustStorePasswordPath=/opt/app/prh/etc/cert/trust.pass
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
^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Heartbeat: http://<container_address>:8100/heartbeat or https://<container_address>:8443/heartbeat

Start prh: http://<container_address>:8100/start or https://<container_address>:8433/start

Stop prh: http://<container_address>:8100/stopPrh or https://<container_address>:8433/stopPrh


Fix for bug (INT-1181) *PRH CSITs use incorrect path for service-instance*
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

**Undeploy PRH with current version (1.3.1) and manually deploy it with version 1.3.2. Steps to install the correction:**

- Fetch the correct blueprint from nexus - k8s-prh.yaml: https://nexus.onap.org/content/sites/raw/org.onap.dcaegen2.platform.blueprints/R5/blueprints/ (It should contain *aai.aaiClientConfiguration.baseUrl* parameter and prh-app-server:**1.3.2**)
- Undeploy existing PRH service (1.3.1) by going into k8s and bootstrap pod.

  - Enter the bootstrap pod: ``kubectl exec -it [pod name] -n onap /bin/bash``
  - Uninstall PRH: ``cfy executions start -d prh uninstall``
  - Delete deployment: ``cfy deployments delete prh``
  - Delete blueprint: ``cfy blueprints delete prh``
  - Replace the old blueprint with the new one (blueprints/k8s-prh.yaml)
  - Update bootstrap configmap with the new PRH version (1.3.2), from outside the pod. ``kubectl -n onap edit configmap [configmap name]``
  - Verify (inside the bootstrap pod) that the version is updated (/inputs/k8s-prh-inputs.yaml)
  - Upload the blueprint to cfy: ``cfy blueprints upload -b prh /blueprints/k8s-prh.yaml``
  - Create deployment: ``cfy deployments create -b prh -i /inputs/k8s-prh-inputs.yaml prh``
  - Install PRH: ``cfy executions start -d prh install``

- Verify that PRH pod is up and running.
