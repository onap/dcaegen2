.. This work is licensed under a Creative Commons Attribution 4.0 International License.
.. http://creativecommons.org/licenses/by/4.0

DCAE MS Deployment
==================

DCAE MS catalog includes number of collectors, analytics and event processor services. Not all MS available on default ONAP/DCAE deployment.

Following Services are deployed via DCAE Bootstrap


.. toctree::
   :maxdepth: 1

   ./services/ves-http/index.rst
   ./services/ves-hv/index.rst
   ./services/prh/index.rst
   ./services/tcagen2-docker/index.rst

Following additional MS are available for on-demand deployment as necessary for any usecases; instruction for deployment are provided under each MS.

.. toctree::
   :maxdepth: 1

   Mapper MS Installation <./services/mapper/installation-helm>
   DFC MS Installation <./services/dfc/installation-helm>
   Heartbeat MS Installation <./services/heartbeat-ms/installation>
   PM-Mapper MS Installation <./services/pm-mapper/installation-helm>
   Son-Handler MS Installation <./services/son-handler/installation-helm>
   RESTconf MS Installation <./services/restconf/installation-helm>
   SNMP Trap Collector MS Installation <./services/snmptrap/installation>
   PM Subscription Handler MS Installation <./services/pm-subscription-handler/installation>
   DataLake Handler Installation <./services/datalake-handler/installation-helm>
