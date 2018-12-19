.. This work is licensed under a Creative Commons Attribution 4.0 International License.
.. http://creativecommons.org/licenses/by/4.0

.. _healthcheck:

Healthcheck and Monitoring
==========================

Healthcheck
-----------
Inside HV-VES docker container runs small http service for healthcheck - exact port for this service can be configured
at deployment using `--health-check-api-port` command line option.

This service exposes single endpoint **GET /health/ready** which returns **HTTP 200 OK** in case HV-VES is healthy
and ready for connections. Otherwise it returns **HTTP 503 Service Unavailable** with short reason of unhealthiness.


Monitoring
----------
HV-VES collector allows to collect metrics data at runtime. This is done by utilizing `Prometheus.io`_.
HV-VES application exposes endpoint monitoring/prometheus which provides data that could be consumed by Prometheus service.
Prometheus endpoint share the same port as healthchecks.

.. _`Prometheus.io`: https://prometheus.io/

Provided by HV-VES metrics:

+-----------------------------------------------+--------------+-----------------------------------------------------+
|           Name of metric                      |     Unit     |              Description                            |
+===============================================+==============+=====================================================+
| hvves_clients_rejected_cause_total            |  cause/piece | cause of client rejection per number of occurencies |
+-----------------------------------------------+--------------+-----------------------------------------------------+
| hvves_clients_rejected_total                  |     piece    | total number of rejected client                     |
+-----------------------------------------------+--------------+-----------------------------------------------------+
| hvves_connections_active                      |     piece    | number of currently active connections              |
+-----------------------------------------------+--------------+-----------------------------------------------------+
| hvves_connections_total                       |     piece    | total number of connections                         |
+-----------------------------------------------+--------------+-----------------------------------------------------+
| hvves_data_received_bytes_total               |     bytes    | total number of received bytes                      |
+-----------------------------------------------+--------------+-----------------------------------------------------+
| hvves_disconnections_total                    |     piece    | total number of disconnections                      |
+-----------------------------------------------+--------------+-----------------------------------------------------+
| hvves_messages_dropped_cause_total            |  cause/piece | cause of drop per number of occurencies             |
+-----------------------------------------------+--------------+-----------------------------------------------------+
| hvves_messages_dropped_total                  |     piece    | total number of dropped messages                    |
+-----------------------------------------------+--------------+-----------------------------------------------------+
| hvves_messages_latency_seconds_count          |     piece    | counter for number of latency appearance            |
+-----------------------------------------------+--------------+-----------------------------------------------------+
| hvves_messages_latency_seconds_max            |    seconds   | maximal observed latency                            |
+-----------------------------------------------+--------------+-----------------------------------------------------+
| hvves_messages_latency_seconds_sum            |    seconds   | sum of latency parameter from each message          |
+-----------------------------------------------+--------------+-----------------------------------------------------+
| hvves_messages_processing_time_seconds_count  |     piece    | counter for number of processing time appearance    |
+-----------------------------------------------+--------------+-----------------------------------------------------+
| hvves_messages_processing_time_seconds_max    |    seconds   | maximal processing time                             |
+-----------------------------------------------+--------------+-----------------------------------------------------+
| hvves_messages_processing_time_seconds_sum    |    seconds   | sum of processing time from each message            |
+-----------------------------------------------+--------------+-----------------------------------------------------+
| hvves_messages_received_payload_bytes_total   |     bytes    | total number of received payload bytes              |
+-----------------------------------------------+--------------+-----------------------------------------------------+
| hvves_messages_received_total                 |     piece    | total number of received messages                   |
+-----------------------------------------------+--------------+-----------------------------------------------------+
| hvves_messages_sent_topic_total               |  topic/piece | topic per number of sent messages                   |
+-----------------------------------------------+--------------+-----------------------------------------------------+
| hvves_messages_sent_total                     |     piece    | number of sent messages                             |
+-----------------------------------------------+--------------+-----------------------------------------------------+

JVM metrics:

-jvm_buffer_memory_used_bytes
-jvm_classes_unloaded_total
-jvm_gc_memory_promoted_bytes_total
-jvm_buffer_total_capacity_bytes
-jvm_threads_live
-jvm_classes_loaded
-jvm_gc_memory_allocated_bytes_total
-jvm_threads_daemon
-jvm_buffer_count
-jvm_gc_pause_seconds_count
-jvm_gc_pause_seconds_sum
-jvm_gc_pause_seconds_max
-jvm_gc_max_data_size_bytes
-jvm_memory_committed_bytes
-jvm_gc_live_data_size_bytes
-jvm_memory_max_bytes
-jvm_memory_used_bytes
-jvm_threads_peak

Sample response for GET from monitoring/prometheus endpoint:

.. literalinclude:: metrics_sample_response.txt
