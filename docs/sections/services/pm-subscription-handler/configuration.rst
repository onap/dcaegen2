.. This work is licensed under a Creative Commons Attribution 4.0 International License.
.. http://creativecommons.org/licenses/by/4.0

.. Configuration:

Configuration
=============

The PMSH is configured and deployed via CLAMP.

Application specific configuration
""""""""""""""""""""""""""""""""""

The application config is the basic information that PMSH needs to run. The following parameters are required, they are
specified in the CLAMP deployment GUI.

+-----------------------------+----------------------------------------------------------------------------------------+---------+----------+-------------------------------------------------------------------------------+
| Field                       | Description                                                                            | Type    | Required | Default                                                                       |
+-----------------------------+----------------------------------------------------------------------------------------+---------+----------+-------------------------------------------------------------------------------+
| tag_version                 | Docker image to be used.                                                               | string  | True     | nexus3.onap.org:10001/onap/org.onap.dcaegen2.services.pm-subscription-handler |
+-----------------------------+----------------------------------------------------------------------------------------+---------+----------+-------------------------------------------------------------------------------+
| replicas                    | Number of instances.                                                                   | integer | True     | 1                                                                             |
+-----------------------------+----------------------------------------------------------------------------------------+---------+----------+-------------------------------------------------------------------------------+
| policy_model_id             | Monitoring policy model ID.                                                            | string  | True     | onap.policies.monitoring.dcae-pm-subscription-handler                         |
+-----------------------------+----------------------------------------------------------------------------------------+---------+----------+-------------------------------------------------------------------------------+
| policy_id                   | Monitoring policy ID.                                                                  | string  | True     | onap.policies.monitoring.dcae-pm-subscription-handler                         |
+-----------------------------+----------------------------------------------------------------------------------------+---------+----------+-------------------------------------------------------------------------------+
| operational_policy_name     | Name of the operational policy that the service will prompt.                           | string  | True     | pmsh-operational-policy                                                       |
+-----------------------------+----------------------------------------------------------------------------------------+---------+----------+-------------------------------------------------------------------------------+
| control_loop_name           | Name of the control loop the service is part of.                                       | string  | True     |                                                                               |
+-----------------------------+----------------------------------------------------------------------------------------+---------+----------+-------------------------------------------------------------------------------+
| pm_publish_topic_name       | The topic that PMSH will publish to, and which policy will subscribe to.               | string  | True     | DCAE_CL_OUTPUT                                                                |
+-----------------------------+----------------------------------------------------------------------------------------+---------+----------+-------------------------------------------------------------------------------+
| policy_feedback_topic_name  | The topic that PMSH will subscribe to, and which policy will publish to.               | string  | True     | PMSH_CL_INPUT                                                                 |
+-----------------------------+----------------------------------------------------------------------------------------+---------+----------+-------------------------------------------------------------------------------+
| aai_notification_topic_name | The topic that PMSH will subscribe to, and which AAI will publish change events to.    | string  | True     | AAI-EVENT                                                                     |
+-----------------------------+----------------------------------------------------------------------------------------+---------+----------+-------------------------------------------------------------------------------+
| publisher_client_role       | The client role used to publish to the topic that policy will subscribe to.            | string  | True     | org.onap.dcae.pmPublisher                                                     |
+-----------------------------+----------------------------------------------------------------------------------------+---------+----------+-------------------------------------------------------------------------------+
| subscriber_client_role      | The client role used to subscribe to the topic that AAI will publish change events to. | string  | True     | org.onap.dcae.pmSubscriber                                                    |
+-----------------------------+----------------------------------------------------------------------------------------+---------+----------+-------------------------------------------------------------------------------+
| client_id                   | Client id for given AAF client.                                                        | string  | True     | dcae@dcae.onap.org                                                            |
+-----------------------------+----------------------------------------------------------------------------------------+---------+----------+-------------------------------------------------------------------------------+
| client_password             | Password for AAF client provided as client_id.                                         | string  | True     |                                                                               |
+-----------------------------+----------------------------------------------------------------------------------------+---------+----------+-------------------------------------------------------------------------------+
| dcae_location               | Location of the DCAE cluster.                                                          | string  | True     | san-francisco                                                                 |
+-----------------------------+----------------------------------------------------------------------------------------+---------+----------+-------------------------------------------------------------------------------+
| pmsh_service_protocol       | Protocol of the PMSH service.                                                          | string  | True     | https                                                                         |
+-----------------------------+----------------------------------------------------------------------------------------+---------+----------+-------------------------------------------------------------------------------+
| pmsh_service_port           | Port of the PMSH service.                                                              | string  | True     | 8443                                                                          |
+-----------------------------+----------------------------------------------------------------------------------------+---------+----------+-------------------------------------------------------------------------------+
| dmaap_mr_service_protocol   | Protocol of Message Router service.                                                    | string  | True     | https                                                                         |
+-----------------------------+----------------------------------------------------------------------------------------+---------+----------+-------------------------------------------------------------------------------+
| dmaap_mr_service_host       | Hostname of the Message Router service.                                                | string  | True     | message-router                                                                |
+-----------------------------+----------------------------------------------------------------------------------------+---------+----------+-------------------------------------------------------------------------------+
| dmaap_mr_service_port       | Port of the Message Router service.                                                    | string  | True     | 3905                                                                          |
+-----------------------------+----------------------------------------------------------------------------------------+---------+----------+-------------------------------------------------------------------------------+
| cpu_limit                   | CPU limit for the PMSH service.                                                        | string  | True     | 1000m                                                                         |
+-----------------------------+----------------------------------------------------------------------------------------+---------+----------+-------------------------------------------------------------------------------+
| cpu_request                 | Requested CPU for the PMSH service.                                                    | string  | True     | 1000m                                                                         |
+-----------------------------+----------------------------------------------------------------------------------------+---------+----------+-------------------------------------------------------------------------------+
| memory_limit                | Memory limit for the PMSH service.                                                     | string  | True     | 1024Mi                                                                        |
+-----------------------------+----------------------------------------------------------------------------------------+---------+----------+-------------------------------------------------------------------------------+
| memory_request              | Requested Memory for the PMSH service.                                                 | string  | True     | 1024Mi                                                                        |
+-----------------------------+----------------------------------------------------------------------------------------+---------+----------+-------------------------------------------------------------------------------+
| pgaas_cluster_name          | Cluster name for Postgres As A Service.                                                | string  | True     | dcae-pg-primary.onap                                                          |
+-----------------------------+----------------------------------------------------------------------------------------+---------+----------+-------------------------------------------------------------------------------+

Subscription configuraton
"""""""""""""""""""""""""

The subscription is configured within the monitoring policy in CLAMP. The subscription model schema is as follows:

**subscription**

::

         {
           "subscription": {
             "subscriptionName": "someExtraPM-AllKista-gNB-R2B",
             "administrativeState": "UNLOCKED",
             "fileBasedGP": 15,
             "fileLocation": "/pm/pm.xml",
             "nfTypeModelInvariantId": "2829292",
             "nfFilter": {
               "swVersions": [
                 "1.0.0",
                 "1.0.1"
               ],
               "nfNames": [
                 "ABC",
                 "DEF",
                 "foo.*"
               ]
             },
             "measurementGroups": [
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
             ]
           }
         }

+------------------------+----------------------------------------------------------------------------------------------------------------------------------------------------------------------------+------+----------+--------+
| Field                  | Description                                                                                                                                                                | Type | Required | Values |
+------------------------+----------------------------------------------------------------------------------------------------------------------------------------------------------------------------+------+----------+--------+
| subscriptionName       | Name of the subscription.                                                                                                                                                  |      |          |        |
+------------------------+----------------------------------------------------------------------------------------------------------------------------------------------------------------------------+------+----------+--------+
| administrativeState    | Setting a subscription to UNLOCKED will apply the subscription to the NF instances immediately. If it is set to LOCKED, it will not be applied until it is later unlocked. |      |          |        |
+------------------------+----------------------------------------------------------------------------------------------------------------------------------------------------------------------------+------+----------+--------+
| fileBasedGP            | The frequency at which measurements are produced.                                                                                                                          |      |          |        |
+------------------------+----------------------------------------------------------------------------------------------------------------------------------------------------------------------------+------+----------+--------+
| fileLocation           | Location of Report Output Period file.                                                                                                                                     |      |          |        |
+------------------------+----------------------------------------------------------------------------------------------------------------------------------------------------------------------------+------+----------+--------+
| nfTypeModelInvariantId | The invariant ID will be used to filter nf's if a list of nf names is not provided, or if regex is used to specify all nf's of a specific type.                            |      |          |        |
+------------------------+----------------------------------------------------------------------------------------------------------------------------------------------------------------------------+------+----------+--------+
| nfFilter               | The network function filter will be used to filter the list of nf's stored in A&AI to produce a subset.                                                                    |      |          |        |
+------------------------+----------------------------------------------------------------------------------------------------------------------------------------------------------------------------+------+----------+--------+
| measurementGroups      | List containing measurementGroup.                                                                                                                                          |      |          |        |
+------------------------+----------------------------------------------------------------------------------------------------------------------------------------------------------------------------+------+----------+--------+

**nfFilter**

The ``nfFilter`` will be used in order to filter the list of NF's retrieved from A&AI. It will filter on the names
specified in the ``nfNames`` field, which can also contain regex as seen below.

::

        "nfFilter": {
            "swVersions": [
                "1.0.0",
                "1.0.1"
            ],
            "nfNames": [
                "ABC",
                "DEF",
                "foo.*"
            ]
        }

+------------+-----------------------------------------------------------------------------+------+----------+
| Field      | Description                                                                 | Type | Required |
+============+=============================================================================+======+==========+
| swVersions | List of software versions.                                                  | list | True     |
+------------+-----------------------------------------------------------------------------+------+----------+
| nfNames    | List of NF names. These names are regexes, which will be parsed by the PMSH.| list | True     |
+------------+-----------------------------------------------------------------------------+------+----------+

**measurementGroup**

``measurementGroup`` is used to specify the group of measurements that will be collected.

::

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
"""""""""""""""""""""

Subscriber:
^^^^^^^^^^^

::

        AAI-EVENT

This topic is used so that the PMSH can listen for new NFs getting registered. If the NF matches the NF filter (See
:ref:`Configuration<Configuration>`) it will be added to the relevant subscription. This topic is **AAI_EVENT**.

::

        PMSH_CL_INPUT

This topic enables the operational policy to provide feedback on the status of a subscription attempt back to the PMSH service.


Publisher:
^^^^^^^^^^

::

        DCAE_CL_OUTPUT

The PMSH publishes subscriptions to this topic. They will be consumed by an operational policy which will make a request to CDS to
change the state of the subscription.