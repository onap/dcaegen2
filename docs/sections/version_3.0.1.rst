.. This work is licensed under a Creative Commons Attribution 4.0 International License.
.. http://creativecommons.org/licenses/by/4.0

Version: 3.0.1
==============

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
