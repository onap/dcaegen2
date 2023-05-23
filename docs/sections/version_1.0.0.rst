.. This work is licensed under a Creative Commons Attribution 4.0 International License.
.. http://creativecommons.org/licenses/by/4.0

Version: 1.0.0
==============

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
