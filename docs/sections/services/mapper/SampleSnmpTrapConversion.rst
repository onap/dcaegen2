.. This work is licensed under a Creative Commons Attribution 4.0 International License.
.. http://creativecommons.org/licenses/by/4.0
.. Copyright 2018 Tech Mahindra Ltd.

Sample Snmp trap Conversion:
============================

Following is the **Sample SNMP Trap** that will be received by the Universal VES Adapter from the Snmp Trap Collector :

.. code-block:: json

    {
   "cambria.partition":"10.53.172.132",
   "trap category":"ONAP-COLLECTOR-SNMPTRAP",
   "community len":0,
   "protocol version":"v2c",
   "varbinds":[
      {
         "varbind_value":"CLEARED and CRITICAL severities have the same name",
         "varbind_oid":"1.3.6.1.4.1.19444.12.2.0.2.0",
         "varbind_type":"OctetString"
      },
      {
         "varbind_value":"1.3",
         "varbind_oid":"1.3.6.1.4.1.19444.12.2.0.3.0",
         "varbind_type":"ObjectIdentifier"
      },
      {
         "varbind_value":"1.3",
         "varbind_oid":"1.3.6.1.4.1.19444.12.2.0.4.0",
         "varbind_type":"ObjectIdentifier"
      },
      {
         "varbind_value":"CLEARED",
         "varbind_oid":"1.3.6.1.4.1.19444.12.2.0.5.0",
         "varbind_type":"OctetString"
      },
      {
         "varbind_value":"Queue manager: Process failure cleared",
         "varbind_oid":"1.3.6.1.4.1.19444.12.2.0.6.0",
         "varbind_type":"OctetString"
      },
      {
         "varbind_value":"The queue manager process has been restored to normal operation",
         "varbind_oid":"1.3.6.1.4.1.19444.12.2.0.7.0",
         "varbind_type":"OctetString"
      },
      {
         "varbind_value":"The queue manager process has been restored to normal operation. The previously issued alarm has been cleared",
         "varbind_oid":"1.3.6.1.4.1.19444.12.2.0.8.0",
         "varbind_type":"OctetString"
      },
      {
         "varbind_value":"Changes to shared config will be synchronized across the cluster",
         "varbind_oid":"1.3.6.1.4.1.19444.12.2.0.9.0",
         "varbind_type":"OctetString"
      },
      {
         "varbind_value":"No action",
         "varbind_oid":"1.3.6.1.4.1.19444.12.2.0.10.0",
         "varbind_type":"OctetString"
      },
      {
         "varbind_value":"sprout-1.example.com",
         "varbind_oid":"1.3.6.1.4.1.19444.12.2.0.12.0",
         "varbind_type":"OctetString"
      }
   ],
   "notify OID":"1.3.6.1.6.3.1.1.5.3",
   "community":"",
   "uuid":"1fad4802-a6d0-11e8-a349-0242ac110002",
   "epoch_serno":15350273450000,
   "agent name":"10.53.172.132",
   "sysUptime":"0",
   "time received":1.535027345042007E9,
   "agent address":"10.53.172.132",
   "notify OID len":10
 }


Following is the converted VES Format of the above SNMP Sample Trap by using the default SNMP Trap Mapping File:

.. code-block:: json

 {
   "event":{
      "commonEventHeader":{
         "startEpochMicrosec":1.5350269902625413E9,
         "eventId":"XXXX",
         "sequence":0,
         "domain":"fault",
         "lastEpochMicrosec":1.5350269902625413E9,
         "eventName":"fault__ONAP-COLLECTOR-SNMPTRAP",
         "sourceName":"10.53.172.132",
         "priority":"Medium",
         "version":3,
         "reportingEntityName":"VesAdapter"
      },
      "faultFields":{
         "eventSeverity":"MINOR",
         "alarmCondition":"ONAP-COLLECTOR-SNMPTRAP",
         "faultFieldsVersion":2,
         "specificProblem":"SNMP Fault",
         "alarmAdditionalInformation":[
            {
               "name":"1.3.6.1.4.1.19444.12.2.0.2.0",
               "value":"CLEARED and CRITICAL severities have the same name"
            },
            {
               "name":"1.3.6.1.4.1.19444.12.2.0.3.0",
               "value":"1.3"
            },
            {
               "name":"1.3.6.1.4.1.19444.12.2.0.4.0",
               "value":"1.3"
            },
            {
               "name":"1.3.6.1.4.1.19444.12.2.0.5.0",
               "value":"CLEARED"
            },
            {
               "name":"1.3.6.1.4.1.19444.12.2.0.6.0",
               "value":"Queue manager: Process failure cleared"
            },
            {
               "name":"1.3.6.1.4.1.19444.12.2.0.7.0",
               "value":"The queue manager process has been restored to normal operation"
            },
            {
               "name":"1.3.6.1.4.1.19444.12.2.0.8.0",
               "value":"The queue manager process has been restored to normal operation. The previously issued alarm has been cleared"
            },
            {
               "name":"1.3.6.1.4.1.19444.12.2.0.9.0",
               "value":"Changes to shared config will be synchronized across the cluster"
            },
            {
               "name":"1.3.6.1.4.1.19444.12.2.0.10.0",
               "value":"No action"
            },
            {
               "name":"1.3.6.1.4.1.19444.12.2.0.12.0",
               "value":"sprout-1.example.com"
            }
         ],
         "eventSourceType":"SNMP Agent",
         "vfStatus":"Active"
      }
   }
 }
