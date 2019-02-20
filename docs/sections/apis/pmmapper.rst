.. This work is licensed under a Creative Commons Attribution 4.0 International License.
.. http://creativecommons.org/licenses/by/4.0
========================
3GPP PM Mapper
========================

.. contents::
    :depth: 3
..

Overview
========

Component description can be found under `3GPP PM Mapper`_.

.. _3GPP PM Mapper: ../../sections/services/pm-mapper/index.html


Paths
=====

PUT ``/delivery``
---------------------------------------------------

Description
~~~~~~~~~~~
Publish the PM Measurment file to PM Mapper.


Responses
~~~~~~~~~

+-----------+---------------------+
| HTTP Code | Description         |
+===========+=====================+
| **200**   | successful response |
+-----------+---------------------+


GET ``/healthcheck``
--------------------



Description
~~~~~~~~~~~
This is the  health check endpoint. If this returns a 200, the server is alive. If not a 200, either dead, or no connection to pm mapper.

Responses
~~~~~~~~~

+-----------+---------------------+
| HTTP Code | Description         |
+===========+=====================+
| **200**   | successful response |
+-----------+---------------------+
