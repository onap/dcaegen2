.. This work is licensed under a Creative Commons Attribution 4.0 International License.
.. http://creativecommons.org/licenses/by/4.0

..      =====================================
..      * * *    HONOLULU  MAINTENANCE  * * *
..      =====================================


Version: 8.0.1
==============

Abstract
--------

This document provides the release notes for the Honolulu Maintenance release


Summary
-------

This maintenance release is primarily to resolve bugs identified during Honolulu release testing.


Release Data
------------

+--------------------------------------+--------------------------------------+
| **Project**                          | DCAE                                 |
|                                      |                                      |
+--------------------------------------+--------------------------------------+
| **Docker images**                    | onap/org.onap.ccsdk.dashboard.       |
|                                      |   .ccsdk-app-os:1.4.4                |
+--------------------------------------+--------------------------------------+
| **Release designation**              | Honolulu Maintenance Release         |
|                                      |                                      |
+--------------------------------------+--------------------------------------+
| **Release date**                     | 2021/06/01                           |
|                                      |                                      |
+--------------------------------------+--------------------------------------+

New features
------------

None

**Bug fixes**

- `DCAEGEN2-2751 <https://jira.onap.org/browse/DCAEGEN2-2751>`_ Dashboard login issue due to oom/common PG upgrade to centos8-13.2-4.6.1
- `CCSDK-3233 <https://jira.onap.org/browse/CCSDK-3233>`_ Switch to integration base image & vulnerability updates fixes
- `DCAEGEN2-2800 <https://jira.onap.org/browse/DCAEGEN2-2800>`_ DCAE Healthcheck failure due to Dashboard
- `DCAEGEN2-2869 <https://jira.onap.org/browse/DCAEGEN2-2869>`_ Fix PRH aai lookup url config

**Known Issues**

None
