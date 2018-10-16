.. This work is licensed under a Creative Commons Attribution 4.0 International License.
.. http://creativecommons.org/licenses/by/4.0

Delivery
========

Docker Container
----------------

**SNMPTRAP** is delivered as a docker container that can be downloaded from onap:

.. code-block:: bash

    docker run --detach -t --rm -p 162:6162/udp -P --name=SNMPTRAP nexus3.onap.org:10001/onap/org.onap.dcaegen2.collectors.snmptrap ./bin/snmptrapd.sh start


Standalone
----------

**SNMPTRAPD** can also be run outside of a docker environment (for details, see "Installation" link) by downloading the source image from:

.. code-block:: bash

    gerrit.onap.org:29418/dcaegen2/collectors/snmptrap

