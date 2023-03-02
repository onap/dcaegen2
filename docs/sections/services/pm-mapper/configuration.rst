.. This work is licensed under a Creative Commons Attribution 4.0 International License.
.. http://creativecommons.org/licenses/by/4.0
.. Copyright 2022 Nokia. All rights reserved.
.. Copyright (c) 2023 AT&T Intellectual Property. All rights reserved.


Configuration and Performance
=============================

Files Processing Configuration
""""""""""""""""""""""""""""""
The PM Mapper consumes the 3GPP XML files from DMaaP-DR, and processes them. It is possible to process it in parallel.
In order to parallel processing, new configuration env has been introduced:

- PROCESSING_LIMIT_RATE (optional, default value: 1) - allows to limit the rate of processing files through channel.

- THREADS_MULTIPLIER (optional, default value: 1) - allows to specify multiplier to calculate the amount of threads.

- PROCESSING_THREADS_COUNT (optional, default value: number of threads available to JVM) - allows to specify number of threads that will be used for files processing.

.. _pm_mapper_disable_tls:

Disable TLS
"""""""""""
Pm-mapper by default uses communication over TLS, but it is also possible to use plain http request. To disable TLS, set configuration flag 'enable_http' to true, and set the certificate paths to empty strings or remove them from the configuration. See the config.yaml examples below.

.. code-block:: yaml
    
  applicationConfig:
    enable_http: true
    key_store_path: ""
    key_store_pass_path: ""
    trust_store_path: ""
    trust_store_pass_path: ""



Or 

.. code-block:: yaml

  applicationConfig:
    enable_http: true
    #key_store_path: 
    #key_store_pass_path: 
    #trust_store_path: 
    #trust_store_pass_path: 


Unauthenticated topic
"""""""""""""""""""""
To use unauthenticated topics :ref:`disable TLS <pm_mapper_disable_tls>`, and edit AAF credentials in configuration, it should be removed or set to empty string. See the examples below.

.. code-block:: yaml
    
  applicationConfig:
    aaf_identity: ""
    aaf_password: ""


Or

.. code-block:: yaml
    
  applicationConfig:
    #aaf_identity: 
    #aaf_password: 



PM Mapper Filtering
"""""""""""""""""""
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
