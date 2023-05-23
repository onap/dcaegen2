.. This work is licensed under a Creative Commons Attribution 4.0 International License.
.. http://creativecommons.org/licenses/by/4.0

Version: 4.0.0
==============

:Release Date: 2019-06-06

**New Features**

DCAE R4 improves upon previous release with the following new features:

- DCAE Platform Enhancement
    - Multisite K8S cluster deployment support for DCAE services (via K8S plugin)
    - Support helm chart deployment in DCAE using new Helm cloudify plugin
    - DCAE Healthcheck enhancement to cover static and dynamic deployments
    - Dynamic AAF based topic provisioning support through Dmaap cloudify plugin
    - Dashboard Integration (UI for deployment/verification)
    - PolicyHandler Enhancement to support new Policy Lifecycle API's
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
