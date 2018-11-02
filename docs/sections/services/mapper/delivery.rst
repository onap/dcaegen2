.. This work is licensed under a Creative Commons Attribution 4.0 International License.
.. http://creativecommons.org/licenses/by/4.0
.. Copyright 2018 Tech Mahindra Ltd.

Delivery
========
Mapper is delivered with **2 Docker container** having spring boot microservices, **UniversalVesAdapter** and **SnmMapper**. UniversalVesAdapter converts SNMP trap JSON to VES and snmpmapper is just helper application for uploading the mapping file to DB. 

| In current release, the installation of mapper service is not integrated with DCAE's installation process and needs to be done manually.

Docker Containers
---------------
Docker images can be pulled from ONAP Nexus repository with below commands: 

| docker pull nexus3.onap.org:10003/snapshots/onap/org.onap.dcaegen2.services.mapper.vesadapter.universalvesadaptor:latest

| docker pull nexus3.onap.org:10003/snapshots/onap/org.onap.dcaegen2.services.mapper.vesadapter.snmpmapper:latest
