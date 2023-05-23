.. This work is licensed under a Creative Commons Attribution 4.0 International License.
.. http://creativecommons.org/licenses/by/4.0

High-level architecture of Heartbeat Microservice
=================================================

**Heartbeat Microservice** startup script (misshtbtd.py) gets the
configuration from CBS and parses these entries and saves them in the
postgres database having table name **vnf_table_1**. Each entry in the
configuration is for a particular eventName. Each entry has missed
heartbeat count, heartbeat interval, Control loop name etc. along with
many other parameters. 

Whenever a heartbeat event is received, the sourceName, lastEpochTime
and other information is stored in another postgres database having
table name **vnf_table_2**. It is designed to process the heartbeat event
having different sourceNames having same eventName. In such case,
sourceName count is maintained in vnf_table_1 which would give number of
SouceNames that have same eventName. As and when new sourceName is
received, sourceName count is incremented in vnf_table_1

The heartbeat Microservice is designed to support multiple instances of
HB Microservice to run simultaneously. The first instance of the HB
Microservice would assume the role of active instance, and instances
that started running later would become inactive instances. If the
active HB microservice is not responding or killed, the inactive HB
instance would take over the active role. To achieve this functionality,
one more postgres table **hb_common** is introduced which has parameters
specific to active instances such as process id/hostname of the active
instance, last accessed time updated by active instance.

Heartbeat Microservice supports the periodic download of CBS
configuration. The periodicity of download can be configured.

Heartbeat Microservice also supports the download of CBS configuration
whenever configuration changes. Here Docker container would call the
function/method to download the CBS configuration.

The heartbeat microservice has 2 states

**Reconfiguration state** - Download configuration from CBS and update
the vnf_table_1 is in progress.

**Running state** - Normal working that comprises of receiving of HB
events and sending of control loop event if required conditions are met.
