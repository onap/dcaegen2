.. This work is licensed under a Creative Commons Attribution 4.0 International License.
.. http://creativecommons.org/licenses/by/4.0

Version: 2.0.0
==============

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
