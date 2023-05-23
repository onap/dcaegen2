.. This work is licensed under a Creative Commons Attribution 4.0 International License.
.. http://creativecommons.org/licenses/by/4.0

.. _hv-ves-design:

Design
======


Compatibility aspects (VES-JSON)
--------------------------------

HV-VES Collector is a high-volume variant of the existing VES (JSON) collector, and not a completely new collector.
HV-VES follows the VES-JSON schema as much as possible.

- HV-VES uses a Google Protocol Buffers (GPB, proto files) representation of the VES Common Header.
- The proto files use most encoding-effective types defined by GPB to cover Common Header fields.
- HV-VES makes routing decisions based on the content of the **domain** field or **stndDefinedNamespace** field in case of stndDefined events.
- HV-VES allows to embed Payload of different types (by default perf3gpp and stndDefined domains are included).

Analytics applications impacts

- An analytics application operating on high-volume data needs to be prepared to read directly from Kafka.
- An analytics application needs to operate on GPB encoded data in order to benefit from GPB encoding efficiencies.
- It is assumed, that due to the nature of high volume data, there would have to be dedicated applications provided, able to operate on such volumes of data.

Extendability
-------------

HV-VES is designed to allow extending by adding new domain-specific proto files.

The proto file (with the VES CommonHeader) comes with a binary-type **Payload** parameter, where domain-specific data should be placed.
Domain-specific data are encoded as well with GPB. A domain-specific proto file is required to decode the data.
This domain-specific proto has to be shared with analytics applications - HV-VES does not analyze domain-specific data.

In order to support the RT-PM use-case, HV-VES uses a **perf3gpp** domain proto file. Within this domain, high volume data are expected to be reported to HV-VES collector.
Additional domains can be defined based on existing VES domains (like Fault, Heartbeat) or completely new domains. New domains can be added when needed.

There is also **stndDefined** domain supported by default in HV-VES. Events with this domain are expected to contain
data payload described by OpenAPI schemas. HV-VES doesn't decode payload of stndDefined events thus it does not contain
specific **stndDefined** proto files. The only difference of **stndDefined** domain is its specific routing. More
details of stndDefined routing: :ref:`stndDefined_domain`.

GPB proto files are backwards compatible, and a new domain can be added without affecting existing systems.

Analytics applications have to be equipped with the new domain-specific proto file as well.
Currently, these additional, domain specific proto files can be added to hv-ves-client protobuf library repository (artifactId: hvvesclient-protobuf).

Implementation details
----------------------

- Project Reactor is used as a backbone of the internal architecture.
- Netty is used by means of reactor-netty library.
- Kotlin is used to write concise code with great interoperability with existing Java libraries.
- Types defined in Λrrow library are also used when it improves readability or general cleanness of the code.
