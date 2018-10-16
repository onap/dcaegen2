.. This work is licensed under a Creative Commons Attribution 4.0 International License.
.. http://creativecommons.org/licenses/by/4.0

Architecture
============

**SNMPTRAP** (or "trapd", as in trap daemon) is a network facing ONAP platform
component.

The simple network management protocol (or "SNMP", for short) is a pervasive
communication protocol standard used between managed devices and a management system.  
It is used to relay data that can be valuable in the operation, fault identification 
and planning processes of all networks.

SNMP utilizes a message called a "trap" to inform SNMP managers of abnormal
or changed conditions on a resource that is running a SNMP agent.  These
agents can run on physical or virtual resources (no difference in reporting)
and can notify on anything from hardware states, resource utilization,
software processes or anything else specific to the agent's environment.


Capabilities
------------

**SNMPTRAP** receives simple network management protocol ("SNMP") traps
and publishes them to a  message router (DMAAP/MR) instance based on
attributes obtained from configuration binding service ("CBS").

.. blockdiag::

   blockdiag layers {
   orientation = portrait

   snmp_agent_1 [stacked];
   snmp_agent_2 [stacked];
   snmp_agent_n [stacked];

   snmp_agent_1 -> SNMPTRAP;
   snmp_agent_2 -> SNMPTRAP;
   snmp_agent_n -> SNMPTRAP;

   config_binding_service [shape = "database", stacked];
   SNMPTRAP [shape = "diamond"];

   config_binding_service <-> SNMPTRAP;
   SNMPTRAP -> dmaap_mr;

   group 1 {
    label = "SNMP Agents"
    color = orange;
    snmp_agent_1; snmp_agent_2; snmp_agent_n;
    }
   group 2 {
    label = "ONAP Trap Receiver"
    color = blue;
    SNMPTRAP;
    }
   group 3 {
    color = orange;
    dmaap_mr;
    }
   group 4 {
    color = gray;
    config_binding_service;
    }
   }


Interactions
------------


Traps are published to DMAAP/MR in a json format.  Once traps are published
to a DMAAP/MR instance, they are available to consumers that are
subscribed to the topic they were published to.


Usage Scenarios
---------------

**SNMPTRAP** runs in a docker container based on python 3.6.  Running
an instance of **SNMPTRAP** will result in arriving traps being published
to the topic specified by config binding services.  If CBS is not present,
SNMPTRAP will look for a JSON configuration file specified via the
environment variable CBS_SIM_JSON at startup (see "CONFIGURATION" link for details).
