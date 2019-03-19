.. This work is licensed under a Creative Commons Attribution 4.0 International License.
.. http://creativecommons.org/licenses/by/4.0

.. _run_time_configuration:

Run-Time configuration
======================

(see :ref:`deployment`)

HV-VES fetches configuration from Config Binding Service in the following JSON format:

.. code-block:: json

    {
        "dmaap.kafkaBootstrapServers": "message-router-kafka:9093",
        "collector.routing": [
                {
                    "fromDomain": "perf3gpp",
                    "toTopic": "HV_VES_PERF3GPP"
                },
                {
                    "fromDomain": "heartbeat",
                    "toTopic": "HV_VES_HEARTBEAT"
                },
                ...
        ]
    }

HV-VES does not verify the correctness of configuration data and uses them as is, in particular:

- **KafkaBootstrapServers** is used as host name and port for publishing events to Kafka service.
- Every **routing** array object specifies one event publishing route.

  - **fromDomain** node should be a case-sensitive string of single domain taken from VES Common Event Header specification.
  - **toTopic** should be a case-sensitive string of Kafka topic.
  - When HV-VES receives VES Event, it checks the domain contained in it. If the route from that domain to any topic exists in configuration, then HV-VES publishes that event to topic in that route.
  - If there are two routes from the same domain to different topics, then it is undefined which route will be used.

The configuration is created from HV-VES Cloudify blueprint by specifying **application_config** node during ONAP OOM/Kubernetes deployment. Example of the node specification:

.. code-block:: YAML

    node_templates:
      hv-ves:
        properties:
          application_config:
            dmaap.kafkaBootstrapServers: message-router-kafka:9092
            collector.routing:
              fromDomain: perf3gpp
              toTopic: HV_VES_PERF3GPP

HV-VES waits 10 seconds (default, configurable during deployment with **firstRequestDelay** option, see :ref:`configuration_file`) before the first attempt to retrieve configuration from CBS. This is to prevent possible synchronization issues. During that time HV-VES declines any connection attempts from xNF (VNF/PNF).

After first request, HV-VES asks for configuration in fixed intervals, configurable from file configuration (**requestInterval**). By default interval is set to 5 seconds.

In case of failing to retrieve configuration, collector retries the action. After five unsuccessful attempts, container becomes unhealthy and cannot recover. HV-VES in this state is unusable and the container should be restarted.
