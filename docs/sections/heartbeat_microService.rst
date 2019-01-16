**Heartbeat Micro Service (version 2.1.0)**

The Heartbeat Micro Service’s startup script (misshtbtd.py) gets the
configuration from CBS and parses these entries and saves them in the
postgres database having table name vnf_table_1. Each entry in the
configuration is for a particular eventName. Each entry has missed
heartbeat count, heartbeat interval, Control loop name etc. along with
many other parameters. The main objective of heartbeat micro service is
to receive the periodic heartbeat from the configured eventNames and
report the loss of heartbeat onto DMaap if number of consecutive missed
heartbeat count is more than the configured missed heartbeat count in
vnf_table_1.

Whenever a heartbeat event is received, the sourceName, lastEpochTime
and other information is stored in another postgres database having
table name vnf_table_2. It is designed to process the heartbeat event
having different sourceNames having same eventName. In such case,
sourceName count is maintained in vnf_table_1 which would give number of
SouceNames that have same eventName. As and when new sourceName is
received, sourceName count is incremented in vnf_table_1

The heartbeat Micro Service is designed to support multiple instances of
HB Micro Service to run simultaneously. The first instance of the HB
Micro Service would assume the role of active instance, and instances
that started running later would become inactive instances. If the
active HB micro service is not responding or killed, the inactive HB
instance would take over the active role. To achieve this functionality,
one more postgres table hb_common is introduced which has parameters
specific to active instances such as process id/hostname of the active
instance, last accessed time updated by active instance.

Heartbeat Micro service supports the periodic download of CBS
configuration. The periodicity of download can be configured.

Heartbeat Micro service also supports the download of CBS configuration
whenever configuration changes. Here Docker container would call the
function/method to download the CBS configuration.

The heartbeat micro service has 2 states

**Reconfiguration state**– Download configuration from CBS and update
the vnf_table_1 is in progress.

**Running state** – Normal working that comprises of receiving of HB
events and sending of control loop event if required conditions are met.

**Design**

To achieve the above mentioned functionality, there are 4 processes
created as below

**Main process** – This is the initial process which does the following

-  Download CBS configuration and update the vnf_table_1

-  Spawns HB worker process, DB Monitoring process and CBS polling
   process (if required)

-  Periodically update the hb_common table

**HB worker process**

-  It waits on the HB Json event message from DMaaP message router

-  It receives the HB Json message and retrieves sourceName,
   lastEpochTime, eventName in the incoming message

-  It checks for the received eventName against the eventName in
   vnf_table_1. If eventName is not matched, then it discards the
   message.

-  It checks for the received sourceName in the vnf_table_2. If the
   sourceName is already there in vnf_table_2, then it updates the
   received HB Json message in vnf_table_2 against that sourceName. If
   the sourceName is not there in vnf_table_2, then it adds an entry in
   vnf_table_2 for that eventName and increments the sourceName count in
   vnf_table_1

**DB Monitoring process**

-  The DB monitoring process scans through each entry of vnf_table_1 and
   looks at the corresponding vnf_table_2 and checks the condition for
   Control Loop event is met or not

-  If it finds that the multiple consecutive HB are missed, it raises
   the Control Loop event.

-  It also clears the control loop event by looking at recently received
   HB message.

-  Because of reconfiguration procedure, some of the existing entries in
   vnf_table_1 may become invalid. DB Monitoring process would clean the
   DB by looking at validity flag maintained in each vnf_table_1 table
   entry. If not valid, it removes the entry in vnf_table_1 and also
   removes the corresponding entries of vnf_table_2.

**CBS polling process** - If the local configuration file
(config/hbproperties.yaml) indicates that CBS polling is required, then
main process would create the CBS polling process. It does the following

-  It takes the CBS polling interval from the configuration file.

-  For every CBS polling interval, it sets the hb_common with state as
   reconfiguration to indicate the main process to download CBS
   configuration

Apart from the above, a function/method is provided to Docker container
that would download the CBS configuration whenever the configuration
changes. This method/function would read hb_common state and change the
state to reconfiguration.

In order to work smoothly in an environment having multiple HB micro
services instances, processes would work differently as mentioned below.

Main Process:
    Active Instance:
     - Download CBS configuration and process it
     - Spawns processes
     - Periodically update hb_common with last accessed time to indicate that active instance is Alive.
    Inactive Instance
        - Spawns processes
        - Constantly check hb_common entry for last accessed time
        - If the last accessed time is more than a minute or so, then it assumes the role of active instance 
    
HB worker process: Both active and inactive instance behaves the sames as metnioned in the Design section above.

DB Monitoring process: Both active periodically checks its process ID/hostname with hb_common data to know whether it is an active instance or not. If inactive instance it does nothing. If active instance, it behaves as mentioned in design section.

CBS Polling process: Periodically checks its process ID/hostname with hb_common data to know whether it is an active instance or not. If inactive instance it does nothing. If active instance, it behaves as mentioned in design section.

**Handling of some of the failure scenarios**

Failure to download the configuration from CBS – In this case, local
configuration file etc/config.json is considered as the configuration
file and vnf_table_1 is updated accordingly.

**The Reconfiguration procedure is as below**

-  If the state is Reconfiguration, then HB worker process, DB
   monitoring process and CBS polling process would wait for
   reconfiguration to complete.

-  Set each entry as invalid by using validity flag in vnf_table_1

-  Download the json file from CBS.

-  Set the validity flag to indicate to valid when an entry is updated.

**Postgres DB**

There are 3 tables maintained.

**Vnf_table_1 table:** This is table is indexed by eventName. Each entry
has following parameters in it.

-  eventName

-  Configured heartbeat Missed Count

-  Configured Heartbeat Interval

-  Number of SourceName having same eventName

-  Validity flag that indicates VNF entry is valid or not

-  It also has following parameter related to Control loop event

   -  policyVersion

   -  policyName

   -  policyScope

   -  target_type

   -  target

   -  closedLoopControlName

   -  version

**Vnf_table_2 table:** For each sourceName there would be an entry in
vnf_table_2. This is indexed by eventName and SourceName. Each entry has
below parameters

-  SourceName

-  Last received heartbeat epoch time

-  Control loop event raised flag. 0 indicates not raised, 1 indicates
   CL event raised

**hb_common table:** This is a single entry table.

-  The configuration status

   -  “RECONFIGURATION” – indicates CBS configuration processing is in
      progress.

   -  “RUNNING” – CBS configuration is completed and ready to process HB
      event and send CL event.

-  The process ID – This indicates the main process ID of the active HB
   instance which is responsible to take care of reconfiguration

-  The source Name – It has 2 parts, hostname and service name. The
   hostname is the Docker container ID. The service name is the
   environment variable set for SERVICE_NAME

-  The last accessed time – The time last accessed by the main process
   having the above process ID.

**Build and Test procedure**

**ONAP Repository**

   https://gerrit.onap.org/r/gitweb?p=dcaegen2/services/heartbeat.git;a=tree;hb=20110ffeb5071193e7b437e797636d9d6318dcd4

**POD 25 access**

   To run heartbeat Micro Service in development environment, POD25
   access is required. Please get the access and install Openvpn.

   Connect to POD25 setup using Openvpn and the credentials obtained.

**[1] Docker build procedure**

(1.a) Clone the code using below command

*git clone https://gerrit.onap.org/r/dcaegen2/services/heartbeat*

(1.b) give executable permission to mvn-phase-script.sh if not there
already

*chmod +x mvn-phase-script.sh*

(1.c) Setting up the postgres DB, group/consumer IDs, CBS download and
CBS polling. The following environment variables are to be set.

   For postgres and CBS download, the environment setting file to be
   passed while running the Docker. The file would contain following
   parameters. The sample values are shown for reference.

   *pg_ipAddress=10.0.4.1*

   *pg_portNum=5432*

   *pg_userName=postgres*

   *pg_passwd=abc*

   *#Below parameters for CBS download*

   *SERVICE_NAME=mvp-dcaegen2-heartbeat-static*

   *CONSUL_HOST=10.12.6.50*

   *HOSTNAME=mvp-dcaegen2-heartbeat-static*

   *#Below parameter for heartbeat worker process to receive message*

   *groupID=group1*

   *consumerID=1*

   If the postgres parameters are not there in environment setting file,
   then it takes the values from
   miss_htbt_service/config/hbproperties.yaml file. Make sure that
   postgres running in the machine where pg_ipAddress parameter is
   mentioned. Run below netstat command to check postgres port number
   and IP address are fine.

   *netstat -ant*

   If CBS parameters are not there in the environment setting file, then
   local config file (etc/config.json) is considered as a default
   configuration file.

   For CBS polling CBS_polling_allowed & CBS_polling_interval to be set
   appropriately in miss_htbt_service/config/hbproperties.yaml file

   The sample values in miss_htbt_service/config/hbproperties.yaml file
   are as follows

   *pg_ipAddress: 10.0.4.1*

   *pg_portNum: 5432*

   *pg_userName: postgres*

   *pg_passwd: postgres*

   *pg_dbName: hb_vnf*

   *CBS_polling_allowed: True*

   *CBS_polling_interval: 300*

   PS: Change the groupID and consumerID in the environment accordingly
   for each HB instance so that HB worker process receive the HB event
   correctly. Usually groupID remains the same for all instance of HB
   where as consumerID would be changed for each instance of HB Micro
   service. If groupID and consumerID is not provided, then it takes
   “DefaultGroup” and “1” respectively.

(1.d) Setting CBS configuration parameters using the consule KV URL.

   The sample consul KV is as below.

   *Consul KV
   -*\ http://10.12.6.50:8500/ui/#/dc1/kv/mvp-dcaegen2-heartbeat-static

   Go to the above link and click on KEY/VALUE tab

   Click on mvp-dcaegen2-heartbeat-static

   Copy the configuration in the box provided and click on update. The
   sample configuration is as below in the config.json

