============
Flow
============
.. [#] VNF submits SNMP traps to the SNMP trap collecto.
.. [#] Collector converts the trap into JSON format and publishes it on DMaaP topic **ONAP-COLLECTOR-SNMPTRAP**
.. [#] The Universal VES Adapter(UVA) microservice has subscribed to this DMaaP topic.
.. [#] On receiving an event from DMaaP, the adapter uses the corresponding mapping file from repository and converts received event into the VES event. It uses the enterprise ID from the received event to find the required mapping file. 
.. [#] Those SNMP Traps for which no mapping file is identified, a default mapping file is used with generic mappings to create the VES object.
.. [#] The VES formatted Event will be then published on DMaaP topic **unauthenticated.SEC_FAULT_OUTPUT**.


.. image:: ./flow.png
   :height: 100px
   :width: 200 px
   :scale: 50 %
   :alt: alternate text
   :align: left