.. This work is licensed under a Creative Commons Attribution 4.0 International License.
.. http://creativecommons.org/licenses/by/4.0

Architecture
============


**SNMPTRAP** (or "trapd", as in trap daemon) is a network facing ONAP platform component.

The simple network management protocol (or "SNMP", for short) is a standardized communication protocol used between managed devices (physical, virtual - or anything in between!) and a management system.  It is used to relay data that can be valuable in the operation, fault identification and planning processes of all networks.

It is the "front line" of management in all environments.

SNMP utilizes a message called a "trap" to inform SNMP managers of abnormal or changed conditions on a resource that is running a SNMP agent.  These agents can run on physical or virtual resources (no difference in reporting) and can notify on anything from hardware states, resource utilization, software processes or anything else specific to the agent's environment.


Capabilities
------------


**SNMPTRAP** receives simple network management protocol ("SNMP") traps and publishes them to a  message router (DMAAP/MR) instance based on attributes obtained from configuration binding service ("CBS").

.. blockdiag::

   blockdiag layers {
   orientation = portrait
   snmp agent 1 -> SNMPTRAP;
   snmp agent 2 -> SNMPTRAP;
   snmp agent <n> -> SNMPTRAP;
   config binding service -> SNMPTRAP;
   SNMPTRAP -> dmaap mr;

   group l1 {
    color = orange;
    snmp agent 1; snmp agent 2; snmp agent <n>;
    }
   group l2 {
    color = blue;
    SNMPTRAP;
    }
   group l3 {
    color = orange;
    dmaap mr;
    }
   group l4 {
    color = gray;
    config binding service;
    }

   }


Interactions
------------


Traps are published to DMAAP/MR in a json format.  Once traps are published to a DMAAP/MR instance, they are available to consumers that are subscribed to the topic they were published to.


Usage Scenarios
---------------

**SNMPTRAP** can be run on any device (physical, logical, container) that is capable of running python 3.6+ and has SNMP traps targeted at it.  Running an instance of **SNMPTRAP** will result in arriving traps being published to the topic specified by config binding services.  If CBS is not present, SNMPTRAP will look for or a JSON configuration file specified via the environment vvariable CBS_SIM_JSON at startup.  Note that relative paths will be located from the bin (<SNMPTRAP base directory>/bin directory.

    E.g.

        CBS_SIM_JSON=../etc/snmptrapd.json
