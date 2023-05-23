.. This work is licensed under a Creative Commons Attribution 4.0 International License.
.. http://creativecommons.org/licenses/by/4.0
.. _snmptrap-installation:

Installation
============

An environment suitable for running docker containers is recommended.
If that is not available, SNMPTRAP source can be downloaded and run
in a VM or on baremetal.  

Both scenarios are documented below.

As a docker container
---------------------

**trapd** is delivered as a docker container based on python 3.6.  The 
host or VM that will run this container must have the docker application 
loaded and available to the userID that will be running the SNMPTRAP container.

If running from a docker container, it is assumed that *Config
Binding Service* has been installed and is successfully providing valid
configuration assets to instantiated containers as needed.

Also required is a working DMAAP/MR environment.  trapd
publishes traps to DMAAP/MR as JSON messages and expects the host
resources and publishing credentials to be included in the *Config Binding Service*
config.

Installation
^^^^^^^^^^^^

The following command will download the latest trapd container from
nexus and launch it in the container named "trapd":

    ``docker run --detach -t --rm -p 162:6162/udp -P --name=trapd nexus3.onap.org:10001/onap/org.onap.dcaegen2.collectors.snmptrap:2.0.6 ./bin/snmptrapd.sh start``

Running an instance of **trapd** will result in arriving traps being published
to the topic specified by Config Binding Services.  

Standalone
----------

**trapd** can also be run outside of a container environment, without CBS interactions. 
If CBS is not present, SNMPTRAP will look for a JSON configuration file specified via the
environment variable CBS_SIM_JSON at startup.  Location of this file should be specified
as a relative path from the <SNMPTRAP base directory>/bin directory. E.g.

Installation
^^^^^^^^^^^^

Prerequisites
"""""""""""""

trapd requires the following to run in a non-docker environment:

    - Python 3.6+
    - Python module "pysnmp" 4.4.5
    - Python module "requests" 2.18.3

To install prerequisites:

    ``export PATH=<path to Python 3.6 binary>:$PATH``

    ``pip3 install --no-cache-dir requests==2.18.3``

    ``pip3 install --no-cache-dir pysnmp==4.4.5``

Download latest trapd version from Gerrit
"""""""""""""""""""""""""""""""""""""""""

Download a copy of the latest trapd image from gerrit in it's standard runtime location:

    ``cd /opt/app``

    ``git clone --depth 1 ssh://<your linux foundation id>@gerrit.onap.org:29418/dcaegen2/collectors/snmptrap snmptrap``

"Un-dockerize"
""""""""""""""

    ``mv /opt/app/snmptrap/snmptrap /opt/app/snmptrap/bin``

Configure for your environment
""""""""""""""""""""""""""""""

In a non-docker environment, ONAP trapd is controlled by a locally hosted JSON configuration file.  It is 
referenced in the trapd startup script as:

.. code-block:: bash

    CBS_SIM_JSON=../etc/snmptrapd.json


This file should be in the exact same format is the response from CBS in a fully implemented container/controller environment.  A sample file is included with source/container images, at:

.. code-block:: bash

    /opt/app/snmptrap/etc/snmptrapd.json

Make applicable changes to this file - typically things that will need to change include: 

.. code-block:: bash

    "topic_url": "http://localhost:3904/events/ONAP-COLLECTOR-SNMPTRAP"

Action:  Change 'localhost' and topic name (ONAP-COLLECTOR-SNMPTRAP) to desired values in your environment.

.. code-block:: bash

    "snmpv3_config" (needed only when SNMPv3 agents are present)

Action:  Add/delete/modify entries as needed to align with SNMP agent configurations in a SNMPv3 environment.

Start the application
"""""""""""""""""""""

    ``nohup /opt/app/snmptrap/bin/snmptrapd.sh start > /opt/app/snmptrap/logs/snmptrapd.out 2>&1 &``
