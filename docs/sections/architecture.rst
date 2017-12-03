.. This work is licensed under a Creative Commons Attribution 4.0 International License.
.. http://creativecommons.org/licenses/by/4.0

Architecture
============


Capabilities
------------
Data Collection Analytics and Events (DCAE) is the data collection and analysis subsystem of ONAP.
Its functions include among other things the collection of FCAPs data from the network entitiess (VNFs, PNFs, etc).It provides also a framework for the  normalization of data format, the transportation of
data, analysis of data, and generations of ONAP events which can be received by other ONAP components such as Policy for
subsequent operations
like closed loops.
DCAE consists of DCAE Platform components and DCAE Services components.  The following list shows the details of what are included
in ONAP R1
When VM is indicated, it means that the components runs on its own VM on the platform.
DCAE platform is based both on virtual machines (VM) and containers.

- DCAE Platform
    - Core Platform
        - Cloudify Manager (VM)
        - Consul service (VM cluster)
    - Extended Platform
        - Docker Host for containerized platform components (VM).  It runs the following DCAE platform micro services (containers).
            - Configuration Binding Servive
            - CDAP Broker
            - Deployment Handler
            - Policy Handler
            - Service Change Handler
            - DCAE Inventory-API
        - CDAP Analytics Platform for CDAP analytics applications (VM cluster)
        - Docker Host for containerized service components (VM)
        - PostgreSQL Database (VM)

note: the ONAP DCAEGEN2 CDAP blueprint deploys a 7 node CAsk Data Application Platform (CDAP) cluster (version 4.1.X), for running data analysis applications.

- DCAE Services
    - Collectors
        - Virtual Event Streaming (VES) collector, containerized
        - SNMP Trap collector, containerized
    - Analytics
        - Holmes correlation analytics, containerized
        - Threshold Crosssing Analytics (TCA), CDAP analytics application


Usage Scenarios
---------------

For ONAP R1 DCAE participates in all use cases.

vDNS/vFW:  VES collector, TCA analytics
vCPE:  VES collector, TCA analytics
vVoLTE:  VES collector, Holmes analytics

Interactions
------------
DCAE is interfacing with the DMaaP(Data Movement as a Platform) message Bus
