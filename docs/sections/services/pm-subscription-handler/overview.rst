.. This work is licensed under a Creative Commons Attribution 4.0 International License.
.. http://creativecommons.org/licenses/by/4.0

.. _Overview:

Overview
========

Introduction
""""""""""""
The PM Subscription Handler (PMSH) is a micro service written in Python, which allows for the definition and unlocking
of PM subscriptions on one or more network function (NF) instances.

.. _Delivery: ./delivery.html

Functionality
"""""""""""""
The PMSH allows for the definition of subscriptions on a network level, which enables the
configuration of PM data on a set of NF instances.

Interaction
"""""""""""

Config Binding Service
^^^^^^^^^^^^^^^^^^^^^^

The PMSH interacts with the Config Binding Service to retrieve it's configuration information, including the
subscription information.

DMaaP
^^^^^

The PMSH subscribes and publishes to various DMaaP Message Router topics (See :ref:`Topics<Topics>`
for more information on which topics are used).

A&AI
^^^^

The PMSH interacts with A&AI to fetch data about network functions. The ``nfFilter`` is then
applied to this data to produce a targeted subset of NF's.

Policy and CDS
^^^^^^^^^^^^^^

The PMSH will indirectly interact with Policy and CDS in order to push subscriptions to NF's. A policy will be used to
make a request to CDS, which will apply the subscription to the NF.








