.. This work is licensed under a Creative Commons Attribution 4.0 International License.

Data Collection Analytics and Events
------------------------------------------------

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

   offeredapis.rst
