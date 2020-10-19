.. This work is licensed under a Creative Commons Attribution 4.0 International License.
.. http://creativecommons.org/licenses/by/4.0

.. Configuration:

Configuration
=============

The PMSH is configured and deployed via the DCAE dashboard.

Application specific configuration
""""""""""""""""""""""""""""""""""

The application config is the basic information that PMSH needs to run. The following parameters are required, they are
specified in the dashboard deployment GUI.

+-----------------------------+----------------------------------------------------------------------------------------+---------+----------+-------------------------------------------------------------------------------------+
| Field                       | Description                                                                            | Type    | Required | Default                                                                             |
+-----------------------------+----------------------------------------------------------------------------------------+---------+----------+-------------------------------------------------------------------------------------+
| tag_version                 | Docker image to be used.                                                               | string  | True     | nexus3.onap.org:10001/onap/org.onap.dcaegen2.services.pm-subscription-handler:1.0.3 |
+-----------------------------+----------------------------------------------------------------------------------------+---------+----------+-------------------------------------------------------------------------------------+
| replicas                    | Number of instances.                                                                   | integer | True     | 1                                                                                   |
+-----------------------------+----------------------------------------------------------------------------------------+---------+----------+-------------------------------------------------------------------------------------+
| operational_policy_name     | Name of the operational policy to be executed.                                         | string  | True     | pmsh-operational-policy                                                             |
+-----------------------------+----------------------------------------------------------------------------------------+---------+----------+-------------------------------------------------------------------------------------+
| control_loop_name           | Name of the control loop.                                                              | string  | True     | pmsh-control-loop                                                                   |
+-----------------------------+----------------------------------------------------------------------------------------+---------+----------+-------------------------------------------------------------------------------------+
| pm_publish_topic_name       | The topic that PMSH will publish to, and which policy will subscribe to.               | string  | True     | unauthenticated.DCAE_CL_OUTPUT                                                      |
+-----------------------------+----------------------------------------------------------------------------------------+---------+----------+-------------------------------------------------------------------------------------+
| policy_feedback_topic_name  | The topic that PMSH will subscribe to, and which policy will publish to.               | string  | True     | unauthenticated.PMSH_CL_INPUT                                                       |
+-----------------------------+----------------------------------------------------------------------------------------+---------+----------+-------------------------------------------------------------------------------------+
| aai_notification_topic_name | The topic that PMSH will subscribe to, and which AAI will publish change events to.    | string  | True     | AAI-EVENT                                                                           |
+-----------------------------+----------------------------------------------------------------------------------------+---------+----------+-------------------------------------------------------------------------------------+
| publisher_client_role       | The client role used to publish to the topic that policy will subscribe to.            | string  | True     | org.onap.dcae.pmPublisher                                                           |
+-----------------------------+----------------------------------------------------------------------------------------+---------+----------+-------------------------------------------------------------------------------------+
| subscriber_client_role      | The client role used to subscribe to the topic that AAI will publish change events to. | string  | True     | org.onap.dcae.pmSubscriber                                                          |
+-----------------------------+----------------------------------------------------------------------------------------+---------+----------+-------------------------------------------------------------------------------------+
| dcae_location               | Location of the DCAE cluster.                                                          | string  | True     | san-francisco                                                                       |
+-----------------------------+----------------------------------------------------------------------------------------+---------+----------+-------------------------------------------------------------------------------------+
| cpu_limit                   | CPU limit for the PMSH service.                                                        | string  | True     | 1000m                                                                               |
+-----------------------------+----------------------------------------------------------------------------------------+---------+----------+-------------------------------------------------------------------------------------+
| cpu_request                 | Requested CPU for the PMSH service.                                                    | string  | True     | 1000m                                                                               |
+-----------------------------+----------------------------------------------------------------------------------------+---------+----------+-------------------------------------------------------------------------------------+
| memory_limit                | Memory limit for the PMSH service.                                                     | string  | True     | 1024Mi                                                                              |
+-----------------------------+----------------------------------------------------------------------------------------+---------+----------+-------------------------------------------------------------------------------------+
| memory_request              | Requested Memory for the PMSH service.                                                 | string  | True     | 1024Mi                                                                              |
+-----------------------------+----------------------------------------------------------------------------------------+---------+----------+-------------------------------------------------------------------------------------+
| pgaas_cluster_name          | Cluster name for Postgres As A Service.                                                | string  | True     | dcae-pg-primary.onap                                                                |
+-----------------------------+----------------------------------------------------------------------------------------+---------+----------+-------------------------------------------------------------------------------------+
| enable_tls                  | Boolean flag to toggle HTTPS cert auth support.                                        | boolean | True     | true                                                                                |
+-----------------------------+----------------------------------------------------------------------------------------+---------+----------+-------------------------------------------------------------------------------------+
| protocol                    | HTTP protocol for PMSH. If 'enable_tls' is false, protocol must be set to http.        | string  | True     | https                                                                               |
+-----------------------------+----------------------------------------------------------------------------------------+---------+----------+-------------------------------------------------------------------------------------+

.. _Subscription:

Subscription configuration
""""""""""""""""""""""""""

The subscription is configured within the monitoring policy. The subscription model schema is as follows:

**subscription**

.. code-block:: json

    {
       "subscription":{
          "subscriptionName":"someExtraPM-All-gNB-R2B",
          "administrativeState":"UNLOCKED",
          "fileBasedGP":15,
          "fileLocation":"/pm/pm.xml",
          "nfFilter":{
             "nfNames":[
                "^pnf1.*"
             ],
             "modelInvariantIDs":[
                "5845y423-g654-6fju-po78-8n53154532k6",
                "7129e420-d396-4efb-af02-6b83499b12f8"
             ],
             "modelVersionIDs":[
                "e80a6ae3-cafd-4d24-850d-e14c084a5ca9"
             ]
          },
          "measurementGroups":[
             {
                "measurementGroup":{
                   "measurementTypes":[
                      {
                         "measurementType":"EutranCell.*"
                      },
                      {
                         "measurementType":"EutranCellRelation.pmCounter1"
                      },
                      {
                         "measurementType":"EutranCellRelation.pmCounter2"
                      }
                   ],
                   "managedObjectDNsBasic":[
                      {
                         "DN":"ManagedElement=1,ENodeBFunction=1,EUtranCell=CityCenter1"
                      },
                      {
                         "DN":"ManagedElement=1,ENodeBFunction=1,EUtranCell=CityCenter1, EUtranCellRelation=CityCenter2"
                      },
                      {
                         "DN":"ManagedElement=1,ENodeBFunction=1,EUtranCell=CityCenter1, EUtranCellRelation=CityCenter3"
                      }
                   ]
                }
             }
          ]
       }
    }


+---------------------+----------------------------------------------------------------------------------------------------------------------------------------------------------------------------+------+----------+--------+
| Field               | Description                                                                                                                                                                | Type | Required | Values |
+---------------------+----------------------------------------------------------------------------------------------------------------------------------------------------------------------------+------+----------+--------+
| subscriptionName    | Name of the subscription.                                                                                                                                                  |      |          |        |
+---------------------+----------------------------------------------------------------------------------------------------------------------------------------------------------------------------+------+----------+--------+
| administrativeState | Setting a subscription to UNLOCKED will apply the subscription to the NF instances immediately. If it is set to LOCKED, it will not be applied until it is later unlocked. |      |          |        |
+---------------------+----------------------------------------------------------------------------------------------------------------------------------------------------------------------------+------+----------+--------+
| fileBasedGP         | The frequency at which measurements are produced.                                                                                                                          |      |          |        |
+---------------------+----------------------------------------------------------------------------------------------------------------------------------------------------------------------------+------+----------+--------+
| fileLocation        | Location of Report Output Period file.                                                                                                                                     |      |          |        |
+---------------------+----------------------------------------------------------------------------------------------------------------------------------------------------------------------------+------+----------+--------+
| nfFilter            | The network function filter will be used to filter the list of nf's stored in A&AI to produce a subset.                                                                    |      |          |        |
+---------------------+----------------------------------------------------------------------------------------------------------------------------------------------------------------------------+------+----------+--------+
| measurementGroups   | List containing measurementGroup.                                                                                                                                          |      |          |        |
+---------------------+----------------------------------------------------------------------------------------------------------------------------------------------------------------------------+------+----------+--------+

**nfFilter**

The ``nfFilter`` will be used in order to filter the list of NF's retrieved from A&AI. There are three criteria that
can be filtered on, nfNames, modelInvariantIDs and/or modelVersionIDs.  All 3 of these are optional fields but at
least 1 must be present for the filter to work.

.. code-block:: json

    "nfFilter": {
        "nfNames":[
           "^pnf.*",
           "^vnf.*"
        ],
        "modelInvariantIDs": [
           "5845y423-g654-6fju-po78-8n53154532k6",
           "7129e420-d396-4efb-af02-6b83499b12f8"
        ],
        "modelVersionIDs": [
           "e80a6ae3-cafd-4d24-850d-e14c084a5ca9"
        ]
    }

+------------------------+-----------------------------------------------------------------------------------------------+------+----------+
| Field                  | Description                                                                                   | Type | Required |
+========================+===============================================================================================+======+==========+
| nfNames                | List of NF names. These names are regexes, which will be parsed by the PMSH.                  | list | False    |
+------------------------+-----------------------------------------------------------------------------------------------+------+----------+
| modelInvariantIDs      | List of modelInvariantIDs. These UUIDs will be checked for exact matches with AAI entities.   | list | False    |
+------------------------+-----------------------------------------------------------------------------------------------+------+----------+
| modelVersionIDs        | List of modelVersionIDs. These IDs will be checked for exact matches with AAI entities.       | list | False    |
+------------------------+-----------------------------------------------------------------------------------------------+------+----------+

**measurementGroup**

``measurementGroup`` is used to specify the group of measurements that will be collected.

.. code-block:: json

    "measurementGroup": {
       "measurementTypes": [
         {
           "measurementType": "EutranCell.*"
         },
         {
           "measurementType": "EutranCellRelation.pmCounter1"
         },
         {
           "measurementType": "EutranCellRelation.pmCounter2"
         }
       ],
       "managedObjectDNsBasic": [
         {
           "DN": "ManagedElement=1,ENodeBFunction=1,EUtranCell=CityCenter1"
         },
         {
           "DN": "ManagedElement=1,ENodeBFunction=1,EUtranCell=CityCenter1, EUtranCellRelation=CityCenter2"
         },
         {
           "DN": "ManagedElement=1,ENodeBFunction=1,EUtranCell=CityCenter1, EUtranCellRelation=CityCenter3"
         }
       ]
    }

+-----------------------+---------------------------------------------------------------------------------------------------------------------------------------------------+------+----------+
| Field                 | Description                                                                                                                                       | Type | Required |
+=======================+===================================================================================================================================================+======+==========+
| measurementTypes      | List of measurement types. These are regexes, and it is expected that either the CDS blueprint, or NF can parse them. As the PMSH will not do so. | list | True     |
+-----------------------+---------------------------------------------------------------------------------------------------------------------------------------------------+------+----------+
| managedObjectDNsBasic | List of managed object distinguished names.                                                                                                       | list | True     |
+-----------------------+---------------------------------------------------------------------------------------------------------------------------------------------------+------+----------+

.. _Topics:

MR Topics
"""""""""

