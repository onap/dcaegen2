.. This work is licensed under a Creative Commons Attribution 4.0 International License.
.. http://creativecommons.org/licenses/by/4.0

..      =====================
..      * * *    KOHN   * * *
..      =====================


Version: 11.0.0
===============


Abstract
--------

This document provides the release notes for Kohn release.

Summary
-------

The following DCAE components are available with default ONAP/DCAE installation:

    - Service components
        - VES Collector
        - HV-VES Collector
        - PNF-Registration Handler
        - Docker based Threshold Crossing Analytics (TCA-Gen2)
        - VES OpenAPI Manager

    - Additional resources that DCAE utilizes are deployed using ONAP common charts:

        - Postgresql Database
        - Mongo Database


These service components (mS) are available to be deployed on-demand via helm:

 	- SNMPTrap Collector
 	- RESTConf Collector
 	- DataFile Collector
 	- PM-Mapper
 	- VES Mapper
 	- Heartbeat mS
 	- SON-Handler
 	- PM-Subscription Handler
 	- DataLake Handler (Admin & Feeder)
 	- Slice Analysis mS
 	- DataLake Extraction Service
 	- KPI-Ms


Under OOM all DCAE component containers are deployed as Kubernetes Pods/Deployments/Services.

For Helm managed microservices,  dependencies are identified on each chart individually.
In general, most DCAE microservice rely on Configmap for sourcing configuration updates. Each microservice can be deployed independently and based on the dcaegen2-services-common template, features can be enabled or disabled via a configuration override during deployment.

For a list of supported features in helm, refer to :doc:`Using Helm to deploy DCAE Microservices <./dcaeservice_helm_template>`.


Release Data
------------

+--------------------------------------+--------------------------------------------------------+
| **DCAE Project**                     |                                                        |
|                                      |                                                        |
+--------------------------------------+--------------------------------------------------------+
| **Docker images**                    | Refer :any:`Deliverable <kohn_deliverable>`            |
|                                      |                                                        |
+--------------------------------------+--------------------------------------------------------+
| **Release designation**              | 11.0.0 Kohn                                            |
|                                      |                                                        |
+--------------------------------------+--------------------------------------------------------+
| **Release date**                     | 2022-12-08                                             |
|                                      |                                                        |
+--------------------------------------+--------------------------------------------------------+


New features
------------

*DCAE Enhancements and Features*

DCAEGEN2-3148 5G SON use case enhancements for Kohn release
    - CL message for ANR modified to align with A1-based flow/support

DCAEGEN2-3195 CCVPN Kohn Enhancements for Intent-based Cloud Leased Line and Transport Slicing
    - DCAE SDK alignment for SliceAnalysis MS & enhancing AAI interface for supporting IBN CL

DCAEGEN2-3194 Maintenance and Enhancement of Intent-driven Closed-loop Autonomous Networks
    - Slice Analysis Enhancement with AAI Interface/processing for CL notification

DCAEGEN2-3119 Helm Transformation - Post migration
     - DCAE Common Template improvements
     - Removed Cloudify and associated platform component charts
     - Removed Consul/CBS API dependency from each DCAE MS, enabling independent config management via respective charts

DCAEGEN2-2975 VES 7.2.1 support for DCAE Microservices
     - TCAgen2 enhanced to support VES 7.2.1

DCAEGEN2-3037 AAF certificate dependency removal
    - DFC Enhanced to support additional property to disable certificates checks

DCAEGEN2-3030 DMAAP SDK standardization for DCAE Microservices
    - SliceAnalysis MS, SON-Handler MS switched to use DMAAP SDK


*Non-Functional*

   - DCAEGEN2-3089 - Sonarcoverage improvements for DCAE components - SliceAnalysis mS, SNMPTrap, TCA-gen2, SON-Handler, KPi-MS, Mapper, RESTConf  (meeting 80% or more coverage)
   - DCAEGEN2-3209 - CII Badging improvements (Silver badge completion)
   - DCAEGEN2-3196 - Vulnerability updates for several DCAE MS (TCA-gen2, DataFileCollector, HV-VES, RESTConf, VES, Mapper, PM-Mapper, PRH, SON-handler, KPI-MS, Slice-Analysis MS, DCAE-SDK, VES OpenAPI Manager)
   - DCAEGEN2-3225 - SBOM Enablement for DCAE components


