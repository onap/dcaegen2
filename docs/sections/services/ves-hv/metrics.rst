.. This work is licensed under a Creative Commons Attribution 4.0 International License.
.. http://creativecommons.org/licenses/by/4.0

HV-VES metrics
==============
HV-VES collector allows to collect metrics data at runtime. It is provided by `Prometheus.io`_ service.
Docker-compose from /hv-ves/development of a project provides Prometheus service is running as a docker image.

.. _`Prometheus.io`: https://prometheus.io/

Provided by HV-VES metrics (counters, timers, gouges):
+-----------------------------------+---------+
|           Name of metric          |  type   |
+-----------------------------------+---------+
|hvves_data_received_bytes          | counter |
+-----------------------------------+---------+
|hvves_messages_received_count      | counter |
+-----------------------------------+---------+
|hvves_messages_received_bytes      | counter |
+-----------------------------------+---------+
|hvves_connections_total_count      | counter |
+-----------------------------------+---------+
|hvves_disconnections_count         | counter |
+-----------------------------------+---------+
|hvves_messages_sent_count          | counter |
+-----------------------------------+---------+
|hvves_messages_sent_topic_count    | counter |
+-----------------------------------+---------+
|hvves_messages_dropped_count       | counter |
+-----------------------------------+---------+
|hvves_messages_dropped_cause_count | counter |
+-----------------------------------+---------+
|hvves_clients_rejected_count       | counter |
+-----------------------------------+---------+
|hvves_clients_rejected_cause_count | counter |
+-----------------------------------+---------+
|hvves_messages_processing_time     |  timer  |
+-----------------------------------+---------+
|hvves_messages_latency_time        |  timer  |
+-----------------------------------+---------+
|hvves_messages_processing_count    |  gouge  |
+-----------------------------------+---------+
|hvves_connections_active_count     |  gouge  |
+-----------------------------------+---------+