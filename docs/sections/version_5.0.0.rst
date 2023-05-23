.. This work is licensed under a Creative Commons Attribution 4.0 International License.
.. http://creativecommons.org/licenses/by/4.0

Version: 5.0.0
==============

El-Alto Early-drop focused on technical debts and SECCOM priority work-items.

Following is summary of updates done for DCAEGEN2

**Security**

Following platform components were enabled for HTTPS
    - ConfigBindingService (CBS)
      -   CBS is used by all DCAE MS to fetch DCAE MS configuration from Consul. To mitigate impact for DCAE MS, CBS deployment through OOM/Helm was modified to support CBS on both HTTP and HTTPS. `Design for CBS TLS migration <https://wiki.onap.org/display/DW/TLS+support+for+CBS+-+Migration+Plan>`_
    - Cloudify Manager
    - InventoryAPI

All components interfacing with platform components were modified to support TLS interface

**Miscellaneous**
    - DCAE Dashboard deployment migration from cloudify blueprint to OOM/Chart
    - Dynamic Topic support via Dmaap plugin integration for DataFileCollector MS
    - Dynamic Topic support via Dmaap plugin integration for PM-Mapper service
    - CBS client libraries updated to remove consul service lookup



**Bug Fixes**
    * k8splugin can generate deployment name > 63 chars (DCAEGEN2-1667)
    * CM container loading invalid Cloudify types file (DCAEGEN2-1685)


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

        - `Project Vulnerability Review Table for DCAE (El-Alto) <https://wiki.onap.org/pages/viewpage.action?pageId=68540441>`_


**Upgrade Notes**

The following components are upgraded from Dublin/R4.
    - Cloudify Manager:
       - Docker container tag: onap/org.onap.dcaegen2.deployments.cm-container:2.0.2
       - Description: DCAE's Cloudify Manager container is based on Cloudify Manager Community Version 19.01.24, which is based on Cloudify Manager 4.5. The container was updated to support TLS.
    - K8S Bootstrap container:
       - Docker container tag: onap/org.onap.dcaegen2.deployments.k8s-bootstrap-container:1.6.2
       - Description: K8s bootstrap container updated to interface with Cloudify using HTTPS; new k8s and Dmaap plugin version included; Dashboard deployment was removed.
    - Configuration Binding Service:
       - Docker container tag: onap/org.onap.dcaegen2.platform.configbinding.app-app:2.5.1
       - Description: HTTPS support, Image optimization and non-root user
    - Deployment Handler
       - Docker container image tag: onap/org.onap.dcaegen2.platform.deployment-handler:4.2.0
       - Description: Update to node10, uninstall workflow updates
    - Service Change Handler
       - Docker container image tag: onap/org.onap.dcaegen2.platform.servicechange-handler:1.3.2
       - Description: HTTPS inventoryAPI support, container optmization and non-root user
    - Inventory API
       - Docker container image tag: onap/org.onap.dcaegen2.platform.inventory-api:3.4.0
       - Description: HTTPS support, container optmization and non-root user
    - DataFile Collector
       - Docker container tag: onap/org.onap.dcaegen2.collectors.datafile.datafile-app-server:1.2.2
       - Description : Code optimization, bug fixes, dmaap plugin integration
    - 3gpp PM-Mapper
       - Docker container tag: onap/org.onap.dcaegen2.services.pm-mapper:1.1.3
       - Description: Code optimization, bug fixes, dmaap plugin integration
