.. This work is licensed under a Creative Commons Attribution 4.0 International License.
.. http://creativecommons.org/licenses/by/4.0

DCAE MS Deployment
==================

DCAE MS catalog includes number of collectors, analytics and event processor services. For Dublin, not all MS available on default ONAP/DCAE deployment. 

Following Services are deployed via DCAE Bootstrap


.. toctree::
   :maxdepth: 1

   ./services/snmptrap/index.rst
   ./services/ves-http/index.rst
   ./services/ves-hv/index.rst
   ./services/prh/index.rst
   ./services/tca-cdap/index.rst
   
Following additional MS are available for on-demand deployment as necessary for any usecases; instruction for deployment are provided under each MS. 

.. toctree::
   :maxdepth: 1

    * `Mapper MS Installation <./services/mapper/installation>`_.
    * `DFC MS Installation <./services/dfc/installation>`_.
    * `Heartbeat MS Installation <./services/heartbeat/installation>`_.
    * `PM-Mapper MS Installation <./services/pm-mapper/installation>`_.
    * `BBS EventProcessor MS Installation <./services/bbs-event-processor/installation>`_.
    * `Son-Handler MS Installation <./services/son-handler/installation>`_.
    * `RESTconf MS Installation <./services/restconf/installation>`_.
