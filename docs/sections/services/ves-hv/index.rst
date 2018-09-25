.. This work is licensed under a Creative Commons Attribution 4.0 International License.
.. http://creativecommons.org/licenses/by/4.0


High Volume VNF Event Streaming (HV-VES) Collector
==================================================

.. Add or remove sections below as appropriate for the platform component.


**HV-VES collector** has been proposed, based on a need to process high-volumes of data generated frequently by a large
number of NFs. The driving use-case is the 5G RAN, where it is expected that up to 10k NF instances report the data,
per DCAE platform deployment. The network traffic generated in simulations - based on 4G BTS Real-Time PM data has
shown, that Google Protocol Buffers ( GPB ) serialization is 2-3 times more effective,
than JSON serialization utilized in VES collector.

Results have been published within ONAP presentation in Casablanca Release Developer Forum:
`Google Protocol Buffers versus JSON - 5G RAN use-case - comparison`_.

.. _`Google Protocol Buffers versus JSON - 5G RAN use-case - comparison`: https://wiki.onap.org/download/attachments/25434845/Casablanca_Dev_Forum_GPB_comparison_20180621.pptx?version=1&modificationDate=1530275050000&api=v2

The goal of the collector is to support high volume data. It uses plain TCP connections tunneled in SSL/TLS.
Connections are stream-based (as opposed to request-based) and long running.
Payload is binary-encoded (currently using Google Protocol Buffers).
HV-VES uses direct connection to DMaaP's Kafka.
All these decisions were made in order to support high-volume data with minimal latency.


High Volume VES Collector overview and functions
------------------------------------------------

.. toctree::
    :maxdepth: 1
   ./design.rst
   ./configuration.rst
   ./delivery.rst
   ./installation.rst
   `Offered APIs`_

.. _`Offered APIs`: ../../apis/ves-hv.rst