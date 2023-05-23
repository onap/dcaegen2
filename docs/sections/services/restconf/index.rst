.. This work is licensed under a Creative Commons Attribution 4.0 International License.
.. http://creativecommons.org/licenses/by/4.0

==================
RestConf Collector
==================

Overview
========

Restconf collector is a microservice in ONAP DCAE. It subscribes to external controllers
and receives event data. After receiving event data it may modify it as per usecase's requirement and
produce a DMaaP event. This DMaap event usually consumed by VES mapper.
Restconf Collector can subscribe multiple events from multiple controllers.

.. toctree::
   :maxdepth: 1

   ./installation-helm
   ./functionality
   ./development_info
