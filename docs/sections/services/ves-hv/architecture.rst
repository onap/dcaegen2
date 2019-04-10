.. This work is licensed under a Creative Commons Attribution 4.0 International License.
.. http://creativecommons.org/licenses/by/4.0

.. _architecture:

High-level architecture of HV-VES
=================================

HV-VES Collector is a part of DCAEGEN2. Its goal is to collect data from xNF (PNF/VNF) and publish it in DMaaP's Kafka.
High Volume Collector is deployed with DCAEGEN2 via OOM Helm charts and Cloudify blueprints.

Input messages come from TCP interface and Wire Transfer Protocol. Each frame includes Google Protocol Buffers (GPB) encoded payload.
Based on information provided in CommonEventHeader, domain messages are validated and published to specific Kafka topic in DMaaP.

.. image:: resources/ONAP_VES_HV_Architecture.png

Messages published in DMaaP's Kafka topic will be consumed by DCAE analytics application or other ONAP component that consumes messages from DMaaP/Kafka.
DMaaP serves direct access to Kafka allowing other analytics applications to utilize its data.
