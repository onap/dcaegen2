.. This work is licensed under a Creative Commons Attribution 4.0 International License.
.. http://creativecommons.org/licenses/by/4.0

Delivery
========

**SNMPTRAP** is delivered as a docker container.  The host or VM that will run this container must have the docker application loaded and available to the userID that will be running the SNMPTRAP container.

The following command will download the latest SNMPTRAP container from nexus and launch it in the container named "SNMPTRAP":

    docker run --detach -t --rm -p 162:6162/udp -P --name=SNMPTRAP nexus3.onap.org:10001/onap/org.onap.dcaegen2.collectors.snmptrap ./bin/snmptrapd.sh start


