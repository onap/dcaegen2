.. This work is licensed under a Creative Commons Attribution 4.0 International License.
.. http://creativecommons.org/licenses/by/4.0

.. _healthcheck_and_monitoring:

Healthcheck and Monitoring
==========================

Healthcheck
-----------
Inside HV-VES docker container runs a small HTTP service for healthcheck. Port for healthchecks can be configured
at deployment using command line (for details see :ref:`deployment`).

This service exposes endpoint **GET /health/ready** which returns a **HTTP 200 OK** when HV-VES is healthy
and ready for connections. Otherwise it returns a **HTTP 503 Service Unavailable** message with a short reason of unhealthiness.


Monitoring
----------
HV-VES collector allows to collect metrics data at runtime. To serve this purpose HV-VES application exposes an endpoint **GET /monitoring/prometheus**
which returns a **HTTP 200 OK** message with a specific data in its body. Returned data is in a format readable by Prometheus service.
Prometheus endpoint shares a port with healthchecks.

Metrics provided by HV-VES metrics:

+-----------------------------------------------+--------------+------------------------------------------------------------------------------------------+
|           Name of metric                      |     Unit     |              Description                                                                 |
+===============================================+==============+==========================================================================================+
| hvves_clients_rejected_cause_total            |  cause/piece | number of rejected clients grouped by cause                                              |
+-----------------------------------------------+--------------+------------------------------------------------------------------------------------------+
| hvves_clients_rejected_total                  |     piece    | total number of rejected clients                                                         |
+-----------------------------------------------+--------------+------------------------------------------------------------------------------------------+
| hvves_connections_active                      |     piece    | number of currently active connections                                                   |
+-----------------------------------------------+--------------+------------------------------------------------------------------------------------------+
| hvves_connections_total                       |     piece    | total number of connections                                                              |
+-----------------------------------------------+--------------+------------------------------------------------------------------------------------------+
| hvves_data_received_bytes_total               |     bytes    | total number of received bytes                                                           |
+-----------------------------------------------+--------------+------------------------------------------------------------------------------------------+
| hvves_disconnections_total                    |     piece    | total number of disconnections                                                           |
+-----------------------------------------------+--------------+------------------------------------------------------------------------------------------+
| hvves_messages_dropped_cause_total            |  cause/piece | number of dropped messages grouped by cause                                              |
+-----------------------------------------------+--------------+------------------------------------------------------------------------------------------+
| hvves_messages_dropped_total                  |     piece    | total number of dropped messages                                                         |
+-----------------------------------------------+--------------+-----------------------------------+------------------------------------------------------+
| hvves_messages_latency_seconds_bucket         |     seconds  | latency is a time between         |  cumulative counters for the latency occurance       |
+-----------------------------------------------+--------------+ message.header.lastEpochMicrosec  +------------------------------------------------------+
| hvves_messages_latency_seconds_count          |     piece    | and time when data has been sent  |  counter for number of latency occurance             |
+-----------------------------------------------+--------------+ from HV-VES to Kafka              +------------------------------------------------------+
| hvves_messages_latency_seconds_max            |    seconds   |                                   |  maximal observed latency                            |
+-----------------------------------------------+--------------+                                   +------------------------------------------------------+
| hvves_messages_latency_seconds_sum            |    seconds   |                                   |  sum of latency parameter from each message          |
+-----------------------------------------------+--------------+-----------------------------------+------------------------------------------------------+
| hvves_messages_processing_time_seconds_bucket |    seconds   | processing time is time meassured |  cumulative counters for processing time occurance   |
+-----------------------------------------------+--------------+ between decoding of WTP message   +------------------------------------------------------+
| hvves_messages_processing_time_seconds_count  |     piece    | and time when data has been sent  |  counter for number of processing time occurance     |
+-----------------------------------------------+--------------+ From HV-VES to Kafka              +------------------------------------------------------+
| hvves_messages_processing_time_seconds_max    |    seconds   |                                   |  maximal processing time                             |
+-----------------------------------------------+--------------+                                   +------------------------------------------------------+
| hvves_messages_processing_time_seconds_sum    |    seconds   |                                   |  sum of processing time from each message            |
+-----------------------------------------------+--------------+-----------------------------------+------------------------------------------------------+
| hvves_messages_received_payload_bytes_total   |     bytes    | total number of received payload bytes                                                   |
+-----------------------------------------------+--------------+------------------------------------------------------------------------------------------+
| hvves_messages_received_total                 |     piece    | total number of received messages                                                        |
+-----------------------------------------------+--------------+------------------------------------------------------------------------------------------+
| hvves_messages_sent_topic_total               |  topic/piece | number of sent messages grouped by topic                                                 |
+-----------------------------------------------+--------------+------------------------------------------------------------------------------------------+
| hvves_messages_sent_total                     |     piece    | number of sent messages                                                                  |
+-----------------------------------------------+--------------+------------------------------------------------------------------------------------------+

JVM metrics:

- jvm_buffer_memory_used_bytes
- jvm_classes_unloaded_total
- jvm_gc_memory_promoted_bytes_total
- jvm_buffer_total_capacity_bytes
- jvm_threads_live
- jvm_classes_loaded
- jvm_gc_memory_allocated_bytes_total
- jvm_threads_daemon
- jvm_buffer_count
- jvm_gc_pause_seconds_count
- jvm_gc_pause_seconds_sum
- jvm_gc_pause_seconds_max
- jvm_gc_max_data_size_bytes
- jvm_memory_committed_bytes
- jvm_gc_live_data_size_bytes
- jvm_memory_max_bytes
- jvm_memory_used_bytes
- jvm_threads_peak

Sample response for **GET monitoring/prometheus**:

.. literalinclude:: resources/metrics_sample_response.txt
