.. This work is licensed under a Creative Commons Attribution 4.0 International License.
.. http://creativecommons.org/licenses/by/4.0
.. Copyright 2018-2019 Tech Mahindra Ltd.


VES-Mapper
==========

Different VNF vendors generate event and telemetry data in different formats. Out of the box, all VNF vendors may not support VES format.
VES-Mapper provides a generic adapter to convert different formats of event and telemetry data into VES structure that can be consumed by existing DCAE analytics applications.

| *Note*: Currently mapping files are available for SNMP collector and RESTConf collector.

**VES-Mapper** converts the telemetry data into the required VES format and publishes to the DMaaP for further action to be taken by the DCAE analytics applications.


.. toctree::
  :maxdepth: 1

  ./flow.rst
  ./delivery.rst
  ./installation-helm.rst
  ./mappingfile.rst
  ./SampleSnmpTrapConversion
  ./troubleshooting.rst
