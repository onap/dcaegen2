.. This work is licensed under a Creative Commons Attribution 4.0 International License.
.. http://creativecommons.org/licenses/by/4.0

..      =======================
..      * * *    LONDON   * * *
..      =======================


Version: 12.0.0
===============


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
