.. This work is licensed under a Creative Commons Attribution 4.0 International License.
.. http://creativecommons.org/licenses/by/4.0
.. Copyright 2018-2019 Tech Mahindra Ltd.

Delivery
========
Mapper is delivered with **1 Docker container** having spring boot microservice, **UniversalVesAdapter**. UniversalVesAdapter converts telementary data to VES.

| In current release, the UniversalVesAdapter is integrated with DCAE's config binding service. On start, it fetches the initial configuration from CBS and uses the same. Currently it is not having functionality to refresh the configuration changes made into Consul KV store.

Docker Containers
-----------------
Docker images can be pulled from ONAP Nexus repository with below commands:

  ``docker pull nexus3.onap.org:10001/onap/org.onap.dcaegen2.services.mapper.vesadapter.universalvesadaptor:latest``
