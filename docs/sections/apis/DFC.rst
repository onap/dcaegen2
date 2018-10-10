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

Reads fileReady events from DMaaP (Data Movement as a Platform)


Responses
~~~~~~~~~

+-----------+-------------------------------------------+
| HTTP Code | Description                               |
+===========+===========================================+
| **200**   | successful response                       |
+-----------+-------------------------------------------+



POST /publish
--------------------------------------

Description
~~~~~~~~~~~

Publish the collected file/s as a stream to DataRouter
    - file as stream
    - compression
    - fileFormatType
    - fileFormatVersion


Responses
~~~~~~~~~

+-----------+-------------------------------------------+
| HTTP Code | Description                               |
+===========+===========================================+
| **200**   | successful response                       |
+-----------+-------------------------------------------+

Compiling DFC
=============

Whole project (top level of DFC directory) and each module (sub module directory) can be compiled using
`mvn clean install` command.

Configuration file: Config/datafile_endpoints.json

Main API Endpoints
==================

Running with dev-mode of DFC
    - Heartbeat: **http://<container_address>:8100/heartbeat** or **https://<container_address>:8433/heartbeat**
    - Start DFC: **http://<container_address>:8100/start** or **https://<container_address>:8433/start**
    - Stop DFC: **http://<container_address>:8100/stopDatafile** or **https://<container_address>:8433/stopDatafile**
    
The external port allocated for 8100 (http) is 30245.

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
4. docker-compose: Contains the docker-compose

