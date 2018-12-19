.. This work is licensed under a Creative Commons Attribution 4.0 International License.
.. http://creativecommons.org/licenses/by/4.0

.. _healthcheck_and_monitoring:

Healthcheck
===========

Inside HV-VES docker container runs small http service for healthcheck - exact port for this service can be configured
at deployment using `--health-check-api-port` command line option.

This service exposes single endpoint **GET /health/ready** which returns **HTTP 200 OK** in case HV-VES is healthy
and ready for connections. Otherwise it returns **HTTP 503 Service Unavailable** with short reason of unhealthiness.


Monitoring
==========
HV-VES collector allows to collect metrics data at runtime. This is done by utilizing `Prometheus.io`_.
HV-VES application exposes endpoint monitoring/prometheus which provides data that could be consumed by Prometheus service.
Prometheus endpoint share the same port as healthchecks.

.. _`Prometheus.io`: https://prometheus.io/

Provided by HV-VES metrics (counters, timers, gauges):

+-----------------------------------------------+--------------+----------------------------------------------------+
|           Name of metric                      |     Unit     |              Description                           |
+===============================================+==============+====================================================+
|hvves_clients_rejected_total                   |     piece    | total number of rejected client                    |
+-----------------------------------------------+--------------+----------------------------------------------------+
|hvves_connections_active                       |     piece    | total number of active connections                 |
+-----------------------------------------------+--------------+----------------------------------------------------+
|hvves_connections_total                        |     piece    | total number of connections                        |
+-----------------------------------------------+--------------+----------------------------------------------------+
|hvves_data_received_bytes_total                |     bytes    | total number of received bytes                     |
+-----------------------------------------------+--------------+----------------------------------------------------+
|hvves_disconnections_total                     |     piece    | total number of disconnections                     |
+-----------------------------------------------+--------------+----------------------------------------------------+
|hvves_messages_dropped_cause_total             |  piece/cause | total number of dropped messages per cause         |
+-----------------------------------------------+--------------+----------------------------------------------------+
|hvves_messages_dropped_total                   |     piece    | total number of dropped messages                   |
+-----------------------------------------------+--------------+----------------------------------------------------+
|hvves_messages_latency_seconds_count           |    seconds   | latency of single message                          |
+-----------------------------------------------+--------------+----------------------------------------------------+
|hvves_messages_latency_seconds_max             |    seconds   | maximal observed latency                           |
+-----------------------------------------------+--------------+----------------------------------------------------+
|hvves_messages_latency_seconds_sum             |    seconds   | sum of latency parameter from each message         |
+-----------------------------------------------+--------------+----------------------------------------------------+
|hvves_messages_processing_time_seconds_count   |    seconds   | processing time for each message                   |
+-----------------------------------------------+--------------+----------------------------------------------------+
|hvves_messages_processing_time_seconds_max     |    seconds   | maximal processing time                            |
+-----------------------------------------------+--------------+----------------------------------------------------+
|hvves_messages_processing_time_seconds_sum     |    seconds   | sum of processing time from each message           |
+-----------------------------------------------+--------------+----------------------------------------------------+
|hvves_messages_received_payload_bytes_total    |     bytes    | total number of received bytes                     |
+-----------------------------------------------+--------------+----------------------------------------------------+
|hvves_messages_received_total                  |     piece    | total number of received messages                  |
+-----------------------------------------------+--------------+----------------------------------------------------+
|hvves_messages_sent_total                      |     piece    | number of sent messages                            |
+-----------------------------------------------+--------------+----------------------------------------------------+

Sample response for GET from monitoring/prometheus endpoint :