.. _kohn_deliverable:

Deliverables
------------

Software Deliverables

.. csv-table::
   :header: "Repository", "SubModules", "Version & Docker Image (if applicable)"
   :widths: auto

   "dcaegen2/analytics/tca-gen2", "", "onap/org.onap.dcaegen2.analytics.tca-gen2.dcae-analytics-tca-web:1.3.4"
   "dcaegen2/collectors/datafile", "", "onap/org.onap.dcaegen2.collectors.datafile.datafile-app-server:1.9.0"
   "dcaegen2/collectors/hv-ves", "", "onap/org.onap.dcaegen2.collectors.hv-ves.hv-collector-main:1.11.0"
   "dcaegen2/collectors/restconf", "", "onap/org.onap.dcaegen2.collectors.restconfcollector:1.3.4"
   "dcaegen2/collectors/snmptrap", "", "onap/org.onap.dcaegen2.collectors.snmptrap:2.0.7"
   "dcaegen2/collectors/ves", "", "onap/org.onap.dcaegen2.collectors.ves.vescollector:1.11.1"
   "dcaegen2/deployments", "healthcheck-container", "onap/org.onap.dcaegen2.deployments.healthcheck-container:2.4.0"
   "dcaegen2/deployments", "tls-init-container", "onap/org.onap.dcaegen2.deployments.tls-init-container:2.1.0"
   "dcaegen2/deployments", "dcae-services-policy-sync", "onap/org.onap.dcaegen2.deployments.dcae-services-policy-sync:1.0.1"
   "dcaegen2/platform", "mod/onboardingapi", "onap/org.onap.dcaegen2.platform.mod.onboardingapi:2.13.0"
   "dcaegen2/platform", "mod/distributorapi", "onap/org.onap.dcaegen2.platform.mod.distributorapi:1.1.1"
   "dcaegen2/platform", "mod/designtool", "onap/org.onap.dcaegen2.platform.mod.designtool-web:1.0.2"
   "dcaegen2/platform", "mod/genprocessor", "onap/org.onap.dcaegen2.platform.mod.genprocessor-http:1.0.2"
   "dcaegen2/platform", "mod/genprocessor", "onap/org.onap.dcaegen2.platform.mod.genprocessor-job:1.0.3"
   "dcaegen2/platform", "mod/designtool/mod-registry", "onap/org.onap.dcaegen2.platform.mod.mod-registry:1.0.0"
   "dcaegen2/platform", "mod/runtimeapi", "onap/org.onap.dcaegen2.platform.mod.runtime-web:1.3.3"
   "dcaegen2/platform/ves-openapi-manager", "", "onap/org.onap.dcaegen2.platform.ves-openapi-manager:1.2.0"
   "dcaegen2/services", "components/datalake-handler", "onap/org.onap.dcaegen2.services.datalakefeeder:1.1.1"
   "dcaegen2/services", "components/datalake-handler", "onap/org.onap.dcaegen2.services.datalakeadminui:1.1.1"
   "dcaegen2/services", "components/datalake-handler", "onap/org.onap.dcaegen2.services.datalake.exposure.service:1.1.1"
   "dcaegen2/services", "components/pm-subscription-handler", "onap/org.onap.dcaegen2.services.pmsh:2.2.2"
   "dcaegen2/services", "components/slice-analysis-ms", "onap/org.onap.dcaegen2.services.components.slice-analysis-ms:1.1.5"
   "dcaegen2/services", "components/kpi-ms", "onap/org.onap.dcaegen2.services.components.kpi-ms:1.0.11"
   "dcaegen2/services/heartbeat", "", "onap/org.onap.dcaegen2.services.heartbeat:2.5.0"
   "dcaegen2/services/mapper", "", "onap/org.onap.dcaegen2.services.mapper.vesadapter.universalvesadaptor:1.4.3"
   "dcaegen2/services/pm-mapper", "", "onap/org.onap.dcaegen2.services.pm-mapper:1.9.0"
   "dcaegen2/services/prh", "", "onap/org.onap.dcaegen2.services.prh.prh-app-server:1.8.1"
   "dcaegen2/services/son-handler", "", "onap/org.onap.dcaegen2.services.son-handler:2.1.11"
   "dcaegen2/platform", "mod2/helm-generator", "Helm Generator 1.0.4 (jar)"
   "dcaegen2/services/sdk", "", "DCAE SDK 1.8.10 (jar)"

