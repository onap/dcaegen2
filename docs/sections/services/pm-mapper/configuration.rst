.. This work is licensed under a Creative Commons Attribution 4.0 International License.
.. http://creativecommons.org/licenses/by/4.0

Configuration and Performance
=============================

Filtering
"""""""""
The PM Mapper performs data reduction, by filtering the PM telemetry data it receives.
This filtering information is provided to the service as part of its configuration, and is used to identify desired PM measurements (measType) contained within the data.
The service can accept an exact match to the measType or regex(java.util.regex) identifying multiple measTypes (it is possible to use both types simultaneously).
If a filter is provided, any measurement that does not match the filter, will be ignored and a warning will be logged.
PM Mapper expects the filter in the following JSON format:

::


         "filters":[{
            "pmDefVsn": "1.3",
            "nfType": "gnb",
            "vendor": "Ericsson",
            "measTypes": [ "attTCHSeizures", "succTCHSeizures", "att.*", ".*Seizures" ]
         }]



====================   ============================      ================================
Field                  Description                       Type
====================   ============================      ================================
pmDefVsn               PM Dictionary version.            String
vendor                 Vendor of the xNF type.           String
nfType                 nfType is vendor                  String
                       defined and should match the
                       string used in file ready
                       eventName.
measTypes              Measurement name used in PM       List of Strings, Regular expressions
                       file in 3GPP format where
                       specified, else vendor
                       defined.
====================   ============================      ================================

Message Router Topic Name
"""""""""""""""""""""""""
PM Mapper publishes the perf3gpp VES PM Events to the following authenticated MR topic;

::

        org.onap.dmaap.mr.PERFORMANCE_MEASUREMENTS

Performance
^^^^^^^^^^^

To see the performance of PM Mapper, see "`PM Mapper performance baseline results`_".

.. _PM Mapper performance baseline results: https://wiki.onap.org/display/DW/PM-Mapper+performance+baseline+results
