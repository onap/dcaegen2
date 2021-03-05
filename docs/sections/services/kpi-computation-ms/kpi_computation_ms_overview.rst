.. This work is licensed under a Creative Commons Attribution 4.0
   International License. http://creativecommons.org/licenses/by/4.0

.. _docs_kpi_computation_ms_overview:

Introduction
""""""""""""

**Kpi Computation MS** is a software component of ONAP that does calucaltion in accordance with the formula defined dynamically. The service include the features:
    Subscribe original PM data from DMaaP.
    Do KPI computation based on KPI formula which can be got from config policies and the formula can be configued dynamically.
    Publish KPI results on DMaaP.
    Receive request for specific KPI computation (future scope) on specific ‘objects’ (e.g., S-NSSAI, Service).

Architecture
------------
The internal architecture of Kpi Computation MS is shown below.

.. image:: ./arch.PNG

Functionality
"""""""""""""
Kpi Computation MS will do calculation based on the PM data that is VES format. publish KPI result as VES events on a DMaaP Message Router topic for consumers that prefer such data in VES format.
Kpi Computation MS receives PM data by subscribing to a Message Router topic.

Flows:
1. KPI Computation MS will get PM data VES format from DMaaP
2. Other modules (e.g., SO/OOF/Slice Analysis MS) can also request KPI-MS for KPI calculation (Future scope beyond H-release).
3. KPI Computation MS will support for periodical KPI Computation. Period may be specified by a requestor optionally, if nothing is specified, KPI computation MS will continue computation until an explicit stop trigger is received.
4. The KPI result which genertate by kpi computation will be published to DMaaP.

Interaction
"""""""""""
Kpi Computation MS interacts with the Config Binding Service to get configuration information.