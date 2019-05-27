.. This work is licensed under a Creative Commons Attribution 4.0 International License.

Release Notes
=============

Version: 4.0.0
--------------

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

**Security Notes**

*Fixed Security Issues*

*Known Security Issues*

    * In default deployment DCAEGEN2 (xdcae-datafile-collector) exposes HTTP port 30223 outside of cluster. [`OJSI-109 <https://jira.onap.org/browse/OJSI-109>`_]

*Known Vulnerabilities in Used Modules*

DCAE code has been formally scanned during build time using NexusIQ and all Critical vulnerabilities have been addressed, items that remain open have been assessed for risk and determined to be false positive. The DCAE open Critical security vulnerabilities and their risk assessment have been documented as part of the `project <https://wiki.onap.org/pages/viewpage.action?pageId=51282478>`_.

Quick Links:
        - `DCAE project page <https://wiki.onap.org/display/DW/Data+Collection+Analytics+and+Events+Project>`_

        - `Passing Badge information for DCAE <https://bestpractices.coreinfrastructure.org/en/projects/1718>`_

        - `Project Vulnerability Review Table for DCAE <https://wiki.onap.org/pages/viewpage.action?pageId=51282478>`_


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
       - Docker container tag: onap/org.onap.dcaegen2.services.son-handler:1.0.2
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
       - Docker container image tag: onap/org.onap.dcaegen2.collectors.ves.vescollector:1.4.4
       - Description : Authentication enhancement, refactoring and bug-fixes
    - Threshold Crossing Analytics
       - Docker container image tag: onap/org.onap.dcaegen2.deployments.tca-cdap-container:1.1.2
       - Description: Config updates. Replaced Hadoop VM Cluster based file system with regular host file system; repackaged full TCA-CDAP stack into Docker container; transactional state separation from TCA in-memory to off-node Redis cluster for supporting horizontal scaling.
    - DataFile Collector
       - Docker container tag: onap/org.onap.dcaegen2.collectors.datafile.datafile-app-server:1.1.3
       - Description : Code optimization, bug fixes, logging and performance improvement
    - PNF Registrator handler
       - Docker container tag: onap/org.onap.dcaegen2.services.prh.prh-app-server:1.2.3
       - Description : Code optimization, SDK integration, PNF-UPDATE flow support
    - HV-VES Collector
       - Docker container tag: onap/org.onap.dcaegen2.collectors.hv-ves.hv-collector-main:1.1.0
       - Description : Code optimization, bug fixes, and enables SASL for kafka interface
    - SNMP Trap Collector
       - Docker container tag: onap/org.onap.dcaegen2.collectors.snmptrap:1.4.0
       - Description : Code coverage improvements




Version: 3.0.1
--------------

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

        - `Project Vulnerability Review Table for DCAE <https://wiki.onap.org/pages/viewpage.action?pageId=41421168>`_


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
--------------

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

        - `Project Vulnerability Review Table for DCAE <https://wiki.onap.org/pages/viewpage.action?pageId=28377647>`_



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
--------------

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
