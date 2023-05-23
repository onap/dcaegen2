.. This work is licensed under a Creative Commons Attribution 4.0 International License.
.. http://creativecommons.org/licenses/by/4.0

..      ======================================
..      * * *    EL-ALTO  MAINTENANCE  * * *
..      ======================================


Version: 5.0.2
==============

Abstract
--------

This document provides the release notes for the El-Alto Maintenance release


Summary
-------

This maintenance release is primarily to update expired certificates
from original El-Alto released TLS-init container.

This patch is not required for Frankfurt release (and beyond) as certificates are dynamically
retrieved from AAF at deployment time for all DCAE components.

Release Data
------------

+--------------------------------------+--------------------------------------+
| **Project**                          | DCAE                                 |
|                                      |                                      |
+--------------------------------------+--------------------------------------+
| **Docker images**                    | onap/org.onap.dcaegen2.deployments   |
|                                      |   .tls-init-container:1.0.4          |
+--------------------------------------+--------------------------------------+
| **Release designation**              | El-Alto  Maintenance Release         |
|                                      |                                      |
+--------------------------------------+--------------------------------------+
| **Release date**                     | 2020/08/24                           |
|                                      |                                      |
+--------------------------------------+--------------------------------------+

New features
------------

None

**Bug fixes**

- `DCAEGEN2-2206 <https://jira.onap.org/browse/DCAEGEN2-2206>`_ DCAE TLS Container : Address certificate expiration

**Known Issues**
Same as El-Alto Release
