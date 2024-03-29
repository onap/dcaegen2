.. This work is licensed under a Creative Commons Attribution 4.0 International License.
.. http://creativecommons.org/licenses/by/4.0

Configuration
=============

VES expects to be able to fetch configuration directly from consul service in following JSON format:

.. code-block:: json

    {
      "collector.dynamic.config.update.frequency": "5",
      "event.transform.flag": "0",
      "collector.schema.checkflag": "1",
      "collector.dmaap.streamid": "fault=ves-fault|syslog=ves-syslog|heartbeat=ves-heartbeat|measurementsForVfScaling=ves-measurement|mobileFlow=ves-mobileflow|other=ves-other|stateChange=ves-statechange|thresholdCrossingAlert=ves-thresholdCrossingAlert|voiceQuality=ves-voicequality|sipSignaling=ves-sipsignaling|notification=ves-notification|pnfRegistration=ves-pnfRegistration|3GPP-FaultSupervision=ves-3gpp-fault-supervision|3GPP-Heartbeat=ves-3gpp-heartbeat|3GPP-Provisioning=ves-3gpp-provisioning|3GPP-PerformanceAssurance=ves-3gpp-performance-assurance",
      "collector.service.port": "8080",
      "collector.schema.file": "{\"v1\":\"./etc/CommonEventFormat_27.2.json\",\"v2\":\"./etc/CommonEventFormat_27.2.json\",\"v3\":\"./etc/CommonEventFormat_27.2.json\",\"v4\":\"./etc/CommonEventFormat_27.2.json\",\"v5\":\"./etc/CommonEventFormat_28.4.1.json\",\"v7\":\"./etc/CommonEventFormat_30.2_ONAP.json\"}",
      "collector.keystore.passwordfile": "/opt/app/VESCollector/etc/passwordfile",
      "streams_publishes": {
        "ves-measurement": {
          "type": "message_router",
          "dmaap_info": {
            "topic_url": "http://message-router:3904/events/unauthenticated.VES_MEASUREMENT_OUTPUT/"
          }
        },
        "ves-fault": {
          "type": "message_router",
          "dmaap_info": {
            "topic_url": "http://message-router:3904/events/unauthenticated.SEC_FAULT_OUTPUT/"
          }
        },
        "ves-pnfRegistration": {
          "type": "message_router",
          "dmaap_info": {
            "topic_url": "http://message-router:3904/events/unauthenticated.VES_PNFREG_OUTPUT/"
          }
        },
        "ves-other": {
          "type": "message_router",
          "dmaap_info": {
            "topic_url": "http://message-router:3904/events/unauthenticated.SEC_OTHER_OUTPUT/"
          }
        },
        "ves-heartbeat": {
          "type": "message_router",
          "dmaap_info": {
            "topic_url": "http://message-router:3904/events/unauthenticated.SEC_HEARTBEAT_OUTPUT/"
          }
        },
        "ves-notification": {
          "type": "message_router",
          "dmaap_info": {
            "topic_url": "http://message-router:3904/events/unauthenticated.VES_NOTIFICATION_OUTPUT/"
          }
        },
        "ves-3gpp-fault-supervision": {
          "type": "message_router",
          "dmaap_info": {
            "topic_url": "http://message-router:3904/events/unauthenticated.SEC_3GPP_FAULTSUPERVISION_OUTPUT/"
          }
        },
        "ves-3gpp-provisioning": {
          "type": "message_router",
          "dmaap_info": {
            "topic_url": "http://message-router:3904/events/unauthenticated.SEC_3GPP_PROVISIONING_OUTPUT/"
          }
        },
        "ves-3gpp-heartbeat": {
          "type": "message_router",
          "dmaap_info": {
            "topic_url": "http://message-router:3904/events/unauthenticated.SEC_3GPP_HEARTBEAT_OUTPUT/"
          }
        },
        "ves-3gpp-performance-assurance": {
          "type": "message_router",
          "dmaap_info": {
            "topic_url": "http://message-router:3904/events/unauthenticated.SEC_3GPP_PERFORMANCEASSURANCE_OUTPUT/"
          }
        }
      },
      "collector.externalSchema.checkflag": 1,
      "collector.externalSchema.schemasLocation": "./etc/externalRepo",
      "collector.externalSchema.mappingFileLocation": "./etc/externalRepo/schema-map.json",
      "event.externalSchema.schemaRefPath": "/event/stndDefinedFields/schemaReference",
      "event.externalSchema.stndDefinedDataPath": "/event/stndDefinedFields/data",
      "collector.service.secure.port": "8443",
      "auth.method": "noAuth",
      "collector.keystore.file.location": "/opt/app/VESCollector/etc/keystore",
      "services_calls": [],
      "header.authlist": "sample1,$2a$10$0buh.2WeYwN868YMwnNNEuNEAMNYVU9.FSMJGyIKV3dGET/7oGOi6"
    }

During ONAP OOM/Kubernetes deployment this configuration is created from VES Cloudify blueprint.
