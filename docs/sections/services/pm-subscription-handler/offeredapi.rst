.. This work is licensed under a Creative Commons Attribution 4.0 International License.
.. http://creativecommons.org/licenses/by/4.0
.. Copyright 2022 Nordix Foundation


API
===

GET /healthcheck
---------------------------------------------------

Description
~~~~~~~~~~~

This is the health check endpoint. If this returns a 200, the server is alive.


Responses
~~~~~~~~~

+-----------+--------------------------+
| HTTP Code | Description              |
+===========+==========================+
| **200**   | Successful response      |
+-----------+--------------------------+
| **503**   | Service unavailable      |
+-----------+--------------------------+


POST /subscription
--------------------------------------------------

Description
~~~~~~~~~~~

Create a PM Subscription

Responses
~~~~~~~~~

+-----------+--------------------------------------+
| HTTP Code | Description                          |
+===========+======================================+
| **201**   | Successfully created PM Subscription |
+-----------+--------------------------------------+
| **400**   | Invalid Input                        |
+-----------+--------------------------------------+
| **409**   | Duplicate Data                       |
+-----------+--------------------------------------+

Sample Subscription Body
~~~~~~~~~~~~~~~~~~~~~~~~

.. code-block:: json

    {
        "subscription": {
            "subscriptionName": "new_sub",
            "policyName": "pmsh_policy",
            "nfFilter": {
                "nfNames": [
                    "^pnf.*",
                    "^vnf.*"
                ],
                "modelInvariantIDs": [

                ],
                "modelVersionIDs": [

                ],
                "modelNames": []
            },
            "measurementGroups": [{
                "measurementGroup": {
                    "measurementGroupName": "msr_grp_name",
                    "fileBasedGP": 15,
                    "fileLocation": "\/pm\/pm.xml",
                    "administrativeState": "UNLOCKED",
                    "measurementTypes": [{
                        "measurementType": "counter_a"
                    }],
                    "managedObjectDNsBasic": [{
                        "DN": "string"
                    }]
                }
            }]
        }
    }


GET /subscription
--------------------------------------------------

Description
~~~~~~~~~~~

Get all the subscriptions from PMSH


Responses
~~~~~~~~~

+-----------+----------------------------------------+
| HTTP Code | Description                            |
+===========+========================================+
| **200**   | Successfully fetched all subscriptions |
+-----------+----------------------------------------+
| **500**   | Exception occured when querying DB     |
+-----------+----------------------------------------+


GET /subscription/{subscription_name}
---------------------------------------------------

Description
~~~~~~~~~~~

Get the Subscription from PMSH specified by Name

Responses
~~~~~~~~~

+-----------+--------------------------------------------+
| HTTP Code | Description                                |
+===========+============================================+
| **200**   | OK; Requested Subscription was returned    |
+-----------+--------------------------------------------+
| **404**   | Subscription with specified name not found |
+-----------+--------------------------------------------+
| **500**   | Exception occurred while querying database |
+-----------+--------------------------------------------+


DELETE /subscription/{subscription_name}
---------------------------------------------------

Description
~~~~~~~~~~~

Deletes the Subscription from PMSH specified by Name

Responses
~~~~~~~~~

+-----------+---------------------------------------------------------------------+
| HTTP Code | Description                                                         |
+===========+=====================================================================+
| **204**   | Successfully deleted the subscription and returns NO Content        |
+-----------+---------------------------------------------------------------------+
| **404**   | Subscription with specified name not found                          |
+-----------+---------------------------------------------------------------------+
| **409**   | Subscription could not be deleted as it contains measurement groups |
|           | with state UNLOCKED OR state change to LOCKED was under process     |
+-----------+---------------------------------------------------------------------+
| **500**   | Exception occurred on the server                                    |
+-----------+---------------------------------------------------------------------+


PUT /subscription/{subscription_name}/nfFilter
----------------------------------------------

Description
~~~~~~~~~~~

Update a Subscription nf filter


Sample NF Filter Body
~~~~~~~~~~~~~~~~~~~~~~~~

