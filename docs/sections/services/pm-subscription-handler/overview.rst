.. This work is licensed under a Creative Commons Attribution 4.0 International License.
.. http://creativecommons.org/licenses/by/4.0

.. _Overview:

Overview
========

Introduction
""""""""""""
The PM Subscription Handler (PMSH) is a Python based micro service, which allows for the definition and activation
of PM subscriptions on one or more network function (NF) instances.


Functionality
"""""""""""""
PMSH allows for the definition of subscriptions on a network level, which enables the configuration of PM data on a
set of NF instances.
During creation of a subscription, PM reporting configuration and a network function filter will be defined.
This filter will then be used to produce a subset of NF's to which the subscription will be applied.
The NF's in question must have an Active orchestration-status in A&AI.
If an NF matching the filter is registered in ONAP after the microservice has been deployed, the subscription will
be applied to that NF.

Interaction
"""""""""""

Config Binding Service
^^^^^^^^^^^^^^^^^^^^^^

PMSH interacts with the Config Binding Service to retrieve it's configuration information, including the
subscription information.

DMaaP
^^^^^

PMSH subscribes and publishes to various DMaaP Message Router topics (See :ref:`Topics<Topics>`
for more information on which topics are used).

A&AI
^^^^

PMSH interacts with A&AI to fetch data about network functions. The ``nfFilter`` is then
applied to this data to produce a targeted subset of NF's.

Policy
^^^^^^

PMSH interacts indirectly with Policy via DMaaP Message Router to trigger an action on an operational policy defined
by the operator. The operational policy must align with the inputs provided in the event sent from PMSH.

CDS
^^^
The operational policy will be used to make a request to CDS, which will apply/remove the subscription to/from the NF.
The CDS blue print processor will execute the action over netconf towards the NF.
(See :ref:`DCAE_CL_OUTPUT_Topic<DCAE_CL_OUTPUT_Topic>` for more details)

Multiple CDS Blueprint support
""""""""""""""""""""""""""""""
When PMSH applies the nfFilter during the parsing of the NF data, it will attempt to retrieve the relevant blueprint information
defined in A&AI related to that model.
These are optional parameters in SDC (sdnc_model_name, sdnc_model_version), and can be defined as properties
assignment inputs, then pushed to A&AI during distribution.

If no blueprint information is available, the NF will be skipped and no subscription event sent.

If successful, the sdnc_model_name and sdnc_model_version will be sent as part of the event to the policy framework as
blueprintName and blueprintVersion respectively.
This in turn will be sent from the operational policy towards CDS blueprint processor, to trigger the action for the relevant blueprint.
