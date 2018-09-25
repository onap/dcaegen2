.. This work is licensed under a Creative Commons Attribution 4.0 International License.
.. http://creativecommons.org/licenses/by/4.0

Design
======


Compatibility aspects (VES-JSON)
--------------------------------

HV-VES Collector has been designed as a high-volume variant of the existing VES(JSON) collector, and not a completely new collector.
HV-VES follows the VES-JSON schema - as much as possible

- It uses a Google Protocol Buffers ( GPB/PROTO ) representation of the VES Common Header
- The PROTO files tend to use most encoding effective types defined by GPB to cover Common Header fields.
- It makes routing decisions based mostly on the content of the "Domain" parameter
- It allows to embed Payload of different types (by default HVMEAS domain is included)

Analytics applications impacts

- An analytics application operating on high-volume data needs to be prepared to read directly from Kafka
- An analytics application need to operate on GPB encoded data in order to benefit from GPB encoding efficiencies
- It is assumed, that due to the nature of high volume data, there would have to be dedicated applications provided,
able to operate on such volumes of data.

Extendability
-------------

HV-VES was designed to allow for extendability - by adding new domain-specific PROTO files.

The PROTO file, which contains the VES CommonHeader, comes with a binary-type Payload parameter, where domain-specific data shall be placed.
Domain-specific data are encoded as well with GPB, and they do require a domain-specific PROTO file to decode the data.
This domain-specific PROTO needs to be shared with analytics applications - HV-VES is not analyzing domain-specific data.

In order to support the RT-PM use-case, HV-VES includes a "HVMEAS" domain PROTO file, as within this domain,
the high volume data is expected to be reported to HV-VES collector.
Still, there are no limitations to define additional domains, based on existing VES domains (like Fault, Heartbeat)
or completely new domains. New domains can be added "when needed".

GPB PROTO files are backwards compatible, and such a new domain could be added without affecting existing systems.

Analytics applications will have to be as well equipped with this new domain-specific PROTO file.
Currently, these additional, domain specific proto files could be simply added to respective repos of HV-VES collector.

Implementation details
----------------------

- Project Reactor is used as a backbone of the internal architecture.
- Netty is used by means of reactor-netty library.
- We are using Kotlin so we can write very concise code with great interoperability with existing Java libraries.
- Types defined in Λrrow library are also used when it improves readability or general cleanness of the code.