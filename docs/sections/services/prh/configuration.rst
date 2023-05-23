.. This work is licensed under a Creative Commons Attribution 4.0 International License.
.. http://creativecommons.org/licenses/by/4.0

.. _prh_configuration:

Configuration
=============

PRH fetches configuration directly from CBS service in the following JSON format:

.. code-block:: json

  {
    "config":{
      "dmaap.dmaapConsumerConfiguration.dmaapUserName":"admin",
      "dmaap.dmaapConsumerConfiguration.dmaapUserPassword":"admin",
      "dmaap.dmaapConsumerConfiguration.consumerId":"c12",
      "dmaap.dmaapConsumerConfiguration.consumerGroup":"OpenDCAE-c12",
      "dmaap.dmaapConsumerConfiguration.timeoutMs":-1,

      "dmaap.dmaapProducerConfiguration.dmaapUserName":"admin",
      "dmaap.dmaapProducerConfiguration.dmaapUserPassword":"admin",
      "dmaap.dmaapUpdateProducerConfiguration.dmaapUserName":"admin",
      "dmaap.dmaapUpdateProducerConfiguration.dmaapUserPassword":"admin",
      "aai.aaiClientConfiguration.pnfUrl": "https://aai.onap.svc.cluster.local:8443/aai/v12/network/pnfs/pnf",
      "aai.aaiClientConfiguration.baseUrl": "https://aai.onap.svc.cluster.local:8443/aai/v12",
      "aai.aaiClientConfiguration.aaiUserName":"AAI",
      "aai.aaiClientConfiguration.aaiUserPassword":"AAI",
      "aai.aaiClientConfiguration.aaiIgnoreSslCertificateErrors":true,
      "aai.aaiClientConfiguration.aaiServiceInstancePath":"/business/customers/customer/${customer}/service-subscriptions/service-subscription/${serviceType}/service-instances/service-instance/${serviceInstanceId}",
      "aai.aaiClientConfiguration.aaiHeaders":{
        "X-FromAppId":"prh",
        "X-TransactionId":"9999",
        "Accept":"application/json",
        "Real-Time":"true",
        "Authorization":"Basic QUFJOkFBSQ=="
      },
      "security.trustStorePath":"/opt/app/prh/local/org.onap.prh.trust.jks",
      "security.trustStorePasswordPath":"change_it",
      "security.keyStorePath":"/opt/app/prh/local/org.onap.prh.p12",
      "security.keyStorePasswordPath":"change_it",
      "security.enableAaiCertAuth":false,
      "security.enableDmaapCertAuth":false,
      "streams_publishes":{
        "pnf-update":{
          "type": "message_router",
          "dmaap_info":{
            "topic_url":"http://dmaap-mr:2222/events/unauthenticated.PNF_UPDATE"
          }
        },
        "pnf-ready":{
          "type": "message_router",
          "dmaap_info":{
            "topic_url":"http://dmaap-mr:2222/events/unauthenticated.PNF_READY"
          }
        }
      },
      "streams_subscribes":{
        "ves-reg-output":{
          "type": "message_router",
          "dmaap_info":{
            "topic_url":"http://dmaap-mr:2222/events/unauthenticated.VES_PNFREG_OUTPUT"
          }
        }
      }
    }
  }

The configuration is created from PRH helm charts by specifying **applicationConfig**  during ONAP OOM/Kubernetes deployment.

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
