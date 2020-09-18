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

   "PM Subscription Handler Service", ":download:`link <pmsh_swagger.json>`", ":download:`link <pmsh_swagger.yaml>`"

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
          "subscription_name":"subscriptiona",
          "subscription_status":"UNLOCKED",
          "network_functions":[
             {
                "nf_name":"PNF104",
                "nf_sub_status":"PENDING_CREATE",
                "model_invariant_id":"8a57e2e6-d7ad-445f-b37e-a9837921014f",
                "model_version_id":"d0938fd8-6fe4-42a2-9d26-82b7fa9336ad",
                "sdnc_model_name":"pm_control",
                "sdnc_model_version":"1.2.4"
             },
             {
                "nf_name":"PNF105",
                "nf_sub_status":"CREATED",
                "model_invariant_id":"9a57e2e6-d7ad-445f-b37e-d6754892",
                "model_version_id":"a0938fd8-6fe4-42a2-9d26-82b7fa93378c",
                "sdnc_model_name":"pm_control",
                "sdnc_model_version":"1.2.5"
             }
          ]
       }
   ]

The subscription_status refers to the administrative status of the subscription.

.. csv-table:: Potential Values
   :header: "Status", "Description"
   :widths: 2,4

   LOCKED, The Subscription is un-deploying / inactive.
   UNLOCKED, The Subscription is deployed / active.


The network_functions.nf_sub_status refers to the status of the subscription (PM Job) on the xNF.

.. csv-table:: Potential Values
   :header: "Status", "Description"
   :widths: 5,16

    PENDING_CREATE, Create event published to Policy topic. Awaiting response.
    CREATE_FAILED, Subscription failed to be created on the xNF.
    CREATED, Subscription created successfully on the xNF.
    PENDING_DELETE, Delete event published to Poilcy topic. Awaiting response.
    DELETE_FAILED, Subscription deletion failed to be applied on the xNF.


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
