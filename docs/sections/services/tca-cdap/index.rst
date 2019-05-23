.. This work is licensed under a Creative Commons Attribution 4.0 International License.
.. http://creativecommons.org/licenses/by/4.0

==================================
Threshold Crossing Analytics (TCA)
==================================


Overview
========

The TCA (cdap-tca-hi-lo) app was first delivered as part of ONAP R0.  In that release, it was intended to be an application that established a software architecture for building CDAP applications that demonstrate sufficient unit test coverage and reusable libraries for ingesting DMaaP MR feeds formatted according to the VES standard.  Functionally, it performs a  comparison of an incoming performance metric(s) against both a high and low threshold defined and generates CL events when threshold are exceeded.

In Amsterdam release, TCA was deployed into 7 node CDAP cluster. However since Beijin release as ONAP required application to be containerized and deployable into K8s, a wrapper TCA CDAP container was built using CDAP SDK base image on which TCA application is deployed.



.. toctree::
   :maxdepth: 1

   ./installation
   ./functionality
   ./development_info
