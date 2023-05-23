.. ==============================LICENSE_START==========================================
.. This work is licensed under a Creative Commons Attribution 4.0 International License.
.. http://creativecommons.org/licenses/by/4.0
.. Copyright (c) 2017-2023 AT&T Intellectual Property. All rights reserved.
.. Copyright 2021 Nokia Solutions and Networks.
.. ==============================LICENSE_END============================================
.. _release_notes:




DCAE Release Notes
##################

.. contents::
    :depth: 2
..


..      =======================
..      * * *    LONDON   * * *
..      =======================


Version: 12.0.0
===============

.. _Version_12.0.0:


Abstract
--------

This document provides the release notes for London release.

Summary
-------

The following DCAE components are available with default ONAP/DCAE chart installation:

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

All supported DCAE Microservices are maintained as Helm charts under `OOM repository <https://github.com/onap/oom/tree/master/kubernetes/dcaegen2-services/components>`_


All DCAE component are deployed as Kubernetes Pods/Deployments/Services through ONAP/OOM.

For each microservices,  dependencies are identified on corresponding helm chart individually.
In general, most DCAE microservice rely on Configmap for sourcing configuration updates. Each microservice can be deployed independently and based on the dcaegen2-services-common template, features can be enabled or disabled via a configuration override during deployment.

For a list of supported features in helm, refer to :doc:`Using Helm to deploy DCAE Microservices <./dcaeservice_helm_template>`.


Release Data
------------

+--------------------------------------+--------------------------------------------------------+
| **DCAE Project**                     |                                                        |
|                                      |                                                        |
+--------------------------------------+--------------------------------------------------------+
| **Docker images**                    | Refer :any:`Deliverable <london_deliverable>`          |
|                                      |                                                        |
+--------------------------------------+--------------------------------------------------------+
| **Release designation**              | 12.0.0 London                                          |
|                                      |                                                        |
+--------------------------------------+--------------------------------------------------------+
| **Release date**                     | 2023-06-15                                             |
|                                      |                                                        |
+--------------------------------------+--------------------------------------------------------+


New features
------------

*DCAE Enhancements and Features*


DCAEGEN2-3037 AAF certificate dependency removal
    - PM-Mapper, RESTConf, VESOpenAPI enhanced to support additional property to disable certificates checks

DCAEGEN2-3312 Improve DCAE PRH to handle Early PNF Registrations
	- Support PNF registration reprocessing via Kafka persistence

DCAEGEN2-3278 - DCAEMOD retirement
	- OOM and documentation updates to formalize DCAEMOD deprecation

DCAEGEN2-3067  AI/ML MS for IBN based closed Loop in E2E Network Slicing (POC)
     - Mainstreaming the ml-prediction-ms (New mS introduction)
     - Support for multiple slices (sNSSAIs) in training and prediction modules
     - Use CPS instead of Config DB
     - Remove RAN Simulator dependency

*Non-Functional*

   - DCAEGEN2-3256 - Sonarcoverage improvements for DCAE components - VESCollector, Heartbeat MS, TCA-gen2  (meeting 80% or more coverage)
   - DCAEGEN2-3318 - Vulnerability updates for several DCAE MS (TCA-gen2, DataFileCollector, RESTConf, VES OpenAPI Manager, KPI-MS, Mapper, PM-Mapper, PRH, DCAE-SDK, SON-handler,  Slice-Analysis MS)



.. _london_deliverable:

Deliverables
------------

Software Deliverables

.. csv-table::
   :header: "Repository", "SubModules", "Version & Docker Image (if applicable)"
   :widths: auto

   "dcaegen2/analytics/tca-gen2", "", "onap/org.onap.dcaegen2.analytics.tca-gen2.dcae-analytics-tca-web:1.4.0"
   "dcaegen2/collectors/datafile", "", "onap/org.onap.dcaegen2.collectors.datafile.datafile-app-server:1.10.0"
   "dcaegen2/collectors/hv-ves", "", "onap/org.onap.dcaegen2.collectors.hv-ves.hv-collector-main:1.11.0"
   "dcaegen2/collectors/restconf", "", "onap/org.onap.dcaegen2.collectors.restconfcollector:1.4.1"
   "dcaegen2/collectors/snmptrap", "", "onap/org.onap.dcaegen2.collectors.snmptrap:2.0.7"
   "dcaegen2/collectors/ves", "", "onap/org.onap.dcaegen2.collectors.ves.vescollector:1.12.3"
   "dcaegen2/deployments", "healthcheck-container", "onap/org.onap.dcaegen2.deployments.healthcheck-container:2.4.0"
   "dcaegen2/deployments", "dcae-services-policy-sync", "onap/org.onap.dcaegen2.deployments.dcae-services-policy-sync:1.0.1"
   "dcaegen2/platform/ves-openapi-manager", "", "onap/org.onap.dcaegen2.platform.ves-openapi-manager:1.3.1"
   "dcaegen2/services", "components/datalake-handler", "onap/org.onap.dcaegen2.services.datalakefeeder:1.1.1"
   "dcaegen2/services", "components/datalake-handler", "onap/org.onap.dcaegen2.services.datalakeadminui:1.1.1"
   "dcaegen2/services", "components/datalake-handler", "onap/org.onap.dcaegen2.services.datalake.exposure.service:1.1.1"
   "dcaegen2/services", "components/pm-subscription-handler", "onap/org.onap.dcaegen2.services.pmsh:2.2.3"
   "dcaegen2/services", "components/slice-analysis-ms", "onap/org.onap.dcaegen2.services.components.slice-analysis-ms:1.2.1"
   "dcaegen2/services", "components/kpi-ms", "onap/org.onap.dcaegen2.services.components.kpi-ms:1.2.1"
   "dcaegen2/services/heartbeat", "", "onap/org.onap.dcaegen2.services.heartbeat:2.6.1"
   "dcaegen2/services/mapper", "", "onap/org.onap.dcaegen2.services.mapper.vesadapter.universalvesadaptor:1.5.0"
   "dcaegen2/services/pm-mapper", "", "onap/org.onap.dcaegen2.services.pm-mapper:1.10.1"
   "dcaegen2/services/prh", "", "onap/org.onap.dcaegen2.services.prh.prh-app-server:1.9.0"
   "dcaegen2/services/son-handler", "", "onap/org.onap.dcaegen2.services.son-handler:2.2.1"
   "dcaegen2/services/sdk", "", "DCAE SDK 1.9.3 (jar)"

The following repositories (and containers) is POC deliverable for IBN based closed Loop in E2E Network Slicing using ML/MS.

.. csv-table::
   :header: "Repository", "SubModules", "Version & Docker Image (if applicable)"
   :widths: auto

   "dcaegen2/services", "components/ml-prediction-ms", "onap/org.onap.dcaegen2.services.ml-prediction-ms:1.0.0"

The following repositories (and containers) have been deprecated with this release.

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
   "dcaegen2/platform", "mod2/helm-generator", "Helm Generator 1.0.4 (jar)"

With AAF deprecation by OOM project, all certificates are managed through Service-Mesh. Following container was introduced in DCAE to work with AAF for interal certificate generation. This container is no longer required with London release.

.. csv-table::
   :header: "Repository", "SubModules", "Version & Docker Image (if applicable)"
   :widths: auto

   "dcaegen2/deployments", "tls-init-container", "onap/org.onap.dcaegen2.deployments.tls-init-container:2.1.0"


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

DCAE code has been formally scanned during build time using NexusIQ and all Critical vulnerabilities have been addressed, items that remain open have been assessed for risk and determined to be false positive. The DCAE open Critical security vulnerabilities and their risk assessment have been documented as part of the `project <https://wiki.onap.org/display/SV/London+DCAE>`_.

Test Results
------------

 - `DCAE R12 Pairwise Test <https://wiki.onap.org/display/DW/DCAE+Pair+Wise+Testing+for+London+Release>`_
 - `DCAE R12 Functional Test <https://wiki.onap.org/display/DW/DCAE+R12+London+Testplan>`_


References
----------

For more information on the ONAP London release, please see:

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



..      =====================
..      * * *    KOHN   * * *
..      =====================


Version: 11.0.0
===============

.. _Version_11.0.0:


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





..      ==========================
..      * * *    JAKARTA    * * *
..      ==========================


Version: 10.0.0
===============

.. _Version_10.0.0:


Abstract
--------

This document provides the release notes for Jakarta release.

Summary
-------

With DCAE transformation to HELM completed this release, all Cloudify/platform handler components have been retired
and only helm based MS deployment mode is supported.
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
 	- DataLake Handler (Admin and Feeder)
 	- Slice Analysis mS
 	- DataLake Extraction Service
 	- KPI-Ms


Under OOM all DCAE component containers are deployed as Kubernetes Pods/Deployments/Services into a Kubernetes cluster.

For Helm managed microservices, the dependencies/pre-requisite are identified on each chart individually.
In general, most DCAE microservice rely on Configmap for sourcing configuration updates. Each microservice can be deployed independently and based on the dcaegen2-services-common template, features can be enabled or disabled via a configuration override during deployment.

For a list of supported features in helm, refer to :doc:`Using Helm to deploy DCAE Microservices <./dcaeservice_helm_template>`.


Release Data
------------

+--------------------------------------+--------------------------------------------------------+
| **DCAE Project**                     |                                                        |
|                                      |                                                        |
+--------------------------------------+--------------------------------------------------------+
| **Docker images**                    | Refer :any:`Deliverable <jakarta_deliverable>`         |
|                                      |                                                        |
+--------------------------------------+--------------------------------------------------------+
| **Release designation**              | 10.0.0 Jakarta                                         |
|                                      |                                                        |
+--------------------------------------+--------------------------------------------------------+
| **Release date**                     | 2022-06-02                                             |
|                                      |                                                        |
+--------------------------------------+--------------------------------------------------------+


New features
------------

*DCAE Enhancements and Features*

DCAEGEN2-3021 DCAE Impacts for E2E Network Slicing in Jakarta release
    - Slice selection taking into consideration resource occupancy levels
    - IBN based Closed loop for Network Slicing

DCAEGEN2-3063 CCVPN Jakarta Enhancements for Intent-based Cloud Leased Line and Closed-loop
    - Support bandwidth evaluation and CL event generation
    - AAI Interface for bandwidth update notification

DCAEGEN2-2773 DCAE Helm Transformation (Phase 3/Final)
    - Removed Consul dependency across all DCAE service components.
    - All DCAE microservices migrated to use latest CBS SDK library to support configmap/policy retrieval
    - Enhancement on DCAE common template for DR Feed pub/sub configuration consistency and disable Consul loader
    - DCAEMOD enhanced to support Helm chart generation for onboarded MS/flows
    - Cloudify and related Handlers removal from ONAP/DCAE Deployment
    - v3 spec introduced for MOD Helm flow support

DCAEGEN2-2906 - Bulk PM / PM Data Control Improvements (PMSH)
    - PMSH functional enhancement and support for dynamic filter/subscription change via API

DCAEGEN2-3031 - Topic alignment for DCAE microservices
    - Migrate DCAE MS to use standard topics for PM-Mapper, Slice-Analysis, KPI-MS


*Non-Functional*

   - DCAEGEN2-2829 - CII Badging improvements
   - DCAEGEN2-3006 - Vulnerability updates for several DCAE MS (TCA-gen2, DataFileCollector,RESTConf, VES,Mapper, PM-Mapper, PRH, SON-handler, KPI-MS, Slice-Analysis MS, DCAE-SDK, VES OpenAPI Manager)
   - DCAEGEN2-2961/DCAEGEN2-2962/DCAEGEN2-2963 - Removed GPLv3 license from software by switching to onap/integration base images for VESCollector, RESTConf, SliceAnalysis MS
   - DCAEGEN2-2958 - STDOUT log compliance for DCAE SNMPTRap collector and Healthcheck container




.. _jakarta_deliverable:

Deliverables
------------

Software Deliverables

.. csv-table::
   :header: "Repository", "SubModules", "Version & Docker Image (if applicable)"
   :widths: auto

   "dcaegen2/analytics/tca-gen2", "", "onap/org.onap.dcaegen2.analytics.tca-gen2.dcae-analytics-tca-web:1.3.2"
   "dcaegen2/collectors/datafile", "", "onap/org.onap.dcaegen2.collectors.datafile.datafile-app-server:1.7.1"
   "dcaegen2/collectors/hv-ves", "", "onap/org.onap.dcaegen2.collectors.hv-ves.hv-collector-main:1.10.0"
   "dcaegen2/collectors/restconf", "", "onap/org.onap.dcaegen2.collectors.restconfcollector:1.3.2"
   "dcaegen2/collectors/snmptrap", "", "onap/org.onap.dcaegen2.collectors.snmptrap:2.0.6"
   "dcaegen2/collectors/ves", "", "onap/org.onap.dcaegen2.collectors.ves.vescollector:1.11.0"
   "dcaegen2/deployments", "healthcheck-container", "onap/org.onap.dcaegen2.deployments.healthcheck-container:2.4.0"
   "dcaegen2/deployments", "tls-init-container", "onap/org.onap.dcaegen2.deployments.tls-init-container:2.1.0"
   "dcaegen2/deployments", "dcae-services-policy-sync", "onap/org.onap.dcaegen2.deployments.dcae-services-policy-sync:1.0.1"
   "dcaegen2/platform", "mod/onboardingapi", "onap/org.onap.dcaegen2.platform.mod.onboardingapi:2.13.0"
   "dcaegen2/platform", "mod/distributorapi", "onap/org.onap.dcaegen2.platform.mod.distributorapi:1.1.0"
   "dcaegen2/platform", "mod/designtool", "onap/org.onap.dcaegen2.platform.mod.designtool-web:1.0.2"
   "dcaegen2/platform", "mod/genprocessor", "onap/org.onap.dcaegen2.platform.mod.genprocessor-http:1.0.2"
   "dcaegen2/platform", "mod/genprocessor", "onap/org.onap.dcaegen2.platform.mod.genprocessor-job:1.0.2"
   "dcaegen2/platform", "mod/designtool/mod-registry", "onap/org.onap.dcaegen2.platform.mod.mod-registry:1.0.0"
   "dcaegen2/platform", "mod/runtimeapi", "onap/org.onap.dcaegen2.platform.mod.runtime-web:1.3.2"
   "dcaegen2/platform", "adapter/acumos", "onap/org.onap.dcaegen2.platform.adapter.acumos:1.0.7"
   "dcaegen2/platform/ves-openapi-manager", "", "onap/org.onap.dcaegen2.platform.ves-openapi-manager:1.1.0"
   "dcaegen2/services", "components/datalake-handler", "onap/org.onap.dcaegen2.services.datalakefeeder:1.1.1"
   "dcaegen2/services", "components/datalake-handler", "onap/org.onap.dcaegen2.services.datalakeadminui:1.1.1"
   "dcaegen2/services", "components/datalake-handler", "onap/org.onap.dcaegen2.services.datalake.exposure.service:1.1.1"
   "dcaegen2/services", "components/pm-subscription-handler", "onap/org.onap.dcaegen2.services.pmsh:2.2.2"
   "dcaegen2/services", "components/slice-analysis-ms", "onap/org.onap.dcaegen2.services.components.slice-analysis-ms:1.1.3"
   "dcaegen2/services", "components/kpi-ms", "onap/org.onap.dcaegen2.services.components.kpi-ms:1.0.4"
   "dcaegen2/services/heartbeat", "", "onap/org.onap.dcaegen2.services.heartbeat:2.3.1"
   "dcaegen2/services/mapper", "", "onap/org.onap.dcaegen2.services.mapper.vesadapter.universalvesadaptor:1.4.0"
   "dcaegen2/services/pm-mapper", "", "onap/org.onap.dcaegen2.services.pm-mapper:1.8.0"
   "dcaegen2/services/prh", "", "onap/org.onap.dcaegen2.services.prh.prh-app-server:1.8.0"
   "dcaegen2/services/son-handler", "", "onap/org.onap.dcaegen2.services.son-handler:2.1.7"
   "dcaegen2/platform", "mod2/helm-generator", "Helm Generator 1.0.3 (jar)"
   "dcaegen2/services/sdk", "", "DCAE SDK 1.8.8 (jar)"