(1.e) Build the Docker using below command with image name as
heartbeat.test1:latest

   *sudo Docker build --no-cache --network=host -f ./Dockerfile -t
   heartbeat.test1:latest .*

   To check whether image is built or not, run below command

   *sudo Docker images \|grep heartbeat.test1*

(1.f) Run the Docker using below command which uses the environment file
mentioned in (1.c)

   *sudo Docker run -d --name hb1 --env-file env.list
   heartbeat.test1:latest*

   To check the logs, run below command

   *sudo Docker logs -f hb1*

(1.g) To stop the Docker run

   Get the Docker container ID from below command

   *sudo Docker ps -a \| grep heartbeat.test1*

   Run below commands to stop the Docker run

   *sudo Docker stop <Docker container ID)*

   *sudo Docker rm -f hb1*

   See the attached file for few test cases run on Docker build

**[2] Running maven build**

(2.a) give executable permission to mvn-phase-script.sh if not there
already

*chmod +x mvn-phase-script.sh*

(2.b) Initiate the maven build

   To run the maven build, execute any one of them.

   *sudo mvn -s settings.xml deploy*

   *sudo mvn -s settings.xml -X deploy*

   If there is a libxml-xpath related issue, then install the
   libxml-xpath as below. If the issue is something else, follow the
   link given as part of the build failure.

   *sudo apt install libxml-xpath-perl*

**[3] Running local build**

(2.a) See the requirements.txt file and install all necessary packages.
The requirements.txt has following parameters.

   request==1.0.1

   requests==2.18.3

   onap_dcae_cbs_docker_client==1.0.1

   six==1.10.0

   PyYAML==3.12

   httplib2==0.9.2

   HTTPretty==0.8.14

   pyOpenSSL==17.5.0

   Wheel==0.31.0

   psycopg2==2.7.6.1

(2.b) Setting postgres DB

   Update miss_htbt_service/config/hbproperties.yaml file with correct
   postgres DB.

(2.c) Make sure to have etc/config.json which would be considered as
configuration file

(2.d) Run the local version using below command

   *python3.6 misshtbtd.py*

**[4] Postgres DB access**

(4.a) Login into postgres DB

   Run below commands to login into postgres DB and connect to HB Micro
   service DB.

   sudo su postgres

   psql

   \\l hb_vnf

   Sample output is as below

   ubuntu@r3-dcae:~$ sudo su postgres

   postgres@r3-dcae:/home/ubuntu$ psql

   psql (9.5.14)

   Type "help" for help.

   postgres=# \\l

   List of databases

   Name \| Owner \| Encoding \| Collate \| Ctype \| Access privileges

   -----------+----------+----------+-------------+-------------+-----------------------

   hb_vnf \| postgres \| UTF8 \| en_US.UTF-8 \| en_US.UTF-8 \|

   postgres \| postgres \| UTF8 \| en_US.UTF-8 \| en_US.UTF-8 \|

   template0 \| postgres \| UTF8 \| en_US.UTF-8 \| en_US.UTF-8 \|
   =c/postgres +

   \| \| \| \| \| postgres=CTc/postgres

   template1 \| postgres \| UTF8 \| en_US.UTF-8 \| en_US.UTF-8 \|
   =c/postgres +

   \| \| \| \| \| postgres=CTc/postgres

   (4 rows)

   postgres=# \\c hb_vnf

   You are now connected to database "hb_vnf" as user "postgres".

   hb_vnf=#

(4.b) Delete all tables before starting Docker run or local run

   After login into postgres and connect to hb_vnf as mentioned in
   (4.a), use below commands to delete the tables if exists

   *DROP TABLE vnf_table_1;*

   *DROP TABLE vnf_table_2;*

   *DROP TABLE hb_common;*

   The sample output is as below

   hb_vnf=# DROP TABLE vnf_table_1;

   DROP TABLE

   hb_vnf=# DROP TABLE vnf_table_2;

   DROP TABLE

   hb_vnf=# DROP TABLE hb_common;

   DROP TABLE

   hb_vnf=#

(4.c) Use select command to check the contents of vnf_table_1,
vnf_table_2 and hb_common

   SELECT \* FROM vnf_table_1;

   SELECT \* FROM vnf_table_2;

   SELECT \* FROM hb_common;

   The sample output is as below

   *hb_vnf=# SELECT \* FROM vnf_table_1;*

   *event_name \| heartbeat_missed_count \| heartbeat_interval \|
   closed_control_loop_name \| policy_version \| policy_name \|
   policy_scope \| target_type \| target \| version \| source_name_count
   \| validity_flag*

   *---------------+------------------------+--------------------+--------------------------+----------------+-------------+-------------------------------------------------------------+-------------+------------+---------+-------------------+---------------*

   *Heartbeat_S \| 4 \| 60 \| ControlLoopEvent1 \| 1.0.0.5 \| vFireWall
   \| resource=sampleResource,type=sampletype,CLName=sampleCLName \| VM
   \| genVnfName \| 2.0 \| 0 \| 1*

   *Heartbeat_vFW \| 4 \| 50 \| ControlLoopEvent1 \| 1.0.0.5 \|
   vFireWall \|
   resource=sampleResource,type=sampletype,CLName=sampleCLName \| VNF \|
   genVnfName \| 2.0 \| 0 \| 1*

   *(2 rows)*

   *hb_vnf=# SELECT \* FROM vnf_table_2;*

   *event_name \| source_name_key \| last_epo_time \| source_name \|
   cl_flag*

   *---------------+-----------------+---------------+--------------+---------*

   *Heartbeat_vFW \| 1 \| 1544705272479 \| SOURCE_NAME1 \| 0*

   *(1 row)*

   *hb_vnf=#*

   *hb_vnf=# SELECT \* FROM hb_common;*

   *process_id \| source_name \| last_accessed_time \| current_state*

   *------------+--------------------------------------------+--------------------+---------------*

   *8 \| 21d744ae8cd5-mvp-dcaegen2-heartbeat-static \| 1544710271 \|
   RUNNING*

   *(1 row)*

   *hb_vnf=#*

**[5] Injecting event into HB micro service**

   Once after starting the Docker run or local run, below commands run
   from tests/ directory would send event to HB worker process

   *curl -i -X POST -d {"test":"msg"} --header "Content-Type:
   application/json"
   http://10.12.5.252:3904/events/unauthenticated.SEC_HEARTBEAT_INPUT*

   *curl -i -X POST -d @test1.json --header "Content-Type:
   application/json"
   http://10.12.5.252:3904/events/unauthenticated.SEC_HEARTBEAT_INPUT*

   *curl -i -X POST -d @test2.json --header "Content-Type:
   application/json"
   http://10.12.5.252:3904/events/unauthenticated.SEC_HEARTBEAT_INPUT*

   *curl -i -X POST -d @test3.json --header "Content-Type:
   application/json"
   http://10.12.5.252:3904/events/unauthenticated.SEC_HEARTBEAT_INPUT*

   The sample output is as below

   ubuntu@r3-aai-inst2:~/heartbeat12Dec/heartbeat/tests$ **curl -i -X
   POST -d @test1.json --header "Content-Type: application/json"
   http://10.12.5.252:3904/events/unauthenticated.SEC_HEARTBEAT_INPUT**

   HTTP/1.1 200 OK

   Date: Wed, 12 Dec 2018 12:41:26 GMT

   Content-Type: application/json

   Accept: \*/\*

   breadcrumbId: ID-22f076777975-37104-1543559663227-0-563929

   User-Agent: curl/7.47.0

   X-CSI-Internal-WriteableRequest: true

   Content-Length: 41

   Server: Jetty(9.3.z-SNAPSHOT)

   {

   "serverTimeMs": 0,

   "count": 1

   }

   curl -i -X POST -d @test1.json --header "Content-Type:
   application/json"
   http://10.12.5.252:3904/events/unauthenticated.SEC_HEARTBEAT_INPUT

   ubuntu@r3-aai-inst2:~/heartbeat12Dec/heartbeat/tests$ **curl -i -X
   POST -d @test2.json --header "Contet-Type: application/json"
   http://10.12.5.252:3904/events/unauthenticated.SEC_HEARTBEAT_INPUT**

   HTTP/1.1 200 OK

   Date: Wed, 12 Dec 2018 12:41:39 GMT

   Content-Type: application/json

   Accept: \*/\*

   breadcrumbId: ID-22f076777975-37104-1543559663227-0-563937

   User-Agent: curl/7.47.0

   X-CSI-Internal-WriteableRequest: true

   Content-Length: 41

   Server: Jetty(9.3.z-SNAPSHOT)

   {

   "serverTimeMs": 0,

   "count": 1

   }

   ubuntu@r3-aai-inst2:~/heartbeat12Dec/heartbeat/tests$ **curl -i -X
   POST -d @test3.json --header "Contet-Type: application/json"
   http://10.12.5.252:3904/events/unauthenticated.SEC_HEARTBEAT_INPUT**

   HTTP/1.1 200 OK

   Date: Wed, 12 Dec 2018 12:41:39 GMT

   Content-Type: application/json

   Accept: \*/\*

   breadcrumbId: ID-22f076777975-37104-1543559663227-0-563937

   User-Agent: curl/7.47.0

   X-CSI-Internal-WriteableRequest: true

   Content-Length: 41

   Server: Jetty(9.3.z-SNAPSHOT)

   {

   "serverTimeMs": 0,

   "count": 1

   }

**[6] Testing Control loop event**

(6.a) Modify the Json as below

Modify the lastEpochTime and startEpochTime with current time in
Test1.json

Modify the eventName in Test1.json to one of the eventName in
vnf_table_1

(6.b) Inject the Test1.json as mentioned in [5]

