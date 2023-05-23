.. This work is licensed under a Creative Commons Attribution 4.0 International License.
.. http://creativecommons.org/licenses/by/4.0
.. _snmpofferedapis:

Offered APIs
============

**trapd** supports the Simple Network Management Protocol (SNMP)
standard.  It is a well documented and pervasive protocol,
used in all networks worldwide.

As an API offering, the only way to interact with **trapd** is
to send traps that conform to the industry standard specification
(RFC1215 - available at https://tools.ietf.org/html/rfc1215 ) to a
running instance.  To accomplish this, you may:

1. Configure SNMP agents to send native traps to a SNMPTRAP instance.
   In SNMP agent configurations, this is usually accomplished by
   setting the "trap target" or "snmp manager" to the IP address
   of the running VM/container hosting SNMPTRAP.

2. Simulate a SNMP trap using various freely available utilities.  Two
   examples are provided below, *be sure to change the target
   ("localhost") and port ("162") to applicable values in your
   environment.*

NetSNMP snmptrap
----------------

One way to simulate an arriving SNMP trap is to use the Net-SNMP utility/command snmptrap.
This command can send V1, V2c or V3 traps to a manager based on the parameters provided.

The example below sends a SNMP V1 trap to the specified host.  Prior to running this command, export
the values of *to_ip_address* (set it to the IP of the VM hosting the ONAP trapd container) and *to_port* (typically
set to "162"):

   ``export to_ip_address=192.168.1.1``

   ``export to_port=162``

Then run the Net-SNMP command/utility:

   ``snmptrap -d -v 1 -c not_public ${to_ip_address}:${to_portt} .1.3.6.1.4.1.99999 localhost 6 1 '55' .1.11.12.13.14.15  s "test trap"``

.. note::

   This will display some "read_config_store open failure" errors;
   they can be ignored, the trap has successfully been sent to the
   specified destination.

python using pysnmp
-------------------

Another way to simulate an arriving SNMP trap is to send one with the python *pysnmp* module.  (Note that this
is the same module that ONAP trapd is based on).

To do this, create a python script called "send_trap.py" with the following contents.  You'll need to change the
target (from "localhost" to whatever the destination IP/hostname of the trap receiver is) before saving:

.. code-block:: python

        from pysnmp.hlapi import *
        from pysnmp import debug

        # debug.setLogger(debug.Debug('msgproc'))

        errorIndication, errorStatus, errorIndex, varbinds = next(sendNotification(SnmpEngine(),
             CommunityData('not_public'),
             UdpTransportTarget(('localhost', 162)),
             ContextData(),
             'trap',
             [ObjectType(ObjectIdentity('.1.3.6.1.4.1.999.1'), OctetString('test trap - ignore')),
              ObjectType(ObjectIdentity('.1.3.6.1.4.1.999.2'), OctetString('ONAP pytest trap'))])
        )

        if errorIndication:
            print(errorIndication)
        else:
            print("successfully sent trap")

To run the pysnmp example:

   ``python ./send_trap.py``