Subscriber:
^^^^^^^^^^^

::

        AAI-EVENT

This topic is used so that the PMSH can listen for new NFs getting added or deleted. If the NF matches the NF filter (See
:ref:`Configuration<Configuration>`) it will be added to the relevant subscription.

::

        unauthenticated.PMSH_CL_INPUT

This topic enables the operational policy to provide feedback on the status of a subscription attempt, back to
PMSH, with a message of either success or failed.

Example of successful CREATE event sent from policy:

.. code-block:: json

    {
        "name": "ResponseEvent",
        "nameSpace": "org.onap.policy.apex.onap.pmcontrol",
        "source": "APEX",
        "target": "DCAE",
        "version": "0.0.1",
        "status": {
            "subscriptionName": "subscriptiona",
            "nfName": "PNF104",
            "changeType": "CREATE",
            "message": "success"
        }
    }


Publisher:
^^^^^^^^^^

.. _DCAE_CL_OUTPUT_Topic:

::

        unauthenticated.DCAE_CL_OUTPUT

PMSH publishes subscriptions to this topic. They will be consumed by an operational policy which will make a request to CDS to
change the state of the subscription.

Example event sent from PMSH:

.. code-block:: json

    {
       "nfName":"PNF104",
       "ipv4Address": "10.12.13.12",
       "policyName":"pmsh-operational-policy",
       "closedLoopControlName":"pmsh-control-loop",
       "blueprintName":"pm_control",
       "blueprintVersion":"1.2.4",
       "changeType":"CREATE",
       "subscription":{
          "administrativeState":"UNLOCKED",
          "subscriptionName":"subscriptiona",
          "fileBasedGP":15,
          "fileLocation":"/pm/pm.xml",
          "measurementGroups":[
             {
                "measurementGroup":{
                   "measurementTypes":[
                      {
                         "measurementType":"countera"
                      },
                      {
                         "measurementType":"counterb"
                      }
                   ],
                   "managedObjectDNsBasic":[
                      {
                         "DN":"dna"
                      },
                      {
                         "DN":"dnb"
                      }
                   ]
                }
             },
             {
                "measurementGroup":{
                   "measurementTypes":[
                      {
                         "measurementType":"counterc"
                      },
                      {
                         "measurementType":"counterd"
                      }
                   ],
                   "managedObjectDNsBasic":[
                      {
                         "DN":"dnc"
                      },
                      {
                         "DN":"dnd"
                      }
                   ]
                }
             }
          ]
       }
    }