The following repositories (and containers) have been deprecated with this release.

.. csv-table::
   :header: "Repository", "SubModules", "Version & Docker Image (if applicable)"
   :widths: auto

   "dcaegen2/deployments", "cm-container", "onap/org.onap.dcaegen2.deployments.cm-container:4.6.1"
   "dcaegen2/deployments", "consul-loader-container", "onap/org.onap.dcaegen2.deployments.consul-loader-container:1.1.1"
   "dcaegen2/deployments", "dcae-k8s-cleanup-container", "onap/org.onap.dcaegen2.deployments.dcae-k8s-cleanup-container:1.0.0"
   "dcaegen2/platform/blueprints", "", "onap/org.onap.dcaegen2.deployments.k8s-bootstrap-container:3.3.5"
   "dcaegen2/platform/configbinding", "", "onap/org.onap.dcaegen2.platform.configbinding:2.5.4"
   "dcaegen2/platform/deployment-handler", "", "onap/org.onap.dcaegen2.platform.deployment-handler:4.4.1"
   "dcaegen2/platform/inventory-api", "", "onap/org.onap.dcaegen2.platform.inventory-api:3.5.2"  
   "dcaegen2/platform/policy-handler", "", "onap/org.onap.dcaegen2.platform.policy-handler:5.1.3"
   "dcaegen2/platform/servicechange-handler", "", "onap/org.onap.dcaegen2.platform.servicechange-handler:1.4.0"
   "dcaegen2/services", "components/bbs-event-processor", "onap/org.onap.dcaegen2.services.components.bbs-event-processor:2.1.1"
   "ccsdk/dashboard", "", "onap/org.onap.ccsdk.dashboard.ccsdk-app-os:1.4.4"


Known Limitations, Issues and Workarounds
-----------------------------------------

DCAEGEN2-2861 - Topic/feed provisioned through Helm require manual cleanup once the helm deployed service are uninstalled.
Refer following document  :doc:`Using Helm to deploy DCAE Microservices <./dcaeservice_helm_template>` for steps to remove topic/feed provisioned in DMAAP.


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

DCAE code has been formally scanned during build time using NexusIQ and all Critical vulnerabilities have been addressed, items that remain open have been assessed for risk and determined to be false positive. The DCAE open Critical security vulnerabilities and their risk assessment have been documented as part of the `project <https://wiki.onap.org/display/SV/Jakarta+DCAE>`_.

Test Results
------------

 - `DCAE R10 Pairwise Test <https://wiki.onap.org/display/DW/DCAE+Pair+Wise+Testing+for+Jakarta+Release>`_
 - `DCAE R10 Functional Test <https://wiki.onap.org/display/DW/DCAE+R10+Testplan>`_


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



..      =====================================
..      * * *    ISTANBUL  MAINTENANCE  * * *
..      =====================================


Version: 9.0.1
==============

.. _Version_9.0.1:

Abstract
--------

This document provides the release notes for the Istanbul Maintenance release


Summary
-------

This maintenance release is primarily to resolve bugs identified during Istanbul release testing.


Release Data
------------

+--------------------------------------+--------------------------------------+
| **Project**                          | DCAE                                 |
|                                      |                                      |
+--------------------------------------+--------------------------------------+
| **Docker images**                    | See Istanbul Maintenance Release     |
|                                      |         Deliverable (below)          |
+--------------------------------------+--------------------------------------+
| **Release designation**              | Istanbul Maintenance Release         |
|                                      |                                      |
+--------------------------------------+--------------------------------------+
| **Release date**                     | 2022/01/31                           |
|                                      |                                      |
+--------------------------------------+--------------------------------------+

New features
------------

None

**Bug fixes**

- `DCAEGEN2-3022 <https://jira.onap.org/browse/DCAEGEN2-3022>`_ Log4j vulnerability fix
- `DCAEGEN2-2998 <https://jira.onap.org/browse/DCAEGEN2-2998>`_ Update SON-Handler missing configuration in helm


**Known Issues**

None


Security Notes
--------------

*Known Vulnerabilities in Used Modules*

    dcaegne2/services/mapper includes transitive dependency on log4j 1.2.17; this will be addressed in later release (DCAEGEN2-3105)


Istanbul Maintenance Rls Deliverables
-------------------------------------

Software Deliverables

.. csv-table::
   :header: "Repository", "SubModules", "Version & Docker Image (if applicable)"
   :widths: auto

   "dcaegen2/collectors/restconf", "", "onap/org.onap.dcaegen2.collectors.restconfcollector:1.2.7"
   "dcaegen2/collectors/ves", "", "onap/org.onap.dcaegen2.collectors.ves.vescollector:1.10.3"
   "dcaegen2/services/mapper", "", "onap/org.onap.dcaegen2.services.mapper.vesadapter.universalvesadaptor:1.3.2"



..      ==========================
..      * * *    ISTANBUL    * * *
..      ==========================


Version: 9.0.0
==============

.. _Version_9.0.0:


Abstract
--------

This document provides the release notes for Istanbul release.

Summary
-------

