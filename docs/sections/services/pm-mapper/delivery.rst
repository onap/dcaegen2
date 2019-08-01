.. This work is licensed under a Creative Commons Attribution 4.0 International License.
.. http://creativecommons.org/licenses/by/4.0

Delivery
========

Docker Container
----------------

**PM Mapper** is delivered as a docker image that can be downloaded from ONAP docker registry:

::

    ``docker run -d --name pmmapper -e CONFIG_BINDING_SERVICE_SERVICE_HOST=<IP Required> -e CONFIG_BINDING_SERVICE_SERVICE_PORT=<Port Required> -e HOSTNAME=<HOSTNAME>  nexus3.onap.org:10001/onap/org.onap.dcaegen2.services.pm-mapper``
