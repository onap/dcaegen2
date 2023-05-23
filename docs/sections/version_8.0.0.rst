.. This work is licensed under a Creative Commons Attribution 4.0 International License.
.. http://creativecommons.org/licenses/by/4.0

..      ==========================
..      * * *    HONOLULU    * * *
..      ==========================


Version: 8.0.0
==============


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
