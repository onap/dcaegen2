.. This work is licensed under a Creative Commons Attribution 4.0 International License.
.. http://creativecommons.org/licenses/by/4.0

Configuration and Performance
=============================

Filtering
"""""""""
PM Mapper maps PM XML files to performance VES event by applying the mapper filtering information. Mapper filtering is configured during instantiation through cloudify manager.
Mapper filtering is based on the PM dictionary fields.
PM Mapper expects the filter in the following JSON format:

::


         "filters":[{
            "pmDefVsn": "1.3",
            "nfType": "gnb",
            "vendor": "Ericsson",
            "measTypes": [ "attTCHSeizures", "succTCHSeizures" ]
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
measTypes              Measurement name used in PM       Array of String
                       file in 3GPP format where
                       specified, else vendor
                       defined.
====================   ============================      ================================

Message Router Topic Name
"""""""""""""""""""""""""
PM Mapper publishes the perf3gpp VES PM Events to the following authenticated MR topic;

::

        org.onap.dmaap.mr.PM_MAPPER

Performance
^^^^^^^^^^^

To see the performance of PM Mapper, see "`PM Mapper performance baseline results`_".

.. _PM Mapper performance baseline results: https://wiki.onap.org/display/DW/PM-Mapper+performance+baseline+results
