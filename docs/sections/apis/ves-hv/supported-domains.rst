.. This work is licensed under a Creative Commons Attribution 4.0 International License.
.. http://creativecommons.org/licenses/by/4.0

.. _supported_domains:

Domains supported by HV-VES
===========================

.. _perf3gpp:

perf3gpp - delivery of equipment Performance Monitoring (PM) data, based on 3GPP specifications
-----------------------------------------------------------------------------------------------
  - The purpose of the perf3gpp domain is frequent periodic delivery of structured PM data to ONAP.
  - The equipment sends an event soon after the PM data has been collected for a granularity period.

The scope and general structure per event is:
  - Single measured entity, e.g. BTS.
  - Single granularity period (collection begin time and duration).
  - Optional top-level grouping in one or more PM groups.
  - Grouping in one or more measured objects, e.g. cells.
  - One or more reported PM values per measured object.

Notes:
  - The event structure is mostly based on 3GPP TS 32.431, 32.436, and 28.550, but the 3GPP structure is enhanced to provide support for efficient transport.
  - A corollary of the single granularity period per event, is that if a single equipment supports multiple concurrent granularity periods, it may send more than one event at a given reporting time.

**Selecting Complimentary fields for population of perf3gpp event**

Context: at the upper level, VesEvent.eventFields is an opaque bytes field, and in the case of the perf3gpp domain (i.e. VesEvent.commonEventHeader.domain=="Perf3gpp"), eventFields maps to a structure defined by Perf3gppFields.

Perf3gppFields contains two main sub-structures:
  - *eventAddlFlds*: the usual optional VES per-event data (HashMap, name/value pairs).
  - *measDataCollection*: the actual payload, based on 3GPP specifications, but modified in order to optionaly reduce the size of the event.

Usage of *measDataCollection*
  - The *measDataCollection* structure offers some flexibility regarding the way an equipment provides the Performance Monitoring (PM) data.
  - The following table gives an outline of the two main options - either follow 3GPP standard as closely as possible, or reduce the message size.
  - Each row of the table corresponds to one field where a choice is to be made, and for each main option it describes whether an optional field is relevant or not, or which subfield to provide for a "oneof" GPB field.

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

  Additional notes:
    - The division between focus 1 and focus 2 above is illustrative, and a mix of choices from both options is possible.
    - *MeasResult.p* can be used to reduce the event size in the following case: more than half of the values in the event are zero values, and these values are not sent to ONAP. Only non-zero values are sent, together with their *MeasInfo.MeasTypes* index (*MeasResult.p*).