.. code-block::
process_cpu_usage 0.00796812749003984
jvm_memory_used_bytes{area="nonheap",id="CodeHeap 'non-nmethods'",} 1234560.0
jvm_memory_used_bytes{area="nonheap",id="Metaspace",} 2.5874296E7
jvm_memory_used_bytes{area="nonheap",id="CodeHeap 'profiled nmethods'",} 4940288.0
jvm_memory_used_bytes{area="nonheap",id="Compressed Class Space",} 3228312.0
jvm_memory_used_bytes{area="heap",id="G1 Eden Space",} 3.145728E7
jvm_memory_used_bytes{area="heap",id="G1 Old Gen",} 3270408.0
jvm_memory_used_bytes{area="heap",id="G1 Survivor Space",} 4194304.0
jvm_memory_used_bytes{area="nonheap",id="CodeHeap 'non-profiled nmethods'",} 1007744.0
hvves_messages_dropped_count_total 0.0
jvm_buffer_count{id="mapped",} 0.0
jvm_buffer_count{id="direct",} 9.0
hvves_messages_received_bytes_total 0.0
jvm_classes_loaded 5544.0
hvves_messages_received_count_total 0.0
system_cpu_usage 0.34063745019920316
hvves_data_received_bytes_total 0.0
hvves_clients_rejected_count_total 0.0
jvm_gc_memory_allocated_bytes_total 5.24288E7
jvm_classes_unloaded_total 0.0
jvm_threads_live 25.0
system_load_average_1m 1.35
jvm_memory_max_bytes{area="nonheap",id="CodeHeap 'non-nmethods'",} 5832704.0
jvm_memory_max_bytes{area="nonheap",id="Metaspace",} -1.0
jvm_memory_max_bytes{area="nonheap",id="CodeHeap 'profiled nmethods'",} 1.22912768E8
jvm_memory_max_bytes{area="nonheap",id="Compressed Class Space",} 1.073741824E9
jvm_memory_max_bytes{area="heap",id="G1 Eden Space",} -1.0
jvm_memory_max_bytes{area="heap",id="G1 Old Gen",} 4.175429632E9
jvm_memory_max_bytes{area="heap",id="G1 Survivor Space",} -1.0
jvm_memory_max_bytes{area="nonheap",id="CodeHeap 'non-profiled nmethods'",} 1.22912768E8
jvm_gc_live_data_size_bytes 3939984.0
hvves_messages_latency_time_seconds_count 0.0
hvves_messages_latency_time_seconds_sum 0.0
hvves_messages_latency_time_seconds_max 0.0
jvm_memory_committed_bytes{area="nonheap",id="CodeHeap 'non-nmethods'",} 2555904.0
jvm_memory_committed_bytes{area="nonheap",id="Metaspace",} 2.660352E7
jvm_memory_committed_bytes{area="nonheap",id="CodeHeap 'profiled nmethods'",} 4980736.0
jvm_memory_committed_bytes{area="nonheap",id="Compressed Class Space",} 3534848.0
jvm_memory_committed_bytes{area="heap",id="G1 Eden Space",} 5.4525952E7
jvm_memory_committed_bytes{area="heap",id="G1 Old Gen",} 3.32398592E8
jvm_memory_committed_bytes{area="heap",id="G1 Survivor Space",} 4194304.0
jvm_memory_committed_bytes{area="nonheap",id="CodeHeap 'non-profiled nmethods'",} 2555904.0
jvm_threads_peak 25.0
hvves_connections_active_count 0.0
hvves_messages_sent_count_total 0.0
jvm_gc_memory_promoted_bytes_total 379000.0
hvves_connections_total_count_total 0.0
hvves_disconnections_count_total 0.0
jvm_threads_daemon 24.0
hvves_messages_processing_time_seconds_max 0.0
hvves_messages_processing_time_seconds_count 0.0
hvves_messages_processing_time_seconds_sum 0.0
jvm_gc_max_data_size_bytes 4.175429632E9
hvves_messages_processing_count 0.0
jvm_buffer_memory_used_bytes{id="mapped",} 0.0
jvm_buffer_memory_used_bytes{id="direct",} 8.389428E7
jvm_buffer_total_capacity_bytes{id="mapped",} 0.0
jvm_buffer_total_capacity_bytes{id="direct",} 8.3894279E7
jvm_gc_pause_seconds_count{action="end of minor GC",cause="G1 Evacuation Pause",} 1.0
jvm_gc_pause_seconds_sum{action="end of minor GC",cause="G1 Evacuation Pause",} 0.024
jvm_gc_pause_seconds_count{action="end of minor GC",cause="Metadata GC Threshold",} 1.0
jvm_gc_pause_seconds_sum{action="end of minor GC",cause="Metadata GC Threshold",} 0.014
jvm_gc_pause_seconds_max{action="end of minor GC",cause="G1 Evacuation Pause",} 0.024
jvm_gc_pause_seconds_max{action="end of minor GC",cause="Metadata GC Threshold",} 0.014
system_cpu_count 4.0
