.. This work is licensed under a Creative Commons Attribution 4.0 International License.
.. http://creativecommons.org/licenses/by/4.0


VNF Event Streaming (VES) Collector
===================================

.. Add or remove sections below as appropriate for the platform component.

**Virtual Event Streaming** (VES) Collector (formerly known as Standard Event Collector/Common Event Collector) is RESTful collector for processing JSON messages into DCAE. The collector supports individual events or eventbatch posted to collector end-point(s) and post them to interface/bus for other application to subscribe.
The collector verifies the source (when authentication is enabled) and validates the events against VES schema before distributing to DMAAP MR topics for downstream system to subscribe. The VESCollector also supports configurable event transformation function and event distribution to DMAAP MR topics.



VES Collector (HTTP) overview and functions
-------------------------------------------


.. toctree::
  :maxdepth: 1

  ./architecture.rst
  ./configuration.rst
  ./delivery.rst
  ./installation-helm.rst
  ./tls-authentication.rst
  ./stnd-defined-validation.rst

API reference
^^^^^^^^^^^^^

Refer to :doc:`VES APIs <../../apis/ves>` for detailed api information.
