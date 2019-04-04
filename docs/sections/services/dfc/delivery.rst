.. This work is licensed under a Creative Commons Attribution 4.0 International License.
.. http://creativecommons.org/licenses/by/4.0

Delivery
========

Docker Container
----------------

**datafile** is delivered as a docker container. The latest onap automatically built version can be downloaded from nexus:

    ``docker run -d -p 8100:8100 -p 8433:8433
    nexus3.onap.org:10001/onap/org.onap.dcaegen2.collectors.datafile.datafile-app-server:latest``


An other option is to pull the container first, and then run it with the image ID:

    ``docker pull nexus3.onap.org:10001/onap/org.onap.dcaegen2.collectors.datafile.datafile-app-server:latest``
    ``docker images | grep 'datafile'``
    ``docker run -d -p 8100:8100 -p 8433:8433 <image ID>``