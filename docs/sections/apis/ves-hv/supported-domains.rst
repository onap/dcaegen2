.. This work is licensed under a Creative Commons Attribution 4.0 International License.
.. http://creativecommons.org/licenses/by/4.0

.. _domains_supported_by_hvves:

Domains supported by HV-VES
===========================

.. _perf3gpp:

perf3gpp domain - delivery of equipment Performance Monitoring (PM) data, based on 3GPP specifications
------------------------------------------------------------------------------------------------------
The purpose of the **perf3gpp** domain is frequent periodic delivery of structured RAN PM data commonly referred to as Real Time PM (RTPM). The equipment sends an event right after collecting the PM data for a granularity period.

The characteristics of each event in the **perf3gpp** domain:

- Single measured entity, for example, BTS
- Single granularity period (collection *begin time* and *duration*)
- Optional top-level grouping in one or more PM groups
- Grouping in one or more measured objects, for example, cells
- One or more reported PM values for each measured object

Due to the single granularity period per event, single equipment supporting multiple concurrent granularity periods might send more than one event at a given reporting time. 

The **perf3gpp** domain is based on 3GPP specifications:


- `3GPP TS 28.550 <http://www.3gpp.org/ftp//Specs/archive/28_series/28.550/>`_

- `3GPP TS 32.431 <http://www.3gpp.org/ftp//Specs/archive/32_series/32.431/>`_

- `3GPP TS 32.436 <http://www.3gpp.org/ftp//Specs/archive/32_series/32.436/>`_

The event structure is changed in comparison to the one presented in 3GPP technical specifications. The 3GPP structure is enhanced to provide support for efficient transport.

Definitions for the **perf3gpp** domain are stored in Perf3gppFields.proto and MeasDataCollection.proto, listed below:

.. literalinclude:: Perf3gppFields.proto
    :language: protobuf

.. literalinclude:: MeasDataCollection.proto
    :language: protobuf

Selecting Complimentary fields for population of **perf3gpp** event
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Context: at the upper level, *VesEvent.eventFields* is an opaque bytes field, and in the case of the **perf3gpp** domain (that is VesEvent.commonEventHeader.domain=="Perf3gpp"), *eventFields* maps to a structure defined by *Perf3gppFields*.

*Perf3gppFields* contains two main sub-structures:

  - *eventAddlFlds*: the usual optional VES per-event data (*HashMap*, name/value pairs)
  - *measDataCollection*: the actual payload, based on 3GPP specifications, but modified in order to optionaly reduce the size of the event

Usage of *measDataCollection*:

 The *measDataCollection* structure offers flexibility in the way an equipment provides the Performance Monitoring (PM) data.
 The following table gives an outline of the two main options:

- Following 3GPP standard as closely as possible
- Reducing the message size

Each row of the table corresponds to one field where a choice is to be made. For each main option it describes whether an optional field is relevant or not, or which subfield to provide for a "oneof" GPB field.

  +----------------------------+----------+-----------------------------+-----------------------------+----------+
  |                            |          | Focus 1: 3GPP compatibility | Focus 2: Minimum event size |          |
  | *MeasDataCollection* field | Type     | (send textual IDs)          | (send numerical IDs)        | Notes    |
  +============================+==========+=============================+=============================+==========+
  | MeasData.measObjInstIdList | optional | <not provided>              | <mandatory>                 | [1]_     |
  +----------------------------+----------+-----------------------------+-----------------------------+----------+
  | MeasValue.MeasObjInstId    | oneof    | sMeasObjInstId              | measObjInstIdListIdx        | [1]_     |
  +----------------------------+----------+-----------------------------+-----------------------------+----------+
  | MeasInfo.MeasInfoId        | oneof    | sMeasInfoId                 | iMeasInfoId                 | [2]_     |
  +----------------------------+----------+-----------------------------+-----------------------------+----------+
  | MeasInfo.MeasTypes         | oneof    | sMeasTypes                  | iMeasTypes                  | [2]_     |
  +----------------------------+----------+-----------------------------+-----------------------------+----------+
  | Notes:                                                                                                       |
  |   .. [1] *MeasData.measObjInstIdList* and *MeasValue.MeasObjInstId.measObjInstIdListIdx* are interdependent  |
  |   .. [2] Numerical IDs normally require the mapping to textual IDs to be provided offline in a PM dictionary |
  |                                                                                                              |
  +----------------------------+----------+-----------------------------+-----------------------------+----------+

.. note:: The division between focus 1 and focus 2 above is illustrative, and a mix of choices from both options is possible.

.. note:: *MeasResult.p* can be used to reduce the event size when more than half of the values in the event are zero values, and these values are not sent to ONAP. Only non-zero values are sent, together with their *MeasInfo.MeasTypes* index (*MeasResult.p*).


.. _stndDefined_domain:

stndDefined domain
------------------

The purpose of 'stndDefined' domain was to allow collection of events defined by standard organizations using HV-VES,
and providing them for consumption by analytics applications running on top of DCAE platform.

All events, except those with 'stndDefined' domain, are routed to DMaaP topics based on domain value. Events with
'stndDefined' domain are sent to proper topic basing on field 'stndDefinedNamespace'.

This is the only difference from standard event routing, specific for 'stndDefined' domain. As in every other event
routing value is being mapped for specific Kafka topic. Mappings to Kafka topics are located in HV-VES Helm Chart
values.yaml file. Four of them are by default available in HV-VES:

+-------------+--------------------------------+--------------------------------------+
| Domain      | StndDefinedNamespace           | Kafka topic                          |
+=============+================================+======================================+
| stndDefined | ves-3gpp-fault-supervision     | SEC_3GPP_FAULTSUPERVISION_OUTPUT     |
+-------------+--------------------------------+--------------------------------------+
| stndDefined | ves-3gpp-provisioning          | SEC_3GPP_PROVISIONING_OUTPUT         |
+-------------+--------------------------------+--------------------------------------+
| stndDefined | ves-3gpp-heartbeat             | SEC_3GPP_HEARTBEAT_OUTPUT            |
+-------------+--------------------------------+--------------------------------------+
| stndDefined | ves-3gpp-performance-assurance | SEC_3GPP_PERFORMANCEASSURANCE_OUTPUT |
+-------------+--------------------------------+--------------------------------------+