.. code-block:: json

    {
        "nfFilter": {
            "nfNames": [
            "^pnf.*",
            "^vnf.*"
            ],
            "modelInvariantIDs": [

            ],
            "modelVersionIDs": [

            ],
            "modelNames": [

            ]
        }
    }

Responses
~~~~~~~~~

+-----------+---------------------------------------------------------------------+
| HTTP Code | Description                                                         |
+===========+=====================================================================+
| **201**   | Successfully updated nf filter                                      |
+-----------+---------------------------------------------------------------------+
| **400**   | Invalid input                                                       |
+-----------+---------------------------------------------------------------------+
| **409**   | Conflicting data                                                    |
+-----------+---------------------------------------------------------------------+
| **500**   | Exception occurred while querying database                          |
+-----------+---------------------------------------------------------------------+


POST /subscription/{subscription_name}/measurementGroups/{measurement_group_name}
----------------------------------------------------------------------------------

Description
~~~~~~~~~~~

Create a measurement group for a given subscription


Sample Measurement Group Body
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code-block:: json

    {
        "measurementGroup": {
            "measurementGroupName": "msg_grp_03",
            "fileBasedGP":15,
            "fileLocation":"pm.xml",
            "administrativeState": "UNLOCKED",
            "measurementTypes": [
                {
                    "measurementType": "counter_a"
                }
            ],
            "managedObjectDNsBasic": [
                {
                    "DN": "string"
                }
            ]
        }
    }

Responses
~~~~~~~~~

+-----------+---------------------------------------------------------------------+
| HTTP Code | Description                                                         |
+===========+=====================================================================+
| **201**   | Successfully created measurement group                              |
+-----------+---------------------------------------------------------------------+
| **404**   | Subscription with the specified name not found                      |
+-----------+---------------------------------------------------------------------+
| **409**   | Duplicate data                                                      |
+-----------+---------------------------------------------------------------------+
| **500**   | Internal server error                                               |
+-----------+---------------------------------------------------------------------+


GET /subscription/{subscription_name}/measurementGroups/{measurement_group_name}
----------------------------------------------------------------------------------

Description
~~~~~~~~~~~

Get the  measurement group and associated network functions from PMSH by using sub name and meas group name

Responses
~~~~~~~~~

+-----------+---------------------------------------------------------------------+
| HTTP Code | Description                                                         |
+===========+=====================================================================+
| **200**   | OK; Received requested measurement group with associated NF's       |
+-----------+---------------------------------------------------------------------+
| **404**   | Measurement group with specified name not found                     |
+-----------+---------------------------------------------------------------------+
| **500**   | Exception occurred on the server                                    |
+-----------+---------------------------------------------------------------------+


DELETE /subscription/{subscription_name}/measurementGroups/{measurement_group_name}
------------------------------------------------------------------------------------

Description
~~~~~~~~~~~

Delete a measurement group

Responses
~~~~~~~~~

+-----------+--------------------------------------------------------------------------------------------------+
| HTTP Code | Description                                                                                      |
+===========+==================================================================================================+
| **204**   | Successfully deleted the measurement group and returns NO Content                                |
+-----------+--------------------------------------------------------------------------------------------------+
| **404**   | Measurement group with the specified name not found                                              |
+-----------+--------------------------------------------------------------------------------------------------+
| **409**   | Measurement group not deleted because state UNLOCKED OR state change to LOCKED was under process |
+-----------+--------------------------------------------------------------------------------------------------+
| **500**   | Exception occurred on the server                                                                 |
+-----------+--------------------------------------------------------------------------------------------------+


PUT /subscription/{subscription_name}/measurementGroups/{measurement_group_name}/{administrativeState}
-------------------------------------------------------------------------------------------------------

Description
~~~~~~~~~~~

Update administrative state for a measurement group

Responses
~~~~~~~~~

+-----------+---------------------------------------------------------------------+
| HTTP Code | Description                                                         |
+===========+=====================================================================+
| **201**   | Successfully updated administrative state                           |
+-----------+---------------------------------------------------------------------+
| **409**   | Duplicate data                                                      |
+-----------+---------------------------------------------------------------------+
| **500**   | Invalid input                                                       |
+-----------+---------------------------------------------------------------------+
