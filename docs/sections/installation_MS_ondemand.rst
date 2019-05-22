.. This work is licensed under a Creative Commons Attribution 4.0 International License.
.. http://creativecommons.org/licenses/by/4.0

DCAE MS Deployment
==================

DCAE MS catalog includes number of collectors, analytics and event processor services. For Dublin, not all MS available on default ONAP/DCAE deployment. 

Following Services are deployed via DCAE Bootstrap
.. toctree::
   :maxdepth: 1

   ./snmptrap/index.rst
   ./ves-http/index.rst
   ./ves-hv/index.rst
   ./prh/index.rst
   ./tca-cdap/index.rst
   
Following additional MS are available for on-demand deployment as necessary for any usecases; instruction for deployment are provided under each MS. 

.. toctree::
   :maxdepth: 1

   ./services/mapper/installation.rst
   ./services/dfc/installation.rst
   ./services/heartbeat-ms/installation.rst
   ./services/pm-mapper/installation.rst
   ./services/bbs-event-processor/installation.rst
   ./services/son-handler/installation.rst
   ./services/restconf/installation.rst