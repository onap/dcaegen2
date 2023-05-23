.. This work is licensed under a Creative Commons Attribution 4.0 International License.
.. http://creativecommons.org/licenses/by/4.0
.. Copyright 2022 Nordix Foundation


Installation and Configuration
==============================

PM Subscription Handler (PMSH) microservice can be deployed using helm charts in oom repository.


Deployment Prerequisites
~~~~~~~~~~~~~~~~~~~~~~~~

- PMSH service requires config-binding-service, policy, dmaap, cds, aai and aaf components to be running.




Deployment Steps
~~~~~~~~~~~~~~~~

- Default app config values can be updated in oom/kubernetes/dcaegen2-services/components/dcae-pmsh/values.yaml


- Enable PMSH component in oom/kubernetes/dcaegen2-services/values.yaml

  .. code-block:: yaml

    dcae-pmsh:
        enabled: true

- Make the chart and deploy using the following command:

  .. code-block:: bash

    cd oom/kubernetes/
    make dcaegen2-services
    helm install dev-dcaegen2-services dcaegen2-services --namespace <namespace> --set global.masterPassword=<password>

- To deploy only PMSH:

  .. code-block:: bash

    helm install dev-pmsh dcaegen2-services/components/dcae-pmsh --namespace <namespace> --set global.masterPassword=<password>

- To uninstall:

  .. code-block:: bash

    helm uninstall dev-pmsh


.. _Subscription:

Subscription configuration
""""""""""""""""""""""""""

The subscription is configured within the monitoring policy. The subscription model schema is as follows:

**subscription**

