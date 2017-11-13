.. This work is licensed under a Creative Commons Attribution 4.0 International License.
.. http://creativecommons.org/licenses/by/4.0

Architecture
============


Capabilities
------------
Data Collection Analytics and Events (DCAE) is the data collection and analysis subsystem of ONAP.
Its functions include collection of FCAPs data from the network entitiess (VNFs, PNFs, etc), normalization and transportation of
data, analysis of data, and generations of ONAP events which can be received by other ONAP components such as Policy for
subsequent operations.

DCAE consists of DCAE Platform components and DCAE Services components.  The following list shows the details of what are included
in ONAP R1

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

