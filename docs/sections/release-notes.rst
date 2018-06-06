.. This work is licensed under a Creative Commons Attribution 4.0 International License.

Release Notes
=============

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

- The DCAE Bootstrap container needs to have a secret key for accessing VMs that it launches.  This key is currently passed in as a Heat template parameter.  Tracked by JIRA DCAEGEN2-178.
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