.. code-block:: json

    {
       "subscription":{
          "subscriptionName":"someExtraPM-All-gNB-R2B",
          "operationalPolicyName":"operational-policy-name",
          "controlLoopName":"controlLoop-name",
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
             ],
            "modelNames": [
                "pnf102"
            ]
          },
          "measurementGroups":[
             {
                "measurementGroup":{
                   "measurementGroupName":"msgroupname",
                   "administrativeState":"UNLOCKED",
                   "fileBasedGP":15,
                   "fileLocation":"/pm/pm.xml",
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


+-----------------------+---------------------------------------------------------------------------------------------------------+--------+----------+--------------------------+
| Field                 | Description                                                                                             | Type   | Required | Values                   |
+-----------------------+---------------------------------------------------------------------------------------------------------+--------+----------+--------------------------+
| subscriptionName      | Name of the subscription.                                                                               | string | True     | subscriptionName         |
+-----------------------+---------------------------------------------------------------------------------------------------------+--------+----------+--------------------------+
| operationalPolicyName | Name of the operational policy to be executed.                                                          | string | True     | operationalPolicyName    |
+-----------------------+---------------------------------------------------------------------------------------------------------+--------+----------+--------------------------+
| controlLoopName       | Name of the control loop.                                                                               | string | False    | controlLoopName          |
+-----------------------+---------------------------------------------------------------------------------------------------------+--------+----------+--------------------------+
| nfFilter              | The network function filter will be used to filter the list of nf's stored in A&AI to produce a subset. |  list  | True     |                          |
+-----------------------+---------------------------------------------------------------------------------------------------------+--------+----------+--------------------------+
| measurementGroups     | List containing measurementGroup.                                                                       |  list  | True     | List of measurementGroup |
+-----------------------+---------------------------------------------------------------------------------------------------------+--------+----------+--------------------------+

.. note::
  Since release Istanbul of ONAP, PMSH Subscriptions model schema is updated.
  Subscription model is centric to ``measurementGroup``, for instance any update on attributes administrativeState, fileBasedGP,
  fileLocation, nfFilter will be applicable to only individual measurementGroup object.

**nfFilter**

The ``nfFilter`` will be used in order to filter the list of NF's retrieved from A&AI. There are four criteria that
can be filtered on, nfNames, modelInvariantIDs, modelVersionIDs and/or modelNames.  All 4 of these are optional fields but at
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
        ],
        "modelNames": [
            "pnf102"
        ]
    }

+------------------------+-----------------------------------------------------------------------------------------------+------+----------+
| Field                  | Description                                                                                   | Type | Required |
+========================+===============================================================================================+======+==========+
| nfNames                | List of NF names. These names are regexes, which will be parsed by the PMSH.                  | list | True     |
+------------------------+-----------------------------------------------------------------------------------------------+------+----------+
| modelInvariantIDs      | List of modelInvariantIDs. These UUIDs will be checked for exact matches with AAI entities.   | list | True     |
+------------------------+-----------------------------------------------------------------------------------------------+------+----------+
| modelVersionIDs        | List of modelVersionIDs. These IDs will be checked for exact matches with AAI entities.       | list | True     |
+------------------------+-----------------------------------------------------------------------------------------------+------+----------+
| modelNames             | List of modelNames. These names will be checked for exact matches with AAI entities.          | list | True     |
+------------------------+-----------------------------------------------------------------------------------------------+------+----------+

**measurementGroup**

``measurementGroup`` is used to specify the group of measurements that will be collected.

.. code-block:: json

    "measurementGroup": {
       "measurementGroupName":"msgroupname",
       "administrativeState":"UNLOCKED",
       "fileBasedGP":15,
       "fileLocation":"/pm/pm.xml",
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

+-----------------------+----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+------+----------+--------+
| Field                 | Description                                                                                                                                                                            | Type | Required | Values |
+=======================+========================================================================================================================================================================================+======+==========+========+
| measurementGroupName  | Unique identifier for measurementGroup.                                                                                                                                                |      | True     |        |
+-----------------------+----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+------+----------+--------+
| administrativeState   | Setting a measurementGroup to UNLOCKED will apply the subscription changes to the NF instances immediately. If it is set to LOCKED, it will not be applied until it is later unlocked. |      | True     |        |
+-----------------------+----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+------+----------+--------+
| fileBasedGP           | The frequency at which measurements are produced.                                                                                                                                      |      | True     |        |
+-----------------------+----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+------+----------+--------+
| fileLocation          | Location of Report Output Period file.                                                                                                                                                 |      | True     |        |
+-----------------------+----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+------+----------+--------+
| measurementTypes      | List of measurement types. These are regexes, and it is expected that either the CDS blueprint, or NF can parse them. As the PMSH will not do so.                                      | list | True     |        |
+-----------------------+----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+------+----------+--------+
| managedObjectDNsBasic | List of managed object distinguished names.                                                                                                                                            | list | True     |        |
+-----------------------+----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+------+----------+--------+

.. _Topics:

MR Topics
"""""""""

Subscriber:
^^^^^^^^^^^

::

        AAI-EVENT

This topic is used so that the PMSH can listen for new NFs getting added or deleted. If the NF matches the NF filter it will be added to the relevant subscription.

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
            "measurementGroupName":"msgroupname",
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

.. note::
  Since release Istanbul of ONAP, PMSH Publish Subscriptions event format is updated.
  A new attribute ``measurementGroupName`` is added as a unique identifier for ``measurementGroup`` and a single ``measurementGroup`` is associated with
  PMSH Subscription event.

Example event sent from PMSH:

.. code-block:: json

    {
       "nfName":"PNF104",
       "ipv4Address": "10.12.13.12",
       "policyName":"operational-policy-name",
       "closedLoopControlName":"controlLoop-name",
       "blueprintName":"pm_control",
       "blueprintVersion":"1.2.4",
       "changeType":"CREATE",
       "subscription":{
          "administrativeState":"UNLOCKED",
          "subscriptionName":"subscriptiona",
          "fileBasedGP":15,
          "fileLocation":"/pm/pm.xml",
          "measurementGroup":{
             "measurementGroupName":"msgroupname",
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
       }
    }
