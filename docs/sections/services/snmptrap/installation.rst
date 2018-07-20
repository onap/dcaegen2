.. This work is licensed under a Creative Commons Attribution 4.0 International License.
.. http://creativecommons.org/licenses/by/4.0

Installation
============

**SNMPTRAP** is delivered as a docker container.  The host or VM that will run this container must have the docker application loaded and available to the userID that will be running the SNMPTRAP container.

The instructions below will download and run the latest SNMPTRAP container from the NEXUS repository.

Environment
-----------

An environment suitable for running docker containers is recommended.  If that is not available, SNMPTRAP source can be downloaded and run in a VM or on baremetal.  

If running from a docker container, it is assumed that the config binding service has been installed and is successfully instantiating container configurations as needed.

Also required is a working DMAAP/MR message router environment.  SNMPTRAP publishes traps to DMAAP/MR as JSON messages, and expect the host resources and publishing credentials to be included in the CONFIG BINDING SERVICE config.

Steps
-----

The following command will download the latest snmptrap container from nexus and launch it in the container named "snmptrap":

    docker run --detach -t --rm -p 162:6162/udp -P --name=snmptrap nexus3.onap.org:10001/onap/org.onap.dcaegen2.collectors.snmptrap ./bin/snmptrapd.sh start

