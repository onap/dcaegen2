.. This work is licensed under a
   Creative Commons Attribution 4.0 International License.

========================
PM Subscription Handler
========================

.. contents::
    :depth: 3

Overview
========

Component description can be found under `PM Subscription Handler`_.

.. _PM Subscription Handler: ../../sections/services/pm-subscription-handler/index.html

Paths
=====

GET ``/healthcheck``
--------------------

Description
~~~~~~~~~~~
This is the health check endpoint. If this returns a 200, the server is alive.
If anything other than a 200, the server is either dead or no connection to PMSH.

Responses
~~~~~~~~~

+-----------+---------------------+
| HTTP Code | Description         |
+===========+=====================+
| **200**   | successful response |
+-----------+---------------------+

GET ``/subscriptions``
----------------------

Description
~~~~~~~~~~~
The subscriptions endpoint can be used to fetch all subscriptions which exist in the database.

Responses
~~~~~~~~~

+-----------+---------------------+
| HTTP Code | Description         |
+===========+=====================+
| **200**   | successful response |
+-----------+---------------------+
