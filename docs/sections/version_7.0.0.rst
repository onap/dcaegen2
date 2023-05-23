.. This work is licensed under a Creative Commons Attribution 4.0 International License.
.. http://creativecommons.org/licenses/by/4.0

..      ========================
..      * * *    GUILIN    * * *
..      ========================


Version: 7.0.0
==============


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
    - MOD/Runtime - Enable configuration for dynamic topic support (DCAEGEN2-1996)
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
