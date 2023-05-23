.. This work is licensed under a Creative Commons Attribution 4.0 International License.
.. http://creativecommons.org/licenses/by/4.0

..      =====================================
..      * * *    ISTANBUL  MAINTENANCE  * * *
..      =====================================


Version: 9.0.1
==============

Abstract
--------

This document provides the release notes for the Istanbul Maintenance release


Summary
-------

This maintenance release is primarily to resolve bugs identified during Istanbul release testing.


Release Data
------------

+--------------------------------------+--------------------------------------+
| **Project**                          | DCAE                                 |
|                                      |                                      |
+--------------------------------------+--------------------------------------+
| **Docker images**                    | See Istanbul Maintenance Release     |
|                                      |         Deliverable (below)          |
+--------------------------------------+--------------------------------------+
| **Release designation**              | Istanbul Maintenance Release         |
|                                      |                                      |
+--------------------------------------+--------------------------------------+
| **Release date**                     | 2022/01/31                           |
|                                      |                                      |
+--------------------------------------+--------------------------------------+

New features
------------

None

**Bug fixes**

- `DCAEGEN2-3022 <https://jira.onap.org/browse/DCAEGEN2-3022>`_ Log4j vulnerability fix
- `DCAEGEN2-2998 <https://jira.onap.org/browse/DCAEGEN2-2998>`_ Update SON-Handler missing configuration in helm


**Known Issues**

None


Security Notes
--------------

*Known Vulnerabilities in Used Modules*

    dcaegne2/services/mapper includes transitive dependency on log4j 1.2.17; this will be addressed in later release (DCAEGEN2-3105)


Istanbul Maintenance Rls Deliverables
-------------------------------------

Software Deliverables

.. csv-table::
   :header: "Repository", "SubModules", "Version & Docker Image (if applicable)"
   :widths: auto

   "dcaegen2/collectors/restconf", "", "onap/org.onap.dcaegen2.collectors.restconfcollector:1.2.7"
   "dcaegen2/collectors/ves", "", "onap/org.onap.dcaegen2.collectors.ves.vescollector:1.10.3"
   "dcaegen2/services/mapper", "", "onap/org.onap.dcaegen2.services.mapper.vesadapter.universalvesadaptor:1.3.2"
