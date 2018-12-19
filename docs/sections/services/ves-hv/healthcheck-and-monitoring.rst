.. This work is licensed under a Creative Commons Attribution 4.0 International License.
.. http://creativecommons.org/licenses/by/4.0

.. _healthcheck_and_monitoring:

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

+-----------------------------------------------+--------------+----------------------------------------------------+
|           Name of metric                      |     Unit     |              Description                           |
+===============================================+==============+====================================================+
|hvves_clients_rejected_cause_total             |  cause/piece | cause of client rejection per number of occurencies|                                                    |
+-----------------------------------------------+--------------+----------------------------------------------------+
|hvves_clients_rejected_total                   |     piece    | total number of rejected client                    |
+-----------------------------------------------+--------------+----------------------------------------------------+
|hvves_connections_active                       |     piece    | number of currently active connections             |
+-----------------------------------------------+--------------+----------------------------------------------------+
|hvves_connections_total                        |     piece    | total number of connections                        |
+-----------------------------------------------+--------------+----------------------------------------------------+
|hvves_data_received_bytes_total                |     bytes    | total number of received bytes                     |
+-----------------------------------------------+--------------+----------------------------------------------------+
|hvves_disconnections_total                     |     piece    | total number of disconnections                     |
+-----------------------------------------------+--------------+----------------------------------------------------+
|hvves_messages_dropped_cause_total             |  cause/piece | cause of drop per number of occurencies            |
+-----------------------------------------------+--------------+----------------------------------------------------+
|hvves_messages_dropped_total                   |     piece    | total number of dropped messages                   |
+-----------------------------------------------+--------------+----------------------------------------------------+
|hvves_messages_latency_seconds_count           |     piece    | counter for number of latency appearance           |
+-----------------------------------------------+--------------+----------------------------------------------------+
|hvves_messages_latency_seconds_max             |    seconds   | maximal observed latency                           |
+-----------------------------------------------+--------------+----------------------------------------------------+
|hvves_messages_latency_seconds_sum             |    seconds   | sum of latency parameter from each message         |
+-----------------------------------------------+--------------+----------------------------------------------------+
|hvves_messages_processing_time_seconds_count   |     piece    | counter for number of processing time appearance   |
+-----------------------------------------------+--------------+----------------------------------------------------+
|hvves_messages_processing_time_seconds_max     |    seconds   | maximal processing time                            |
+-----------------------------------------------+--------------+----------------------------------------------------+
|hvves_messages_processing_time_seconds_sum     |    seconds   | sum of processing time from each message           |
+-----------------------------------------------+--------------+----------------------------------------------------+
|hvves_messages_received_payload_bytes_total    |     bytes    | total number of received payload bytes             |
+-----------------------------------------------+--------------+----------------------------------------------------+
|hvves_messages_received_total                  |     piece    | total number of received messages                  |
+-----------------------------------------------+--------------+----------------------------------------------------+
|hvves_messages_sent_topic_total                |  topic/piece | topic per number of sent messages                  |
+-----------------------------------------------+--------------+----------------------------------------------------+
|hvves_messages_sent_total                      |     piece    | number of sent messages                            |
+-----------------------------------------------+--------------+----------------------------------------------------+

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

Sample response for GET from monitoring/prometheus endpoint :

