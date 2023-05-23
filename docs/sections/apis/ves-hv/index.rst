.. This work is licensed under a Creative Commons Attribution 4.0 International License.
.. http://creativecommons.org/licenses/by/4.0

========================
HV-VES (High Volume VES)
========================


.. contents::
    :depth: 4

.. toctree::
    :maxdepth: 1

    ./supported-domains.rst

..

Overview
========

Component description can be found under `HV-VES Collector`_.

.. _HV-VES Collector: ../../services/ves-hv/index.rst
.. _Domains supported by HV-VES: ./supported-domains.rst

.. _tcp_endpoint:

TCP Endpoint
============

HV-VES is exposed as NodePort service on Kubernetes cluster on port 30222/tcp.
By default, as of the Frankfurt release, all TCP communications are secured using
SSL/TLS. Plain, insecure TCP connections without socket data encryption can be enabled if needed.
(see ref:`ssl_tls_authorization`).

Without TLS, client authentication/authorization is not possible.
Connections are stream-based (as opposed to request-based) and long-running.

Communication is wrapped with thin Wire Transfer Protocol, which mainly provides delimitation.

.. literalinclude:: WTP.asn
    :language: text

Payload is binary-encoded, using Google Protocol Buffers (GPB) representation of the VES Event.

.. literalinclude:: VesEvent.proto
    :language: protobuf

HV-VES makes routing decisions based on the content of the **domain** field or **stndDefinedNamespace** field in case of stndDefined events.

The PROTO file, which contains the VES CommonEventHeader, comes with a binary-type Payload (eventFields) parameter, where domain-specific
data should be placed. Domain-specific data are encoded as well with GPB. A domain-specific PROTO file is required to decode the data.

API towards DMaaP
=================

HV-VES Collector forwards incoming messages to a particular DMaaP Kafka topic based on the domain (or stndDefinedNamespace) and configuration. Every Kafka record is comprised of a key and a value. In case of HV-VES:

- **Kafka record key** is a GPB-encoded `CommonEventHeader`.
- **Kafka record value** is a GPB-encoded `VesEvent` (`CommonEventHeader` and domain-specific `eventFields`).

In both cases raw bytes might be extracted using ``org.apache.kafka.common.serialization.ByteArrayDeserializer``. The resulting bytes might be further passed to ``parseFrom`` methods included in classes generated from GPB definitions. WTP is not used here - it is only used in communication between PNF/VNF and the collector.

In case of Helm deployment routing is defined in values.yaml file in HV-VES Helm Chart.


.. _supported_domains:

Supported domains
=================

Domains that are currently supported by HV-VES:

- perf3gpp - basic domain to Kafka topic mapping
- stndDefined - specific routing, when event has this domain, then stndDefinedNamespace field value is mapped to Kafka topic

For domains descriptions, see :ref:`domains_supported_by_hvves`

.. _hv_ves_behaviors:

HV-VES behaviors
================

Connections with HV-VES are stream-based (as opposed to request-based) and long-running. In case of interrupted or closed connection, the collector logs such event but does not try to reconnect to client.
Communication is wrapped with thin Wire Transfer Protocol, which mainly provides delimitation. Wire Transfer Protocol Frame:

- is dropped after decoding and validating and only GPB is used in further processing.
- has to start with **MARKER_BYTE**, as defined in protocol specification (see :ref:`tcp_endpoint`). If **MARKER_BYTE** is invalid, HV-VES disconnects from client.

HV-VES decodes only CommonEventHeader from GPB message received. Collector does not decode or validate the rest of the GPB message and publishes it to Kafka topic intact.
Kafka topic for publishing events with specific domain can be configured through Consul service as described in :ref:`run_time_configuration`.
In case of Kafka service unavailability, the collector drops currently handled messages and disconnects the client.

Messages handling:

- HV-VES Collector skips messages with unknown/invalid GPB CommonEventHeader format.
- HV-VES Collector skips messages with unsupported domain. Domain is unsupported if there is no route for it in configuration (see :ref:`run_time_configuration`).
- HV-VES Collector skips messages with invalid Wire Frame format, unsupported WTP version or inconsistencies of data in the frame (other than invalid **MARKER_BYTE**).
- HV-VES Collector interrupts connection when it encounters a message with too big GPB payload. Default maximum size and ways to change it are described in :ref:`deployment`.

.. note:: xNF (VNF/PNF) can split  messages bigger than 1 MiB and set `sequence` field in CommonEventHeader accordingly. It is advised to use smaller than 1 MiB messages for GPBs encoding/decoding efficiency.

- Skipped messages (for any of the above reasons) might not leave any trace in HV-VES logs.
