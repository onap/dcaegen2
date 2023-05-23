.. This work is licensed under a Creative Commons Attribution 4.0 International License.
.. http://creativecommons.org/licenses/by/4.0


Docker Installation
===================

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



Helm Installation
=================

The PRH microservice can be deployed using helm charts in the oom repository.


Deployment steps
================

- Default app config values can be updated in oom/kubernetes/dcaegen2-services/components/dcae-prh/values.yaml.

- Make the chart and deploy using the following command:

  .. code-block:: bash

    cd oom/kubernetes/
    make dcaegen2-services
    helm install dev-dcaegen2-services dcaegen2-services --namespace <namespace> --set global.masterPassword=<password>

- To deploy only PRH:

  .. code-block:: bash

    helm install dev-dcae-prh dcaegen2-services/components/dcae-prh --namespace <namespace> --set global.masterPassword=<password>

- To Uninstall

  .. code-block:: bash

    helm uninstall dev-dcae-prh

Application Configurations
==========================

Supported configuration modifiable in HELM charts under **applicationConfig** section.

.. code-block:: yaml

	applicationConfig:
	  dmaap.dmaapConsumerConfiguration.dmaapContentType: "application/json"
	  dmaap.dmaapConsumerConfiguration.consumerId: "c12"
	  dmaap.dmaapConsumerConfiguration.consumerGroup: "OpenDCAE-c12"
	  dmaap.dmaapConsumerConfiguration.timeoutMs: -1
	  dmaap.dmaapProducerConfiguration.dmaapContentType: "application/json"
	  dmaap.dmaapUpdateProducerConfiguration.dmaapContentType: "application/json"
	  aai.aaiClientConfiguration.pnfUrl: http://aai-internal.onap.svc.cluster.local:80/aai/v23/network/pnfs/pnf
	  aai.aaiClientConfiguration.baseUrl: http://aai-internal.onap.svc.cluster.local:80/aai/v23
	  aai.aaiClientConfiguration.aaiHost: aai-internal.onap.svc.cluster.local
	  aai.aaiClientConfiguration.aaiHostPortNumber: 80
	  aai.aaiClientConfiguration.aaiProtocol: "http"
	  aai.aaiClientConfiguration.aaiUserName: ${AAI_USER}
	  aai.aaiClientConfiguration.aaiUserPassword: ${AAI_PASSWORD}
	  aai.aaiClientConfiguration.aaiIgnoreSslCertificateErrors: true
	  aai.aaiClientConfiguration.aaiBasePath: "/aai/v23"
	  aai.aaiClientConfiguration.aaiPnfPath: "/network/pnfs/pnf"
	  aai.aaiClientConfiguration.aaiServiceInstancePath: "/business/customers/customer/{{customer}}/service-subscriptions/service-subscription/{{serviceType}}/service-instances/service-instance/{{serviceInstanceId}}"
	  aai.aaiClientConfiguration.aaiHeaders:
	      X-FromAppId: "prh"
	      X-TransactionId: "9999"
	      Accept: "application/json"
	      Real-Time: "true"
	      Authorization: ${AUTH_HDR}
	  security.trustStorePath: "/opt/app/prh/etc/cert/trust.jks"
	  security.trustStorePasswordPath: "/opt/app/prh/etc/cert/trust.pass"
	  security.keyStorePath: "/opt/app/prh/etc/cert/cert.jks"
	  security.keyStorePasswordPath: "/opt/app/prh/etc/cert/jks.pass"
	  security.enableAaiCertAuth: false
	  security.enableDmaapCertAuth: false
	  streams_publishes:
	      pnf-update:
	        type: "message_router"
	        dmaap_info:
	          topic_url: http://message-router.onap.svc.cluster.local:3904/events/unauthenticated.PNF_UPDATE
	      pnf-ready:
	        type: "message_router"
	        dmaap_info:
	          topic_url: http://message-router.onap.svc.cluster.local:3904/events/unauthenticated.PNF_READY
	  streams_subscribes:
	      ves-reg-output:
	        type: "message_router"
	        dmaap_info:
	          topic_url: http://message-router.onap.svc.cluster.local:3904/events/unauthenticated.VES_PNFREG_OUTPUT

The location of the configuration file should be set in ``CBS_CLIENT_CONFIG_PATH`` env, for example:

    ``CBS_CLIENT_CONFIG_PATH: /app-config-input/application_config.yaml``


For PRH 1.9.0 version (London) , a new mode has been introduced which allows early PNF registrations. This mode uses a direct Kafka consumer and not the DMAAP consumer. This mode is not the default mode and has to be activated by setting certain environment variables in the Helm chart values.yaml file under **applicationEnv**, as shown below:

.. code-block:: yaml


        - name: kafkaBoostrapServerConfig
          value: onap-strimzi-kafka-bootstrap:9092
        - name: groupIdConfig
          value: OpenDCAE-c12
        - name: kafkaUsername
          value: strimzi-kafka-admin
        - name: kafkaPassword
          valueFrom:
            secretKeyRef:
              key: password
              name: strimzi-kafka-admin
        - name: kafkaTopic
          value: unauthenticated.VES_PNFREG_OUTPUT
        - name: SPRING_PROFILES_ACTIVE
          value: autoCommitDisabled
        - name: JAAS_CONFIG
          valueFrom:
            secretKeyRef:
              key: sasl.jaas.config
              name: strimzi-kafka-admin
