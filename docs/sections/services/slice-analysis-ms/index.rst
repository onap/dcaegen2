.. This work is licensed under a Creative Commons Attribution 4.0 International License.
.. http://creativecommons.org/licenses/by/4.0


Slice Analysis MS
=================

.. Add or remove sections below as appropriate for the platform component.


**Slice Analysis MS** is introduced in ONAP for:
(a) Analyzing the FM/PM data (reported from the xNFs) and KPI data (computed from PM data) related to various slice instances (NSIs), slice sub-net instances (NSSIs) and services catered to by the slices (S-NSSAIs).
(b) Determining and triggering appropriate Control Loop actions based on the analysis above
(c) Receiving recommendations for closed loop actions from ML or Analytics engines, performing validity checks, etc. to determine if the actions can be carried out, and then triggering the appropriate Control Loop

In Guilin, this MS:
- Performs simple Closed Loop control action for the RAN slice sub-net instances based on simple analysis of a set of RAN PM data
- Initiates simple control loop actions in the RAN based on recommendation from an ML engine for RAN slice sub-net instance re-configuration

For the Control loops, SO, VES Collector, Policy, DMaaP and CCSDK/SDN-R, AAI, PM-mapper and DFC are involved apart from this MS.

Flow diagrams are available at:
https://wiki.onap.org/display/DW/Closed+Loop
https://wiki.onap.org/display/DW/Intelligent+Slicing+flow


Slice Analysis MS overview and functions
----------------------------------------

.. toctree::
    :maxdepth: 1

    ./slice_analysis_ms_overview.rst

Slice Analysis MS Runtime Configuration
----------------------------------------

.. toctree::
    :maxdepth: 1

    ./runtime_configuration.rst


Slice Analysis MS Installation Steps
------------------------------------

.. toctree::
    :maxdepth: 1

    ./installation-helm.rst


Slice Analysis MS Troubleshooting Steps
---------------------------------------

.. toctree::
    :maxdepth: 1

    ./slice_analysis_ms_troubleshooting.rst
