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

+------------------+----------------------------------------------------------------------------------------------------+---------+----------+
| Field            | Description                                                                                        | Type    | Required |
+==================+====================================================================================================+=========+==========+
| tag_version      | Docker image to be used.                                                                           | string  | True     |
+------------------+----------------------------------------------------------------------------------------------------+---------+----------+
| replicas         | Number of instances.                                                                               | integer | True     |
+------------------+----------------------------------------------------------------------------------------------------+---------+----------+
| subscriber_topic | The topic that PMSH will subscribe to, this is where activation/de-activation events will be sent. | string  | True     |
+------------------+----------------------------------------------------------------------------------------------------+---------+----------+
| publisher_topic  | The topic that PMSH will publish subscriptions to, policy will subscribe to this topic.            | string  | True     |
+------------------+----------------------------------------------------------------------------------------------------+---------+----------+
| client_role      | Client role to request secure access to topic.                                                     | string  | True     |
+------------------+----------------------------------------------------------------------------------------------------+---------+----------+
| client_id        | Client id for given AAF client.                                                                    | string  | True     |
+------------------+----------------------------------------------------------------------------------------------------+---------+----------+
| client_password  | Password for AAF client provided as client_id.                                                     | string  | True     |
+------------------+----------------------------------------------------------------------------------------------------+---------+----------+

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
           }
         }

+------------------------+-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+---------+----------+------------------+
| Field                  | Description                                                                                                                                                                         | Type    | Required | Values           |
+========================+=====================================================================================================================================================================================+=========+==========+==================+
| subscriptionName       | Name of the subscription                                                                                                                                                            | string  | True     |                  |
+------------------------+-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+---------+----------+------------------+
| administrativeState    | Setting a subscription to UNLOCKED will apply the subscription to the NF instances immediately. Whereas if it is set to LOCKED, it will not be applied until it is later activated. | enum    | True     | LOCKED, UNLOCKED |
+------------------------+-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+---------+----------+------------------+
| fileBasedGP            | The frequency at which measurements are produced.                                                                                                                                   | integer | True     |                  |
+------------------------+-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+---------+----------+------------------+
| fileLocation           | Location of Report Output Period file.                                                                                                                                              | string  | True     |                  |
+------------------------+-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+---------+----------+------------------+
| nfTypeModelInvariantId | The invariant ID will be used to filter nf's if a list of nf names is not provided, or if regex is used to specify all nf's of a specific type.                                     | string  | True     |                  |
+------------------------+-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+---------+----------+------------------+
| nfFilter               | The network function filter will be used to filter the list of nf's stored in A&AI to produce a subset.                                                                             | object  | True     |                  |
+------------------------+-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+---------+----------+------------------+
| measurementGroup       | List of measurement types and managed object distinguished names                                                                                                                    | object  | True     |                  |
+------------------------+-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+---------+----------+------------------+

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
| swVersions | List of software versions                                                   | list | True     |
+------------+-----------------------------------------------------------------------------+------+----------+
| nfNames    | List of NF names. These names are regexes, which will be parsed by the PMSH | list | True     |
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
           ],
           "mapToVES": "TRUE"
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

The PMSH subscribes to two MR topics:

::

        AAI-EVENT

This topic is used so that the PMSH to listen for new NFs getting registered. If the NF matches the NF filter (See
:ref:`Configuration<Configuration>`) it will be added to the relevant subscription. This topic is **AAI_EVENT**.

::

        org.onap.dmaap.mr.PM_SUBSCRIPTION_EVENTS

This topic is used for activation and de-activation events. i.e if a user has previously created an inactive
subscription, they can publish an event to this topic to activate it, or vice versa.

Publisher:
^^^^^^^^^^

::

        org.onap.dmaap.mr.PM_SUBSCRIPTIONS

The PMSH publishes subscriptions to this topic. They will be consumed by a policy which will make a request to CDS to
activate the subscription.