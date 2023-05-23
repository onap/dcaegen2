.. This work is licensed under a Creative Commons Attribution 4.0 International License.
.. http://creativecommons.org/licenses/by/4.0

..      ===========================
..      * * *    FRANKFURT    * * *
..      ===========================


Version: 6.0.0
==============


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
