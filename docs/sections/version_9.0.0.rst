.. This work is licensed under a Creative Commons Attribution 4.0 International License.
.. http://creativecommons.org/licenses/by/4.0

..      ==========================
..      * * *    ISTANBUL    * * *
..      ==========================


Version: 9.0.0
==============


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