(6.c) Get missed heartbeat count (for e.g 3) and heartbeat interval (for
e.g. 60 seconds) for the eventName from vnf_table_1. Wait for heartbeat
to miss multiple time, i.e. 3 \* 60seconds = 180 seconds.

   After waiting for the specified period, you would see the control
   loop event. The sample one is as below.

   *2018-12-13 12:51:13,016 \| \__main_\_ \| db_monitoring \|
   db_monitoring \| 95 \| INFO \| ('DBM:Time to raise Control Loop Event
   for target type - ', 'VNF')*

   *2018-12-13 12:51:13,016 \| \__main_\_ \| db_monitoring \|
   db_monitoring \| 132 \| INFO \| ('DBM: CL Json object is',
   '{"closedLoopEventClient": "DCAE_Heartbeat_MS", "policyVersion":
   "1.0.0.5", "policyName": "vFireWall", "policyScope":
   "resource=sampleResource,type=sampletype,CLName=sampleCLName",
   "target_type": "VNF", "AAI": {"generic-vnf.vnf-name":
   "SOURCE_NAME1"}, "closedLoopAlarmStart": 1544705473016,
   "closedLoopEventStatus": "ONSET", "closedLoopControlName":
   "ControlLoopEvent1", "version": "2.0", "target": "genVnfName",
   "requestID": "8c1b8bd8-06f7-493f-8ed7-daaa4cc481bc", "from":
   "DCAE"}')*

   The postgres DB also have a CL_flag set indicating control loop event
   with ONSET is raised.

   *hb_vnf=# SELECT \* FROM vnf_table_2;*

   *event_name \| source_name_key \| last_epo_time \| source_name \|
   cl_flag*

   *---------------+-----------------+---------------+--------------+---------*

   *Heartbeat_vFW \| 1 \| 1544705272479 \| SOURCE_NAME1 \| 1*

   *(1 row)*

   *hb_vnf=#*

[7] The sample log for 5 minutes from startup is as below.

ubuntu@r3-aai-inst2:~/heartbeat12Dec/heartbeat$ sudo Docker run -d
--name hb1 --env-file env.list
heartbeat.test1:latest102413e8af4ab754e008cee43a01bf3d5439820aa91cfb4e099a140a7931fd71

ubuntu@r3-aai-inst2:~/heartbeat12Dec/heartbeat$ sudo Docker logs -f hb1

/usr/local/lib/python3.6/site-packages/psycopg2/__init__.py:144:
UserWarning: The psycopg2 wheel package will be renamed from release
2.8; in order to keep installing from binary please use "pip install
psycopg2-binary" instead. For details see:
<http://initd.org/psycopg/docs/install.html#binary-install-from-pypi>.

""")

2018-12-12 12:39:58,968 \| \__main_\_ \| misshtbtd \| main \| 309 \|
INFO \| MSHBD:Execution Started

2018-12-12 12:39:58,970 \| \__main_\_ \| misshtbtd \| main \| 314 \|
INFO \| ('MSHBT:HB Properties -', '10.0.4.1', '5432', 'postgres', 'abc',
'hb_vnf', True, 300)

2018-12-12 12:39:58,970 \| onap_dcae_cbs_docker_client.client \| client
\| \_get_uri_from_consul \| 36 \| DEBUG \| Trying to lookup service:
http://10.12.6.50:8500/v1/catalog/service/config_binding_service

2018-12-12 12:39:58,974 \| urllib3.connectionpool \| connectionpool \|
\_new_conn \| 208 \| DEBUG \| Starting new HTTP connection (1):
10.12.6.50

2018-12-12 12:39:58,976 \| urllib3.connectionpool \| connectionpool \|
\_make_request \| 396 \| DEBUG \| http://10.12.6.50:8500 "GET
/v1/catalog/service/config_binding_service HTTP/1.1" 200 375

2018-12-12 12:39:58,979 \| urllib3.connectionpool \| connectionpool \|
\_new_conn \| 208 \| DEBUG \| Starting new HTTP connection (1):
10.12.6.50

2018-12-12 12:39:58,988 \| urllib3.connectionpool \| connectionpool \|
\_make_request \| 396 \| DEBUG \| http://10.12.6.50:10000 "GET
/service_component/mvp-dcaegen2-heartbeat-static HTTP/1.1" 200 1015

2018-12-12 12:39:58,989 \| onap_dcae_cbs_docker_client.client \| client
\| \_get_path \| 83 \| INFO \| get_config returned the following
configuration: {"heartbeat_config": {"vnfs": [{"eventName":
"Heartbeat_S", "heartbeatcountmissed": 3, "heartbeatinterval": 60,
"closedLoopControlName": "ControlLoopEvent1", "policyVersion":
"1.0.0.5", "policyName": "vFireWall", "policyScope":
"resource=sampleResource,type=sampletype,CLName=sampleCLName",
"target_type": "VM", "target": "genVnfName", "version": "2.0"},
{"eventName": "Heartbeat_vFW", "heartbeatcountmissed": 3,
"heartbeatinterval": 60, "closedLoopControlName": "ControlLoopEvent1",
"policyVersion": "1.0.0.5", "policyName": "vFireWall", "policyScope":
"resource=sampleResource,type=sampletype,CLName=sampleCLName",
"target_type": "VNF", "target": "genVnfName", "version": "2.0"}]},
"streams_publishes": {"ves_heartbeat": {"dmaap_info": {"topic_url":
"http://10.12.5.252:3904/events/unauthenticated.DCAE_CL_OUTPUT/"},
"type": "message_router"}}, "streams_subscribes": {"ves_heartbeat":
{"dmaap_info": {"topic_url":
"http://10.12.5.252:3904/events/unauthenticated.SEC_HEARTBEAT_INPUT/"},
"type": "message_router"}}}

2018-12-12 12:39:58,989 \| \__main_\_ \| misshtbtd \| fetch_json_file \|
254 \| INFO \| MSHBD:current config logged to : ../etc/download.json

2018-12-12 12:39:58,996 \| \__main_\_ \| misshtbtd \| fetch_json_file \|
272 \| INFO \| ('MSHBT: The json file is - ', '../etc/config.json')

2018-12-12 12:39:59,028 \| \__main_\_ \| misshtbtd \| create_database \|
79 \| INFO \| ('MSHBT:Create_database:DB not exists? ', (False,))

2018-12-12 12:39:59,030 \| \__main_\_ \| misshtbtd \| create_database \|
86 \| INFO \| MSHBD:Database already exists

2018-12-12 12:39:59,032 \| \__main_\_ \| misshtbtd \| create_update_db
\| 281 \| INFO \| ('MSHBT: DB parameters -', '10.0.4.1', '5432',
'postgres', 'abc', 'hb_vnf')

2018-12-12 12:39:59,099 \| \__main_\_ \| misshtbtd \| main \| 325 \|
INFO \| ('MSHBD:Current process id is', 7)

2018-12-12 12:39:59,099 \| \__main_\_ \| misshtbtd \| main \| 326 \|
INFO \| MSHBD:Now be in a continuous loop

2018-12-12 12:39:59,111 \| \__main_\_ \| misshtbtd \| main \| 331 \|
INFO \| ('MSHBT: hb_common values ', 6, 'RUNNING',
'8909e4332e34-mvp-dcaegen2-heartbeat-static', 1544618286)

2018-12-12 12:39:59,111 \| \__main_\_ \| misshtbtd \| main \| 335 \|
INFO \| ('MSHBD:pid,srcName,state,time,ctime,timeDiff is', 6,
'8909e4332e34-mvp-dcaegen2-heartbeat-static', 'RUNNING', 1544618286,
1544618399, 113)

2018-12-12 12:39:59,111 \| \__main_\_ \| misshtbtd \| main \| 378 \|
INFO \| MSHBD:Active instance is inactive for long time: Time to
switchover

2018-12-12 12:39:59,111 \| \__main_\_ \| misshtbtd \| main \| 380 \|
INFO \| MSHBD:Initiating to become Active Instance

2018-12-12 12:39:59,111 \| onap_dcae_cbs_docker_client.client \| client
\| \_get_uri_from_consul \| 36 \| DEBUG \| Trying to lookup service:
http://10.12.6.50:8500/v1/catalog/service/config_binding_service

2018-12-12 12:39:59,114 \| urllib3.connectionpool \| connectionpool \|
\_new_conn \| 208 \| DEBUG \| Starting new HTTP connection (1):
10.12.6.50

2018-12-12 12:39:59,118 \| urllib3.connectionpool \| connectionpool \|
\_make_request \| 396 \| DEBUG \| http://10.12.6.50:8500 "GET
/v1/catalog/service/config_binding_service HTTP/1.1" 200 375

2018-12-12 12:39:59,120 \| urllib3.connectionpool \| connectionpool \|
\_new_conn \| 208 \| DEBUG \| Starting new HTTP connection (1):
10.12.6.50

2018-12-12 12:39:59,129 \| urllib3.connectionpool \| connectionpool \|
\_make_request \| 396 \| DEBUG \| http://10.12.6.50:10000 "GET
/service_component/mvp-dcaegen2-heartbeat-static HTTP/1.1" 200 1015

2018-12-12 12:39:59,129 \| onap_dcae_cbs_docker_client.client \| client
\| \_get_path \| 83 \| INFO \| get_config returned the following
configuration: {"heartbeat_config": {"vnfs": [{"eventName":
"Heartbeat_S", "heartbeatcountmissed": 3, "heartbeatinterval": 60,
"closedLoopControlName": "ControlLoopEvent1", "policyVersion":
"1.0.0.5", "policyName": "vFireWall", "policyScope":
"resource=sampleResource,type=sampletype,CLName=sampleCLName",
"target_type": "VM", "target": "genVnfName", "version": "2.0"},
{"eventName": "Heartbeat_vFW", "heartbeatcountmissed": 3,
"heartbeatinterval": 60, "closedLoopControlName": "ControlLoopEvent1",
"policyVersion": "1.0.0.5", "policyName": "vFireWall", "policyScope":
"resource=sampleResource,type=sampletype,CLName=sampleCLName",
"target_type": "VNF", "target": "genVnfName", "version": "2.0"}]},
"streams_publishes": {"ves_heartbeat": {"dmaap_info": {"topic_url":
"http://10.12.5.252:3904/events/unauthenticated.DCAE_CL_OUTPUT/"},
"type": "message_router"}}, "streams_subscribes": {"ves_heartbeat":
{"dmaap_info": {"topic_url":
"http://10.12.5.252:3904/events/unauthenticated.SEC_HEARTBEAT_INPUT/"},
"type": "message_router"}}}

2018-12-12 12:39:59,129 \| \__main_\_ \| misshtbtd \| fetch_json_file \|
254 \| INFO \| MSHBD:current config logged to : ../etc/download.json

2018-12-12 12:39:59,139 \| \__main_\_ \| misshtbtd \| fetch_json_file \|
272 \| INFO \| ('MSHBT: The json file is - ', '../etc/config.json')

2018-12-12 12:39:59,139 \| \__main_\_ \| misshtbtd \| main \| 386 \|
INFO \| ('MSHBD: Creating HB and DBM threads. The param pssed %d and
%s', '../etc/config.json', 7)

2018-12-12 12:39:59,142 \| \__main_\_ \| misshtbtd \| create_process \|
301 \| INFO \| ('MSHBD:jobs list is', [<Process(Process-2, started)>,
<Process(Process-3, started)>])

2018-12-12 12:39:59,221 \| \__main_\_ \| misshtbtd \|
create_update_hb_common \| 143 \| INFO \| MSHBT:Updated hb_common DB
with new values

/usr/local/lib/python3.6/site-packages/psycopg2/__init__.py:144:
UserWarning: The psycopg2 wheel package will be renamed from release
2.8; in order to keep installing from binary please use "pip install
psycopg2-binary" instead. For details see:
<http://initd.org/psycopg/docs/install.html#binary-install-from-pypi>.

""")

