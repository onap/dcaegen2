.. This work is licensed under a Creative Commons Attribution 4.0 International License.
.. http://creativecommons.org/licenses/by/4.0

Design
======

There are 4 processes created as below

Main process
------------
 
This is the initial process which does the following.

- Download CBS configuration and update the vnf_table_1
- Spawns HB worker process, DB Monitoring process and CBS polling
  process (if required)
- Periodically update the hb_common table

HB worker process
-----------------

This process is created by main process and does the following.

- It waits on the HB Json event message from DMaaP message router
- It receives the HB Json message and retrieves sourceName,
  lastEpochTime, eventName in the incoming message
- It checks for the received eventName against the eventName in
  vnf_table_1. If eventName is not matched, then it discards the
  message.
- It checks for the received sourceName in the vnf_table_2. If the
  sourceName is already there in vnf_table_2, then it updates the
  received HB Json message in vnf_table_2 against that sourceName. If
  the sourceName is not there in vnf_table_2, then it adds an entry in
  vnf_table_2 for that eventName and increments the sourceName count in
  vnf_table_1

DB Monitoring process
---------------------

This process is created by main process and does the following.

- The DB monitoring process scans through each entry of vnf_table_1 and
  looks at the corresponding vnf_table_2 and checks the condition for
  Control Loop event is met or not
- If it finds that the multiple consecutive HB are missed, it raises
  the Control Loop event.
- It also clears the control loop event by looking at recently received
  HB message.
- Because of reconfiguration procedure, some of the existing entries in
  vnf_table_1 may become invalid. DB Monitoring process would clean the
  DB by looking at validity flag maintained in each vnf_table_1 table
  entry. If not valid, it removes the entry in vnf_table_1 and also
  removes the corresponding entries of vnf_table_2.

CBS polling process
-------------------

If the local configuration file (config/hbproperties.yaml) indicates
that CBS polling is required, then main process would create the CBS 
polling process. It does the following.

- It takes the CBS polling interval from the configuration file.

- For every CBS polling interval, it sets the hb_common with state as
  reconfiguration to indicate the main process to download CBS
  configuration

CBS configuration download support
----------------------------------

Apart from the above, a function/method is provided to Docker container
that would download the CBS configuration whenever the configuration
changes. This method/function would read hb_common state and change the
state to reconfiguration.

Heartbeat Microserice Multi instance support
--------------------------------------------

In order to work smoothly in an environment having multiple HB micro
services instances, processes would work differently as mentioned below.

**Main Process:**

    Active Instance:
     - Download CBS configuration and process it
     - Spawns processes
     - Periodically update hb_common with last accessed time to indicate that active instance is Alive.
	 
    Inactive Instance:
        - Spawns processes
        - Constantly check hb_common entry for last accessed time
        - If the last accessed time is more than a minute or so, then it assumes the role of active instance 
    
**HB worker process:** Both active and inactive instance behaves the sames as metnioned in the Design section.

**DB Monitoring process:** Both active periodically checks its process ID/hostname with hb_common data to know whether it is an active instance or not. If inactive instance it does nothing. If active instance, it behaves as mentioned in design section.

**CBS Polling process:** Periodically checks its process ID/hostname with hb_common data to know whether it is an active instance or not. If inactive instance it does nothing. If active instance, it behaves as mentioned in design section.

Handling of some of the failure scenarios
-----------------------------------------

Failure to download the configuration from CBS - In this case, local
configuration file etc/config.json is considered as the configuration
file and vnf_table_1 is updated accordingly.

The Reconfiguration procedure is as below
-----------------------------------------

- If the state is Reconfiguration, then HB worker process, DB
  monitoring process and CBS polling process would wait for
  reconfiguration to complete.
- Set each entry as invalid by using validity flag in vnf_table_1
- Download the json file from CBS.
- Set the validity flag to indicate to valid when an entry is updated.

Postgres Database
-----------------

There are 3 tables maintained.

**Vnf_table_1 table:** 
This is table is indexed by eventName. Each entry
has following parameters in it.

- eventName
- Configured heartbeat Missed Count
- Configured Heartbeat Interval
- Number of SourceName having same eventName
- Validity flag that indicates VNF entry is valid or not
- It also has following parameter related to Control loop event
   - policyVersion
   - policyName
   - policyScope
   - target_type
   - target
   - closedLoopControlName
   - version

**Vnf_table_2 table:** 
For each sourceName there would be an entry in vnf_table_2. 
This is indexed by eventName and SourceName. Each entry has
below parameters

- SourceName
- Last received heartbeat epoch time
- Control loop event raised flag. 0 indicates not raised, 1 indicates
  CL event raised

**hb_common table:** 
This is a single entry table.

- The configuration status which would have one of the below.
   - **RECONFIGURATION** - indicates CBS configuration processing is in
      progress.
   - **RUNNING** - CBS configuration is completed and ready to process HB
      event and send CL event.
- The process ID - This indicates the main process ID of the active HB
  instance which is responsible to take care of reconfiguration
- The source Name - It has 2 parts, hostname and service name. The
  hostname is the Docker container ID. The service name is the
  environment variable set for SERVICE_NAME
- The last accessed time - The time last accessed by the main process
  having the above process ID.
