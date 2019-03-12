.. This work is licensed under a Creative Commons Attribution 4.0 International License.
.. http://creativecommons.org/licenses/by/4.0

Configuration
=============

Filtering
"""""""""
PM mapper maps PM XML files to performance VES event based on mapper filtering. Mapper filtering is configured during instantiation through cloudify manager.
Mapper filtering is based on the PM dictionary fields.
PM mapper expects the filter in the following JSON format:

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
Vendor                 Vendor of the NF type to          String
                       whom this PM Dictionary
                       applies.
nfType                 NF type to whom this PM
                       PM Dictionary applies.
                       nfType is vendor defined
                       and should match the string
                       used in eventName.                String
measType               Measurement name used in PM
                       file, in 3GPP format where
                       specified, else vendor
                       defined. Names for
                       3GPP-defined 4G measurements
                       are specified in 3GPP TS
                       32.425 item e). Names for
                       3GPP-defined 5G measurements
                       are specified in 3GPP TS
                       28.552 item e). Vendor
                       defined names are preceded
                       with VS.                           Array of String

====================   ============================      ================================

Feed Name
"""""""""
A default feed name "bulk_pm_feed" is configured in PM Mapper blueprint but the feed name can be configured to user defined through cloudify manager.