.. This work is licensed under a Creative Commons Attribution 4.0 International License.
.. http://creativecommons.org/licenses/by/4.0

=======================================
Threshold Crossing Analytics (TCA-gen2)
=======================================


Overview
========

The TCA-gen2 is docker based mS intended to replace TCA/cdap version, which was first delivered as part of ONAP R0.   Functionality of TCA-gen2 is identical to that of TCA - where meaurement events are subscribed from DMAAP in VES structure, once events are recieved TCA-gen2 performs a comparison of an incoming performance metric(s) against both a high and low threshold defined and generates CL events when threshold are exceeded. When the original threshold defined are cleared, TCA-Gen2 will generate an ABATEMENT event to notify the downstream system on original problem being cleared.


.. toctree::
   :maxdepth: 1

   ./installation-helm.rst
   ./configuration
   ./functionality
   ./delivery
