.. This work is licensed under a Creative Commons Attribution 4.0 International License.
.. http://creativecommons.org/licenses/by/4.0

Delivery
========

Docker Container
----------------

**datafile** is delivered as a docker container that can be downloaded from onap:

    ``docker run -d --name pmmapper -e CONFIG_BINDING_SERVICE_SERVICE_HOST=172.18.0.9 -e CONFIG_BINDING_SERVICE_SERVICE_PORT=10000 -e HOSTNAME=pmmapper  nexus3.onap.org:10001/onap/org.onap.dcaegen2.services.pm-mapper:1.0-SNAPSHOT``
