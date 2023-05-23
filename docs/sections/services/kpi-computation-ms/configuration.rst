.. This work is licensed under a Creative Commons Attribution 4.0 International License.
.. http://creativecommons.org/licenses/by/4.0

Configuration
=============

KPI Computation MS expects to be able to fetch configuration in following JSON format:

.. code-block:: json

    {
      "pollingInterval": 20,
      "aafUsername": "dcae@dcae.onap.org",
      "streams_publishes": {
        "kpi_topic": {
          "type": "message-router",
          "dmaap_info": {
            "topic_url": "https://message-router.onap.svc.cluster.local:3905/events/unauthenticated.DCAE_KPI_OUTPUT"
          }
        }
      },
      "trust_store_pass_path": "/opt/app/kpims/etc/cert/trust.pass",
      "cid": "kpi-cid",
      "cg": "kpi-cg",
      "streams_subscribes": {
        "performance_management_topic": {
          "aaf_password": "demo123456!",
          "type": "message-router",
          "dmaap_info": {
            "topic_url": "https://message-router.onap.svc.cluster.local:3905/events/org.onap.dmaap.mr.PERFORMANCE_MEASUREMENTS"
          },
          "aaf_username": "dcae@dcae.onap.org"
        }
      },
      "trust_store_path": "/opt/app/kpims/etc/cert/trust.jks",
      "pollingTimeout": 60,
      "cbsPollingInterval": 60,
      "aafPassword": "demo123456!",
      "kpi.policy": "{\"domain\":\"measurementsForKpi\",\"methodForKpi\":[{\"eventName\":\"perf3gpp_CORE-AMF_pmMeasResult\",\"controlLoopSchemaType\":\"SLICE\",\"policyScope\":\"resource=networkSlice;type=configuration\",\"policyName\":\"configuration.dcae.microservice.kpi-computation\",\"policyVersion\":\"v0.0.1\",\"kpis\":[{\"measType\":\"AMFRegNbr\",\"operation\":\"SUM\",\"operands\":\"RM.RegisteredSubNbrMean\"}]},{\"eventName\":\"perf3gpp_AcmeNode-Acme_pmMeasResult\",\"controlLoopSchemaType\":\"SLICE\",\"policyScope\":\"resource=networkSlice;type=configuration\",\"policyName\":\"configuration.dcae.microservice.kpi-computation\",\"policyVersion\":\"v0.0.1\",\"kpis\":[{\"measType\":\"UpstreamThr\",\"operation\":\"SUM\",\"operands\":\"GTP.InDataOctN3UPF\"},{\"measType\":\"DownstreamThr\",\"operation\":\"SUM\",\"operands\":\"GTP.OutDataOctN3UPF\"}]}]}",
      "dmaap.server": ["message-router"]
    }

During ONAP OOM/Kubernetes deployment this configuration is created from Helm chart based on properties defined under **applicationConfig** section.
