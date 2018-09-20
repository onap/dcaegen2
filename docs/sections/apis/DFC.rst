==============================
DFC (DataFile Collector)
==============================

:Date: 2018-09-21

.. contents::
    :depth: 3
..

Overview
========

DFC will orchestrate the collection of bulk PM data flow:
	1. Subscribes to fileReady DMaaP topic
	2. Collects the file from the xNF
	3. Sends new event to DataRouter with file.

Introduction
============

DFC is delivered as one **Docker container** which hosts application server and can be started by `docker-compose`.

Functionality
=============
.. image:: ../images/DFC.png


Paths
=====

GET /events/unauthenticated.VES_NOTIFICATION_OUTPUT
-----------------------------------------------

Description
~~~~~~~~~~~

Reads fileReady events fromD DMaaP (Data Movement as a Platform)


.. Responses
.. ~~~~~~~~~

.. +-----------+-------------------------------------------+
.. | HTTP Code | Description                               |
.. +===========+===========================================+
.. | **200**   | successful response                       |
.. +-----------+-------------------------------------------+


.. PATCH /aai/v12/network/pnfs/{pnf-name}
.. --------------------------------------

.. Description
.. ~~~~~~~~~~~

.. Update AAI (Active and Available Inventory) PNF's specific entries:
    - ipv4 to ipaddress-v4-oam
    - ipv6 to ipaddress-v6-oam

.. Parameters
.. ~~~~~~~~~~

.. +----------+---------------+---------------------------------+------------------+
.. | Type     | Name          | Description                     | Schema           |
.. +==========+===============+=================================+==================+
.. | **Path** | | **pnf-name**| Name of the PNF.                | string (text)    |
.. |          | | *required*  |                                 |                  |
.. +----------+---------------+---------------------------------+------------------+
.. | **Body** | **patchbody** | Required patch body.            |                  |
.. +----------+---------------+---------------------------------+------------------+


.. Responses
.. ~~~~~~~~~

.. +-----------+-------------------------------------------+
.. | HTTP Code | Description                               |
.. +===========+===========================================+
.. | **200**   | successful response                       |
.. +-----------+-------------------------------------------+


.. POST /events/unauthenticated.PNF_READY
.. --------------------------------------

.. Description
.. ~~~~~~~~~~~

.. Publish PNF_READY to DMaaP and set:
    - pnf-id to correlationID
    - ipv4 to ipaddress-v4-oam
    - ipv6 to ipaddress-v6-oam

.. Parameters
.. ~~~~~~~~~~

.. +----------+----------------+---------------------------------+------------------+
.. | Type     | Name           | Description                     | Schema           |
.. +==========+================+=================================+==================+
.. | **Body** | | **postbody** | Required patch body.            | `hydratorappput  |
.. |          | | *required*   |                                 | <#_hydratorapppu |
.. |          |                |                                 | t>`__            |
.. +----------+----------------+---------------------------------+------------------+


.. Responses
.. ~~~~~~~~~

.. +-----------+-------------------------------------------+
.. | HTTP Code | Description                               |
.. +===========+===========================================+
.. | **200**   | successful response                       |
.. +-----------+-------------------------------------------+

Compiling DFC
=============

Whole project (top level of DFC directory) and each module (sub module directory) can be compiled using
`mvn clean install` command.

.. Main API Endpoints
.. ==================

.. Running with dev-mode of PRH
..    - Heartbeat: **http://<container_address>:8100/heartbeat** or **https://<container_address>:8443/heartbeat**
..    - Start PRH: **http://<container_address>:8100/start** or **https://<container_address>:8433/start**
..    - Stop PRH: **http://<container_address>:8100/stopPrh** or **https://<container_address>:8433/stopPrh**

Maven GroupId:
==============

org.onap.dcaegen2.collectors

Maven Parent ArtifactId:
========================

dcae-collectors

Maven Children Artifacts:
=========================

1. datafile-app-server: DFC server
2. datafile-dmaap-client: Contains implementation of DmaaP client
3. datafile-commons: Common code for whole DFC modules


