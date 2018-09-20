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
../images/DFC.png


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