Following DCAE components are available with default ONAP/DCAE installation.

    - Platform components

        - Cloudify Manager (helm chart)*
        - Bootstrap container (helm chart)*
        - Configuration Binding Service (helm chart)
        - Deployment Handler (helm chart)*
        - Policy Handler (helm chart*
        - Service Change Handler (helm chart)*
        - Inventory API (helm chart)*
        - Dashboard (helm chart)*
        - VES OpenAPI Manager (helm chart)

    - Service components

        - VES Collector (helm chart  & cloudify blueprint)
        - HV-VES Collector (helm chart  & cloudify blueprint)
        - PNF-Registration Handler  (helm chart  & cloudify blueprint)
        - Docker based Threshold Crossing Analytics (TCA-Gen2) (helm chart  & cloudify blueprint)

    - Additional resources that DCAE utilizes deployed using ONAP common charts:

        - Postgres Database
        - Mongo Database
        - Consul Cluster

    \*  These components will be retired next ONAP release as cloudify deployments will be diabled after Istanbul.
 

Below service components (mS) are available to be deployed on-demand (helm chart & Cloudify Blueprint)

 	- SNMPTrap Collector
 	- RESTConf Collector
 	- DataFile Collector
 	- PM-Mapper
 	- BBS-EventProcessor
 	- VES Mapper
 	- Heartbeat mS
 	- SON-Handler
 	- PM-Subscription Handler
 	- DataLake Handler (Admin and Feeder)
 	- Slice Analysis mS
 	- DataLake Extraction Service
 	- KPI-Ms


Under OOM all DCAE component containers are deployed as Kubernetes Pods/Deployments/Services into Kubernetes cluster.
With DCAE tranformation to Helm in Istanbul release - all DCAE components are available to be deployed under Helm; Cloudify blueprint deployment is provided for backward compatibility support in this release.

For Helm managed microservices, the dependencies/pre-requisite are identified on each charts individually. In general, most DCAE microservice rely on Consul/Configbindingservice for sourcing configuration updates (this dependency will be removed in next release). Each microservice can be deployed independently and based on dcaegen2-services-common template, features can be enabled or disabled via configuration override during deployment. For list of supported features in helm refer - :doc:`Using Helm to deploy DCAE Microservices <./dcaeservice_helm_template>`.

DCAE continues to provides Cloudify deployment through plugins (cloudify) that is capable of expanding a Cloudify blueprint node specification for a service component to a full Kubernetes specification, with additional enhancements such as replica scaling, sidecar for logging to ONAP ELK stack.


Release Data
------------

+--------------------------------------+--------------------------------------------------------+
| **DCAE Project**                     |                                                        |
|                                      |                                                        |
+--------------------------------------+--------------------------------------------------------+
| **Docker images**                    | Refer :any:`Deliverable <istanbul_deliverable>`        |
|                                      |                                                        |
+--------------------------------------+--------------------------------------------------------+
| **Release designation**              | 9.0.0 Istanbul                                         |
|                                      |                                                        |
+--------------------------------------+--------------------------------------------------------+
| **Release date**                     | 2021-11-18                                             |
|                                      |                                                        |
+--------------------------------------+--------------------------------------------------------+


New features
------------

*DCAE Enhancements Features*

DCAEGEN2-2771 DCAE Impacts for E2E Network Slicing in Istanbul release
    - SliceAnalysis and KPI-Computation MS migrated from ConfigDb to CPS
    - Integration with new CBS client SDK and support policy sidecar

DCAEGEN2-2703 Add stndDefined domain to HV-VES
    - HV_VES microservice was adapted to support stdDefined domain introduced under VES7.2.1 spec  

DCAEGEN2-2630 DCAE Helm Transformation (Phase 2)
    - All DCAE microservices migration to helm was completed in Istanbul release. Since Honolulu, 13 additional MS has been delivered added for Helm deployment support
    - All DCAE Microservice are supported under both Helm and Cloudify/blueprint based deployments (legacy)
    - Helm Templated resuable function - Several new common features has been added in generic fashion as named template/functions defined in dcaegen2-services-common charts; each DCAEcomponents/mS can enable required features via configuration override. Following are current set of features available under dcaegen2-services-common
            - K8S Secret/Environment mapping
            - CMPv2 Certificate support
            - Policy Sidecar
            - Mount data from configmap through PV/PVC
            - Topic/feed provisioning support
            - AAF certificates generation/distribution
            - Consul loader for application config

    - Reducing Consul Dependency for DCAE components
         Under cloudify deployments, Consul is used as central configuration store for all applications. With migration to Helm, the consul dependency is being removed by switching config management through K8S Configmap (via python/java SDK libraries). This allows application to be deployed standalone in multi/edge cloud without any dependency on central platform components.          

    - Helm-generator tool (POC) available for generating DCAE component helm-chart given component spec. This tool will be integrated with MOD/design flow to support helm chart generation and distribution for Jakarta release. 

DCAEGEN2-2541 Bulk PM (PMSH) - Additional use cases, deployment and documentation enhancements
    - Enhanced PMSH Microservice to support subscription property updates, config updates to support 'n' subscriptions, support resource name in filter

DCAEGEN2-2522 Enhancements for OOF SON use case
    - Implemented CPS client interface (replacing ConfigDb)
    - Switched to new CBS client SDK for removing consul dependency and enabling policy configuration through sidecar.

*Non-Functional*

   - Removed GPLv3 license from software by switching to onap/integration base images (DCAEGEN2-2455)
   - CII Badging improvements (DCAEGEN2-2622)
   - Healthcheck container Py3 upgrade  (DCAEGEN2-2737)
   - Vulnerability updates for several DCAE MS (TCA-gen2, DataFileCollector,RESTConf, VES,Mapper, PM-Mapper, PRH, SON-handler, KPI-MS, Slice-Analysis MS) (DCAEGEN2-2768)


Bug Fixes

   - BPGenerator yaml Fixes are different for yaml file and string (DCAEGEN2-2489)
   - Slice Analysis - Avoid removal of data when insufficient samples are present (DCAEGEN2-2509)


.. _istanbul_deliverable:

Deliverables
------------

Software Deliverables

.. csv-table::
   :header: "Repository", "SubModules", "Version & Docker Image (if applicable)"
   :widths: auto

   "dcaegen2/analytics/tca-gen2", "", "onap/org.onap.dcaegen2.analytics.tca-gen2.dcae-analytics-tca-web:1.3.1"
   "dcaegen2/collectors/datafile", "", "onap/org.onap.dcaegen2.collectors.datafile.datafile-app-server:1.6.1"
   "dcaegen2/collectors/hv-ves", "", "onap/org.onap.dcaegen2.collectors.hv-ves.hv-collector-main:1.9.1"
   "dcaegen2/collectors/restconf", "", "onap/org.onap.dcaegen2.collectors.restconfcollector:1.2.5"
   "dcaegen2/collectors/snmptrap", "", "onap/org.onap.dcaegen2.collectors.snmptrap:2.0.5"
   "dcaegen2/collectors/ves", "", "onap/org.onap.dcaegen2.collectors.ves.vescollector:1.10.1"
   "dcaegen2/deployments", "cm-container", "onap/org.onap.dcaegen2.deployments.cm-container:4.6.1"
   "dcaegen2/deployments", "consul-loader-container", "onap/org.onap.dcaegen2.deployments.consul-loader-container:1.1.1"
   "dcaegen2/deployments", "dcae-k8s-cleanup-container", "onap/org.onap.dcaegen2.deployments.dcae-k8s-cleanup-container:1.0.0"
   "dcaegen2/deployments", "healthcheck-container", "onap/org.onap.dcaegen2.deployments.healthcheck-container:2.2.0"
   "dcaegen2/deployments", "tls-init-container", "onap/org.onap.dcaegen2.deployments.tls-init-container:2.1.0"
   "dcaegen2/deployments", "dcae-services-policy-sync", "onap/org.onap.dcaegen2.deployments.dcae-services-policy-sync:1.0.1"
   "dcaegen2/platform", "mod/onboardingapi", "onap/org.onap.dcaegen2.platform.mod.onboardingapi:2.12.5"
   "dcaegen2/platform", "mod/distributorapi", "onap/org.onap.dcaegen2.platform.mod.distributorapi:1.1.0"
   "dcaegen2/platform", "mod/designtool", "onap/org.onap.dcaegen2.platform.mod.designtool-web:1.0.2"
   "dcaegen2/platform", "mod/genprocessor", "onap/org.onap.dcaegen2.platform.mod.genprocessor-http:1.0.2"
   "dcaegen2/platform", "mod/genprocessor", "onap/org.onap.dcaegen2.platform.mod.genprocessor-job:1.0.2"
   "dcaegen2/platform", "mod/designtool/mod-registry", "onap/org.onap.dcaegen2.platform.mod.mod-registry:1.0.0"
   "dcaegen2/platform", "mod/runtimeapi", "onap/org.onap.dcaegen2.platform.mod.runtime-web:1.2.3"
   "dcaegen2/platform", "adapter/acumos", "onap/org.onap.dcaegen2.platform.adapter.acumos:1.0.6"
   "dcaegen2/platform/blueprints", "", "onap/org.onap.dcaegen2.deployments.k8s-bootstrap-container:3.3.5"
   "dcaegen2/platform/configbinding", "", "onap/org.onap.dcaegen2.platform.configbinding:2.5.4"
   "dcaegen2/platform/deployment-handler", "", "onap/org.onap.dcaegen2.platform.deployment-handler:4.4.1"
   "dcaegen2/platform/inventory-api", "", "onap/org.onap.dcaegen2.platform.inventory-api:3.5.2"  
   "dcaegen2/platform/policy-handler", "", "onap/org.onap.dcaegen2.platform.policy-handler:5.1.3"
   "dcaegen2/platform/servicechange-handler", "", "onap/org.onap.dcaegen2.platform.servicechange-handler:1.4.0"
   "dcaegen2/platform/ves-openapi-manager", "", "onap/org.onap.dcaegen2.platform.ves-openapi-manager:1.0.1"
   "dcaegen2/services", "components/datalake-handler", "onap/org.onap.dcaegen2.services.datalakefeeder:1.1.1"
   "dcaegen2/services", "components/datalake-handler", "onap/org.onap.dcaegen2.services.datalakeadminui:1.1.1"
   "dcaegen2/services", "components/datalake-handler", "onap/org.onap.dcaegen2.services.datalake.exposure.service:1.1.1"
   "dcaegen2/services", "components/pm-subscription-handler", "onap/org.onap.dcaegen2.services.pmsh:1.3.2"
   "dcaegen2/services", "components/slice-analysis-ms", "onap/org.onap.dcaegen2.services.components.slice-analysis-ms:1.0.6"
   "dcaegen2/services", "components/bbs-event-processor", "onap/org.onap.dcaegen2.services.components.bbs-event-processor:2.1.1"
   "dcaegen2/services", "components/kpi-ms", "onap/org.onap.dcaegen2.services.components.kpi-ms:1.0.1"
   "dcaegen2/services/heartbeat", "", "onap/org.onap.dcaegen2.services.heartbeat:2.3.1"
   "dcaegen2/services/mapper", "", "onap/org.onap.dcaegen2.services.mapper.vesadapter.universalvesadaptor:1.3.0"
   "dcaegen2/services/pm-mapper", "", "onap/org.onap.dcaegen2.services.pm-mapper:1.7.2"
   "dcaegen2/services/prh", "", "onap/org.onap.dcaegen2.services.prh.prh-app-server:1.7.1"
   "dcaegen2/services/son-handler", "", "onap/org.onap.dcaegen2.services.son-handler:2.1.5"
   "dcaegen2/platform", "mod/bpgenerator", "Blueprint Generator 1.8.0 (jar)"
   "dcaegen2/services/sdk", "", "DCAE SDK 1.8.7 (jar)"
   "ccsdk/dashboard", "", "onap/org.onap.ccsdk.dashboard.ccsdk-app-os:1.4.4"


Known Limitations, Issues and Workarounds
-----------------------------------------

DCAEGEN2-2861 - Topic/feed provisioned through Helm require manual cleanup once the helm deployed service are uninstalled.
Refer following document  :doc:`Using Helm to deploy DCAE Microservices <./dcaeservice_helm_template>` for steps to remove topic/feed provisioned in DMAAP.


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

DCAE code has been formally scanned during build time using NexusIQ and all Critical vulnerabilities have been addressed, items that remain open have been assessed for risk and determined to be false positive. The DCAE open Critical security vulnerabilities and their risk assessment have been documented as part of the `project <https://wiki.onap.org/pages/viewpage.action?pageId=51282478>`_.

Test Results
------------

 - `DCAE R9 Pairwise Test <https://wiki.onap.org/display/DW/DCAE+Pair+Wise+Testing+for+Istanbul+Release>`_
 - `DCAE R9 Functional Test <https://wiki.onap.org/display/DW/DCAE+R9+Testplan>`_


References
----------

For more information on the ONAP Honolulu release, please see:

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


..      =====================================
..      * * *    HONOLULU  MAINTENANCE  * * *
..      =====================================


Version: 8.0.1
==============

.. _Version_8.0.1:

Abstract
--------

This document provides the release notes for the Honolulu Maintenance release


Summary
-------

This maintenance release is primarily to resolve bugs identified during Honolulu release testing.


Release Data
------------

+--------------------------------------+--------------------------------------+
| **Project**                          | DCAE                                 |
|                                      |                                      |
+--------------------------------------+--------------------------------------+
| **Docker images**                    | onap/org.onap.ccsdk.dashboard.       |
|                                      |   .ccsdk-app-os:1.4.4                |
+--------------------------------------+--------------------------------------+
| **Release designation**              | Honolulu Maintenance Release         |
|                                      |                                      |
+--------------------------------------+--------------------------------------+
| **Release date**                     | 2021/06/01                           |
|                                      |                                      |
+--------------------------------------+--------------------------------------+

New features
------------

None

**Bug fixes**

- `DCAEGEN2-2751 <https://jira.onap.org/browse/DCAEGEN2-2751>`_ Dashboard login issue due to oom/common PG upgrade to centos8-13.2-4.6.1
- `CCSDK-3233 <https://jira.onap.org/browse/CCSDK-3233>`_ Switch to integration base image & vulnerability updates fixes
- `DCAEGEN2-2800 <https://jira.onap.org/browse/DCAEGEN2-2800>`_ DCAE Healthcheck failure due to Dashboard 
- `DCAEGEN2-2869 <https://jira.onap.org/browse/DCAEGEN2-2869>`_ Fix PRH aai lookup url config

**Known Issues**

None

..      ==========================
..      * * *    HONOLULU    * * *
..      ==========================


Version: 8.0.0
==============

.. _Version_8.0.0:


Abstract
--------

This document provides the release notes for Honolulu release.

Summary
-------

Following DCAE components are available with default ONAP/DCAE installation.

    - Platform components

        - Cloudify Manager (helm chart)
        - Bootstrap container (helm chart)
        - Configuration Binding Service (helm chart)
        - Deployment Handler (helm chart)
        - Policy Handler (helm chart
        - Service Change Handler (helm chart)
        - Inventory API (helm chart)
        - Dashboard (helm chart)
        - VES OpenAPI Manager (helm chart)

    - Service components

        - VES Collector (helm chart  & cloudify blueprint)
        - HV-VES Collector (helm chart  & cloudify blueprint)
        - PNF-Registration Handler  (helm chart  & cloudify blueprint)
        - Docker based Threshold Crossing Analytics (TCA-Gen2) (helm chart  & cloudify blueprint)
        - Holmes Rule Management (helm chart  & cloudify blueprint)
        - Holmes Engine Management (helm chart  & cloudify blueprint)

    - Additional resources that DCAE utilizes deployed using ONAP common charts:

        - Postgres Database
        - Mongo Database
        - Consul Cluster

Below service components (mS) are available to be deployed on-demand (through Cloudify Blueprint)

 	- SNMPTrap Collector
 	- RESTConf Collector
 	- DataFile Collector
 	- PM-Mapper 
 	- BBS-EventProcessor
 	- VES Mapper
 	- Heartbeat mS
 	- SON-Handler
 	- PM-Subscription Handler
 	- DataLake Handler (Admin and Feeder)
 	- Slice Analysis mS
 	- DataLake Extraction Service
 	- KPI-Ms

    Notes:

        \*  These components are delivered by the Holmes project.



Under OOM (Kubernetes) all DCAE component containers are deployed as Kubernetes Pods/Deployments/Services into Kubernetes cluster. DCAE components are deployed using combination of Helm charts and Cloudify blueprint as noted above. DCAE provides a Cloudify Manager plugin (k8splugin) that is capable of expanding a Cloudify blueprint node specification for a service component to a full Kubernetes specification, with additional enhancements such as replica scaling, sidecar for logging to ONAP ELK stack, registering services to MSB, etc.


Release Data
------------

+--------------------------------------+--------------------------------------------------------+
| **DCAE Project**                     |                                                        |
|                                      |                                                        |
+--------------------------------------+--------------------------------------------------------+
| **Docker images**                    | Refer :any:`Deliverable <honolulu_deliverable>`        |
|                                      |                                                        |
+--------------------------------------+--------------------------------------------------------+
| **Release designation**              | 8.0.0 Honolulu                                         |
|                                      |                                                        |
+--------------------------------------+--------------------------------------------------------+
| **Release date**                     | 2021-04-29                                             |
|                                      |                                                        |
+--------------------------------------+--------------------------------------------------------+


New features
------------

*DCAE Enhancements*


Functional Updates

   - New service VES-Openapi-Manager component added to DCAE, allowing to notify of missing openAPI description, at xNF distribution phase (DCAEGEN2-2571) 
   - Added VES 7.2.1 support in VESCollector (DCAEGEN2-2539, DCAEGEN2-2477)
   - DCAE MS deployment through helm with introduction of common dcae-service template to standardize charts with migration (DCAEGEN2-2488) 
   - New service KPI-Computation MS introduced for support for E2E Slicing Usecase (DCAEGEN2-2521)
   - K8S configMap support through onboarding/design/deployment via DCAE-MOD and DCAE-Platform (DCAEGEN2-2539)
   - BP-generation Enhancements - support Native-kafka & Config-map through onboarding (DCAEGEN2-2458)
   - CFY plugin enhancements - support IPV6 service exposure + Config-Map + Cert-Manager's CMPv2 issuer integration (DCAEGEN2-2539, DCAEGEN2-2458, DCAEGEN2-2388)
   - DCAE SDK enhancement - Dmaap Client update for timeout/retry + CBS client update (DCAEGEN2-1483)
   - DFC enhancement - support in HTTP/HTTPS/enroll certificate from CMPv2 server (DCAEGEN2-2517)

Non-Functional

   - DCAE Cloudify py3 upgrade including plugins/bootstrap cli (DCAEGEN2-1546)
   - CII Badging improvements (DCAEGEN2-2570)
   - Policy-Handler Py3 upgrade  (DCAEGEN2-2494)
   - Vulnerability updates for several DCAE MS (DataFile Collector, RESTConf, VESCollector, InventoryAPI, MOD/RuntimeAPI, VES-mapper, PM-Mapper, PRH, SON-Handler) (DCAEGEN2-2551)
   - Code Coverage improvement (DataFile, SDK, Blueprint-generator, Plugins, Acumos Adapter) (DCAEGEN2-2382)
   - Documentation/user-guide updates

Bug Fixes

   - BPGenerator yaml Fixes are different for yaml file and string (DCAEGEN2-2489)
   - Slice Analysis - Avoid removal of data when insufficient samples are present (DCAEGEN2-2509)


- Following new services are delivered this release
    - VES OpenAPI Manager
    - KPI MS (Analytics/RCA)

.. _honolulu_deliverable:

Deliverables
------------

Software Deliverables

.. csv-table::
   :header: "Repository", "SubModules", "Version & Docker Image (if applicable)"
   :widths: auto

   "dcaegen2/analytics/tca-gen2", "", "onap/org.onap.dcaegen2.analytics.tca-gen2.dcae-analytics-tca-web:1.2.1"
   "dcaegen2/collectors/datafile", "", "onap/org.onap.dcaegen2.collectors.datafile.datafile-app-server:1.5.5"
   "dcaegen2/collectors/hv-ves", "", "onap/org.onap.dcaegen2.collectors.hv-ves.hv-collector-main:1.6.0"
   "dcaegen2/collectors/restconf", "", "onap/org.onap.dcaegen2.collectors.restconfcollector:1.2.4"
   "dcaegen2/collectors/snmptrap", "", "onap/org.onap.dcaegen2.collectors.snmptrap:2.0.4"
   "dcaegen2/collectors/ves", "", "onap/org.onap.dcaegen2.collectors.ves.vescollector:1.8.0"
   "dcaegen2/deployments", "cm-container", "onap/org.onap.dcaegen2.deployments.cm-container:4.4.2"
   "dcaegen2/deployments", "consul-loader-container", "onap/org.onap.dcaegen2.deployments.consul-loader-container:1.1.0"
   "dcaegen2/deployments", "dcae-k8s-cleanup-container", "onap/org.onap.dcaegen2.deployments.dcae-k8s-cleanup-container:1.0.0"
   "dcaegen2/deployments", "healthcheck-container", "onap/org.onap.dcaegen2.deployments.healthcheck-container:2.1.0"
   "dcaegen2/deployments", "tls-init-container", "onap/org.onap.dcaegen2.deployments.tls-init-container:2.1.0"
   "dcaegen2/deployments", "dcae-services-policy-sync", "onap/org.onap.dcaegen2.deployments.dcae-services-policy-sync:1.0.0"
   "dcaegen2/platform", "mod/onboardingapi", "onap/org.onap.dcaegen2.platform.mod.onboardingapi:2.12.5"
   "dcaegen2/platform", "mod/distributorapi", "onap/org.onap.dcaegen2.platform.mod.distributorapi:1.1.0"
   "dcaegen2/platform", "mod/designtool", "onap/org.onap.dcaegen2.platform.mod.designtool-web:1.0.2"
   "dcaegen2/platform", "mod/genprocessor", "onap/org.onap.dcaegen2.platform.mod.genprocessor-http:1.0.2"
   "dcaegen2/platform", "mod/genprocessor", "onap/org.onap.dcaegen2.platform.mod.genprocessor-job:1.0.2"
   "dcaegen2/platform", "mod/designtool/mod-registry", "onap/org.onap.dcaegen2.platform.mod.mod-registry:1.0.0"
   "dcaegen2/platform", "mod/runtimeapi", "onap/org.onap.dcaegen2.platform.mod.runtime-web:1.2.3"
   "dcaegen2/platform", "adapter/acumos", "onap/org.onap.dcaegen2.platform.adapter.acumos:1.0.4"
   "dcaegen2/platform/blueprints", "", "onap/org.onap.dcaegen2.deployments.k8s-bootstrap-container:3.0.4" 
   "dcaegen2/platform/configbinding", "", "onap/org.onap.dcaegen2.platform.configbinding:2.5.3"
   "dcaegen2/platform/deployment-handler", "", "onap/org.onap.dcaegen2.platform.deployment-handler:4.4.1"
   "dcaegen2/platform/inventory-api", "", "onap/org.onap.dcaegen2.platform.inventory-api:3.5.2"  
   "dcaegen2/platform/policy-handler", "", "onap/org.onap.dcaegen2.platform.policy-handler:5.1.2"
   "dcaegen2/platform/servicechange-handler", "", "onap/org.onap.dcaegen2.platform.servicechange-handler:1.4.0"
   "dcaegen2/platform/ves-openapi-manager", "", "onap/org.onap.dcaegen2.platform.ves-openapi-manager:1.0.1"
   "dcaegen2/services", "components/datalake-handler", "onap/org.onap.dcaegen2.services.datalakefeeder:1.1.0"
   "dcaegen2/services", "components/datalake-handler", "onap/org.onap.dcaegen2.services.datalakeadminui:1.1.0"
   "dcaegen2/services", "components/datalake-handler", "onap/org.onap.dcaegen2.services.datalake.exposure.service:1.1.0"
   "dcaegen2/services", "components/pm-subscription-handler", "onap/org.onap.dcaegen2.services.pmsh:1.1.2"
   "dcaegen2/services", "components/slice-analysis-ms", "onap/org.onap.dcaegen2.services.components.slice-analysis-ms:1.0.4"
   "dcaegen2/services", "components/bbs-event-processor", "onap/org.onap.dcaegen2.services.components.bbs-event-processor:2.0.1"
   "dcaegen2/services", "components/kpi-ms", "onap/org.onap.dcaegen2.services.components.kpi-ms:1.0.0"
   "dcaegen2/services/heartbeat", "", "onap/org.onap.dcaegen2.services.heartbeat:2.1.1"
   "dcaegen2/services/mapper", "", "onap/org.onap.dcaegen2.services.mapper.vesadapter.universalvesadaptor:1.2.0"
   "dcaegen2/services/pm-mapper", "", "onap/org.onap.dcaegen2.services.pm-mapper:1.5.2"
   "dcaegen2/services/prh", "", "onap/org.onap.dcaegen2.services.prh.prh-app-server:1.5.6"
   "dcaegen2/services/son-handler", "", "onap/org.onap.dcaegen2.services.son-handler:2.1.3"
   "dcaegen2/platform", "mod/bpgenerator", "Blueprint Generator 1.7.3 (jar)"
   "dcaegen2/services/sdk", "", "DCAE SDK 1.7.0 (jar)"
   "ccsdk/dashboard", "", "onap/org.onap.ccsdk.dashboard.ccsdk-app-os:1.4.0"


Known Limitations, Issues and Workarounds
-----------------------------------------

The new, Helm based installation mechanism for collectors doesn't support yet certain features available with the traditional Cloudify orchestration based mechanisms:
   - Obtaining X.509 certificates from external CMP v2 server for secure xNF connections
   - Exposing the Collector port in Dual Stack IPv4/IPv6 networks.

Such features are available, when the collectors are installed using the Cloudify mechanisms.
Refer to collector installation page for more details:

.. toctree::
   :maxdepth: 1

   ./services/ves-http/installation-helm.rst
   ./services/ves-hv/installation-helm.rst

    
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
	
DCAE code has been formally scanned during build time using NexusIQ and all Critical vulnerabilities have been addressed, items that remain open have been assessed for risk and determined to be false positive. The DCAE open Critical security vulnerabilities and their risk assessment have been documented as part of the `project <https://wiki.onap.org/pages/viewpage.action?pageId=51282478>`_.

Test Results
------------

 - `DCAE R8 Pairwise Test <https://wiki.onap.org/display/DW/DCAE+Pair+Wise+Testing+for+Honolulu+Release>`_
 - `DCAE R8 Functional Test <https://wiki.onap.org/display/DW/DCAE+R8+Testplan>`_


References
----------

For more information on the ONAP Honolulu release, please see:

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


..      ===================================
..      * * *    GUILIN  MAINTENANCE  * * *
..      ===================================


Version: 7.0.1
==============

.. _Version_7.0.1:

Abstract
--------

This document provides the release notes for the Guilin Maintenance release


Summary
-------

This maintenance release is primarily to resolve bugs identified during Guilin release testing.


Release Data
------------

+--------------------------------------+--------------------------------------+
| **Project**                          | DCAE                                 |
|                                      |                                      |
+--------------------------------------+--------------------------------------+
| **Docker images**                    | onap/org.onap.dcaegen2.collectors    |
|                                      |   .hv-ves.hv-collector-main:1.5.1    |
+--------------------------------------+--------------------------------------+
| **Release designation**              | Guilin Maintenance Release           |
|                                      |                                      |
+--------------------------------------+--------------------------------------+
| **Release date**                     | 2021/04/19                           |
|                                      |                                      |
+--------------------------------------+--------------------------------------+

New features
------------

None

**Bug fixes**

- `DCAEGEN2-2516 <https://jira.onap.org/browse/DCAEGEN2-2516>`_ HV-VES Pod recovery when config-fetch fails
- `OOM-2641 <https://jira.onap.org/browse/OOM-2641>`_ Fix DCAEMOD paths based on Guilin ingress template

**Known Issues**

Same as Guilin Release


..      ========================
..      * * *    GUILIN    * * *
..      ========================


Version: 7.0.0
==============

.. _Version_7.0.0:


Abstract
--------

This document provides the release notes for Guilin release.

Summary
-------

Following DCAE components are available with default ONAP/DCAE installation.

    - Platform components

        - Cloudify Manager (helm chart)
        - Bootstrap container (helm chart)
        - Configuration Binding Service (helm chart)
        - Deployment Handler (helm chart)
        - Policy Handler (helm chart
        - Service Change Handler (helm chart)
        - Inventory API (helm chart)
        - Dashboard (helm chart)

    - Service components

        - VES Collector
        - HV-VES Collector
        - PNF-Registration Handler
        - Docker based Threshold Crossing Analytics (TCA-Gen2)
        - Holmes Rule Management *
        - Holmes Engine Management *

    - Additional resources that DCAE utilizes deployed using ONAP common charts:
    
        - Postgres Database
        - Mongo Database
        - Redis Cluster Database
        - Consul Cluster 

Below service components (mS) are available to be deployed on-demand.

 	- SNMPTrap Collector
 	- RESTConf Collector
 	- DataFile Collector
 	- PM-Mapper 
 	- BBS-EventProcessor
 	- VES Mapper
 	- Heartbeat mS
 	- SON-Handler
 	- PM-Subscription Handler
 	- DataLake Handler (Admin and Feeder)
 	- Slice Analysis
 	- DataLake Extraction Service

    Notes:

        \*  These components are delivered by the Holmes project.



Under OOM (Kubernetes) all DCAE component containers are deployed as Kubernetes Pods/Deployments/Services into Kubernetes cluster. DCAE platform components are deployed using Helm charts. DCAE service components are deployed using Cloudify blueprints. DCAE provides a Cloudify Manager plugin (k8splugin) that is capable of expanding a Cloudify blueprint node specification for a service component to a full Kubernetes specification, with additional enhancements such as replica scaling, sidecar for logging to ONAP ELK stack, registering services to MSB, etc.


Release Data
------------

+--------------------------------------+--------------------------------------------------------+
| **DCAE Project**                     |                                                        |
|                                      |                                                        |
+--------------------------------------+--------------------------------------------------------+
| **Docker images**                    | Refer :any:`Deliverable <guilin_deliverable>`          |
|                                      |                                                        |
+--------------------------------------+--------------------------------------------------------+
| **Release designation**              | 7.0.0 Guilin                                           |
|                                      |                                                        |
+--------------------------------------+--------------------------------------------------------+
| **Release date**                     | 2020-11-19                                             |
|                                      |                                                        |
+--------------------------------------+--------------------------------------------------------+


New features
------------

- DCAE Enhancements

    - Cloudify Container upgraded with new base image; plugins load optimized (DCAEGEN2-2236, DCAEGEN2-2207, DCAEGEN2-2262)
    - Bootstrap container optimization  (DCAEGEN2-1791)
    - MOD/Runtime – Enable configuration for dynamic topic support (DCAEGEN2-1996)
    - MOD/OnboardingAPI - Support for offline install (DCAEGEN2-2221)
    - DCAE Dashboard UI Optimization  and bugfixes (DCAEGEN2-2223, DCAEGEN2-2364,DCAEGEN2-1638,DCAEGEN2-2298, DCAEGEN2-1857)
    - Blueprint generator tool and K8Splugin enhancement to support External Certificate (DCAEGEN2-2250)
    - K8S v1.17 support through DCAE Cloudify K8S plugins (DCAEGEN2-2309)
    - Python 3.8 support enabled for several DCAE components - Heartbeat mS, PMSH mS, MOD/DistriubtorAPI mS, MOD/OnboardingAPI mS, Policy Library (DCAEGEN2-2292)
    - Java 11 upgrade complete for following modules - RESTConf, PM-Mapper, DFC, VES-Mapper, SON-handler, TCA-gen2, DL-Feeder, InventoryAPI, ServiceChangeHandler, MOD/RuntimeAPI, MOD/Bp-gen (DCAEGEN2-2223)
    - Hardcoded password removed from OOM charts - Cloudify, Bootstrap, DeploymentHandler, Dashboard; now managed dynamically through K8S secret (DCAEGEN2-1972, DCAEGEN2-1975)
    - Best practice compliance
    	 - STDOUT log compliance for DCAE Containers (DCAEGEN2-2324)
    	 - No more than one main process (DCAEGEN2-2327/REQ-365)
    	 - Container must crash when failure is noted (DCAEGEN2-2326/REQ-366)
    	 - All containers must run as non-root (REQ-362)
    	 - Code coverage >55% (DCAEGEN2-2333)
    - All Vulnerability identified by SECCOM has been resolved (DCAEGEN2-2242)
 

- Following new services are delivered this release

    - Event Processors
        - DataLake Extraction Service 
       
    - Analytics/RCA
        - Slice Analysis MS
	
.. _guilin_deliverable:

Deliverables
------------

Software Deliverables

.. csv-table::
   :header: "Repository", "SubModules", "Version & Docker Image (if applicable)"
   :widths: auto

   "dcaegen2/analytics/tca-gen2", "", "onap/org.onap.dcaegen2.analytics.tca-gen2.dcae-analytics-tca-web:1.2.1"
   "dcaegen2/collectors/datafile", "", "onap/org.onap.dcaegen2.collectors.datafile.datafile-app-server:1.4.3"
   "dcaegen2/collectors/hv-ves", "", "onap/org.onap.dcaegen2.collectors.hv-ves.hv-collector-main:1.5.0"
   "dcaegen2/collectors/restconf", "", "onap/org.onap.dcaegen2.collectors.restconfcollector:1.2.2"
   "dcaegen2/collectors/snmptrap", "", "onap/org.onap.dcaegen2.collectors.snmptrap:2.0.3"
   "dcaegen2/collectors/ves", "", "onap/org.onap.dcaegen2.collectors.ves.vescollector:1.7.9"
   "dcaegen2/deployments", "cm-container", "onap/org.onap.dcaegen2.deployments.cm-container:3.3.4"
   "dcaegen2/deployments", "consul-loader-container", "onap/org.onap.dcaegen2.deployments.consul-loader-container:1.0.0"
   "dcaegen2/deployments", "dcae-k8s-cleanup-container", "onap/org.onap.dcaegen2.deployments.dcae-k8s-cleanup-container:1.0.0"
   "dcaegen2/deployments", "healthcheck-container", "onap/org.onap.dcaegen2.deployments.healthcheck-container:2.1.0"
   "dcaegen2/deployments", "multisite-init-container", "onap/org.onap.dcaegen2.deployments.multisite-init-container:1.0.0"
   "dcaegen2/deployments", "tls-init-container", "onap/org.onap.dcaegen2.deployments.tls-init-container:2.1.0"
   "dcaegen2/platform", "mod/onboardingapi", "onap/org.onap.dcaegen2.platform.mod.onboardingapi:2.12.3"
   "dcaegen2/platform", "mod/distributorapi", "onap/org.onap.dcaegen2.platform.mod.distributorapi:1.1.0"
   "dcaegen2/platform", "mod/designtool", "onap/org.onap.dcaegen2.platform.mod.designtool-web:1.0.2"
   "dcaegen2/platform", "mod/genprocessor", "onap/org.onap.dcaegen2.platform.mod.genprocessor-http:1.0.2"
   "dcaegen2/platform", "mod/genprocessor", "onap/org.onap.dcaegen2.platform.mod.genprocessor-job:1.0.2"
   "dcaegen2/platform", "mod/designtool/mod-registry", "onap/org.onap.dcaegen2.platform.mod.mod-registry:1.0.0"
   "dcaegen2/platform", "mod/runtimeapi", "onap/org.onap.dcaegen2.platform.mod.runtime-web:1.1.1"
   "dcaegen2/platform", "adapter/acumos", "onap/org.onap.dcaegen2.platform.adapter.acumos:1.0.3"
   "dcaegen2/platform/blueprints", "", "onap/org.onap.dcaegen2.deployments.k8s-bootstrap-container:2.1.8" 
   "dcaegen2/platform/configbinding", "", "onap/org.onap.dcaegen2.platform.configbinding:2.5.3"
   "dcaegen2/platform/deployment-handler", "", "onap/org.onap.dcaegen2.platform.deployment-handler:4.4.1"
   "dcaegen2/platform/inventory-api", "", "onap/org.onap.dcaegen2.platform.inventory-api:3.5.1"  
   "dcaegen2/platform/policy-handler", "", "onap/org.onap.dcaegen2.platform.policy-handler:5.1.0"
   "dcaegen2/platform/servicechange-handler", "", "onap/org.onap.dcaegen2.platform.servicechange-handler:1.4.0"
   "dcaegen2/services", "components/datalake-handler", "onap/org.onap.dcaegen2.services.datalakefeeder:1.1.0"
   "dcaegen2/services", "components/datalake-handler", "onap/org.onap.dcaegen2.services.datalakeadminui:1.1.0"
   "dcaegen2/services", "components/datalake-handler", "onap/org.onap.dcaegen2.services.datalake.exposure.service:1.1.0"
   "dcaegen2/services", "components/pm-subscription-handler", "onap/org.onap.dcaegen2.services.pmsh:1.1.2"
   "dcaegen2/services", "components/slice-analysis-ms", "onap/org.onap.dcaegen2.services.components.slice-analysis-ms:1.0.1"
   "dcaegen2/services", "components/bbs-event-processor", "onap/org.onap.dcaegen2.services.components.bbs-event-processor:2.0.1"
   "dcaegen2/services/heartbeat", "", "onap/org.onap.dcaegen2.services.heartbeat:2.1.1"
   "dcaegen2/services/mapper", "", "onap/org.onap.dcaegen2.services.mapper.vesadapter.universalvesadaptor:1.1.0"
   "dcaegen2/services/pm-mapper", "", "onap/org.onap.dcaegen2.services.pm-mapper:1.4.1"
   "dcaegen2/services/prh", "", "onap/org.onap.dcaegen2.services.prh.prh-app-server:1.5.4"
   "dcaegen2/services/son-handler", "", "onap/org.onap.dcaegen2.services.son-handler:2.1.2"
   "dcaegen2/platform", "mod/bpgenerator", "Blueprint Generator 1.5.2 (jar)"
   "dcaegen2/services/sdk", "", "DCAE SDK 1.4.3 (jar)"
   "ccsdk/dashboard", "", "onap/org.onap.ccsdk.dashboard.ccsdk-app-os:1.4.0"
	

Known Limitations, Issues and Workarounds
-----------------------------------------

    * BPGenerator yaml Fixes are different for yaml file and string (DCAEGEN2-2489)
    * Slice Analysis - Avoid removal of data when insufficient samples are present (DCAEGEN2-2509)
    * HV-VES - Pod recovery when config-fetch fails (DCAEGEN2-2516)
    

*System Limitations*

None

*Known Vulnerabilities*

None

*Workarounds*

Documented under corresponding jira if applicable.

Security Notes
--------------

*Fixed Security Issues*
    Listed above
    
*Known Security Issues*

	None
	
	
*Known Vulnerabilities in Used Modules*

	None
	
DCAE code has been formally scanned during build time using NexusIQ and all Critical vulnerabilities have been addressed, items that remain open have been assessed for risk and determined to be false positive. The DCAE open Critical security vulnerabilities and their risk assessment have been documented as part of the `project <https://wiki.onap.org/pages/viewpage.action?pageId=51282478>`_.

Test Results
------------

 - `DCAE R7 Pairwise Test <https://wiki.onap.org/display/DW/DCAE+Pair+Wise+Testing+for+Guilin+Release>`_
 - `DCAE MOD R7 Test <https://wiki.onap.org/display/DW/DCAE+R7+Testplan>`_


References
----------

For more information on the ONAP Guilin release, please see:

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




..      ======================================
..      * * *    EL-ALTO  MAINTENANCE  * * *
..      ======================================


Version: 5.0.2
==============

.. _Version_5.0.2:

Abstract
--------

This document provides the release notes for the El-Alto Maintenance release


Summary
-------

This maintenance release is primarily to update expired certificates 
from original El-Alto released TLS-init container.

This patch is not required for Frankfurt release (and beyond) as certificates are dynamically 
retrieved from AAF at deployment time for all DCAE components.

Release Data
------------

+--------------------------------------+--------------------------------------+
| **Project**                          | DCAE                                 |
|                                      |                                      |
+--------------------------------------+--------------------------------------+
| **Docker images**                    | onap/org.onap.dcaegen2.deployments   |
|                                      |   .tls-init-container:1.0.4          |
+--------------------------------------+--------------------------------------+
| **Release designation**              | El-Alto  Maintenance Release         |
|                                      |                                      |
+--------------------------------------+--------------------------------------+
| **Release date**                     | 2020/08/24                           |
|                                      |                                      |
+--------------------------------------+--------------------------------------+

New features
------------

None

**Bug fixes**

- `DCAEGEN2-2206 <https://jira.onap.org/browse/DCAEGEN2-2206>`_ DCAE TLS Container : Address certificate expiration

**Known Issues**
Same as El-Alto Release



..      ======================================
..      * * *    FRANKFURT  MAINTENANCE  * * *
..      ======================================


Version: 6.0.1
==============

.. _Version_6.0.1:

Abstract
--------

This document provides the release notes for the Frankfurt Maintenance release


Summary
-------

The focus of this release is to correct issues found on Frankfurt release.

Release Data
------------

+--------------------------------------+--------------------------------------+
| **Project**                          | DCAE                                 |
|                                      |                                      |
+--------------------------------------+--------------------------------------+
| **Docker images**                    | onap/org.onap.dcaegen2.services.     |
|                                      |   son-handler:2.0.4                  |
+--------------------------------------+--------------------------------------+
| **Release designation**              | Frankfurt  Maintenance Release 1     |
|                                      |                                      |
+--------------------------------------+--------------------------------------+
| **Release date**                     | 2020/08/17                           |
|                                      |                                      |
+--------------------------------------+--------------------------------------+

New features
------------

None

**Bug fixes**

- `DCAEGEN2-2249 <https://jira.onap.org/browse/DCAEGEN2-2249>`_ SON-Handler: Fix networkId issue while making call to oof
- `DCAEGEN2-2216 <https://jira.onap.org/browse/DCAEGEN2-2216>`_ SON-Handler: Change Policy notification  to align with policy component updates

**Known Issues**

Same as Frankfurt Release




..      ===========================
..      * * *    FRANKFURT    * * *
..      ===========================


Version: 6.0.0
==============

.. _Version_6.0.0:


Abstract
--------

This document provides the release notes for the Frankfurt release.

Summary
-------

Following DCAE components are available with default ONAP/DCAE installation.

    - Platform components

        - Cloudify Manager (helm chart)
        - Bootstrap container (helm chart)
        - Configuration Binding Service (helm chart)
        - Deployment Handler (helm chart)
        - Policy Handler (helm chart
        - Service Change Handler (helm chart)
        - Inventory API (helm chart)
        - Dashboard (helm chart)

    - Service components

        - VES Collector
        - Threshold Crossing Analytics (TCA/CDAP)
        - HV-VES Collector
        - PNF-Registration Handler
        - Docker based Threshold Crossing Analytics (TCA-Gen2)
        - Holmes Rule Management *
        - Holmes Engine Management *

    - Additional resources that DCAE utilizes deployed using ONAP common charts:
    
        - Postgres Database
        - Mongo Database
        - Redis Cluster Database
        - Consul Cluster 

Below service components (mS) are available to be deployed on-demand.

 	- SNMPTrap Collector
 	- RESTConf Collector
 	- DataFile Collector
 	- PM-Mapper 
 	- BBS-EventProcessor
 	- VES Mapper
 	- Heartbeat mS
 	- SON-Handler
 	- PM-Subscription Handler

    Notes:

        \*  These components are delivered by the Holmes project.



Under OOM (Kubernetes) deployment all DCAE component containers are deployed as Kubernetes Pods/Deployments/Services into Kubernetes cluster. DCAE platform components are deployed using Helm charts. DCAE service components are deployed using Cloudify blueprints. DCAE provides a Cloudify Manager plugin (k8splugin) that is capable of expanding a Cloudify blueprint node specification for a service component to a full Kubernetes specification, with additional enhancements such as replica scaling, sidecar for logging to ONAP ELK stack, registering services to MSB, etc.


Release Data
------------

+--------------------------------------+--------------------------------------------------------+
| **DCAE Project**                     |                                                        |
|                                      |                                                        |
+--------------------------------------+--------------------------------------------------------+
| **Docker images**                    |Refer :any:`Deliverable <frankfurt_deliverable>`        |
|                                      |                                                        |
+--------------------------------------+--------------------------------------------------------+
| **Release designation**              | 6.0.0 frankfurt                                        |
|                                      |                                                        |
+--------------------------------------+--------------------------------------------------------+
| **Release date**                     | 2020-06-04                                             |
|                                      |                                                        |
+--------------------------------------+--------------------------------------------------------+


New features
------------

- DCAE Platform Enhancement

    - Introduction of Microservice and Onboarding Design (MOD) platform 
    - Policy Notification support for DCAE components
    - Dynamic AAF certificate creation during component instantiation
    - Helm chart optimization to control each platform component separate
    - Dashboard Optimization 
    - Blueprint generator tool to simplify deployment artifact creation
   

- Following new services are delivered this release

    - Event Processors
    
        - PM Subscription Handler
        - DataLake Handlers 
    - Analytics/RCA
    
        - TCA-GEN2
	
	- Acumos Adapter (PoC)

.. _frankfurt_deliverable:

Deliverables
------------

Software Deliverables

.. csv-table::
   :header: "Repository", "SubModules", "Version & Docker Image (if applicable)"
   :widths: auto

   "dcaegen2/analytics/tca-gen2", "", "onap/org.onap.dcaegen2.analytics.tca-gen2.dcae-analytics-tca-web:1.0.1"
   "dcaegen2/collectors/datafile", "", "onap/org.onap.dcaegen2.collectors.datafile.datafile-app-server:1.3.0"
   "dcaegen2/collectors/hv-ves", "", "onap/org.onap.dcaegen2.collectors.hv-ves.hv-collector-main:1.4.0"
   "dcaegen2/collectors/restconf", "", "onap/org.onap.dcaegen2.collectors.restconfcollector:1.1.1"
   "dcaegen2/collectors/snmptrap", "", "onap/org.onap.dcaegen2.collectors.snmptrap:2.0.3"
   "dcaegen2/collectors/ves", "", "onap/org.onap.dcaegen2.collectors.ves.vescollector:1.5.4"
   "dcaegen2/deployments", "cm-container", "onap/org.onap.dcaegen2.deployments.cm-container:2.1.0"
   "dcaegen2/deployments", "consul-loader-container", "onap/org.onap.dcaegen2.deployments.consul-loader-container:1.0.0"
   "dcaegen2/deployments", "dcae-k8s-cleanup-container", "onap/org.onap.dcaegen2.deployments.dcae-k8s-cleanup-container:1.0.0"
   "dcaegen2/deployments", "healthcheck-container", "onap/org.onap.dcaegen2.deployments.healthcheck-container:1.3.1"
   "dcaegen2/deployments", "multisite-init-container", "onap/org.onap.dcaegen2.deployments.multisite-init-container:1.0.0"
   "dcaegen2/deployments", "redis-cluster-container", "onap/org.onap.dcaegen2.deployments.redis-cluster-container:1.0.0"
   "dcaegen2/deployments", "tca-cdap-container", "onap/org.onap.dcaegen2.deployments.tca-cdap-container:1.2.2"
   "dcaegen2/deployments", "tls-init-container", "onap/org.onap.dcaegen2.deployments.tls-init-container:2.1.0"
   "dcaegen2/platform", "mod/onboardingapi", "onap/org.onap.dcaegen2.platform.mod.onboardingapi:2.12.1"
   "dcaegen2/platform", "mod/distributorapi", "onap/org.onap.dcaegen2.platform.mod.distributorapi:1.0.1"
   "dcaegen2/platform", "mod/designtool", "onap/org.onap.dcaegen2.platform.mod.designtool-web:1.0.2"
   "dcaegen2/platform", "mod/genprocessor", "onap/org.onap.dcaegen2.platform.mod.genprocessor-http:1.0.1"
   "dcaegen2/platform", "mod/genprocessor", "onap/org.onap.dcaegen2.platform.mod.genprocessor-job:1.0.1"
   "dcaegen2/platform", "mod/designtool/mod-registry", "onap/org.onap.dcaegen2.platform.mod.mod-registry:1.0.0"
   "dcaegen2/platform", "mod/runtimeapi", "onap/org.onap.dcaegen2.platform.mod.runtime-web:1.0.3"
   "dcaegen2/platform/blueprints", "", "onap/org.onap.dcaegen2.deployments.k8s-bootstrap-container:1.12.6" 
   "dcaegen2/platform/configbinding", "", "onap/org.onap.dcaegen2.platform.configbinding:2.5.2"
   "dcaegen2/platform/deployment-handler", "", "onap/org.onap.dcaegen2.platform.deployment-handler:4.3.0"
   "dcaegen2/platform/inventory-api", "", "onap/org.onap.dcaegen2.platform.inventory-api:3.4.1"  
   "dcaegen2/platform/policy-handler", "", "onap/org.onap.dcaegen2.platform.policy-handler:5.1.0"
   "dcaegen2/platform/servicechange-handler", "", "onap/org.onap.dcaegen2.platform.servicechange-handler:1.3.2"
   "dcaegen2/services", "components/datalake-handler", "onap/org.onap.dcaegen2.services.datalakefeeder:1.0.2"
   "dcaegen2/services", "components/datalake-handler", "onap/org.onap.dcaegen2.services.datalakeadminui:1.0.2"
   "dcaegen2/services", "components/pm-subscription-handler", "onap/org.onap.dcaegen2.services.pmsh:1.0.3"
   "dcaegen2/services", "components/bbs-event-processor", "onap/org.onap.dcaegen2.services.components.bbs-event-processor:2.0.0"
   "dcaegen2/services/heartbeat", "", "onap/org.onap.dcaegen2.services.heartbeat:2.1.0"
   "dcaegen2/services/mapper", "", "onap/org.onap.dcaegen2.services.mapper.vesadapter.universalvesadaptor:1.0.1"
   "dcaegen2/services/pm-mapper", "", "onap/org.onap.dcaegen2.services.pm-mapper:1.3.1"
   "dcaegen2/services/prh", "", "onap/org.onap.dcaegen2.services.prh.prh-app-server:1.5.2"
   "dcaegen2/services/son-handler", "", "onap/org.onap.dcaegen2.services.son-handler:2.0.2"
   "dcaegen2/platform", "adapter/acumos", "onap/org.onap.dcaegen2.platform.adapter.acumos:1.0.2"
   "dcaegen2/platform", "mod/bpgenerator", "Blueprint Generator 1.3.1 (jar)"
   "dcaegen2/services/sdk", "", "DCAE SDK 1.3.5 (jar)"
   "ccsdk/dashboard", "", "onap/org.onap.ccsdk.dashboard.ccsdk-app-os:1.3.2"
	

Known Limitations, Issues and Workarounds
-----------------------------------------

    * Blueprint generator escape char issue (DCAEGEN2-2140)
    * TCAgen2 Policy configuration support (DCAEGEN2-2198)
    * TCA/CDAP config refresh causes duplicate events (DCAEGEN2-2241)



*System Limitations*

None

*Known Vulnerabilities*

None

*Workarounds*

Documented under corresponding jira if applicable.

Security Notes
--------------

*Fixed Security Issues*

    * Unsecured Swagger UI Interface in xdcae-ves-collector. [`OJSI-30 <https://jira.onap.org/browse/OJSI-30>`_]
    * In default deployment DCAEGEN2 (xdcae-ves-collector) exposes HTTP port 30235 outside of cluster. [`OJSI-116 <https://jira.onap.org/browse/OJSI-116>`_]
    * In default deployment DCAEGEN2 (xdcae-dashboard) exposes HTTP port 30418 outside of cluster. [`OJSI-159 <https://jira.onap.org/browse/OJSI-159>`_]
    * In default deployment DCAEGEN2 (dcae-redis) exposes redis port 30286 outside of cluster. [`OJSI-187 <https://jira.onap.org/browse/OJSI-187>`_]
    * In default deployment DCAEGEN2 (config-binding-service) exposes HTTP port 30415 outside of cluster. [`OJSI-195 <https://jira.onap.org/browse/OJSI-195>`_]

    
*Known Security Issues*

	None
	
	
*Known Vulnerabilities in Used Modules*

	None
	
DCAE code has been formally scanned during build time using NexusIQ and all Critical vulnerabilities have been addressed, items that remain open have been assessed for risk and determined to be false positive. The DCAE open Critical security vulnerabilities and their risk assessment have been documented as part of the `project <https://wiki.onap.org/pages/viewpage.action?pageId=51282478>`_.

Test Results
------------

 - `DCAE R6 Pairwise Test <https://wiki.onap.org/display/DW/DCAE+Pair+Wise+Testing+for+Frankfurt+Release>`_
 - `DCAE MOD R6 Test <https://wiki.onap.org/display/DW/DCAE+MOD+Test+Plan>`_


References
----------

For more information on the ONAP Frankfurt release, please see:

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


..      =========================
..      * * *    EL-ALTO    * * *
..      =========================


Version: 5.0.1
==============

.. _Version_5.0.1:

The offical El-Alto release (rolls up all 5.0.0 early drop deliverables) focused on technical debts and SECCOM priority work-items.

Following is summary of updates done for DCAEGEN2

**Security**

Following platform components were enabled for HTTPS
    - ConfigBindingService (CBS)
      -   CBS is used by all DCAE MS to fetch DCAE MS configuration from Consul. To mitigate impact for DCAE MS, CBS deployment through OOM/Helm was modified to support CBS on both HTTP and HTTPS. `Design for CBS TLS migration <https://wiki.onap.org/display/DW/TLS+support+for+CBS+-+Migration+Plan>`_
    - Cloudify Manager
    - InventoryAPI
    - Non-root container process (ConfigBindingService, InventoryAPI, ServiceChangeHandler, HV-VES, PRH, Son-handler)

All components interfacing with platform components were modified to support TLS interface

**Miscellaneous**
    - DCAE Dashboard deployment migration from cloudify blueprint to OOM/Chart
    - Dynamic Topic support via Dmaap plugin integration for DataFileCollector MS
    - Dynamic Topic support via Dmaap plugin integration for PM-Mapper service
    - CBS client libraries updated to remove consul service lookup
    - Image Optimization (ConfigBindingService, InventoryAPI, ServiceChangeHandler, HV-VES, PRH, Son-handler)



With this release, all DCAE platform components has been migrated to helm charts. Following is complete list of DCAE components available part of default ONAP/DCAE installation.
    - Platform components
        - Cloudify Manager (helm chart)
        - Bootstrap container (helm chart)
        - Configuration Binding Service (helm chart)
        - Deployment Handler (helm chart)
        - Policy Handler (helm chart
        - Service Change Handler (helm chart)
        - Inventory API (helm chart)
        - Dashboard (helm charts)
    - Service components
        - VES Collector
        - SNMP Collector
        - Threshold Crossing Analytics
        - HV-VES Collector
        - PNF-Registration Handler
        - Holmes Rule Management *
        - Holmes Engine Management *
    - Additional resources that DCAE utilizes:
        - Postgres Database
        - Redis Cluster Database
        - Consul Cluster *

    Notes:
        \*  These components are delivered by external ONAP project.

DCAE also includes below MS which can be deployed on-demand (via Dashboard or Cloudify CLI or CLAMP)

    - Collectors
        - RESTConf collector 
        - DataFile collector
    - Event Processors
        - VES Mapper
        - 3gpp PM-Mapper
        - BBS Event processor
    - Analytics/RCA
        - SON-Handler
        - Missing Heartbeat Ms

- All DCAE components are designed to support platform maturity requirements.


**Source Code**

Source code of DCAE components are released under the following repositories on gerrit.onap.org; there is no new component introduced for El-Alto Early-drop.
    - dcaegen2
    - dcaegen2.analytics.tca
    - dcaegen2.collectors.snmptrap
    - dcaegen2.collectors.ves
    - dcaegen2.collectors.hv-ves
    - dcaegen2.collectors.datafile
    - dcaegen2.collectors.restconf
    - dcaegen2.deployments
    - dcaegen2.platform.blueprints
    - dcaegen2.platform.cli
    - dcaegen2.platform.configbinding
    - dcaegen2.platform.deployment-handler
    - dcaegen2.platform.inventory-api
    - dcaegen2.platform.plugins
    - dcaegen2.platform.policy-handler
    - dcaegen2.platform.servicechange-handler
    - dcaegen2.services.heartbeat
    - dcaegen2.services.mapper
    - dcaegen2.services.pm-mapper
    - dcaegen2.services.prh
    - dcaegen2.services.son-handler
    - dcaegen2.services
    - dcaegen2.services.sdk
    - dcaegen2.utils
    - ccsdk.platform.plugins
    - ccsdk.dashboard

**Bug Fixes**
    * k8splugin can generate deployment name > 63 chars (DCAEGEN2-1667)
    * CM container loading invalid Cloudify types file (DCAEGEN2-1685)


**Known Issues**
    * Healthcheck/Readiness probe VES Collector when authentication is enabled (DCAEGEN2-1594)

**Security Notes**

*Fixed Security Issues*
    * Unsecured Swagger UI Interface in xdcae-datafile-collector. [`OJSI-28 <https://jira.onap.org/browse/OJSI-28>`_]
    * In default deployment DCAEGEN2 (xdcae-datafile-collector) exposes HTTP port 30223 outside of cluster. [`OJSI-109 <https://jira.onap.org/browse/OJSI-109>`_]
    * In default deployment DCAEGEN2 (xdcae-tca-analytics) exposes HTTP port 32010 outside of cluster. [`OJSI-161 <https://jira.onap.org/browse/OJSI-161>`_]
    * In default deployment DCAEGEN2 (dcae-datafile-collector) exposes HTTP port 30262 outside of cluster. [`OJSI-131 <https://jira.onap.org/browse/OJSI-131>`_]
    * CVE-2019-12126 - DCAE TCA exposes unprotected APIs/UIs on port 32010. [`OJSI-201 <https://jira.onap.org/browse/OJSI-201>`_]

*Known Security Issues*
    * Unsecured Swagger UI Interface in xdcae-ves-collector. [`OJSI-30 <https://jira.onap.org/browse/OJSI-30>`_]
    * In default deployment DCAEGEN2 (xdcae-ves-collector) exposes HTTP port 30235 outside of cluster. [`OJSI-116 <https://jira.onap.org/browse/OJSI-116>`_]
    * In default deployment DCAEGEN2 (xdcae-dashboard) exposes HTTP port 30418 outside of cluster. [`OJSI-159 <https://jira.onap.org/browse/OJSI-159>`_]
    * In default deployment DCAEGEN2 (dcae-redis) exposes redis port 30286 outside of cluster. [`OJSI-187 <https://jira.onap.org/browse/OJSI-187>`_]
    * In default deployment DCAEGEN2 (config-binding-service) exposes HTTP port 30415 outside of cluster. [`OJSI-195 <https://jira.onap.org/browse/OJSI-195>`_]

*Known Vulnerabilities in Used Modules*

DCAE code has been formally scanned during build time using NexusIQ and all Critical vulnerabilities have been addressed, items that remain open have been assessed for risk and determined to be false positive. The DCAE open Critical security vulnerabilities and their risk assessment have been documented as part of the `project <https://wiki.onap.org/pages/viewpage.action?pageId=51282478>`_.

Quick Links:
        - `DCAE project page <https://wiki.onap.org/display/DW/Data+Collection+Analytics+and+Events+Project>`_

        - `Passing Badge information for DCAE <https://bestpractices.coreinfrastructure.org/en/projects/1718>`_

        - `Project Vulnerability Review Table for DCAE (El-Alto Maintenance) <https://wiki.onap.org/pages/viewpage.action?pageId=68540441>`_


**Upgrade Notes**

The following components are upgraded from Dublin/R4 and El-Alto EarlyDrop deliverables.
    - K8S Bootstrap container:
       - Docker container tag: onap/org.onap.dcaegen2.deployments.k8s-bootstrap-container:1.6.4
       - Description: K8s bootstrap container updated to interface with Cloudify using HTTPS; new k8s and Dmaap plugin version included; Dashboard deployment was removed.
    - Configuration Binding Service:
       - Docker container tag: onap/org.onap.dcaegen2.platform.configbinding.app-app:2.5.2
       - Description: HTTPS support, Image optimization and non-root user
    - Inventory API
       - Docker container image tag: onap/org.onap.dcaegen2.platform.inventory-api:3.4.0
       - Description: HTTPS support, container optmization and non-root user
    - DataFile Collector
       - Docker container tag: onap/org.onap.dcaegen2.collectors.datafile.datafile-app-server:1.2.3
       - Description : Code optimization, bug fixes, dmaap plugin integration
    - SON Handler MS
       - Docker container tag: onap/org.onap.dcaegen2.services.son-handler:1.1.1
       - Description : Image optimization, bug fixes, CBS integration
    - VES Adapter/Mapper MS
       - Docker container tag: onap/org.onap.dcaegen2.services.mapper.vesadapter.universalvesadaptor:1.0.1
       - Description : Image optimization & CBS periodic polling
    - PRH MS
       - Docker container tag: onap/org.onap.dcaegen2.services.prh.prh-app-server:1.3.1
       - Description : Code optimization, bug fixes and SDK alignment
    - HV-VES MS
       - Docker container tag: onap/org.onap.dcaegen2.collectors.hv-ves.hv-collector-main:1.3.0
       - Description : Code optimization, bug fixes and SDK alignment

Version: 5.0.0
==============

.. _Version_5.0.0:

El-Alto Early-drop focused on technical debts and SECCOM priority work-items.

Following is summary of updates done for DCAEGEN2

**Security**

Following platform components were enabled for HTTPS
    - ConfigBindingService (CBS)
      -   CBS is used by all DCAE MS to fetch DCAE MS configuration from Consul. To mitigate impact for DCAE MS, CBS deployment through OOM/Helm was modified to support CBS on both HTTP and HTTPS. `Design for CBS TLS migration <https://wiki.onap.org/display/DW/TLS+support+for+CBS+-+Migration+Plan>`_
    - Cloudify Manager
    - InventoryAPI

All components interfacing with platform components were modified to support TLS interface

**Miscellaneous**
    - DCAE Dashboard deployment migration from cloudify blueprint to OOM/Chart
    - Dynamic Topic support via Dmaap plugin integration for DataFileCollector MS
    - Dynamic Topic support via Dmaap plugin integration for PM-Mapper service
    - CBS client libraries updated to remove consul service lookup



**Bug Fixes**
    * k8splugin can generate deployment name > 63 chars (DCAEGEN2-1667)
    * CM container loading invalid Cloudify types file (DCAEGEN2-1685)


**Known Issues**
    * Healthcheck/Readiness probe VES Collector when authentication is enabled (DCAEGEN2-1594)


**Security Notes**

*Fixed Security Issues*

*Known Security Issues*

    * Unsecured Swagger UI Interface in xdcae-datafile-collector. [`OJSI-28 <https://jira.onap.org/browse/OJSI-28>`_]
    * Unsecured Swagger UI Interface in xdcae-ves-collector. [`OJSI-30 <https://jira.onap.org/browse/OJSI-30>`_]
    * In default deployment DCAEGEN2 (xdcae-datafile-collector) exposes HTTP port 30223 outside of cluster. [`OJSI-109 <https://jira.onap.org/browse/OJSI-109>`_]
    * In default deployment DCAEGEN2 (xdcae-ves-collector) exposes HTTP port 30235 outside of cluster. [`OJSI-116 <https://jira.onap.org/browse/OJSI-116>`_]
    * In default deployment DCAEGEN2 (dcae-datafile-collector) exposes HTTP port 30262 outside of cluster. [`OJSI-131 <https://jira.onap.org/browse/OJSI-131>`_]
    * In default deployment DCAEGEN2 (xdcae-dashboard) exposes HTTP port 30418 outside of cluster. [`OJSI-159 <https://jira.onap.org/browse/OJSI-159>`_]
    * In default deployment DCAEGEN2 (xdcae-tca-analytics) exposes HTTP port 32010 outside of cluster. [`OJSI-161 <https://jira.onap.org/browse/OJSI-161>`_]
    * In default deployment DCAEGEN2 (dcae-redis) exposes redis port 30286 outside of cluster. [`OJSI-187 <https://jira.onap.org/browse/OJSI-187>`_]
    * In default deployment DCAEGEN2 (config-binding-service) exposes HTTP port 30415 outside of cluster. [`OJSI-195 <https://jira.onap.org/browse/OJSI-195>`_]
    * CVE-2019-12126 - DCAE TCA exposes unprotected APIs/UIs on port 32010. [`OJSI-201 <https://jira.onap.org/browse/OJSI-201>`_]

*Known Vulnerabilities in Used Modules*

DCAE code has been formally scanned during build time using NexusIQ and all Critical vulnerabilities have been addressed, items that remain open have been assessed for risk and determined to be false positive. The DCAE open Critical security vulnerabilities and their risk assessment have been documented as part of the `project <https://wiki.onap.org/pages/viewpage.action?pageId=51282478>`_.

Quick Links:
        - `DCAE project page <https://wiki.onap.org/display/DW/Data+Collection+Analytics+and+Events+Project>`_

        - `Passing Badge information for DCAE <https://bestpractices.coreinfrastructure.org/en/projects/1718>`_

        - `Project Vulnerability Review Table for DCAE (El-Alto) <https://wiki.onap.org/pages/viewpage.action?pageId=68540441>`_


**Upgrade Notes**

The following components are upgraded from Dublin/R4.
    - Cloudify Manager:
       - Docker container tag: onap/org.onap.dcaegen2.deployments.cm-container:2.0.2
       - Description: DCAE's Cloudify Manager container is based on Cloudify Manager Community Version 19.01.24, which is based on Cloudify Manager 4.5. The container was updated to support TLS.
    - K8S Bootstrap container:
       - Docker container tag: onap/org.onap.dcaegen2.deployments.k8s-bootstrap-container:1.6.2
       - Description: K8s bootstrap container updated to interface with Cloudify using HTTPS; new k8s and Dmaap plugin version included; Dashboard deployment was removed.
    - Configuration Binding Service:
       - Docker container tag: onap/org.onap.dcaegen2.platform.configbinding.app-app:2.5.1
       - Description: HTTPS support, Image optimization and non-root user
    - Deployment Handler
       - Docker container image tag: onap/org.onap.dcaegen2.platform.deployment-handler:4.2.0
       - Description: Update to node10, uninstall workflow updates
    - Service Change Handler
       - Docker container image tag: onap/org.onap.dcaegen2.platform.servicechange-handler:1.3.2
       - Description: HTTPS inventoryAPI support, container optmization and non-root user
    - Inventory API
       - Docker container image tag: onap/org.onap.dcaegen2.platform.inventory-api:3.4.0
       - Description: HTTPS support, container optmization and non-root user
    - DataFile Collector
       - Docker container tag: onap/org.onap.dcaegen2.collectors.datafile.datafile-app-server:1.2.2
       - Description : Code optimization, bug fixes, dmaap plugin integration
    - 3gpp PM-Mapper
       - Docker container tag: onap/org.onap.dcaegen2.services.pm-mapper:1.1.3
       - Description: Code optimization, bug fixes, dmaap plugin integration



Version: 4.0.0
==============

.. _Version_4.0.0:

:Release Date: 2019-06-06

**New Features**

DCAE R4 improves upon previous release with the following new features:

- DCAE Platform Enhancement
    - Multisite K8S cluster deployment support for DCAE services (via K8S plugin)
    - Support helm chart deployment in DCAE using new Helm cloudify plugin
    - DCAE Healthcheck enhancement to cover static and dynamic deployments
    - Dynamic AAF based topic provisioning support through Dmaap cloudify plugin
    - Dashboard Integration (UI for deployment/verification)
    - PolicyHandler Enhancement to support new Policy Lifecycle API’s
    - Blueprint generator tool to simplify deployment artifact creation
    - Cloudify Manager resiliency

- Following new services are delivered with Dublin
    - Collectors
        - RESTConf collector 
    - Event Processors
        - VES Mapper
        - 3gpp PM-Mapper
        - BBS Event processor
    - Analytics/RCA
        - SON-Handler
        - Heartbeat MS

Most platform components has been migrated to helm charts. Following is complete list of DCAE components available part of default ONAP/dcae installation.
    - Platform components
        - Cloudify Manager (helm chart)
        - Bootstrap container (helm chart)
        - Configuration Binding Service (helm chart)
        - Deployment Handler (helm chart)
        - Policy Handler (helm chart
        - Service Change Handler (helm chart)
        - Inventory API (helm chart)
        - Dashboard (Cloudify Blueprint)
    - Service components
        - VES Collector
        - SNMP Collector
        - Threshold Crossing Analytics
        - HV-VES Collector
        - PNF-Registration Handler
        - Holmes Rule Management *
        - Holmes Engine Management *
    - Additional resources that DCAE utilizes:
        - Postgres Database
        - Redis Cluster Database
        - Consul Cluster *

    Notes:
        \*  These components are delivered by the Holmes project.


Under OOM (Kubernetes) deployment all DCAE component containers are deployed as Kubernetes Pods/Deployments/Services into Kubernetes cluster. DCAE R3 includes enhancement to Cloudify Manager plugin (k8splugin) that is capable of expanding a Blueprint node specification written for Docker container to a full Kubernetes specification, with additional enhancements such as replica scaling, sidecar for logging to ONAP ELK stack, registering services to MSB, etc.

- All DCAE components are designed to support platform maturity requirements.


**Source Code**

Source code of DCAE components are released under the following repositories on gerrit.onap.org:
    - dcaegen2
    - dcaegen2.analytics.tca
    - dcaegen2.collectors.snmptrap
    - dcaegen2.collectors.ves
    - dcaegen2.collectors.hv-ves
    - dcaegen2.collectors.datafile
    - dcaegen2.collectors.restconf
    - dcaegen2.deployments
    - dcaegen2.platform.blueprints
    - dcaegen2.platform.cli
    - dcaegen2.platform.configbinding
    - dcaegen2.platform.deployment-handler
    - dcaegen2.platform.inventory-api
    - dcaegen2.platform.plugins
    - dcaegen2.platform.policy-handler
    - dcaegen2.platform.servicechange-handler
    - dcaegen2.services.heartbeat
    - dcaegen2.services.mapper
    - dcaegen2.services.pm-mapper
    - dcaegen2.services.prh
    - dcaegen2.services.son-handler
    - dcaegen2.services
    - dcaegen2.services.sdk
    - dcaegen2.utils
    - ccsdk.platform.plugins
    - ccsdk.dashboard

**Bug Fixes**

**Known Issues**
    * Healthcheck/Readiness probe VES Collector when authentication is enabled (DCAEGEN2-1594)


**Security Notes**

*Fixed Security Issues*

*Known Security Issues*

    * Unsecured Swagger UI Interface in xdcae-datafile-collector. [`OJSI-28 <https://jira.onap.org/browse/OJSI-28>`_]
    * Unsecured Swagger UI Interface in xdcae-ves-collector. [`OJSI-30 <https://jira.onap.org/browse/OJSI-30>`_]
    * In default deployment DCAEGEN2 (xdcae-datafile-collector) exposes HTTP port 30223 outside of cluster. [`OJSI-109 <https://jira.onap.org/browse/OJSI-109>`_]
    * In default deployment DCAEGEN2 (xdcae-ves-collector) exposes HTTP port 30235 outside of cluster. [`OJSI-116 <https://jira.onap.org/browse/OJSI-116>`_]
    * In default deployment DCAEGEN2 (dcae-datafile-collector) exposes HTTP port 30262 outside of cluster. [`OJSI-131 <https://jira.onap.org/browse/OJSI-131>`_]
    * In default deployment DCAEGEN2 (xdcae-dashboard) exposes HTTP port 30418 outside of cluster. [`OJSI-159 <https://jira.onap.org/browse/OJSI-159>`_]
    * In default deployment DCAEGEN2 (xdcae-tca-analytics) exposes HTTP port 32010 outside of cluster. [`OJSI-161 <https://jira.onap.org/browse/OJSI-161>`_]
    * In default deployment DCAEGEN2 (dcae-redis) exposes redis port 30286 outside of cluster. [`OJSI-187 <https://jira.onap.org/browse/OJSI-187>`_]
    * In default deployment DCAEGEN2 (config-binding-service) exposes HTTP port 30415 outside of cluster. [`OJSI-195 <https://jira.onap.org/browse/OJSI-195>`_]
    * CVE-2019-12126 - DCAE TCA exposes unprotected APIs/UIs on port 32010. [`OJSI-201 <https://jira.onap.org/browse/OJSI-201>`_]

*Known Vulnerabilities in Used Modules*

DCAE code has been formally scanned during build time using NexusIQ and all Critical vulnerabilities have been addressed, items that remain open have been assessed for risk and determined to be false positive. The DCAE open Critical security vulnerabilities and their risk assessment have been documented as part of the `project <https://wiki.onap.org/pages/viewpage.action?pageId=51282478>`_.

Quick Links:
        - `DCAE project page <https://wiki.onap.org/display/DW/Data+Collection+Analytics+and+Events+Project>`_

        - `Passing Badge information for DCAE <https://bestpractices.coreinfrastructure.org/en/projects/1718>`_

        - `Project Vulnerability Review Table for DCAE (Dublin) <https://wiki.onap.org/pages/viewpage.action?pageId=51282478>`_


**New component Notes**
The following components are introduced in R4

    - Dashboard
       - Docker container tag: onap/org.onap.ccsdk.dashboard.ccsdk-app-os:1.1.0
       - Description: Dashboard provides an UI interface for users/operation to deploy and manage service components in DCAE
    - Blueprint generator
       - Java artifact : /org/onap/dcaegen2/platform/cli/blueprint-generator/1.0.0/blueprint-generator-1.0.0.jar
       - Description: Tool to generate the deployment artifact (cloudify blueprints) based on component spec
    - RESTConf collector 
       - Docker container tag: onap/org.onap.dcaegen2.collectors.restconfcollector:1.1.1
       - Description: Provides RESTConf interfaces to events from external domain controllers
    - VES/Universal Mapper
       - Docker container tag: onap/org.onap.dcaegen2.services.mapper.vesadapter.universalvesadaptor:1.0.0
       - Description: Standardizes events recieved from SNMP and RESTConf collector into VES for further processing with DCAE analytics services
    - 3gpp PM-Mapper
       - Docker container tag: onap/org.onap.dcaegen2.services.pm-mapper:1.0.1
       - Description: Transforms 3gpp data feed recieved from DMAAP-DR into VES events
    - BBS Event processor
       - Docker container tag: onap/org.onap.dcaegen2.services.components.bbs-event-processor:1.0.0
       - Description: Handles PNF-Reregistration and CPE authentication events and generate CL events
    - SON-Handler
       - Docker container tag: onap/org.onap.dcaegen2.services.son-handler:1.0.3
       - Description: Supports PC-ANR optimization analysis and generating CL events output
    - Heartbeat MS
       - Docker container tag: onap/org.onap.dcaegen2.services.heartbeat:2.1.0
       - Description: Generates missing heartbeat CL events based on configured threshold for VES heartbeats/VNF type.


**Upgrade Notes**

The following components are upgraded from R3
    - Cloudify Manager:
       - Docker container tag: onap/org.onap.dcaegen2.deployments.cm-container:1.6.2
       - Description: DCAE's Cloudify Manager container is based on Cloudify Manager Community Version 19.01.24, which is based on Cloudify Manager 4.5.
    - K8S Bootstrap container:
       - Docker container tag: onap/org.onap.dcaegen2.deployments.k8s-bootstrap-container:1.4.18
       - Description: K8s bootstrap container updated to include new plugin and remove DCAE Controller components which have been migrated to Helm chart.
    - Configuration Binding Service:
       - Docker container tag: onap/org.onap.dcaegen2.platform.configbinding.app-app:2.3.0
       - Description: Code optimization and bug fixes
    - Deployment Handler
       - Docker container image tag: onap/org.onap.dcaegen2.platform.deployment-handler:4.0.1
       - Include updates for health and service endpoint check and bug fixes
    - Policy Handler
       - Docker container image tag: onap/org.onap.dcaegen2.platform.policy-handler:5.0.0
       - Description: Policy Handler supports the new lifecycle API's from Policy framework
    - Service Change Handler
       - Docker container image tag: onap/org.onap.dcaegen2.platform.servicechange-handler:1.1.5
       - Description: No update from R3
    - Inventory API
       - Docker container image tag: onap/org.onap.dcaegen2.platform.inventory-api:3.2.0
       - Description: Refactoring and updates for health and service endpoint check
    - VES Collector
       - Docker container image tag: onap/org.onap.dcaegen2.collectors.ves.vescollector:1.4.5
       - Description : Authentication enhancement, refactoring and bug-fixes
    - Threshold Crossing Analytics
       - Docker container image tag: onap/org.onap.dcaegen2.deployments.tca-cdap-container:1.1.2
       - Description: Config updates. Replaced Hadoop VM Cluster based file system with regular host file system; repackaged full TCA-CDAP stack into Docker container; transactional state separation from TCA in-memory to off-node Redis cluster for supporting horizontal scaling.
    - DataFile Collector
       - Docker container tag: onap/org.onap.dcaegen2.collectors.datafile.datafile-app-server:1.1.3
       - Description : Code optimization, bug fixes, logging and performance improvement
    - PNF Registrator handler
       - Docker container tag: onap/org.onap.dcaegen2.services.prh.prh-app-server:1.2.4
       - Description : Code optimization, SDK integration, PNF-UPDATE flow support
    - HV-VES Collector
       - Docker container tag: onap/org.onap.dcaegen2.collectors.hv-ves.hv-collector-main:1.1.0
       - Description : Code optimization, bug fixes, and enables SASL for kafka interface
    - SNMP Trap Collector
       - Docker container tag: onap/org.onap.dcaegen2.collectors.snmptrap:1.4.0
       - Description : Code coverage improvements




Version: 3.0.1
==============

.. _Version_3.0.1:

:Release Date: 2019-01-31

DCAE R3 Maintenance release includes following fixes

**Bug Fixes**

- DataFileCollector
     - DCAEGEN2-940
       Larger files of size 100Kb publish to DR
     - DCAEGEN2-941
       DFC error after running over 12 hours
     - DCAEGEN2-1001
       Multiple Fileready notification not handled

- HighVolume VES Collector (protobuf/tcp)
     - DCAEGEN2-976
       HV-VES not fully complaint to RTPM protocol (issue with CommonEventHeader.sequence)

- VESCollector (http)
     - DCAEGEN2-1035
       Issue with VES batch event publish

- Heat deployment
     - DCAEGEN2-1007
       Removing obsolete services configuration


The following containers are updated in R3.0.1

    - DataFile Collector
       - Docker container tag: onap/org.onap.dcaegen2.collectors.datafile.datafile-app-server:1.0.5
    - HV-VES Collector
       - Docker container tag: onap/org.onap.dcaegen2.collectors.hv-ves.hv-collector-main:1.0.2
    - VES Collector
       - Docker container tag: onap/org.onap.dcaegen2.collectors.ves.vescollector:1.3.2

**Known Issues**

- An issue related to VESCollector basic authentication was noted and tracked under DCAEGEN2-1130. This configuration is not enabled by default for R3.0.1; and fix will be handled in Dublin

- Certificates under onap/org.onap.dcaegen2.deployments.tls-init-container:1.0.0 has expired March'2019 and impacting CL deployment from CLAMP. Follow below workaround to update the certificate
    kubectl get deployments -n onap | grep deployment-handler
    kubectl edit deployment -n onap dev-dcaegen2-dcae-deployment-handler
    Search and change tag onap/org.onap.dcaegen2.deployments.tls-init-container:1.0.0 to onap/org.onap.dcaegen2.deployments.tls-init-container:1.0.3




Version: 3.0.0
--------------

.. _Version_3.0.0:

:Release Date: 2018-11-30

**New Features**

DCAE R3 improves upon previous release with the following new features:

- All DCAE R3 components are delivered as Docker container images.  The list of components is as follows.
    - Platform components
        - Cloudify Manager
        - Bootstrap container
        - Configuration Binding Service
        - Deployment Handler
        - Policy Handler
        - Service Change Handler
        - Inventory API
    - Service components
        - VES Collector
        - SNMP Collector
        - Threshold Crossing Analytics
        - Holmes Rule Management *
        - Holmes Engine Management *
    - Additional resources that DCAE utilizes:
        - Postgres Database
        - Redis Cluster Database
        - Consul Cluster

    Notes:
        \*  These components are delivered by the Holmes project.

- DCAE R3 supports both OpenStack Heat Orchestration Template based deployment and OOM (Kubernetes) based deployment.

    - Under Heat based deployment all DCAE component containers are deployed onto a single Docker host VM that is launched from an OpenStack Heat Orchestration Template as part of "stack creation".
    - Under OOM (Kubernetes) deployment all DCAE component containers are deployed as Kubernetes Pods/Deployments/Services into Kubernetes cluster.

- DCAE R3 includes a new Cloudify Manager plugin (k8splugin) that is capable of expanding a Blueprint node specification written for Docker container to a full Kubernetes specification, with additional enhancements such as replica scaling, sidecar for logging to ONAP ELK stack, registering services to MSB, etc.

- All DCAE components are designed to support platform maturity requirements.


**Source Code**

Source code of DCAE components are released under the following repositories on gerrit.onap.org:
    - dcaegen2
    - dcaegen2.analytics
    - dcaegen2.analytics.tca
    - dcaegen2.collectors
    - dcaegen2.collectors.snmptrap
    - dcaegen2.collectors.ves
    - dcaegen2.collectors.hv-ves
    - dcaegen2.collectors.datafile
    - dcaegen2.deployments
    - dcaegen2.platform
    - dcaegen2.platform.blueprints
    - dcaegen2.platform.cli
    - dcaegen2.platform.configbinding
    - dcaegen2.platform.deployment-handler
    - dcaegen2.platform.inventory-api
    - dcaegen2.platform.plugins
    - dcaegen2.platform.policy-handler
    - dcaegen2.platform.servicechange-handler
    - dcaegen2.services.heartbeat
    - dcaegen2.services.mapper
    - dcaegen2.services.prh
    - dcaegen2.utils

**Bug Fixes**

**Known Issues**

- DCAE utilizes Cloudify Manager as its declarative model based resource deployment engine.  Cloudify Manager is an open source upstream technology provided by Cloudify Inc. as a Docker image.  DCAE R2 does not provide additional enhancements towards Cloudify Manager's platform maturity.

**Security Notes**

DCAE code has been formally scanned during build time using NexusIQ and all Critical vulnerabilities have been addressed, items that remain open have been assessed for risk and determined to be false positive. The DCAE open Critical security vulnerabilities and their risk assessment have been documented as part of the `project <https://wiki.onap.org/pages/viewpage.action?pageId=28377647>`_.

Quick Links:
        - `DCAE project page <https://wiki.onap.org/display/DW/Data+Collection+Analytics+and+Events+Project>`_

        - `Passing Badge information for DCAE <https://bestpractices.coreinfrastructure.org/en/projects/1718>`_

        - `Project Vulnerability Review Table for DCAE (Casablanca) <https://wiki.onap.org/pages/viewpage.action?pageId=41421168>`_


**New component Notes**
The following components are introduced in R3

    - DataFile Collector
       - Docker container tag: onap/org.onap.dcaegen2.collectors.datafile.datafile-app-server:1.0.4
       - Description : Bulk data file collector to fetch non-realtime PM data
    - PNF Registrator handler
       - Docker container tag: onap/org.onap.dcaegen2.services.prh.prh-app-server:1.1.1
       - Description : Recieves VES registration event and updates AAI and SO
    - HV-VES Collector
       - Docker container tag: onap/org.onap.dcaegen2.collectors.hv-ves.hv-collector-main:1.0.0
       - Description : High Volume VES Collector for fetching real-time PM measurement data
    - SNMP Trap Collector
       - Docker container tag: onap/org.onap.dcaegen2.collectors.snmptrap:1.4.0
       - Description : Receives SNMP traps and publishes them to a  message router (DMAAP/MR) in json structure


**Upgrade Notes**

The following components are upgraded from R2:
    - Cloudify Manager:
       - Docker container tag: onap/org.onap.dcaegen2.deployments.cm-container:1.4.2
       - Description: R3 DCAE's Cloudify Manager container is based on Cloudify Manager Community Version 18.7.23, which is based on Cloudify Manager 4.3.
    - Bootstrap container:
       - Docker container tag: onap/org.onap.dcaegen2.deployments.k8s-bootstrap-container:1.4.5
       - Description: R3 DCAE no longer uses bootstrap container for Heat based deployment, -- deployment is done through cloud-init scripts and docker-compose specifications.  The bootstrap is for OOM (Kubernetes) based deployment.
    - Configuration Binding Service:
       - Docker container tag: onap/org.onap.dcaegen2.platform.configbinding.app-app:2.2.3
       - Description: Configuration Binding Sevice now supports the new configuration policy format and support for TLS
    - Deployment Handler
       - Docker container image tag: onap/org.onap.dcaegen2.platform.deployment-handler:3.0.3
    - Policy Handler
       - Docker container image tag: onap/org.onap.dcaegen2.platform.policy-handler:4.4.0
       - Description: Policy Handler now supports the new configuration policy format and support for TLS
    - Service Change Handler
       - Docker container image tag: onap/org.onap.dcaegen2.platform.servicechange-handler:1.1.5
       - Description: Refactoring.
    - Inventory API
       - Docker container image tag: onap/org.onap.dcaegen2.platform.inventory-api:3.0.4
       - Description: Refactoring.
    - VES Collector
       - Docker container image tag: onap/org.onap.dcaegen2.collectors.ves.vescollector:1.3.1
       - Description : Refactoring
    - Threshold Crossing Analytics
       - Docker container image tag: onap/org.onap.dcaegen2.deployments.tca-cdap-container:1.1.0
       - Description: Replaced Hadoop VM Cluster based file system with regular host file system; repackaged full TCA-CDAP stack into Docker container; transactional state separation from TCA in-memory to off-node Redis cluster for supporting horizontal scaling.




Version: 2.0.0
==============

.. _Version_2.0.0:

:Release Date: 2018-06-07

**New Features**

DCAE R2 improves upon previous release with the following new features:

- All DCAE R2 components are delivered as Docker container images.  The list of components is as follows.
    - Platform components
        - Cloudify Manager
        - Bootstrap container
        - Configuration Binding Service
        - Deployment Handler
        - Policy Handler
        - Service Change Handler
        - Inventory API
    - Service components
        - VES Collector
        - SNMP Collector
        - Threshold Crossing Analytics
        - Holmes Rule Management *
        - Holmes Engine Management *
    - Additional resources that DCAE utilizes:
        - Postgres Database
        - Redis Cluster Database
        - Consul Cluster

    Notes:
        \*  These components are delivered by the Holmes project and used as a DCAE analytics component in R2.

- DCAE R2 supports both OpenStack Heat Orchestration Template based deployment and OOM (Kubernetes) based deployment.

    - Under Heat based deployment all DCAE component containers are deployed onto a single Docker host VM that is launched from an OpenStack Heat Orchestration Template as part of "stack creation".
    - Under OOM (Kubernetes) deployment all DCAE component containers are deployed as Kubernetes Pods/Deployments/Services into Kubernetes cluster.

- DCAE R2 includes a new Cloudify Manager plugin (k8splugin) that is capable of expanding a Blueprint node specification written for Docker container to a full Kubernetes specification, with additional enhancements such as replica scaling, sidecar for logging to ONAP ELK stack, registering services to MSB, etc.

- All DCAE components are designed to support platform maturity requirements.


**Source Code**

Source code of DCAE components are released under the following repositories on gerrit.onap.org:
    - dcaegen2
    - dcaegen2.analytics
    - dcaegen2.analytics.tca
    - dcaegen2.collectors
    - dcaegen2.collectors.snmptrap
    - dcaegen2.collectors.ves
    - dcaegen2.deployments
    - dcaegen2.platform
    - dcaegen2.platform.blueprints
    - dcaegen2.platform.cli
    - dcaegen2.platform.configbinding
    - dcaegen2.platform.deployment-handler
    - dcaegen2.platform.inventory-api
    - dcaegen2.platform.plugins
    - dcaegen2.platform.policy-handler
    - dcaegen2.platform.servicechange-handler
    - dcaegen2.services.heartbeat
    - dcaegen2.services.mapper
    - dcaegen2.services.prh
    - dcaegen2.utils

**Bug Fixes**

**Known Issues**

- DCAE utilizes Cloudify Manager as its declarative model based resource deployment engine.  Cloudify Manager is an open source upstream technology provided by Cloudify Inc. as a Docker image.  DCAE R2 does not provide additional enhancements towards Cloudify Manager's platform maturity.

**Security Notes**

DCAE code has been formally scanned during build time using NexusIQ and all Critical vulnerabilities have been addressed, items that remain open have been assessed for risk and determined to be false positive. The DCAE open Critical security vulnerabilities and their risk assessment have been documented as part of the `project <https://wiki.onap.org/pages/viewpage.action?pageId=28377647>`_.

Quick Links:
        - `DCAE project page <https://wiki.onap.org/display/DW/Data+Collection+Analytics+and+Events+Project>`_

        - `Passing Badge information for DCAE <https://bestpractices.coreinfrastructure.org/en/projects/1718>`_

        - `Project Vulnerability Review Table for DCAE (Beijing) <https://wiki.onap.org/pages/viewpage.action?pageId=28377647>`_



**Upgrade Notes**

The following components are upgraded from R1:
    - Cloudify Manager:
       - Docker container tag: onap/org.onap.dcaegen2.deployments.cm-container:1.3.0
       - Description: R2 DCAE's Cloudify Manager container is based on Cloudify Manager Community Version 18.2.28, which is based on Cloudify Manager 4.3.
    - Bootstrap container:
       - Docker container tag: onap/org.onap.dcaegen2.deployments.k8s-bootstrap-container:1.1.11
       - Description: R2 DCAE no longer uses bootstrap container for Heat based deployment, -- deployment is done through cloud-init scripts and docker-compose specifications.  The bootstrap is for OOM (Kubernetes) based deployment.
    - Configuration Binding Service:
       - Docker container tag: onap/org.onap.dcaegen2.platform.configbinding:2.1.5
       - Description: Configuration Binding Sevice now supports the new configuration policy format.
    - Deployment Handler
       - Docker container image tag: onap/org.onap.dcaegen2.platform.deployment-handler:2.1.5
    - Policy Handler
       - Docker container image tag: onap/org.onap.dcaegen2.platform.policy-handler:2.4.5
       - Description: Policy Handler now supports the new configuration policy format.
    - Service Change Handler
       - Docker container image tag: onap/org.onap.dcaegen2.platform.servicechange-handler:1.1.4
       - Description: Refactoring.
    - Inventory API
       - Docker container image tag: onap/org.onap.dcaegen2.platform.inventory-api:3.0.1
       - Description: Refactoring.
    - VES Collector
       - Docker container image tag: onap/org.onap.dcaegen2.collectors.ves.vescollector:1.2.0
    - Threshold Crossing Analytics
       - Docker container image tag: onap/org.onap.dcaegen2.deployments.tca-cdap-container:1.1.0
       - Description: Replaced Hadoop VM Cluster based file system with regular host file system; repackaged full TCA-CDAP stack into Docker container; transactional state separation from TCA in-memory to off-node Redis cluster for supporting horizontal scaling.



Version: 1.0.0
==============

.. _Version_1.0.0:

:Release Date: 2017-11-16


**New Features**

DCAE is the data collection and analytics sub-system of ONAP.  Under ONAP Release 1 the DCAE
sub-system includes both platform components and DCAE service components.  Collectively the ONAP R1
DCAE components support the data collection and analytics functions for the R1 use cases, i.e. vFW,
vDNS, vCPU, and vVoLTE.

Specifically, DCAE R1 includes the following components:

- Core platform
    - Cloudify manager
    - Consul cluster
- Extended platform
    - Platform component docker host
    - Service component docker host
    - CDAP cluster
    - PostgreSQL database (*)
- Platform docker container components
    - Configuration binding service
    - Deployment handler
    - Service change handler
    - Inventory
    - Policy handler
    - CDAP broker
- Service components
    - Docker container components
        - VNF Event Streaming (VES) collector
        - Holmes (engine and rule management) **
    - CDAP analytics component
        - Threshold Crossing Analytics (TCA)

(*) Note: This component is delivered under the CCSDK project, deployed by DCAE under a single
VM configuration as a shared PostgreSQL database for the R1 demos.  (CCSDK PostgreSQL supports
other deployment configurations not used in the R1 demos.)
(**) Note: This component is delivered under the Holmes project and used as a DCAE analytics component
in R1.

Source codes of DCAE are released under the following repositories on gerrit.onap.org:

- dcaegen2
- dcaegen2/analytics
- dcaegen2/analytics/tca
- dcaegen2/collectors
- dcaegen2/collectors/snmptrap
- dcaegen2/collectors/ves
- dcaegen2/deployments
- dcaegen2/platform
- dcaegen2/platform/blueprints
- dcaegen2/platform/cdapbroker
- dcaegen2/platform/cli
- dcaegen2/platform/configbinding
- dcaegen2/platform/deployment-handler
- dcaegen2/platform/inventory-api
- dcaegen2/platform/plugins
- dcaegen2/platform/policy-handler
- dcaegen2/platform/servicechange-handler
- dcaegen2/utils


**Bug Fixes**

This is the initial release.


**Known Issues**

- Need to test/integrate into an OpenStack environment other than Intel/Windriver Pod25.
- Need to provide a dev configuration DCAE.


**Security Issues**

- The DCAE Bootstrap container needs to have a secret key for accessing VMs that it launches.  This key is currently passed in as a Heat template parameter.  Tracked by JIRA `DCAEGEN2-178 <https://jira.onap.org/browse/DCAEGEN2-178>`_.>`_.
- The RESTful API calls are generally not secure.  That is, they are either over http, or https without certificate verification.  Once there is an ONAP wide solution for handling certificates, DCAE will switch to https.


**Upgrade Notes**

This is the initial release.


**Deprecation Notes**

There is a GEN1 DCAE sub-system implementation existing in the pre-R1 ONAP Gerrit system.  The GEN1
DCAE is deprecated by the R1 release.  The DCAE included in ONAP R1 is also known as DCAE GEN2.  The
following Gerrit repos are voided and already locked as read-only.

- dcae
- dcae/apod
- dcae/apod/analytics
- dcae/apod/buildtools
- dcae/apod/cdap
- dcae/collectors
- dcae/collectors/ves
- dcae/controller
- dcae/controller/analytics
- dcae/dcae-inventory
- dcae/demo
- dcae/demo/startup
- dcae/demo/startup/aaf
- dcae/demo/startup/controller
- dcae/demo/startup/message-router
- dcae/dmaapbc
- dcae/operation
- dcae/operation/utils
- dcae/orch-dispatcher
- dcae/pgaas
- dcae/utils
- dcae/utils/buildtools
- ncomp
- ncomp/cdap
- ncomp/core
- ncomp/docker
- ncomp/maven
- ncomp/openstack
- ncomp/sirius
- ncomp/sirius/manager
- ncomp/utils


**Other**

SNMP trap collector is seed code delivery only.
