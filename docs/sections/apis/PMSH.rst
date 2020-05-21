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

.. csv-table::
   :header: "API name", "Swagger JSON", "Swagger YAML"
   :widths: 10,5,5

   "Config Binding Service", ":download:`link <pmsh_swagger.json>`", ":download:`link <pmsh_swagger.yaml>`"

Paths
=====

GET ``/subscriptions``
----------------------

Description
~~~~~~~~~~~
Retrieves all defined Subscriptions and their related Network Functions from ONAP.

Responses
~~~~~~~~~

**200**
^^^^^^^

The Subscription details are returned successfully

**Example:**

.. code-block:: javascript

   [
     {
       "network_functions": [
         {
           "nf_name": "pnf102",
           "nf_sub_status": "PENDING_CREATE",
           "orchestration_status": "Active"
         },
         {
           "nf_name": "vnf101",
           "nf_sub_status": "CREATED",
           "orchestration_status": "Active"
         }
       ],
       "subscription_name": "demo-subscription",
       "subscription_status": "UNLOCKED"
     }
   ]


GET ``/healthcheck``
--------------------

Description
~~~~~~~~~~~
This is the health check endpoint. If this returns a 200, the server is alive.
If anything other than a 200, the server is either dead or no connection to PMSH.

Responses
~~~~~~~~~

**200**
^^^^^^^

The PMSH instance is running
