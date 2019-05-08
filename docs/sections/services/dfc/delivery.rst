.. This work is licensed under a Creative Commons Attribution 4.0 International License.
.. http://creativecommons.org/licenses/by/4.0

Delivery
========

Docker Container
----------------

**datafile** is delivered as a docker container. The latest onap automatically built version can be downloaded from nexus:

    ``docker run -d -p 8100:8100 -p 8433:8433
    nexus3.onap.org:10001/onap/org.onap.dcaegen2.collectors.datafile.datafile-app-server:latest``

For an older version, it is possible to replace the tag 'latest' with any version that seems suitable. Available images
are visible following this `link`_.

.. _link https://nexus3.onap.org/#browse/search=keyword%3D*datafile*


Another option is to pull the container first, and then run it with the image ID:

    ``docker pull nexus3.onap.org:10001/onap/org.onap.dcaegen2.collectors.datafile.datafile-app-server:latest``

    ``docker images | grep 'datafile'``

    ``docker run -d -p 8100:8100 -p 8433:8433 <image ID>``

The grep command will display the images corresponding to DFC. There can be several due to remotely or locally built
image, and also to different tags, i.e. different versions.

ONAP Gerrit
-----------

It is possible to clone the Gerrit repository of DFC with at this `link`_. Choose your preferred settings (ssh, http or
https, with or without hook) and run the command in your terminal.

.. _link https://gerrit.onap.org/r/#/admin/projects/dcaegen2/collectors/datafile