2018-12-12 12:39:59,815 \| \__main_\_ \| htbtworker \| <module> \| 243
\| INFO \| HBT:HeartBeat thread Created

2018-12-12 12:39:59,815 \| \__main_\_ \| htbtworker \| <module> \| 245
\| INFO \| ('HBT:The config file name passed is -%s',
'../etc/config.json')

/usr/local/lib/python3.6/site-packages/psycopg2/__init__.py:144:
UserWarning: The psycopg2 wheel package will be renamed from release
2.8; in order to keep installing from binary please use "pip install
psycopg2-binary" instead. For details see:
<http://initd.org/psycopg/docs/install.html#binary-install-from-pypi>.

""")

2018-12-12 12:39:59,931 \| \__main_\_ \| cbs_polling \| pollCBS \| 39 \|
INFO \| ('CBSP:Main process ID in hb_common is %d', 7)

2018-12-12 12:39:59,931 \| \__main_\_ \| cbs_polling \| pollCBS \| 41 \|
INFO \| ('CBSP:My parent process ID is %d', '7')

2018-12-12 12:39:59,931 \| \__main_\_ \| cbs_polling \| pollCBS \| 43 \|
INFO \| ('CBSP:CBS Polling interval is %d', 300)

/usr/local/lib/python3.6/site-packages/psycopg2/__init__.py:144:
UserWarning: The psycopg2 wheel package will be renamed from release
2.8; in order to keep installing from binary please use "pip install
psycopg2-binary" instead. For details see:
<http://initd.org/psycopg/docs/install.html#binary-install-from-pypi>.

""")

2018-12-12 12:39:59,937 \| \__main_\_ \| db_monitoring \| <module> \|
231 \| INFO \| DBM: DBM Process started

2018-12-12 12:39:59,939 \| \__main_\_ \| db_monitoring \| <module> \|
236 \| INFO \| ('DBM:Parent process ID and json file name', '7',
'../etc/config.json')

2018-12-12 12:40:09,860 \| \__main_\_ \| htbtworker \| process_msg \| 71
\| INFO \| ('\n\nHBT:eventnameList values ', ['Heartbeat_S',
'Heartbeat_vFW'])

2018-12-12 12:40:09,860 \| \__main_\_ \| htbtworker \| process_msg \| 77
\| INFO \| HBT:Getting
:http://10.12.5.252:3904/events/unauthenticated.SEC_HEARTBEAT_INPUT/group1/1?timeout=15000

2018-12-12 12:40:09,864 \| urllib3.connectionpool \| connectionpool \|
\_new_conn \| 208 \| DEBUG \| Starting new HTTP connection (1):
10.12.5.252

2018-12-12 12:40:19,968 \| \__main_\_ \| db_monitoring \| db_monitoring
\| 53 \| INFO \| DBM: Active DB Monitoring Instance

2018-12-12 12:40:24,259 \| \__main_\_ \| misshtbtd \| main \| 331 \|
INFO \| ('MSHBT: hb_common values ', 7, 'RUNNING',
'102413e8af4a-mvp-dcaegen2-heartbeat-static', 1544618399)

2018-12-12 12:40:24,260 \| \__main_\_ \| misshtbtd \| main \| 335 \|
INFO \| ('MSHBD:pid,srcName,state,time,ctime,timeDiff is', 7,
'102413e8af4a-mvp-dcaegen2-heartbeat-static', 'RUNNING', 1544618399,
1544618424, 25)

2018-12-12 12:40:24,260 \| \__main_\_ \| misshtbtd \| main \| 351 \|
INFO \| ('MSHBD:config status is', 'RUNNING')

2018-12-12 12:40:24,267 \| \__main_\_ \| misshtbtd \|
create_update_hb_common \| 143 \| INFO \| MSHBT:Updated hb_common DB
with new values

2018-12-12 12:40:24,810 \| urllib3.connectionpool \| connectionpool \|
\_make_request \| 396 \| DEBUG \| http://10.12.5.252:3904 "GET
/events/unauthenticated.SEC_HEARTBEAT_INPUT/group1/1?timeout=15000
HTTP/1.1" 200 2

2018-12-12 12:40:24,812 \| \__main_\_ \| htbtworker \| process_msg \| 92
\| INFO \| ('HBT:', '[]')

2018-12-12 12:40:34,837 \| \__main_\_ \| htbtworker \| process_msg \| 71
\| INFO \| ('\n\nHBT:eventnameList values ', ['Heartbeat_S',
'Heartbeat_vFW'])

2018-12-12 12:40:34,838 \| \__main_\_ \| htbtworker \| process_msg \| 77
\| INFO \| HBT:Getting
:http://10.12.5.252:3904/events/unauthenticated.SEC_HEARTBEAT_INPUT/group1/1?timeout=15000

2018-12-12 12:40:34,839 \| urllib3.connectionpool \| connectionpool \|
\_new_conn \| 208 \| DEBUG \| Starting new HTTP connection (1):
10.12.5.252

2018-12-12 12:40:39,994 \| \__main_\_ \| db_monitoring \| db_monitoring
\| 53 \| INFO \| DBM: Active DB Monitoring Instance

2018-12-12 12:40:49,304 \| \__main_\_ \| misshtbtd \| main \| 331 \|
INFO \| ('MSHBT: hb_common values ', 7, 'RUNNING',
'102413e8af4a-mvp-dcaegen2-heartbeat-static', 1544618424)

2018-12-12 12:40:49,304 \| \__main_\_ \| misshtbtd \| main \| 335 \|
INFO \| ('MSHBD:pid,srcName,state,time,ctime,timeDiff is', 7,
'102413e8af4a-mvp-dcaegen2-heartbeat-static', 'RUNNING', 1544618424,
1544618449, 25)

2018-12-12 12:40:49,304 \| \__main_\_ \| misshtbtd \| main \| 351 \|
INFO \| ('MSHBD:config status is', 'RUNNING')

2018-12-12 12:40:49,314 \| \__main_\_ \| misshtbtd \|
create_update_hb_common \| 143 \| INFO \| MSHBT:Updated hb_common DB
with new values

2018-12-12 12:40:49,681 \| urllib3.connectionpool \| connectionpool \|
\_make_request \| 396 \| DEBUG \| http://10.12.5.252:3904 "GET
/events/unauthenticated.SEC_HEARTBEAT_INPUT/group1/1?timeout=15000
HTTP/1.1" 200 2

2018-12-12 12:40:49,682 \| \__main_\_ \| htbtworker \| process_msg \| 92
\| INFO \| ('HBT:', '[]')

2018-12-12 12:40:59,719 \| \__main_\_ \| htbtworker \| process_msg \| 71
\| INFO \| ('\n\nHBT:eventnameList values ', ['Heartbeat_S',
'Heartbeat_vFW'])

2018-12-12 12:40:59,720 \| \__main_\_ \| htbtworker \| process_msg \| 77
\| INFO \| HBT:Getting
:http://10.12.5.252:3904/events/unauthenticated.SEC_HEARTBEAT_INPUT/group1/1?timeout=15000

2018-12-12 12:40:59,721 \| urllib3.connectionpool \| connectionpool \|
\_new_conn \| 208 \| DEBUG \| Starting new HTTP connection (1):
10.12.5.252

2018-12-12 12:41:00,036 \| \__main_\_ \| db_monitoring \| db_monitoring
\| 53 \| INFO \| DBM: Active DB Monitoring Instance

2018-12-12 12:41:00,225 \| urllib3.connectionpool \| connectionpool \|
\_make_request \| 396 \| DEBUG \| http://10.12.5.252:3904 "GET
/events/unauthenticated.SEC_HEARTBEAT_INPUT/group1/1?timeout=15000
HTTP/1.1" 200 22

