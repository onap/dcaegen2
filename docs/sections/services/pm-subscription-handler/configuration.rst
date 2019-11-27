.. This work is licensed under a Creative Commons Attribution 4.0 International License.
.. http://creativecommons.org/licenses/by/4.0

.. Configuration:

Configuration
=============

Subscriptions
"""""""""""""

The PMSH is configured via CLAMP. The Subscription itself is configured within the monitoring policy, however, there
will be application specific configuration declared as inputs to the Cloudify Blueprint.

The subscription model schema is as follows:

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
               "swVersion": [
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
               ],
               "mapToVES": "TRUE"
             }
           }
         }



====================   =====================================   ========      ==========      ===================
Field                  Description                             Type          Required        Values
====================   =====================================   ========      ==========      ===================
subscriptionName       Name of the subscription                String        True
administrativeState    State of the subscription               Enum          True            LOCKED, UNLOCKED
fileBasedGP            Granularity Period                      Integer       True
fileLocation           Location of Report Output Period file   String        True
softwareVersion        PM Dictionary version                   String        True
nfFilter               xNF filter                              Object        True
measurementGroup       List of Measurement Types               Object        True
====================   =====================================   ========      ==========      ===================

**nfFilter**

::

        "nfFilter": {
            "swVersion": [
                "1.0.0",
                "1.0.1"
            ],
            "nfNames": [
                "ABC",
                "DEF",
                "foo.*"
            ]
        }

====================   =====================================   ========      ==========      ===================
Field                  Description                             Type          Required        Values
====================   =====================================   ========      ==========      ===================
swVersion              List of software versions               List          True
nfNames                List of xNF names                       List          True
====================   =====================================   ========      ==========      ===================

**measurementGroup**

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

=====================   =====================================   ========      ==========      ===================
Field                   Description                             Type          Required        Values
=====================   =====================================   ========      ==========      ===================
measurementTypes        List of measurement types               List          True
managedObjectDnsBasic   List of managed objects                 List          True
=====================   =====================================   ========      ==========      ===================

.. _Topics:

MR Topics
"""""""""""""""""""""

Subscriber:
^^^^^^^^^^^

The PMSH subscribes to two MR topics:

::

        AAI-EVENT

The first topic is for the PMSH to listen for new xNFs getting registered. If the xNF matches the xNF filter (See
:ref:`Configuration<Configuration>`) it will be added to the relevant subscription. This topic is **AAI_EVENT**.

::

        org.onap.dmaap.mr.PM_SUBSCRIPTION_EVENTS

The second topic is for activation and de-activation events. i.e if a user has previously created an inactive
subscription, they can publish an event to this topic to activate it, or vice versa.

Publisher:
^^^^^^^^^^

::

        org.onap.dmaap.mr.PM_SUBSCRIPTIONS

The PMSH publishes subscriptions to this topic. They will be consumed by a policy which will make a request to CDS to
activate the subscription.