.. This work is licensed under a Creative Commons Attribution 4.0 International License.
.. http://creativecommons.org/licenses/by/4.0


Data Collection, Analytics, and Events (DCAE)
=======================

.. Add or remove sections below as appropriate for the platform component.
Data Collection Analytics and Events (DCAE) is the data collection and analysis subsystem of ONAP.
Its functions include collection of FCAPs data from the network entotiess (VNFs, PNFs, etc), normalization and transportation of
data, analysis of data, and generations of ONAP events which can be received by other ONAP components such as Policy for
subsequent operations.

DCAE consists of DCAE Platform components and DCAE Services components.

- DCAE Platform
    - Core Platform
        - Cloudify Manager
        - Consul
    - Extended Platform
        - Docker Host for containerized platform components
        - CDAP Analytics Platform for CDAP analytics applications
        - Docker Host for containerized service components


- DCAE Services
    - Collectors
        - Virtual Event Streaming (VES) collector, dockerized
        - SNMP Trap collector, dockerized
    - Analytics
        - Holmes correlation analytics, dockerized
        - Threshold Crosssing Analytics (TCA), CDAP analytics application

.. toctree::
   :maxdepth: 1

   ./sections/architecture.rst
   ./sections/offeredapis.rst
   ./sections/consumedapis.rst
   ./sections/delivery.rst
   ./sections/logging.rst
   ./sections/installation.rst
   ./sections/configuration.rst
   ./sections/administration.rst
   ./sections/humaninterfaces.rst
   ./sections/release-notes.rst

   offeredapis.rst

