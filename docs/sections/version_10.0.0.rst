.. This work is licensed under a Creative Commons Attribution 4.0 International License.
.. http://creativecommons.org/licenses/by/4.0

..      ==========================
..      * * *    JAKARTA    * * *
..      ==========================


Version: 10.0.0
===============


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