The following repositories (and containers) have been deprecated with this release.

.. csv-table::
   :header: "Repository", "SubModules", "Version & Docker Image (if applicable)"
   :widths: auto

   "dcaegen2/platform", "adapter/acumos", "onap/org.onap.dcaegen2.platform.adapter.acumos:1.0.7"

As DCAEMOD has been identified for EOL with London, following containers will be deprecated in next release and removed from OOM.

.. csv-table::
   :header: "Repository", "SubModules", "Version & Docker Image (if applicable)"
   :widths: auto

   "dcaegen2/platform", "mod/onboardingapi", "onap/org.onap.dcaegen2.platform.mod.onboardingapi:2.13.0"
   "dcaegen2/platform", "mod/distributorapi", "onap/org.onap.dcaegen2.platform.mod.distributorapi:1.1.1"
   "dcaegen2/platform", "mod/designtool", "onap/org.onap.dcaegen2.platform.mod.designtool-web:1.0.2"
   "dcaegen2/platform", "mod/genprocessor", "onap/org.onap.dcaegen2.platform.mod.genprocessor-http:1.0.2"
   "dcaegen2/platform", "mod/genprocessor", "onap/org.onap.dcaegen2.platform.mod.genprocessor-job:1.0.3"
   "dcaegen2/platform", "mod/designtool/mod-registry", "onap/org.onap.dcaegen2.platform.mod.mod-registry:1.0.0"
   "dcaegen2/platform", "mod/runtimeapi", "onap/org.onap.dcaegen2.platform.mod.runtime-web:1.3.3"

Known Limitations, Issues and Workarounds
-----------------------------------------


   - DCAEGEN2-3184 DL-Feeder log error and configuration issue

*Known Vulnerabilities*

None

*Workarounds*

Documented under corresponding jira if applicable.

Security Notes
--------------

*Fixed Security Issues*

    Documented on earlier section

*Known Security Issues*

    None

*Known Vulnerabilities in Used Modules*

    None

DCAE code has been formally scanned during build time using NexusIQ and all Critical vulnerabilities have been addressed, items that remain open have been assessed for risk and determined to be false positive. The DCAE open Critical security vulnerabilities and their risk assessment have been documented as part of the `project <https://wiki.onap.org/display/SV/Kohn+DCAE>`_.

Test Results
------------

 - `DCAE R11 Pairwise Test <https://wiki.onap.org/display/DW/DCAE+Pair+Wise+Testing+for+Kohn+Release>`_
 - `DCAE R11 Functional Test <https://wiki.onap.org/display/DW/DCAE+R11+Kohn+Testplan>`_


References
----------

For more information on the ONAP Jakarta release, please see:

#. `ONAP Home Page`_
#. `ONAP Documentation`_
#. `ONAP Release Downloads`_
#. `ONAP Wiki Page`_


.. _`ONAP Home Page`: https://www.onap.org
.. _`ONAP Wiki Page`: https://wiki.onap.org
.. _`ONAP Documentation`: https://docs.onap.org
.. _`ONAP Release Downloads`: https://git.onap.org

Quick Links:

        - `DCAE project page <https://wiki.onap.org/display/DW/Data+Collection+Analytics+and+Events+Project>`_
        - `Passing Badge information for DCAE <https://bestpractices.coreinfrastructure.org/en/projects/1718>`_
