.. This work is licensed under a Creative Commons Attribution 4.0 International License.
.. http://creativecommons.org/licenses/by/4.0

Configuration
=============

HV-VES expects to be able to fetch configuration directly from consul service in following JSON format:

.. code-block:: json

    {
        "dmaap.kafkaBootstrapServers": "kafka-host:9093",
        "collector.routing": [
                {
                    "fromDomain": "PERF3GPP",
                    "toTopic": "topic-1"
                },
                {
                    "fromDomain": "HEARTBEAT",
                    "toTopic": "topic-2"
                },
                ...
        ]
    }


During ONAP OOM/Kubernetes deployment this configuration is created from HV-VES cloudify blueprint.

Endpoint on which HV-VES seeks configuration can be configured during deployment as described in installation_.

.. _installation: ./installation.html