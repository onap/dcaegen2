.. This work is licensed under a Creative Commons Attribution 4.0 International License.
.. http://creativecommons.org/licenses/by/4.0
.. Copyright 2018-2019 Tech Mahindra Ltd.


Mapper
=====================

| **Problem:** Different VNF vendors generate event and telemetry data in different formats. Out of the box, all VNF vendors may not support VES format. 
| **Solution**: A generic adapter which can convert different formats of event and telemetry data to VES format can be of use here. 
| *Note*: Currently mapping files are available for SNMP collector and RESTConf collector.

There is 1 micro service in the mapper functionality.

**Universal VES Adapter** - It converts the telemetry data into the required VES format and publishes to the DMaaP for further action to be taken by the DCAE analytics applications. 


.. toctree::
  :maxdepth: 1

  ./flow.rst
  ./delivery.rst
  ./installation.rst
  ./mappingfile.rst
  ./SampleSnmpTrapConversion