.. code-block::
jvm_threads_live 26.0
system_cpu_count 4.0
jvm_gc_memory_promoted_bytes_total 6740576.0
process_cpu_usage 5.485463521667581E-4
jvm_buffer_count{id="mapped",} 0.0
jvm_buffer_count{id="direct",} 14.0
jvm_threads_peak 26.0
jvm_classes_unloaded_total 0.0
hvves_clients_rejected_cause_total{cause="too_big_payload",} 7.0
hvves_messages_sent_topic_total{topic="HV_VES_PERF3GPP",} 20000.0
jvm_threads_daemon 25.0
jvm_buffer_memory_used_bytes{id="mapped",} 0.0
jvm_buffer_memory_used_bytes{id="direct",} 1.34242446E8
jvm_gc_max_data_size_bytes 4.175429632E9
hvves_messages_received_total 32000.0
hvves_messages_dropped_total 12000.0
hvves_clients_rejected_total 7.0
system_cpu_usage 0.36204059243006037
jvm_memory_max_bytes{area="nonheap",id="CodeHeap 'non-nmethods'",} 5832704.0
jvm_memory_max_bytes{area="nonheap",id="Metaspace",} -1.0
jvm_memory_max_bytes{area="nonheap",id="CodeHeap 'profiled nmethods'",} 1.22912768E8
jvm_memory_max_bytes{area="nonheap",id="Compressed Class Space",} 1.073741824E9
jvm_memory_max_bytes{area="heap",id="G1 Eden Space",} -1.0
jvm_memory_max_bytes{area="heap",id="G1 Old Gen",} 4.175429632E9
jvm_memory_max_bytes{area="heap",id="G1 Survivor Space",} -1.0
jvm_memory_max_bytes{area="nonheap",id="CodeHeap 'non-profiled nmethods'",} 1.22912768E8
hvves_messages_dropped_cause_total{cause="invalid",} 12000.0
hvves_messages_received_payload_bytes_total 1.0023702E7
jvm_buffer_total_capacity_bytes{id="mapped",} 0.0
jvm_buffer_total_capacity_bytes{id="direct",} 1.34242445E8
system_load_average_1m 2.77
hvves_data_received_bytes_total 1.052239E7
jvm_gc_pause_seconds_count{action="end of minor GC",cause="Metadata GC Threshold",} 2.0
jvm_gc_pause_seconds_sum{action="end of minor GC",cause="Metadata GC Threshold",} 0.087
jvm_gc_pause_seconds_count{action="end of minor GC",cause="G1 Evacuation Pause",} 8.0
jvm_gc_pause_seconds_sum{action="end of minor GC",cause="G1 Evacuation Pause",} 0.218
jvm_gc_pause_seconds_max{action="end of minor GC",cause="Metadata GC Threshold",} 0.03
jvm_gc_pause_seconds_max{action="end of minor GC",cause="G1 Evacuation Pause",} 0.031
hvves_messages_processing_time_seconds_max 0.114395
hvves_messages_processing_time_seconds_count 20000.0
hvves_messages_processing_time_seconds_sum 280.282544
hvves_disconnections_total 11.0
jvm_memory_used_bytes{area="nonheap",id="CodeHeap 'non-nmethods'",} 1312640.0
jvm_memory_used_bytes{area="nonheap",id="Metaspace",} 3.624124E7
jvm_memory_used_bytes{area="nonheap",id="CodeHeap 'profiled nmethods'",} 1.1602304E7
jvm_memory_used_bytes{area="nonheap",id="Compressed Class Space",} 4273752.0
jvm_memory_used_bytes{area="heap",id="G1 Eden Space",} 1.38412032E8
jvm_memory_used_bytes{area="heap",id="G1 Old Gen",} 7638112.0
jvm_memory_used_bytes{area="heap",id="G1 Survivor Space",} 7340032.0
jvm_memory_used_bytes{area="nonheap",id="CodeHeap 'non-profiled nmethods'",} 4083712.0
jvm_memory_committed_bytes{area="nonheap",id="CodeHeap 'non-nmethods'",} 2555904.0
jvm_memory_committed_bytes{area="nonheap",id="Metaspace",} 3.7486592E7
jvm_memory_committed_bytes{area="nonheap",id="CodeHeap 'profiled nmethods'",} 1.1730944E7
jvm_memory_committed_bytes{area="nonheap",id="Compressed Class Space",} 4587520.0
jvm_memory_committed_bytes{area="heap",id="G1 Eden Space",} 1.58334976E8
jvm_memory_committed_bytes{area="heap",id="G1 Old Gen",} 9.8566144E7
jvm_memory_committed_bytes{area="heap",id="G1 Survivor Space",} 7340032.0
jvm_memory_committed_bytes{area="nonheap",id="CodeHeap 'non-profiled nmethods'",} 4128768.0
jvm_gc_memory_allocated_bytes_total 1.235222528E9
hvves_connections_total 12.0
jvm_classes_loaded 7120.0
hvves_messages_sent_total 20000.0
hvves_connections_active 1.0
jvm_gc_live_data_size_bytes 7634496.0
hvves_messages_latency_seconds_max 1.5459828692292638E9
hvves_messages_latency_seconds_count 20000.0
hvves_messages_latency_seconds_sum 2.91400110035487E9