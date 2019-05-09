.. This work is licensed under a Creative Commons Attribution 4.0 International License.
.. http://creativecommons.org/licenses/by/4.0

Installation
============

An environment suitable for running docker containers is recommended.

As a docker container
---------------------

**datafile** is delivered as a docker container based on openjdk:8-jre-alpine.  The
host or VM that will run this container must have the docker application
loaded and available to the userID that will be running the DFC container.

Also required is a working DMAAP/MR and DMAAP/DR environment.  datafile
subscribes to DMAAP/MR fileReady event as JSON messages and publishes the downloaded files to the DMAAP/DR.

Installation
^^^^^^^^^^^^

The following command will download the Dublin version of the datafile container from
nexus and launch it in the container named "datafile":

    ``docker run -d -p 8100:8100 -p 8433:8433
    nexus3.onap.org:10001/onap/org.onap.dcaegen2.collectors.datafile.datafile-app-server:1.1.2``

For another version, it is possible to replace the tag '1.1.2' with any version that seems suitable (including latest).
Available images are visible following this `link`_.

.. _link https://nexus3.onap.org/#browse/search=keyword%3D*datafile*