2018-12-12 12:41:00,226 \| \__main_\_ \| htbtworker \| process_msg \| 92
\| INFO \| ('HBT:', '["{\\"test\\":\\"msg\\"}"]')

2018-12-12 12:41:00,226 \| \__main_\_ \| htbtworker \| process_msg \|
122 \| ERROR \| ('HBT message process error - ', KeyError('event',))

2018-12-12 12:41:10,255 \| \__main_\_ \| htbtworker \| process_msg \| 71
\| INFO \| ('\n\nHBT:eventnameList values ', ['Heartbeat_S',
'Heartbeat_vFW'])

2018-12-12 12:41:10,255 \| \__main_\_ \| htbtworker \| process_msg \| 77
\| INFO \| HBT:Getting
:http://10.12.5.252:3904/events/unauthenticated.SEC_HEARTBEAT_INPUT/group1/1?timeout=15000

2018-12-12 12:41:10,256 \| urllib3.connectionpool \| connectionpool \|
\_new_conn \| 208 \| DEBUG \| Starting new HTTP connection (1):
10.12.5.252

2018-12-12 12:41:14,350 \| \__main_\_ \| misshtbtd \| main \| 331 \|
INFO \| ('MSHBT: hb_common values ', 7, 'RUNNING',
'102413e8af4a-mvp-dcaegen2-heartbeat-static', 1544618449)

2018-12-12 12:41:14,350 \| \__main_\_ \| misshtbtd \| main \| 335 \|
INFO \| ('MSHBD:pid,srcName,state,time,ctime,timeDiff is', 7,
'102413e8af4a-mvp-dcaegen2-heartbeat-static', 'RUNNING', 1544618449,
1544618474, 25)

2018-12-12 12:41:14,350 \| \__main_\_ \| misshtbtd \| main \| 351 \|
INFO \| ('MSHBD:config status is', 'RUNNING')

2018-12-12 12:41:14,359 \| \__main_\_ \| misshtbtd \|
create_update_hb_common \| 143 \| INFO \| MSHBT:Updated hb_common DB
with new values

2018-12-12 12:41:20,075 \| \__main_\_ \| db_monitoring \| db_monitoring
\| 53 \| INFO \| DBM: Active DB Monitoring Instance

2018-12-12 12:41:25,193 \| urllib3.connectionpool \| connectionpool \|
\_make_request \| 396 \| DEBUG \| http://10.12.5.252:3904 "GET
/events/unauthenticated.SEC_HEARTBEAT_INPUT/group1/1?timeout=15000
HTTP/1.1" 200 2

2018-12-12 12:41:25,193 \| \__main_\_ \| htbtworker \| process_msg \| 92
\| INFO \| ('HBT:', '[]')

2018-12-12 12:41:35,222 \| \__main_\_ \| htbtworker \| process_msg \| 71
\| INFO \| ('\n\nHBT:eventnameList values ', ['Heartbeat_S',
'Heartbeat_vFW'])

2018-12-12 12:41:35,222 \| \__main_\_ \| htbtworker \| process_msg \| 77
\| INFO \| HBT:Getting
:http://10.12.5.252:3904/events/unauthenticated.SEC_HEARTBEAT_INPUT/group1/1?timeout=15000

2018-12-12 12:41:35,223 \| urllib3.connectionpool \| connectionpool \|
\_new_conn \| 208 \| DEBUG \| Starting new HTTP connection (1):
10.12.5.252

2018-12-12 12:41:35,838 \| urllib3.connectionpool \| connectionpool \|
\_make_request \| 396 \| DEBUG \| http://10.12.5.252:3904 "GET
/events/unauthenticated.SEC_HEARTBEAT_INPUT/group1/1?timeout=15000
HTTP/1.1" 200 662

2018-12-12 12:41:35,839 \| \__main_\_ \| htbtworker \| process_msg \| 92
\| INFO \| ('HBT:',
'["{\\"event\\":{\\"commonEventHeader\\":{\\"startEpochMicrosec\\":1548313727714,\\"sourceId\\":\\"VNFA_SRC1\\",\\"eventId\\":\\"mvfs10\\",\\"nfcNamingCode\\":\\"VNFA\\",\\"timeZoneOffset\\":\\"UTC-05:30\\",\\"reportingEntityId\\":\\"cc305d54-75b4-431b-adb2-eb6b9e541234\\",\\"eventType\\":\\"platform\\",\\"priority\\":\\"Normal\\",\\"version\\":\\"4.0.2\\",\\"reportingEntityName\\":\\"ibcx0001vm002oam001\\",\\"sequence\\":1000,\\"domain\\":\\"heartbeat\\",\\"lastEpochMicrosec\\":1548313727714,\\"eventName\\":\\"Heartbeat_vDNS\\",\\"vesEventListenerVersion\\":\\"7.0.2\\",\\"sourceName\\":\\"SOURCE_NAME1\\",\\"nfNamingCode\\":\\"VNFA\\"},\\"heartbeatFields\\":{\\"heartbeatInterval\\":20,\\"heartbeatFieldsVersion\\":\\"3.0\\"}}}"]')

2018-12-12 12:41:35,839 \| \__main_\_ \| htbtworker \| process_msg \|
125 \| INFO \| ('HBT:Newly received HB event values ::',
'Heartbeat_vDNS', 1548313727714, 'SOURCE_NAME1')

2018-12-12 12:41:35,842 \| \__main_\_ \| htbtworker \| process_msg \|
132 \| INFO \| HBT:vnf_table_2 is already there

2018-12-12 12:41:35,842 \| \__main_\_ \| htbtworker \| process_msg \|
183 \| INFO \| HBT:eventName is not being monitored, Igonoring JSON
message

2018-12-12 12:41:39,407 \| \__main_\_ \| misshtbtd \| main \| 331 \|
INFO \| ('MSHBT: hb_common values ', 7, 'RUNNING',
'102413e8af4a-mvp-dcaegen2-heartbeat-static', 1544618474)

2018-12-12 12:41:39,407 \| \__main_\_ \| misshtbtd \| main \| 335 \|
INFO \| ('MSHBD:pid,srcName,state,time,ctime,timeDiff is', 7,
'102413e8af4a-mvp-dcaegen2-heartbeat-static', 'RUNNING', 1544618474,
1544618499, 25)

2018-12-12 12:41:39,407 \| \__main_\_ \| misshtbtd \| main \| 351 \|
INFO \| ('MSHBD:config status is', 'RUNNING')

2018-12-12 12:41:39,418 \| \__main_\_ \| misshtbtd \|
create_update_hb_common \| 143 \| INFO \| MSHBT:Updated hb_common DB
with new values

2018-12-12 12:41:40,118 \| \__main_\_ \| db_monitoring \| db_monitoring
\| 53 \| INFO \| DBM: Active DB Monitoring Instance

2018-12-12 12:41:45,864 \| \__main_\_ \| htbtworker \| process_msg \| 71
\| INFO \| ('\n\nHBT:eventnameList values ', ['Heartbeat_S',
'Heartbeat_vFW'])

2018-12-12 12:41:45,864 \| \__main_\_ \| htbtworker \| process_msg \| 77
\| INFO \| HBT:Getting
:http://10.12.5.252:3904/events/unauthenticated.SEC_HEARTBEAT_INPUT/group1/1?timeout=15000

2018-12-12 12:41:45,865 \| urllib3.connectionpool \| connectionpool \|
\_new_conn \| 208 \| DEBUG \| Starting new HTTP connection (1):
10.12.5.252

2018-12-12 12:41:46,482 \| urllib3.connectionpool \| connectionpool \|
\_make_request \| 396 \| DEBUG \| http://10.12.5.252:3904 "GET
/events/unauthenticated.SEC_HEARTBEAT_INPUT/group1/1?timeout=15000
HTTP/1.1" 200 661

2018-12-12 12:41:46,483 \| \__main_\_ \| htbtworker \| process_msg \| 92
\| INFO \| ('HBT:',
'["{\\"event\\":{\\"commonEventHeader\\":{\\"startEpochMicrosec\\":1544608845841,\\"sourceId\\":\\"VNFB_SRC5\\",\\"eventId\\":\\"mvfs10\\",\\"nfcNamingCode\\":\\"VNFB\\",\\"timeZoneOffset\\":\\"UTC-05:30\\",\\"reportingEntityId\\":\\"cc305d54-75b4-431b-adb2-eb6b9e541234\\",\\"eventType\\":\\"platform\\",\\"priority\\":\\"Normal\\",\\"version\\":\\"4.0.2\\",\\"reportingEntityName\\":\\"ibcx0001vm002oam001\\",\\"sequence\\":1000,\\"domain\\":\\"heartbeat\\",\\"lastEpochMicrosec\\":1544608845841,\\"eventName\\":\\"Heartbeat_vFW\\",\\"vesEventListenerVersion\\":\\"7.0.2\\",\\"sourceName\\":\\"SOURCE_NAME2\\",\\"nfNamingCode\\":\\"VNFB\\"},\\"heartbeatFields\\":{\\"heartbeatInterval\\":20,\\"heartbeatFieldsVersion\\":\\"3.0\\"}}}"]')

2018-12-12 12:41:46,483 \| \__main_\_ \| htbtworker \| process_msg \|
125 \| INFO \| ('HBT:Newly received HB event values ::',
'Heartbeat_vFW', 1544608845841, 'SOURCE_NAME2')

2018-12-12 12:41:46,486 \| \__main_\_ \| htbtworker \| process_msg \|
132 \| INFO \| HBT:vnf_table_2 is already there

