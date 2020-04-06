.. This work is licensed under a Creative Commons Attribution 4.0 International License.
.. http://creativecommons.org/licenses/by/4.0

Delivery
========

Docker Container
----------------

**TCA-GEN2** is delivered as a docker image that can be downloaded from ONAP docker registry:

::

    ``docker run -d --name tca-gen2 -e CONFIG_BINDING_SERVICE_SERVICE_HOST=<IP Required> -e CONFIG_BINDING_SERVICE_SERVICE_PORT=<Port Required> -e HOSTNAME=<HOSTNAME>  nexus3.onap.org:10001/onap/org.onap.dcaegen2.analytics.tca-gen2.dcae-analytics-tca-web:<tag>``