2018-12-12 12:41:46,486 \| \__main_\_ \| htbtworker \| process_msg \|
136 \| INFO \| ('HBT:', "Select source_name_count from vnf_table_1 where
event_name='Heartbeat_vFW'")

2018-12-12 12:41:46,487 \| \__main_\_ \| htbtworker \| process_msg \|
153 \| INFO \| ('HBT:event name, source_name & source_name_count are',
'Heartbeat_vFW', 'SOURCE_NAME2', 1)

2018-12-12 12:41:46,487 \| \__main_\_ \| htbtworker \| process_msg \|
157 \| INFO \| ('HBT:eppc query is', "Select source_name from
vnf_table_2 where event_name= 'Heartbeat_vFW' and source_name_key=1")

2018-12-12 12:41:46,487 \| \__main_\_ \| htbtworker \| process_msg \|
165 \| INFO \| ('HBT: Update vnf_table_2 : ', 0, [('SOURCE_NAME2',)])

2018-12-12 12:41:46,488 \| \__main_\_ \| htbtworker \| process_msg \|
173 \| INFO \| ('HBT: The source_name_key and source_name_count are ',
1, 1)

2018-12-12 12:41:56,508 \| \__main_\_ \| htbtworker \| process_msg \| 71
\| INFO \| ('\n\nHBT:eventnameList values ', ['Heartbeat_S',
'Heartbeat_vFW'])

2018-12-12 12:41:56,508 \| \__main_\_ \| htbtworker \| process_msg \| 77
\| INFO \| HBT:Getting
:http://10.12.5.252:3904/events/unauthenticated.SEC_HEARTBEAT_INPUT/group1/1?timeout=15000

2018-12-12 12:41:56,509 \| urllib3.connectionpool \| connectionpool \|
\_new_conn \| 208 \| DEBUG \| Starting new HTTP connection (1):
10.12.5.252

2018-12-12 12:42:00,160 \| \__main_\_ \| db_monitoring \| db_monitoring
\| 53 \| INFO \| DBM: Active DB Monitoring Instance

2018-12-12 12:42:04,456 \| \__main_\_ \| misshtbtd \| main \| 331 \|
INFO \| ('MSHBT: hb_common values ', 7, 'RUNNING',
'102413e8af4a-mvp-dcaegen2-heartbeat-static', 1544618499)

2018-12-12 12:42:04,456 \| \__main_\_ \| misshtbtd \| main \| 335 \|
INFO \| ('MSHBD:pid,srcName,state,time,ctime,timeDiff is', 7,
'102413e8af4a-mvp-dcaegen2-heartbeat-static', 'RUNNING', 1544618499,
1544618524, 25)

2018-12-12 12:42:04,456 \| \__main_\_ \| misshtbtd \| main \| 351 \|
INFO \| ('MSHBD:config status is', 'RUNNING')

2018-12-12 12:42:04,464 \| \__main_\_ \| misshtbtd \|
create_update_hb_common \| 143 \| INFO \| MSHBT:Updated hb_common DB
with new values

2018-12-12 12:42:11,463 \| urllib3.connectionpool \| connectionpool \|
\_make_request \| 396 \| DEBUG \| http://10.12.5.252:3904 "GET
/events/unauthenticated.SEC_HEARTBEAT_INPUT/group1/1?timeout=15000
HTTP/1.1" 200 2

2018-12-12 12:42:11,464 \| \__main_\_ \| htbtworker \| process_msg \| 92
\| INFO \| ('HBT:', '[]')

2018-12-12 12:42:20,199 \| \__main_\_ \| db_monitoring \| db_monitoring
\| 53 \| INFO \| DBM: Active DB Monitoring Instance

2018-12-12 12:42:21,489 \| \__main_\_ \| htbtworker \| process_msg \| 71
\| INFO \| ('\n\nHBT:eventnameList values ', ['Heartbeat_S',
'Heartbeat_vFW'])

2018-12-12 12:42:21,489 \| \__main_\_ \| htbtworker \| process_msg \| 77
\| INFO \| HBT:Getting
:http://10.12.5.252:3904/events/unauthenticated.SEC_HEARTBEAT_INPUT/group1/1?timeout=15000

2018-12-12 12:42:21,491 \| urllib3.connectionpool \| connectionpool \|
\_new_conn \| 208 \| DEBUG \| Starting new HTTP connection (1):
10.12.5.252

2018-12-12 12:42:29,490 \| \__main_\_ \| misshtbtd \| main \| 331 \|
INFO \| ('MSHBT: hb_common values ', 7, 'RUNNING',
'102413e8af4a-mvp-dcaegen2-heartbeat-static', 1544618524)

2018-12-12 12:42:29,490 \| \__main_\_ \| misshtbtd \| main \| 335 \|
INFO \| ('MSHBD:pid,srcName,state,time,ctime,timeDiff is', 7,
'102413e8af4a-mvp-dcaegen2-heartbeat-static', 'RUNNING', 1544618524,
1544618549, 25)

2018-12-12 12:42:29,490 \| \__main_\_ \| misshtbtd \| main \| 351 \|
INFO \| ('MSHBD:config status is', 'RUNNING')

2018-12-12 12:42:29,503 \| \__main_\_ \| misshtbtd \|
create_update_hb_common \| 143 \| INFO \| MSHBT:Updated hb_common DB
with new values

2018-12-12 12:42:36,431 \| urllib3.connectionpool \| connectionpool \|
\_make_request \| 396 \| DEBUG \| http://10.12.5.252:3904 "GET
/events/unauthenticated.SEC_HEARTBEAT_INPUT/group1/1?timeout=15000
HTTP/1.1" 200 2

2018-12-12 12:42:36,433 \| \__main_\_ \| htbtworker \| process_msg \| 92
\| INFO \| ('HBT:', '[]')

2018-12-12 12:42:40,235 \| \__main_\_ \| db_monitoring \| db_monitoring
\| 53 \| INFO \| DBM: Active DB Monitoring Instance

2018-12-12 12:42:46,467 \| \__main_\_ \| htbtworker \| process_msg \| 71
\| INFO \| ('\n\nHBT:eventnameList values ', ['Heartbeat_S',
'Heartbeat_vFW'])

2018-12-12 12:42:46,467 \| \__main_\_ \| htbtworker \| process_msg \| 77
\| INFO \| HBT:Getting
:http://10.12.5.252:3904/events/unauthenticated.SEC_HEARTBEAT_INPUT/group1/1?timeout=15000

2018-12-12 12:42:46,468 \| urllib3.connectionpool \| connectionpool \|
\_new_conn \| 208 \| DEBUG \| Starting new HTTP connection (1):
10.12.5.252

2018-12-12 12:42:54,539 \| \__main_\_ \| misshtbtd \| main \| 331 \|
INFO \| ('MSHBT: hb_common values ', 7, 'RUNNING',
'102413e8af4a-mvp-dcaegen2-heartbeat-static', 1544618549)

2018-12-12 12:42:54,539 \| \__main_\_ \| misshtbtd \| main \| 335 \|
INFO \| ('MSHBD:pid,srcName,state,time,ctime,timeDiff is', 7,
'102413e8af4a-mvp-dcaegen2-heartbeat-static', 'RUNNING', 1544618549,
1544618575, 26)

2018-12-12 12:42:54,539 \| \__main_\_ \| misshtbtd \| main \| 351 \|
INFO \| ('MSHBD:config status is', 'RUNNING')

2018-12-12 12:42:54,555 \| \__main_\_ \| misshtbtd \|
create_update_hb_common \| 143 \| INFO \| MSHBT:Updated hb_common DB
with new values

2018-12-12 12:43:00,273 \| \__main_\_ \| db_monitoring \| db_monitoring
\| 53 \| INFO \| DBM: Active DB Monitoring Instance

2018-12-12 12:43:01,415 \| urllib3.connectionpool \| connectionpool \|
\_make_request \| 396 \| DEBUG \| http://10.12.5.252:3904 "GET
/events/unauthenticated.SEC_HEARTBEAT_INPUT/group1/1?timeout=15000
HTTP/1.1" 200 2

2018-12-12 12:43:01,416 \| \__main_\_ \| htbtworker \| process_msg \| 92
\| INFO \| ('HBT:', '[]')

2018-12-12 12:43:11,439 \| \__main_\_ \| htbtworker \| process_msg \| 71
\| INFO \| ('\n\nHBT:eventnameList values ', ['Heartbeat_S',
'Heartbeat_vFW'])

2018-12-12 12:43:11,439 \| \__main_\_ \| htbtworker \| process_msg \| 77
\| INFO \| HBT:Getting
:http://10.12.5.252:3904/events/unauthenticated.SEC_HEARTBEAT_INPUT/group1/1?timeout=15000

2018-12-12 12:43:11,440 \| urllib3.connectionpool \| connectionpool \|
\_new_conn \| 208 \| DEBUG \| Starting new HTTP connection (1):
10.12.5.252

2018-12-12 12:43:19,592 \| \__main_\_ \| misshtbtd \| main \| 331 \|
INFO \| ('MSHBT: hb_common values ', 7, 'RUNNING',
'102413e8af4a-mvp-dcaegen2-heartbeat-static', 1544618575)

2018-12-12 12:43:19,593 \| \__main_\_ \| misshtbtd \| main \| 335 \|
INFO \| ('MSHBD:pid,srcName,state,time,ctime,timeDiff is', 7,
'102413e8af4a-mvp-dcaegen2-heartbeat-static', 'RUNNING', 1544618575,
1544618600, 25)

2018-12-12 12:43:19,593 \| \__main_\_ \| misshtbtd \| main \| 351 \|
INFO \| ('MSHBD:config status is', 'RUNNING')

2018-12-12 12:43:19,601 \| \__main_\_ \| misshtbtd \|
create_update_hb_common \| 143 \| INFO \| MSHBT:Updated hb_common DB
with new values

2018-12-12 12:43:20,309 \| \__main_\_ \| db_monitoring \| db_monitoring
\| 53 \| INFO \| DBM: Active DB Monitoring Instance

2018-12-12 12:43:26,383 \| urllib3.connectionpool \| connectionpool \|
\_make_request \| 396 \| DEBUG \| http://10.12.5.252:3904 "GET
/events/unauthenticated.SEC_HEARTBEAT_INPUT/group1/1?timeout=15000
HTTP/1.1" 200 2

2018-12-12 12:43:26,384 \| \__main_\_ \| htbtworker \| process_msg \| 92
\| INFO \| ('HBT:', '[]')

2018-12-12 12:43:36,399 \| \__main_\_ \| htbtworker \| process_msg \| 71
\| INFO \| ('\n\nHBT:eventnameList values ', ['Heartbeat_S',
'Heartbeat_vFW'])

2018-12-12 12:43:36,400 \| \__main_\_ \| htbtworker \| process_msg \| 77
\| INFO \| HBT:Getting
:http://10.12.5.252:3904/events/unauthenticated.SEC_HEARTBEAT_INPUT/group1/1?timeout=15000

2018-12-12 12:43:36,401 \| urllib3.connectionpool \| connectionpool \|
\_new_conn \| 208 \| DEBUG \| Starting new HTTP connection (1):
10.12.5.252

2018-12-12 12:43:40,346 \| \__main_\_ \| db_monitoring \| db_monitoring
\| 53 \| INFO \| DBM: Active DB Monitoring Instance

2018-12-12 12:43:44,635 \| \__main_\_ \| misshtbtd \| main \| 331 \|
INFO \| ('MSHBT: hb_common values ', 7, 'RUNNING',
'102413e8af4a-mvp-dcaegen2-heartbeat-static', 1544618600)

2018-12-12 12:43:44,635 \| \__main_\_ \| misshtbtd \| main \| 335 \|
INFO \| ('MSHBD:pid,srcName,state,time,ctime,timeDiff is', 7,
'102413e8af4a-mvp-dcaegen2-heartbeat-static', 'RUNNING', 1544618600,
1544618625, 25)

2018-12-12 12:43:44,636 \| \__main_\_ \| misshtbtd \| main \| 351 \|
INFO \| ('MSHBD:config status is', 'RUNNING')

2018-12-12 12:43:44,645 \| \__main_\_ \| misshtbtd \|
create_update_hb_common \| 143 \| INFO \| MSHBT:Updated hb_common DB
with new values

2018-12-12 12:43:51,339 \| urllib3.connectionpool \| connectionpool \|
\_make_request \| 396 \| DEBUG \| http://10.12.5.252:3904 "GET
/events/unauthenticated.SEC_HEARTBEAT_INPUT/group1/1?timeout=15000
HTTP/1.1" 200 2

2018-12-12 12:43:51,343 \| \__main_\_ \| htbtworker \| process_msg \| 92
\| INFO \| ('HBT:', '[]')

2018-12-12 12:44:00,385 \| \__main_\_ \| db_monitoring \| db_monitoring
\| 53 \| INFO \| DBM: Active DB Monitoring Instance

2018-12-12 12:44:01,369 \| \__main_\_ \| htbtworker \| process_msg \| 71
\| INFO \| ('\n\nHBT:eventnameList values ', ['Heartbeat_S',
'Heartbeat_vFW'])

2018-12-12 12:44:01,369 \| \__main_\_ \| htbtworker \| process_msg \| 77
\| INFO \| HBT:Getting
:http://10.12.5.252:3904/events/unauthenticated.SEC_HEARTBEAT_INPUT/group1/1?timeout=15000

2018-12-12 12:44:01,371 \| urllib3.connectionpool \| connectionpool \|
\_new_conn \| 208 \| DEBUG \| Starting new HTTP connection (1):
10.12.5.252

2018-12-12 12:44:09,678 \| \__main_\_ \| misshtbtd \| main \| 331 \|
INFO \| ('MSHBT: hb_common values ', 7, 'RUNNING',
'102413e8af4a-mvp-dcaegen2-heartbeat-static', 1544618625)

2018-12-12 12:44:09,679 \| \__main_\_ \| misshtbtd \| main \| 335 \|
INFO \| ('MSHBD:pid,srcName,state,time,ctime,timeDiff is', 7,
'102413e8af4a-mvp-dcaegen2-heartbeat-static', 'RUNNING', 1544618625,
1544618650, 25)

2018-12-12 12:44:09,679 \| \__main_\_ \| misshtbtd \| main \| 351 \|
INFO \| ('MSHBD:config status is', 'RUNNING')

2018-12-12 12:44:09,687 \| \__main_\_ \| misshtbtd \|
create_update_hb_common \| 143 \| INFO \| MSHBT:Updated hb_common DB
with new values

2018-12-12 12:44:16,313 \| urllib3.connectionpool \| connectionpool \|
\_make_request \| 396 \| DEBUG \| http://10.12.5.252:3904 "GET
/events/unauthenticated.SEC_HEARTBEAT_INPUT/group1/1?timeout=15000
HTTP/1.1" 200 2

2018-12-12 12:44:16,313 \| \__main_\_ \| htbtworker \| process_msg \| 92
\| INFO \| ('HBT:', '[]')

2018-12-12 12:44:20,422 \| \__main_\_ \| db_monitoring \| db_monitoring
\| 53 \| INFO \| DBM: Active DB Monitoring Instance

2018-12-12 12:44:26,338 \| \__main_\_ \| htbtworker \| process_msg \| 71
\| INFO \| ('\n\nHBT:eventnameList values ', ['Heartbeat_S',
'Heartbeat_vFW'])

2018-12-12 12:44:26,338 \| \__main_\_ \| htbtworker \| process_msg \| 77
\| INFO \| HBT:Getting
:http://10.12.5.252:3904/events/unauthenticated.SEC_HEARTBEAT_INPUT/group1/1?timeout=15000

2018-12-12 12:44:26,339 \| urllib3.connectionpool \| connectionpool \|
\_new_conn \| 208 \| DEBUG \| Starting new HTTP connection (1):
10.12.5.252

2018-12-12 12:44:34,721 \| \__main_\_ \| misshtbtd \| main \| 331 \|
INFO \| ('MSHBT: hb_common values ', 7, 'RUNNING',
'102413e8af4a-mvp-dcaegen2-heartbeat-static', 1544618650)

2018-12-12 12:44:34,721 \| \__main_\_ \| misshtbtd \| main \| 335 \|
INFO \| ('MSHBD:pid,srcName,state,time,ctime,timeDiff is', 7,
'102413e8af4a-mvp-dcaegen2-heartbeat-static', 'RUNNING', 1544618650,
1544618675, 25)

2018-12-12 12:44:34,721 \| \__main_\_ \| misshtbtd \| main \| 351 \|
INFO \| ('MSHBD:config status is', 'RUNNING')

2018-12-12 12:44:34,730 \| \__main_\_ \| misshtbtd \|
create_update_hb_common \| 143 \| INFO \| MSHBT:Updated hb_common DB
with new values

2018-12-12 12:44:40,448 \| \__main_\_ \| db_monitoring \| db_monitoring
\| 53 \| INFO \| DBM: Active DB Monitoring Instance

2018-12-12 12:44:41,287 \| urllib3.connectionpool \| connectionpool \|
\_make_request \| 396 \| DEBUG \| http://10.12.5.252:3904 "GET
/events/unauthenticated.SEC_HEARTBEAT_INPUT/group1/1?timeout=15000
HTTP/1.1" 200 2

2018-12-12 12:44:41,288 \| \__main_\_ \| htbtworker \| process_msg \| 92
\| INFO \| ('HBT:', '[]')

2018-12-12 12:44:51,316 \| \__main_\_ \| htbtworker \| process_msg \| 71
\| INFO \| ('\n\nHBT:eventnameList values ', ['Heartbeat_S',
'Heartbeat_vFW'])

2018-12-12 12:44:51,316 \| \__main_\_ \| htbtworker \| process_msg \| 77
\| INFO \| HBT:Getting
:http://10.12.5.252:3904/events/unauthenticated.SEC_HEARTBEAT_INPUT/group1/1?timeout=15000

2018-12-12 12:44:51,317 \| urllib3.connectionpool \| connectionpool \|
\_new_conn \| 208 \| DEBUG \| Starting new HTTP connection (1):
10.12.5.252

2018-12-12 12:44:59,764 \| \__main_\_ \| misshtbtd \| main \| 331 \|
INFO \| ('MSHBT: hb_common values ', 7, 'RUNNING',
'102413e8af4a-mvp-dcaegen2-heartbeat-static', 1544618675)

2018-12-12 12:44:59,764 \| \__main_\_ \| misshtbtd \| main \| 335 \|
INFO \| ('MSHBD:pid,srcName,state,time,ctime,timeDiff is', 7,
'102413e8af4a-mvp-dcaegen2-heartbeat-static', 'RUNNING', 1544618675,
1544618700, 25)

2018-12-12 12:44:59,764 \| \__main_\_ \| misshtbtd \| main \| 351 \|
INFO \| ('MSHBD:config status is', 'RUNNING')

2018-12-12 12:44:59,773 \| \__main_\_ \| misshtbtd \|
create_update_hb_common \| 143 \| INFO \| MSHBT:Updated hb_common DB
with new values

2018-12-12 12:45:00,038 \| \__main_\_ \| cbs_polling \| pollCBS \| 52 \|
INFO \| CBSP:ACTIVE Instance:Change the state to RECONFIGURATION

2018-12-12 12:45:00,046 \| misshtbtd \| misshtbtd \|
create_update_hb_common \| 143 \| INFO \| MSHBT:Updated hb_common DB
with new values

2018-12-12 12:45:00,055 \| \__main_\_ \| cbs_polling \| pollCBS \| 39 \|
INFO \| ('CBSP:Main process ID in hb_common is %d', 7)

2018-12-12 12:45:00,055 \| \__main_\_ \| cbs_polling \| pollCBS \| 41 \|
INFO \| ('CBSP:My parent process ID is %d', '7')

2018-12-12 12:45:00,055 \| \__main_\_ \| cbs_polling \| pollCBS \| 43 \|
INFO \| ('CBSP:CBS Polling interval is %d', 300)

2018-12-12 12:45:00,485 \| \__main_\_ \| db_monitoring \| db_monitoring
\| 225 \| INFO \| DBM:Inactive instance or hb_common state is not
RUNNING

2018-12-12 12:45:06,290 \| urllib3.connectionpool \| connectionpool \|
\_make_request \| 396 \| DEBUG \| http://10.12.5.252:3904 "GET
/events/unauthenticated.SEC_HEARTBEAT_INPUT/group1/1?timeout=15000
HTTP/1.1" 200 2

2018-12-12 12:45:06,291 \| \__main_\_ \| htbtworker \| process_msg \| 92
\| INFO \| ('HBT:', '[]')

2018-12-12 12:45:16,308 \| \__main_\_ \| htbtworker \| process_msg \| 57
\| INFO \| HBT:Waiting for hb_common state to become RUNNING

2018-12-12 12:45:20,517 \| \__main_\_ \| db_monitoring \| db_monitoring
\| 225 \| INFO \| DBM:Inactive instance or hb_common state is not
RUNNING

2018-12-12 12:45:24,806 \| \__main_\_ \| misshtbtd \| main \| 331 \|
INFO \| ('MSHBT: hb_common values ', 7, 'RECONFIGURATION',
'102413e8af4a-mvp-dcaegen2-heartbeat-static', 1544618700)

2018-12-12 12:45:24,806 \| \__main_\_ \| misshtbtd \| main \| 335 \|
INFO \| ('MSHBD:pid,srcName,state,time,ctime,timeDiff is', 7,
'102413e8af4a-mvp-dcaegen2-heartbeat-static', 'RECONFIGURATION',
1544618700, 1544618725, 25)

2018-12-12 12:45:24,806 \| \__main_\_ \| misshtbtd \| main \| 351 \|
INFO \| ('MSHBD:config status is', 'RECONFIGURATION')

2018-12-12 12:45:24,806 \| \__main_\_ \| misshtbtd \| main \| 357 \|
INFO \| MSHBD:Reconfiguration is in progress,Starting new processes by
killing the present processes

2018-12-12 12:45:24,806 \| onap_dcae_cbs_docker_client.client \| client
\| \_get_uri_from_consul \| 36 \| DEBUG \| Trying to lookup service:
http://10.12.6.50:8500/v1/catalog/service/config_binding_service

2018-12-12 12:45:24,808 \| urllib3.connectionpool \| connectionpool \|
\_new_conn \| 208 \| DEBUG \| Starting new HTTP connection (1):
10.12.6.50

2018-12-12 12:45:24,810 \| urllib3.connectionpool \| connectionpool \|
\_make_request \| 396 \| DEBUG \| http://10.12.6.50:8500 "GET
/v1/catalog/service/config_binding_service HTTP/1.1" 200 375

2018-12-12 12:45:24,814 \| urllib3.connectionpool \| connectionpool \|
\_new_conn \| 208 \| DEBUG \| Starting new HTTP connection (1):
10.12.6.50

2018-12-12 12:45:24,820 \| urllib3.connectionpool \| connectionpool \|
\_make_request \| 396 \| DEBUG \| http://10.12.6.50:10000 "GET
/service_component/mvp-dcaegen2-heartbeat-static HTTP/1.1" 200 1015

2018-12-12 12:45:24,821 \| onap_dcae_cbs_docker_client.client \| client
\| \_get_path \| 83 \| INFO \| get_config returned the following
configuration: {"heartbeat_config": {"vnfs": [{"eventName":
"Heartbeat_S", "heartbeatcountmissed": 3, "heartbeatinterval": 60,
"closedLoopControlName": "ControlLoopEvent1", "policyVersion":
"1.0.0.5", "policyName": "vFireWall", "policyScope":
"resource=sampleResource,type=sampletype,CLName=sampleCLName",
"target_type": "VM", "target": "genVnfName", "version": "2.0"},
{"eventName": "Heartbeat_vFW", "heartbeatcountmissed": 3,
"heartbeatinterval": 60, "closedLoopControlName": "ControlLoopEvent1",
"policyVersion": "1.0.0.5", "policyName": "vFireWall", "policyScope":
"resource=sampleResource,type=sampletype,CLName=sampleCLName",
"target_type": "VNF", "target": "genVnfName", "version": "2.0"}]},
"streams_publishes": {"ves_heartbeat": {"dmaap_info": {"topic_url":
"http://10.12.5.252:3904/events/unauthenticated.DCAE_CL_OUTPUT/"},
"type": "message_router"}}, "streams_subscribes": {"ves_heartbeat":
{"dmaap_info": {"topic_url":
"http://10.12.5.252:3904/events/unauthenticated.SEC_HEARTBEAT_INPUT/"},
"type": "message_router"}}}

2018-12-12 12:45:24,821 \| \__main_\_ \| misshtbtd \| fetch_json_file \|
254 \| INFO \| MSHBD:current config logged to : ../etc/download.json

2018-12-12 12:45:24,828 \| \__main_\_ \| misshtbtd \| fetch_json_file \|
272 \| INFO \| ('MSHBT: The json file is - ', '../etc/config.json')

2018-12-12 12:45:24,829 \| \__main_\_ \| misshtbtd \| create_update_db
\| 281 \| INFO \| ('MSHBT: DB parameters -', '10.0.4.1', '5432',
'postgres', 'abc', 'hb_vnf')

2018-12-12 12:45:24,840 \| \__main_\_ \| misshtbtd \|
create_update_vnf_table_1 \| 162 \| INFO \| MSHBT:Set Validity flag to
zero in vnf_table_1 table

2018-12-12 12:45:24,841 \| \__main_\_ \| misshtbtd \|
create_update_vnf_table_1 \| 191 \| INFO \| MSHBT:Updated vnf_table_1 as
per the json configuration file

2018-12-12 12:45:24,843 \| \__main_\_ \| misshtbtd \| main \| 362 \|
INFO \| ('MSHBD: parameters passed to DBM and HB are %d and %s', 7)

2018-12-12 12:45:24,852 \| \__main_\_ \| misshtbtd \|
create_update_hb_common \| 143 \| INFO \| MSHBT:Updated hb_common DB
with new values

2018-12-12 12:45:26,325 \| \__main_\_ \| htbtworker \| process_msg \| 71
\| INFO \| ('\n\nHBT:eventnameList values ', ['Heartbeat_S',
'Heartbeat_vFW'])

2018-12-12 12:45:26,325 \| \__main_\_ \| htbtworker \| process_msg \| 77
\| INFO \| HBT:Getting
:http://10.12.5.252:3904/events/unauthenticated.SEC_HEARTBEAT_INPUT/group1/1?timeout=15000

2018-12-12 12:45:26,326 \| urllib3.connectionpool \| connectionpool \|
\_new_conn \| 208 \| DEBUG \| Starting new HTTP connection (1):
10.12.5.252

2018-12-12 12:45:40,549 \| \__main_\_ \| db_monitoring \| db_monitoring
\| 53 \| INFO \| DBM: Active DB Monitoring Instance

2018-12-12 12:45:41,267 \| urllib3.connectionpool \| connectionpool \|
\_make_request \| 396 \| DEBUG \| http://10.12.5.252:3904 "GET
/events/unauthenticated.SEC_HEARTBEAT_INPUT/group1/1?timeout=15000
HTTP/1.1" 200 2

2018-12-12 12:45:41,268 \| \__main_\_ \| htbtworker \| process_msg \| 92
\| INFO \| ('HBT:', '[]')

2018-12-12 12:45:49,885 \| \__main_\_ \| misshtbtd \| main \| 331 \|
INFO \| ('MSHBT: hb_common values ', 7, 'RUNNING',
'102413e8af4a-mvp-dcaegen2-heartbeat-static', 1544618725)

2018-12-12 12:45:49,886 \| \__main_\_ \| misshtbtd \| main \| 335 \|
INFO \| ('MSHBD:pid,srcName,state,time,ctime,timeDiff is', 7,
'102413e8af4a-mvp-dcaegen2-heartbeat-static', 'RUNNING', 1544618725,
1544618750, 25)

2018-12-12 12:45:49,886 \| \__main_\_ \| misshtbtd \| main \| 351 \|
INFO \| ('MSHBD:config status is', 'RUNNING')

2018-12-12 12:45:49,894 \| \__main_\_ \| misshtbtd \|
create_update_hb_common \| 143 \| INFO \| MSHBT:Updated hb_common DB
with new values

2018-12-12 12:45:51,291 \| \__main_\_ \| htbtworker \| process_msg \| 71
\| INFO \| ('\n\nHBT:eventnameList values ', ['Heartbeat_S',
'Heartbeat_vFW'])

2018-12-12 12:45:51,291 \| \__main_\_ \| htbtworker \| process_msg \| 77
\| INFO \| HBT:Getting
:http://10.12.5.252:3904/events/unauthenticated.SEC_HEARTBEAT_INPUT/group1/1?timeout=15000

2018-12-12 12:45:51,292 \| urllib3.connectionpool \| connectionpool \|
\_new_conn \| 208 \| DEBUG \| Starting new HTTP connection (1):
10.12.5.252

2018-12-12 12:46:00,585 \| \__main_\_ \| db_monitoring \| db_monitoring
\| 53 \| INFO \| DBM: Active DB Monitoring Instance
