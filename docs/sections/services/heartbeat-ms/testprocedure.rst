.. This work is licensed under a Creative Commons Attribution 4.0 International License.
.. http://creativecommons.org/licenses/by/4.0

Test procedures and Postgres Database access
============================================

Postgres DB access
------------------

Login into postgres DB

Run below commands to login into postgres DB and connect to HB Micro service DB.

::

     sudo su postgres
     psql
     \l hb_vnf

Sample output is as below

::

		ubuntu@r3-dcae:~$ sudo su postgres
		postgres@r3-dcae:/home/ubuntu$ psql
		psql (9.5.14)
		Type "help" for help.

		postgres=# \l
										  List of databases
		   Name    |  Owner   | Encoding |   Collate   |    Ctype    |   Access privileges
		-----------+----------+----------+-------------+-------------+-----------------------
		 hb_vnf    | postgres | UTF8     | en_US.UTF-8 | en_US.UTF-8 |
		 postgres  | postgres | UTF8     | en_US.UTF-8 | en_US.UTF-8 |
		 template0 | postgres | UTF8     | en_US.UTF-8 | en_US.UTF-8 | =c/postgres          +
				   |          |          |             |             | postgres=CTc/postgres
		 template1 | postgres | UTF8     | en_US.UTF-8 | en_US.UTF-8 | =c/postgres          +
				   |          |          |             |             | postgres=CTc/postgres
		(4 rows)

		postgres=# \c hb_vnf
		You are now connected to database "hb_vnf" as user "postgres".
		hb_vnf=#

Delete all tables before starting Docker run or local run
---------------------------------------------------------

After login into postgres and connect to hb_vnf as mentioned in (4.a), use below commands to delete the tables if exists

DROP TABLE vnf_table_1;
DROP TABLE vnf_table_2;
DROP TABLE hb_common;

The sample output is as below

::

		hb_vnf=# DROP TABLE vnf_table_1;
		DROP TABLE
		hb_vnf=# DROP TABLE vnf_table_2;
		DROP TABLE
		hb_vnf=# DROP TABLE hb_common;
		DROP TABLE
		hb_vnf=#

Use select command to check the contents of vnf_table_1, vnf_table_2 and hb_common
----------------------------------------------------------------------------------

SELECT * FROM vnf_table_1;
SELECT * FROM vnf_table_2;
SELECT * FROM hb_common;

The sample output is as below

::

		hb_vnf=# SELECT * FROM vnf_table_1;

		  event_name   | heartbeat_missed_count | heartbeat_interval | closed_control_loop_name | policy_version | policy_name |                        policy_scope                         | target_type |   target   | version | source_name_count | validity_flag
		---------------+------------------------+--------------------+--------------------------+----------------+-------------+-------------------------------------------------------------+-------------+------------+---------+-------------------+---------------
		 Heartbeat_S   |                      4 |                 60 | ControlLoopEvent1        | 1.0.0.5        | vFireWall   | resource=sampleResource,type=sampletype,CLName=sampleCLName | VM          | genVnfName | 2.0     |                 0 |             1
		 Heartbeat_vFW |                      4 |                 50 | ControlLoopEvent1        | 1.0.0.5        | vFireWall   | resource=sampleResource,type=sampletype,CLName=sampleCLName | VNF         | genVnfName | 2.0     |                 0 |             1
		(2 rows)

		hb_vnf=# SELECT * FROM vnf_table_2;
		  event_name   | source_name_key | last_epo_time | source_name  | cl_flag
		---------------+-----------------+---------------+--------------+---------
		 Heartbeat_vFW |               1 | 1544705272479 | SOURCE_NAME1 |       0
		(1 row)

		hb_vnf=#

		hb_vnf=# SELECT * FROM hb_common;
		 process_id |                source_name                 | last_accessed_time | current_state
		------------+--------------------------------------------+--------------------+---------------
				  8 | 21d744ae8cd5-mvp-dcaegen2-heartbeat-static |         1544710271 | RUNNING
		(1 row)

		hb_vnf=#

Testing procedures
==================

Injecting event into HB micro service
-------------------------------------

Once after starting the Docker run or local run, below commands run from tests/ directory would send event to HB worker process

::

	curl -i -X POST -d {"test":"msg"} --header "Content-Type: application/json" http://10.12.5.252:3904/events/unauthenticated.SEC_HEARTBEAT_INPUT
	curl -i -X POST -d @test1.json --header "Content-Type: application/json" http://10.12.5.252:3904/events/unauthenticated.SEC_HEARTBEAT_INPUT
	curl -i -X POST -d @test2.json --header "Content-Type: application/json" http://10.12.5.252:3904/events/unauthenticated.SEC_HEARTBEAT_INPUT
	curl -i -X POST -d @test3.json --header "Content-Type: application/json" http://10.12.5.252:3904/events/unauthenticated.SEC_HEARTBEAT_INPUT

The sample output is as below

::

		ubuntu@r3-aai-inst2:~/heartbeat12Dec/heartbeat/tests$ curl -i -X POST -d @test1.json --header "Content-Type: application/json" http://10.12.5.252:3904/events/unauthenticated.SEC_HEARTBEAT_INPUT
		HTTP/1.1 200 OK
		Date: Wed, 12 Dec 2018 12:41:26 GMT
		Content-Type: application/json
		Accept: */*
		breadcrumbId: ID-22f076777975-37104-1543559663227-0-563929
		User-Agent: curl/7.47.0
		X-CSI-Internal-WriteableRequest: true
		Content-Length: 41
		Server: Jetty(9.3.z-SNAPSHOT)

		{
			"serverTimeMs": 0,
			"count": 1
		}



		curl -i -X POST -d @test1.json --header "Content-Type: application/json" http://10.12.5.252:3904/events/unauthenticated.SEC_HEARTBEAT_INPUT
		ubuntu@r3-aai-inst2:~/heartbeat12Dec/heartbeat/tests$ curl -i -X POST -d @test2.json --header "Contet-Type: application/json" http://10.12.5.252:3904/events/unauthenticated.SEC_HEARTBEAT_INPUT
		HTTP/1.1 200 OK
		Date: Wed, 12 Dec 2018 12:41:39 GMT
		Content-Type: application/json
		Accept: */*
		breadcrumbId: ID-22f076777975-37104-1543559663227-0-563937
		User-Agent: curl/7.47.0
		X-CSI-Internal-WriteableRequest: true
		Content-Length: 41
		Server: Jetty(9.3.z-SNAPSHOT)

		{
			"serverTimeMs": 0,
			"count": 1
		}


		ubuntu@r3-aai-inst2:~/heartbeat12Dec/heartbeat/tests$ curl -i -X POST -d @test3.json --header "Contet-Type: application/json" http://10.12.5.252:3904/events/unauthenticated.SEC_HEARTBEAT_INPUT
		HTTP/1.1 200 OK
		Date: Wed, 12 Dec 2018 12:41:39 GMT
		Content-Type: application/json
		Accept: */*
		breadcrumbId: ID-22f076777975-37104-1543559663227-0-563937
		User-Agent: curl/7.47.0
		X-CSI-Internal-WriteableRequest: true
		Content-Length: 41
		Server: Jetty(9.3.z-SNAPSHOT)

		{
			"serverTimeMs": 0,
			"count": 1
		}

Testing Control loop event
--------------------------

- Modify the Json as below
	Modify the lastEpochTime and startEpochTime with current time in Test1.json
	Modify the eventName in Test1.json to one of the eventName in vnf_table_1

- Inject the Test1.json as mentioned in above section

- Get missed heartbeat count (for e.g 3) and heartbeat interval (for e.g. 60 seconds) for the eventName from  vnf_table_1. Wait for heartbeat to miss multiple time, i.e. 3 * 60seconds = 180 seconds.

After waiting for the specified period, you would see the control loop event. The sample one is as below.

::

	2018-12-13 12:51:13,016 | __main__ | db_monitoring | db_monitoring | 95 |  INFO | ('DBM:Time to raise Control Loop Event for target type - ', 'VNF')
	2018-12-13 12:51:13,016 | __main__ | db_monitoring | db_monitoring | 132 |  INFO | ('DBM: CL Json object is', '{"closedLoopEventClient": "DCAE_Heartbeat_MS", "policyVersion": "1.0.0.5", "policyName": "vFireWall", "policyScope": "resource=sampleResource,type=sampletype,CLName=sampleCLName", "target_type": "VNF", "AAI": {"generic-vnf.vnf-name": "SOURCE_NAME1"}, "closedLoopAlarmStart": 1544705473016, "closedLoopEventStatus": "ONSET", "closedLoopControlName": "ControlLoopEvent1", "version": "2.0", "target": "genVnfName", "requestID": "8c1b8bd8-06f7-493f-8ed7-daaa4cc481bc", "from": "DCAE"}')

The postgres DB also have a CL_flag set indicating control loop event with ONSET is raised.

::

		hb_vnf=# SELECT * FROM vnf_table_2;
		  event_name   | source_name_key | last_epo_time | source_name  | cl_flag
		---------------+-----------------+---------------+--------------+---------
		 Heartbeat_vFW |               1 | 1544705272479 | SOURCE_NAME1 |       1
		(1 row)

		hb_vnf=#

**The sample log from startup is as below**

::

		ubuntu@r3-aai-inst2:~/heartbeat12Dec/heartbeat$ sudo Docker run -d --name hb1 --env-file env.list heartbeat.test1:latest102413e8af4ab754e008cee43a01bf3d5439820aa91cfb4e099a140a7931fd71
		ubuntu@r3-aai-inst2:~/heartbeat12Dec/heartbeat$ sudo Docker logs -f hb1
		/usr/local/lib/python3.6/site-packages/psycopg2/__init__.py:144: UserWarning: The psycopg2 wheel package will be renamed from release 2.8; in order to keep installing from binary please use "pip install --no-cache-dir psycopg2-binary" instead. For details see: <http://initd.org/psycopg/docs/install.html#binary-install-from-pypi>.
		  """)
		2018-12-12 12:39:58,968 | __main__ | misshtbtd | main | 309 |  INFO | MSHBD:Execution Started
		2018-12-12 12:39:58,970 | __main__ | misshtbtd | main | 314 |  INFO | ('MSHBT:HB Properties -', '10.0.4.1', '5432', 'postgres', 'abc', 'hb_vnf', True, 300)
		2018-12-12 12:39:58,970 | onap_dcae_cbs_docker_client.client | client | _get_uri_from_consul | 36 |  DEBUG | Trying to lookup service: http://10.12.6.50:8500/v1/catalog/service/config_binding_service
		2018-12-12 12:39:58,974 | urllib3.connectionpool | connectionpool | _new_conn | 208 |  DEBUG | Starting new HTTP connection (1): 10.12.6.50
		2018-12-12 12:39:58,976 | urllib3.connectionpool | connectionpool | _make_request | 396 |  DEBUG | http://10.12.6.50:8500 "GET /v1/catalog/service/config_binding_service HTTP/1.1" 200 375
		2018-12-12 12:39:58,979 | urllib3.connectionpool | connectionpool | _new_conn | 208 |  DEBUG | Starting new HTTP connection (1): 10.12.6.50
		2018-12-12 12:39:58,988 | urllib3.connectionpool | connectionpool | _make_request | 396 |  DEBUG | http://10.12.6.50:10000 "GET /service_component/mvp-dcaegen2-heartbeat-static HTTP/1.1" 200 1015
		2018-12-12 12:39:58,989 | onap_dcae_cbs_docker_client.client | client | _get_path | 83 |  INFO | get_config returned the following configuration: {"heartbeat_config": {"vnfs": [{"eventName": "Heartbeat_S", "heartbeatcountmissed": 3, "heartbeatinterval": 60, "closedLoopControlName": "ControlLoopEvent1", "policyVersion": "1.0.0.5", "policyName": "vFireWall", "policyScope": "resource=sampleResource,type=sampletype,CLName=sampleCLName", "target_type": "VM", "target": "genVnfName", "version": "2.0"}, {"eventName": "Heartbeat_vFW", "heartbeatcountmissed": 3, "heartbeatinterval": 60, "closedLoopControlName": "ControlLoopEvent1", "policyVersion": "1.0.0.5", "policyName": "vFireWall", "policyScope": "resource=sampleResource,type=sampletype,CLName=sampleCLName", "target_type": "VNF", "target": "genVnfName", "version": "2.0"}]}, "streams_publishes": {"ves_heartbeat": {"dmaap_info": {"topic_url": "http://10.12.5.252:3904/events/unauthenticated.DCAE_CL_OUTPUT/"}, "type": "message_router"}}, "streams_subscribes": {"ves_heartbeat": {"dmaap_info": {"topic_url": "http://10.12.5.252:3904/events/unauthenticated.SEC_HEARTBEAT_INPUT/"}, "type": "message_router"}}}
		2018-12-12 12:39:58,989 | __main__ | misshtbtd | fetch_json_file | 254 |  INFO | MSHBD:current config logged to : ../etc/download.json
		2018-12-12 12:39:58,996 | __main__ | misshtbtd | fetch_json_file | 272 |  INFO | ('MSHBT: The json file is - ', '../etc/config.json')
		2018-12-12 12:39:59,028 | __main__ | misshtbtd | create_database | 79 |  INFO | ('MSHBT:Create_database:DB not exists? ', (False,))
		2018-12-12 12:39:59,030 | __main__ | misshtbtd | create_database | 86 |  INFO | MSHBD:Database already exists
		2018-12-12 12:39:59,032 | __main__ | misshtbtd | create_update_db | 281 |  INFO | ('MSHBT: DB parameters -', '10.0.4.1', '5432', 'postgres', 'abc', 'hb_vnf')
		2018-12-12 12:39:59,099 | __main__ | misshtbtd | main | 325 |  INFO | ('MSHBD:Current process id is', 7)
		2018-12-12 12:39:59,099 | __main__ | misshtbtd | main | 326 |  INFO | MSHBD:Now be in a continuous loop
		2018-12-12 12:39:59,111 | __main__ | misshtbtd | main | 331 |  INFO | ('MSHBT: hb_common values ', 6, 'RUNNING', '8909e4332e34-mvp-dcaegen2-heartbeat-static', 1544618286)
		2018-12-12 12:39:59,111 | __main__ | misshtbtd | main | 335 |  INFO | ('MSHBD:pid,srcName,state,time,ctime,timeDiff is', 6, '8909e4332e34-mvp-dcaegen2-heartbeat-static', 'RUNNING', 1544618286, 1544618399, 113)
		2018-12-12 12:39:59,111 | __main__ | misshtbtd | main | 378 |  INFO | MSHBD:Active instance is inactive for long time: Time to switchover
		2018-12-12 12:39:59,111 | __main__ | misshtbtd | main | 380 |  INFO | MSHBD:Initiating to become Active Instance
		2018-12-12 12:39:59,111 | onap_dcae_cbs_docker_client.client | client | _get_uri_from_consul | 36 |  DEBUG | Trying to lookup service: http://10.12.6.50:8500/v1/catalog/service/config_binding_service
		2018-12-12 12:39:59,114 | urllib3.connectionpool | connectionpool | _new_conn | 208 |  DEBUG | Starting new HTTP connection (1): 10.12.6.50
		2018-12-12 12:39:59,118 | urllib3.connectionpool | connectionpool | _make_request | 396 |  DEBUG | http://10.12.6.50:8500 "GET /v1/catalog/service/config_binding_service HTTP/1.1" 200 375
		2018-12-12 12:39:59,120 | urllib3.connectionpool | connectionpool | _new_conn | 208 |  DEBUG | Starting new HTTP connection (1): 10.12.6.50
		2018-12-12 12:39:59,129 | urllib3.connectionpool | connectionpool | _make_request | 396 |  DEBUG | http://10.12.6.50:10000 "GET /service_component/mvp-dcaegen2-heartbeat-static HTTP/1.1" 200 1015
		2018-12-12 12:39:59,129 | onap_dcae_cbs_docker_client.client | client | _get_path | 83 |  INFO | get_config returned the following configuration: {"heartbeat_config": {"vnfs": [{"eventName": "Heartbeat_S", "heartbeatcountmissed": 3, "heartbeatinterval": 60, "closedLoopControlName": "ControlLoopEvent1", "policyVersion": "1.0.0.5", "policyName": "vFireWall", "policyScope": "resource=sampleResource,type=sampletype,CLName=sampleCLName", "target_type": "VM", "target": "genVnfName", "version": "2.0"}, {"eventName": "Heartbeat_vFW", "heartbeatcountmissed": 3, "heartbeatinterval": 60, "closedLoopControlName": "ControlLoopEvent1", "policyVersion": "1.0.0.5", "policyName": "vFireWall", "policyScope": "resource=sampleResource,type=sampletype,CLName=sampleCLName", "target_type": "VNF", "target": "genVnfName", "version": "2.0"}]}, "streams_publishes": {"ves_heartbeat": {"dmaap_info": {"topic_url": "http://10.12.5.252:3904/events/unauthenticated.DCAE_CL_OUTPUT/"}, "type": "message_router"}}, "streams_subscribes": {"ves_heartbeat": {"dmaap_info": {"topic_url": "http://10.12.5.252:3904/events/unauthenticated.SEC_HEARTBEAT_INPUT/"}, "type": "message_router"}}}
		2018-12-12 12:39:59,129 | __main__ | misshtbtd | fetch_json_file | 254 |  INFO | MSHBD:current config logged to : ../etc/download.json
		2018-12-12 12:39:59,139 | __main__ | misshtbtd | fetch_json_file | 272 |  INFO | ('MSHBT: The json file is - ', '../etc/config.json')
		2018-12-12 12:39:59,139 | __main__ | misshtbtd | main | 386 |  INFO | ('MSHBD: Creating HB and DBM threads. The param pssed %d and %s', '../etc/config.json', 7)
		2018-12-12 12:39:59,142 | __main__ | misshtbtd | create_process | 301 |  INFO | ('MSHBD:jobs list is', [<Process(Process-2, started)>, <Process(Process-3, started)>])
		2018-12-12 12:39:59,221 | __main__ | misshtbtd | create_update_hb_common | 143 |  INFO | MSHBT:Updated  hb_common DB with new values
		/usr/local/lib/python3.6/site-packages/psycopg2/__init__.py:144: UserWarning: The psycopg2 wheel package will be renamed from release 2.8; in order to keep installing from binary please use "pip install --no-cache-dir psycopg2-binary" instead. For details see: <http://initd.org/psycopg/docs/install.html#binary-install-from-pypi>.
		  """)
		2018-12-12 12:39:59,815 | __main__ | htbtworker | <module> | 243 |  INFO | HBT:HeartBeat thread Created
		2018-12-12 12:39:59,815 | __main__ | htbtworker | <module> | 245 |  INFO | ('HBT:The config file name passed is -%s', '../etc/config.json')
		/usr/local/lib/python3.6/site-packages/psycopg2/__init__.py:144: UserWarning: The psycopg2 wheel package will be renamed from release 2.8; in order to keep installing from binary please use "pip install --no-cache-dir psycopg2-binary" instead. For details see: <http://initd.org/psycopg/docs/install.html#binary-install-from-pypi>.
		  """)
		2018-12-12 12:39:59,931 | __main__ | cbs_polling | pollCBS | 39 |  INFO | ('CBSP:Main process ID in hb_common is %d', 7)
		2018-12-12 12:39:59,931 | __main__ | cbs_polling | pollCBS | 41 |  INFO | ('CBSP:My parent process ID is %d', '7')
		2018-12-12 12:39:59,931 | __main__ | cbs_polling | pollCBS | 43 |  INFO | ('CBSP:CBS Polling interval is %d', 300)
		/usr/local/lib/python3.6/site-packages/psycopg2/__init__.py:144: UserWarning: The psycopg2 wheel package will be renamed from release 2.8; in order to keep installing from binary please use "pip install --no-cache-dir psycopg2-binary" instead. For details see: <http://initd.org/psycopg/docs/install.html#binary-install-from-pypi>.
		  """)
		2018-12-12 12:39:59,937 | __main__ | db_monitoring | <module> | 231 |  INFO | DBM: DBM Process started
		2018-12-12 12:39:59,939 | __main__ | db_monitoring | <module> | 236 |  INFO | ('DBM:Parent process ID and json file name', '7', '../etc/config.json')
		2018-12-12 12:40:09,860 | __main__ | htbtworker | process_msg | 71 |  INFO | ('\n\nHBT:eventnameList values ', ['Heartbeat_S', 'Heartbeat_vFW'])
		2018-12-12 12:40:09,860 | __main__ | htbtworker | process_msg | 77 |  INFO | HBT:Getting :http://10.12.5.252:3904/events/unauthenticated.SEC_HEARTBEAT_INPUT/group1/1?timeout=15000
		2018-12-12 12:40:09,864 | urllib3.connectionpool | connectionpool | _new_conn | 208 |  DEBUG | Starting new HTTP connection (1): 10.12.5.252
		2018-12-12 12:40:19,968 | __main__ | db_monitoring | db_monitoring | 53 |  INFO | DBM: Active DB Monitoring Instance
		2018-12-12 12:40:24,259 | __main__ | misshtbtd | main | 331 |  INFO | ('MSHBT: hb_common values ', 7, 'RUNNING', '102413e8af4a-mvp-dcaegen2-heartbeat-static', 1544618399)
		2018-12-12 12:40:24,260 | __main__ | misshtbtd | main | 335 |  INFO | ('MSHBD:pid,srcName,state,time,ctime,timeDiff is', 7, '102413e8af4a-mvp-dcaegen2-heartbeat-static', 'RUNNING', 1544618399, 1544618424, 25)
		2018-12-12 12:40:24,260 | __main__ | misshtbtd | main | 351 |  INFO | ('MSHBD:config status is', 'RUNNING')
		2018-12-12 12:40:24,267 | __main__ | misshtbtd | create_update_hb_common | 143 |  INFO | MSHBT:Updated  hb_common DB with new values
		2018-12-12 12:40:24,810 | urllib3.connectionpool | connectionpool | _make_request | 396 |  DEBUG | http://10.12.5.252:3904 "GET /events/unauthenticated.SEC_HEARTBEAT_INPUT/group1/1?timeout=15000 HTTP/1.1" 200 2
		2018-12-12 12:40:24,812 | __main__ | htbtworker | process_msg | 92 |  INFO | ('HBT:', '[]')
		2018-12-12 12:40:34,837 | __main__ | htbtworker | process_msg | 71 |  INFO | ('\n\nHBT:eventnameList values ', ['Heartbeat_S', 'Heartbeat_vFW'])
		2018-12-12 12:40:34,838 | __main__ | htbtworker | process_msg | 77 |  INFO | HBT:Getting :http://10.12.5.252:3904/events/unauthenticated.SEC_HEARTBEAT_INPUT/group1/1?timeout=15000
		2018-12-12 12:40:34,839 | urllib3.connectionpool | connectionpool | _new_conn | 208 |  DEBUG | Starting new HTTP connection (1): 10.12.5.252
		2018-12-12 12:40:39,994 | __main__ | db_monitoring | db_monitoring | 53 |  INFO | DBM: Active DB Monitoring Instance
		2018-12-12 12:40:49,304 | __main__ | misshtbtd | main | 331 |  INFO | ('MSHBT: hb_common values ', 7, 'RUNNING', '102413e8af4a-mvp-dcaegen2-heartbeat-static', 1544618424)
		2018-12-12 12:40:49,304 | __main__ | misshtbtd | main | 335 |  INFO | ('MSHBD:pid,srcName,state,time,ctime,timeDiff is', 7, '102413e8af4a-mvp-dcaegen2-heartbeat-static', 'RUNNING', 1544618424, 1544618449, 25)
		2018-12-12 12:40:49,304 | __main__ | misshtbtd | main | 351 |  INFO | ('MSHBD:config status is', 'RUNNING')
		2018-12-12 12:40:49,314 | __main__ | misshtbtd | create_update_hb_common | 143 |  INFO | MSHBT:Updated  hb_common DB with new values
		2018-12-12 12:40:49,681 | urllib3.connectionpool | connectionpool | _make_request | 396 |  DEBUG | http://10.12.5.252:3904 "GET /events/unauthenticated.SEC_HEARTBEAT_INPUT/group1/1?timeout=15000 HTTP/1.1" 200 2
		2018-12-12 12:40:49,682 | __main__ | htbtworker | process_msg | 92 |  INFO | ('HBT:', '[]')
		2018-12-12 12:40:59,719 | __main__ | htbtworker | process_msg | 71 |  INFO | ('\n\nHBT:eventnameList values ', ['Heartbeat_S', 'Heartbeat_vFW'])
		2018-12-12 12:40:59,720 | __main__ | htbtworker | process_msg | 77 |  INFO | HBT:Getting :http://10.12.5.252:3904/events/unauthenticated.SEC_HEARTBEAT_INPUT/group1/1?timeout=15000
		2018-12-12 12:40:59,721 | urllib3.connectionpool | connectionpool | _new_conn | 208 |  DEBUG | Starting new HTTP connection (1): 10.12.5.252
		2018-12-12 12:41:00,036 | __main__ | db_monitoring | db_monitoring | 53 |  INFO | DBM: Active DB Monitoring Instance
		2018-12-12 12:41:00,225 | urllib3.connectionpool | connectionpool | _make_request | 396 |  DEBUG | http://10.12.5.252:3904 "GET /events/unauthenticated.SEC_HEARTBEAT_INPUT/group1/1?timeout=15000 HTTP/1.1" 200 22
		2018-12-12 12:41:00,226 | __main__ | htbtworker | process_msg | 92 |  INFO | ('HBT:', '["{\\"test\\":\\"msg\\"}"]')
		2018-12-12 12:41:00,226 | __main__ | htbtworker | process_msg | 122 |  ERROR | ('HBT message process error - ', KeyError('event',))
		2018-12-12 12:41:10,255 | __main__ | htbtworker | process_msg | 71 |  INFO | ('\n\nHBT:eventnameList values ', ['Heartbeat_S', 'Heartbeat_vFW'])
		2018-12-12 12:41:10,255 | __main__ | htbtworker | process_msg | 77 |  INFO | HBT:Getting :http://10.12.5.252:3904/events/unauthenticated.SEC_HEARTBEAT_INPUT/group1/1?timeout=15000
		2018-12-12 12:41:10,256 | urllib3.connectionpool | connectionpool | _new_conn | 208 |  DEBUG | Starting new HTTP connection (1): 10.12.5.252
		2018-12-12 12:41:14,350 | __main__ | misshtbtd | main | 331 |  INFO | ('MSHBT: hb_common values ', 7, 'RUNNING', '102413e8af4a-mvp-dcaegen2-heartbeat-static', 1544618449)
		2018-12-12 12:41:14,350 | __main__ | misshtbtd | main | 335 |  INFO | ('MSHBD:pid,srcName,state,time,ctime,timeDiff is', 7, '102413e8af4a-mvp-dcaegen2-heartbeat-static', 'RUNNING', 1544618449, 1544618474, 25)
		2018-12-12 12:41:14,350 | __main__ | misshtbtd | main | 351 |  INFO | ('MSHBD:config status is', 'RUNNING')
		2018-12-12 12:41:14,359 | __main__ | misshtbtd | create_update_hb_common | 143 |  INFO | MSHBT:Updated  hb_common DB with new values
		2018-12-12 12:41:20,075 | __main__ | db_monitoring | db_monitoring | 53 |  INFO | DBM: Active DB Monitoring Instance
		2018-12-12 12:41:25,193 | urllib3.connectionpool | connectionpool | _make_request | 396 |  DEBUG | http://10.12.5.252:3904 "GET /events/unauthenticated.SEC_HEARTBEAT_INPUT/group1/1?timeout=15000 HTTP/1.1" 200 2
		2018-12-12 12:41:25,193 | __main__ | htbtworker | process_msg | 92 |  INFO | ('HBT:', '[]')
		2018-12-12 12:41:35,222 | __main__ | htbtworker | process_msg | 71 |  INFO | ('\n\nHBT:eventnameList values ', ['Heartbeat_S', 'Heartbeat_vFW'])
		2018-12-12 12:41:35,222 | __main__ | htbtworker | process_msg | 77 |  INFO | HBT:Getting :http://10.12.5.252:3904/events/unauthenticated.SEC_HEARTBEAT_INPUT/group1/1?timeout=15000
		2018-12-12 12:41:35,223 | urllib3.connectionpool | connectionpool | _new_conn | 208 |  DEBUG | Starting new HTTP connection (1): 10.12.5.252
		2018-12-12 12:41:35,838 | urllib3.connectionpool | connectionpool | _make_request | 396 |  DEBUG | http://10.12.5.252:3904 "GET /events/unauthenticated.SEC_HEARTBEAT_INPUT/group1/1?timeout=15000 HTTP/1.1" 200 662
		2018-12-12 12:41:35,839 | __main__ | htbtworker | process_msg | 92 |  INFO | ('HBT:', '["{\\"event\\":{\\"commonEventHeader\\":{\\"startEpochMicrosec\\":1548313727714,\\"sourceId\\":\\"VNFA_SRC1\\",\\"eventId\\":\\"mvfs10\\",\\"nfcNamingCode\\":\\"VNFA\\",\\"timeZoneOffset\\":\\"UTC-05:30\\",\\"reportingEntityId\\":\\"cc305d54-75b4-431b-adb2-eb6b9e541234\\",\\"eventType\\":\\"platform\\",\\"priority\\":\\"Normal\\",\\"version\\":\\"4.0.2\\",\\"reportingEntityName\\":\\"ibcx0001vm002oam001\\",\\"sequence\\":1000,\\"domain\\":\\"heartbeat\\",\\"lastEpochMicrosec\\":1548313727714,\\"eventName\\":\\"Heartbeat_vDNS\\",\\"vesEventListenerVersion\\":\\"7.0.2\\",\\"sourceName\\":\\"SOURCE_NAME1\\",\\"nfNamingCode\\":\\"VNFA\\"},\\"heartbeatFields\\":{\\"heartbeatInterval\\":20,\\"heartbeatFieldsVersion\\":\\"3.0\\"}}}"]')
		2018-12-12 12:41:35,839 | __main__ | htbtworker | process_msg | 125 |  INFO | ('HBT:Newly received HB event values ::', 'Heartbeat_vDNS', 1548313727714, 'SOURCE_NAME1')
		2018-12-12 12:41:35,842 | __main__ | htbtworker | process_msg | 132 |  INFO | HBT:vnf_table_2 is already there
		2018-12-12 12:41:35,842 | __main__ | htbtworker | process_msg | 183 |  INFO | HBT:eventName is not being monitored, Igonoring JSON message
		2018-12-12 12:41:39,407 | __main__ | misshtbtd | main | 331 |  INFO | ('MSHBT: hb_common values ', 7, 'RUNNING', '102413e8af4a-mvp-dcaegen2-heartbeat-static', 1544618474)
		2018-12-12 12:41:39,407 | __main__ | misshtbtd | main | 335 |  INFO | ('MSHBD:pid,srcName,state,time,ctime,timeDiff is', 7, '102413e8af4a-mvp-dcaegen2-heartbeat-static', 'RUNNING', 1544618474, 1544618499, 25)
		2018-12-12 12:41:39,407 | __main__ | misshtbtd | main | 351 |  INFO | ('MSHBD:config status is', 'RUNNING')
		2018-12-12 12:41:39,418 | __main__ | misshtbtd | create_update_hb_common | 143 |  INFO | MSHBT:Updated  hb_common DB with new values
		2018-12-12 12:41:40,118 | __main__ | db_monitoring | db_monitoring | 53 |  INFO | DBM: Active DB Monitoring Instance
		2018-12-12 12:41:45,864 | __main__ | htbtworker | process_msg | 71 |  INFO | ('\n\nHBT:eventnameList values ', ['Heartbeat_S', 'Heartbeat_vFW'])
		2018-12-12 12:41:45,864 | __main__ | htbtworker | process_msg | 77 |  INFO | HBT:Getting :http://10.12.5.252:3904/events/unauthenticated.SEC_HEARTBEAT_INPUT/group1/1?timeout=15000
		2018-12-12 12:41:45,865 | urllib3.connectionpool | connectionpool | _new_conn | 208 |  DEBUG | Starting new HTTP connection (1): 10.12.5.252
		2018-12-12 12:41:46,482 | urllib3.connectionpool | connectionpool | _make_request | 396 |  DEBUG | http://10.12.5.252:3904 "GET /events/unauthenticated.SEC_HEARTBEAT_INPUT/group1/1?timeout=15000 HTTP/1.1" 200 661
		2018-12-12 12:41:46,483 | __main__ | htbtworker | process_msg | 92 |  INFO | ('HBT:', '["{\\"event\\":{\\"commonEventHeader\\":{\\"startEpochMicrosec\\":1544608845841,\\"sourceId\\":\\"VNFB_SRC5\\",\\"eventId\\":\\"mvfs10\\",\\"nfcNamingCode\\":\\"VNFB\\",\\"timeZoneOffset\\":\\"UTC-05:30\\",\\"reportingEntityId\\":\\"cc305d54-75b4-431b-adb2-eb6b9e541234\\",\\"eventType\\":\\"platform\\",\\"priority\\":\\"Normal\\",\\"version\\":\\"4.0.2\\",\\"reportingEntityName\\":\\"ibcx0001vm002oam001\\",\\"sequence\\":1000,\\"domain\\":\\"heartbeat\\",\\"lastEpochMicrosec\\":1544608845841,\\"eventName\\":\\"Heartbeat_vFW\\",\\"vesEventListenerVersion\\":\\"7.0.2\\",\\"sourceName\\":\\"SOURCE_NAME2\\",\\"nfNamingCode\\":\\"VNFB\\"},\\"heartbeatFields\\":{\\"heartbeatInterval\\":20,\\"heartbeatFieldsVersion\\":\\"3.0\\"}}}"]')
		2018-12-12 12:41:46,483 | __main__ | htbtworker | process_msg | 125 |  INFO | ('HBT:Newly received HB event values ::', 'Heartbeat_vFW', 1544608845841, 'SOURCE_NAME2')
		2018-12-12 12:41:46,486 | __main__ | htbtworker | process_msg | 132 |  INFO | HBT:vnf_table_2 is already there
		2018-12-12 12:41:46,486 | __main__ | htbtworker | process_msg | 136 |  INFO | ('HBT:', "Select source_name_count from vnf_table_1 where event_name='Heartbeat_vFW'")
		2018-12-12 12:41:46,487 | __main__ | htbtworker | process_msg | 153 |  INFO | ('HBT:event name, source_name & source_name_count are', 'Heartbeat_vFW', 'SOURCE_NAME2', 1)
		2018-12-12 12:41:46,487 | __main__ | htbtworker | process_msg | 157 |  INFO | ('HBT:eppc query is', "Select source_name from vnf_table_2 where event_name= 'Heartbeat_vFW' and source_name_key=1")
		2018-12-12 12:41:46,487 | __main__ | htbtworker | process_msg | 165 |  INFO | ('HBT: Update vnf_table_2 : ', 0, [('SOURCE_NAME2',)])
		2018-12-12 12:41:46,488 | __main__ | htbtworker | process_msg | 173 |  INFO | ('HBT: The source_name_key and source_name_count are ', 1, 1)
		2018-12-12 12:41:56,508 | __main__ | htbtworker | process_msg | 71 |  INFO | ('\n\nHBT:eventnameList values ', ['Heartbeat_S', 'Heartbeat_vFW'])
		2018-12-12 12:41:56,508 | __main__ | htbtworker | process_msg | 77 |  INFO | HBT:Getting :http://10.12.5.252:3904/events/unauthenticated.SEC_HEARTBEAT_INPUT/group1/1?timeout=15000
		2018-12-12 12:41:56,509 | urllib3.connectionpool | connectionpool | _new_conn | 208 |  DEBUG | Starting new HTTP connection (1): 10.12.5.252
		2018-12-12 12:42:00,160 | __main__ | db_monitoring | db_monitoring | 53 |  INFO | DBM: Active DB Monitoring Instance
		2018-12-12 12:42:04,456 | __main__ | misshtbtd | main | 331 |  INFO | ('MSHBT: hb_common values ', 7, 'RUNNING', '102413e8af4a-mvp-dcaegen2-heartbeat-static', 1544618499)
		2018-12-12 12:42:04,456 | __main__ | misshtbtd | main | 335 |  INFO | ('MSHBD:pid,srcName,state,time,ctime,timeDiff is', 7, '102413e8af4a-mvp-dcaegen2-heartbeat-static', 'RUNNING', 1544618499, 1544618524, 25)
		2018-12-12 12:42:04,456 | __main__ | misshtbtd | main | 351 |  INFO | ('MSHBD:config status is', 'RUNNING')
		2018-12-12 12:42:04,464 | __main__ | misshtbtd | create_update_hb_common | 143 |  INFO | MSHBT:Updated  hb_common DB with new values
		2018-12-12 12:42:11,463 | urllib3.connectionpool | connectionpool | _make_request | 396 |  DEBUG | http://10.12.5.252:3904 "GET /events/unauthenticated.SEC_HEARTBEAT_INPUT/group1/1?timeout=15000 HTTP/1.1" 200 2
		2018-12-12 12:42:11,464 | __main__ | htbtworker | process_msg | 92 |  INFO | ('HBT:', '[]')
		2018-12-12 12:42:20,199 | __main__ | db_monitoring | db_monitoring | 53 |  INFO | DBM: Active DB Monitoring Instance
		2018-12-12 12:42:21,489 | __main__ | htbtworker | process_msg | 71 |  INFO | ('\n\nHBT:eventnameList values ', ['Heartbeat_S', 'Heartbeat_vFW'])
		2018-12-12 12:42:21,489 | __main__ | htbtworker | process_msg | 77 |  INFO | HBT:Getting :http://10.12.5.252:3904/events/unauthenticated.SEC_HEARTBEAT_INPUT/group1/1?timeout=15000
		2018-12-12 12:42:21,491 | urllib3.connectionpool | connectionpool | _new_conn | 208 |  DEBUG | Starting new HTTP connection (1): 10.12.5.252
		2018-12-12 12:42:29,490 | __main__ | misshtbtd | main | 331 |  INFO | ('MSHBT: hb_common values ', 7, 'RUNNING', '102413e8af4a-mvp-dcaegen2-heartbeat-static', 1544618524)
		2018-12-12 12:42:29,490 | __main__ | misshtbtd | main | 335 |  INFO | ('MSHBD:pid,srcName,state,time,ctime,timeDiff is', 7, '102413e8af4a-mvp-dcaegen2-heartbeat-static', 'RUNNING', 1544618524, 1544618549, 25)
		2018-12-12 12:42:29,490 | __main__ | misshtbtd | main | 351 |  INFO | ('MSHBD:config status is', 'RUNNING')
		2018-12-12 12:42:29,503 | __main__ | misshtbtd | create_update_hb_common | 143 |  INFO | MSHBT:Updated  hb_common DB with new values
		2018-12-12 12:42:36,431 | urllib3.connectionpool | connectionpool | _make_request | 396 |  DEBUG | http://10.12.5.252:3904 "GET /events/unauthenticated.SEC_HEARTBEAT_INPUT/group1/1?timeout=15000 HTTP/1.1" 200 2
		2018-12-12 12:42:36,433 | __main__ | htbtworker | process_msg | 92 |  INFO | ('HBT:', '[]')
		2018-12-12 12:42:40,235 | __main__ | db_monitoring | db_monitoring | 53 |  INFO | DBM: Active DB Monitoring Instance
		2018-12-12 12:42:46,467 | __main__ | htbtworker | process_msg | 71 |  INFO | ('\n\nHBT:eventnameList values ', ['Heartbeat_S', 'Heartbeat_vFW'])
		2018-12-12 12:42:46,467 | __main__ | htbtworker | process_msg | 77 |  INFO | HBT:Getting :http://10.12.5.252:3904/events/unauthenticated.SEC_HEARTBEAT_INPUT/group1/1?timeout=15000
		2018-12-12 12:42:46,468 | urllib3.connectionpool | connectionpool | _new_conn | 208 |  DEBUG | Starting new HTTP connection (1): 10.12.5.252
		2018-12-12 12:42:54,539 | __main__ | misshtbtd | main | 331 |  INFO | ('MSHBT: hb_common values ', 7, 'RUNNING', '102413e8af4a-mvp-dcaegen2-heartbeat-static', 1544618549)
		2018-12-12 12:42:54,539 | __main__ | misshtbtd | main | 335 |  INFO | ('MSHBD:pid,srcName,state,time,ctime,timeDiff is', 7, '102413e8af4a-mvp-dcaegen2-heartbeat-static', 'RUNNING', 1544618549, 1544618575, 26)
		2018-12-12 12:42:54,539 | __main__ | misshtbtd | main | 351 |  INFO | ('MSHBD:config status is', 'RUNNING')
		2018-12-12 12:42:54,555 | __main__ | misshtbtd | create_update_hb_common | 143 |  INFO | MSHBT:Updated  hb_common DB with new values
		2018-12-12 12:43:00,273 | __main__ | db_monitoring | db_monitoring | 53 |  INFO | DBM: Active DB Monitoring Instance
		2018-12-12 12:43:01,415 | urllib3.connectionpool | connectionpool | _make_request | 396 |  DEBUG | http://10.12.5.252:3904 "GET /events/unauthenticated.SEC_HEARTBEAT_INPUT/group1/1?timeout=15000 HTTP/1.1" 200 2
		2018-12-12 12:43:01,416 | __main__ | htbtworker | process_msg | 92 |  INFO | ('HBT:', '[]')
		2018-12-12 12:43:11,439 | __main__ | htbtworker | process_msg | 71 |  INFO | ('\n\nHBT:eventnameList values ', ['Heartbeat_S', 'Heartbeat_vFW'])
		2018-12-12 12:43:11,439 | __main__ | htbtworker | process_msg | 77 |  INFO | HBT:Getting :http://10.12.5.252:3904/events/unauthenticated.SEC_HEARTBEAT_INPUT/group1/1?timeout=15000
		2018-12-12 12:43:11,440 | urllib3.connectionpool | connectionpool | _new_conn | 208 |  DEBUG | Starting new HTTP connection (1): 10.12.5.252
		2018-12-12 12:43:19,592 | __main__ | misshtbtd | main | 331 |  INFO | ('MSHBT: hb_common values ', 7, 'RUNNING', '102413e8af4a-mvp-dcaegen2-heartbeat-static', 1544618575)
		2018-12-12 12:43:19,593 | __main__ | misshtbtd | main | 335 |  INFO | ('MSHBD:pid,srcName,state,time,ctime,timeDiff is', 7, '102413e8af4a-mvp-dcaegen2-heartbeat-static', 'RUNNING', 1544618575, 1544618600, 25)
		2018-12-12 12:43:19,593 | __main__ | misshtbtd | main | 351 |  INFO | ('MSHBD:config status is', 'RUNNING')
		2018-12-12 12:43:19,601 | __main__ | misshtbtd | create_update_hb_common | 143 |  INFO | MSHBT:Updated  hb_common DB with new values
		2018-12-12 12:43:20,309 | __main__ | db_monitoring | db_monitoring | 53 |  INFO | DBM: Active DB Monitoring Instance
		2018-12-12 12:43:26,383 | urllib3.connectionpool | connectionpool | _make_request | 396 |  DEBUG | http://10.12.5.252:3904 "GET /events/unauthenticated.SEC_HEARTBEAT_INPUT/group1/1?timeout=15000 HTTP/1.1" 200 2
		2018-12-12 12:43:26,384 | __main__ | htbtworker | process_msg | 92 |  INFO | ('HBT:', '[]')
		2018-12-12 12:43:36,399 | __main__ | htbtworker | process_msg | 71 |  INFO | ('\n\nHBT:eventnameList values ', ['Heartbeat_S', 'Heartbeat_vFW'])
		2018-12-12 12:43:36,400 | __main__ | htbtworker | process_msg | 77 |  INFO | HBT:Getting :http://10.12.5.252:3904/events/unauthenticated.SEC_HEARTBEAT_INPUT/group1/1?timeout=15000
		2018-12-12 12:43:36,401 | urllib3.connectionpool | connectionpool | _new_conn | 208 |  DEBUG | Starting new HTTP connection (1): 10.12.5.252
		2018-12-12 12:43:40,346 | __main__ | db_monitoring | db_monitoring | 53 |  INFO | DBM: Active DB Monitoring Instance
		2018-12-12 12:43:44,635 | __main__ | misshtbtd | main | 331 |  INFO | ('MSHBT: hb_common values ', 7, 'RUNNING', '102413e8af4a-mvp-dcaegen2-heartbeat-static', 1544618600)
		2018-12-12 12:43:44,635 | __main__ | misshtbtd | main | 335 |  INFO | ('MSHBD:pid,srcName,state,time,ctime,timeDiff is', 7, '102413e8af4a-mvp-dcaegen2-heartbeat-static', 'RUNNING', 1544618600, 1544618625, 25)
		2018-12-12 12:43:44,636 | __main__ | misshtbtd | main | 351 |  INFO | ('MSHBD:config status is', 'RUNNING')
		2018-12-12 12:43:44,645 | __main__ | misshtbtd | create_update_hb_common | 143 |  INFO | MSHBT:Updated  hb_common DB with new values
		2018-12-12 12:43:51,339 | urllib3.connectionpool | connectionpool | _make_request | 396 |  DEBUG | http://10.12.5.252:3904 "GET /events/unauthenticated.SEC_HEARTBEAT_INPUT/group1/1?timeout=15000 HTTP/1.1" 200 2
		2018-12-12 12:43:51,343 | __main__ | htbtworker | process_msg | 92 |  INFO | ('HBT:', '[]')
		2018-12-12 12:44:00,385 | __main__ | db_monitoring | db_monitoring | 53 |  INFO | DBM: Active DB Monitoring Instance
		2018-12-12 12:44:01,369 | __main__ | htbtworker | process_msg | 71 |  INFO | ('\n\nHBT:eventnameList values ', ['Heartbeat_S', 'Heartbeat_vFW'])
		2018-12-12 12:44:01,369 | __main__ | htbtworker | process_msg | 77 |  INFO | HBT:Getting :http://10.12.5.252:3904/events/unauthenticated.SEC_HEARTBEAT_INPUT/group1/1?timeout=15000
		2018-12-12 12:44:01,371 | urllib3.connectionpool | connectionpool | _new_conn | 208 |  DEBUG | Starting new HTTP connection (1): 10.12.5.252
		2018-12-12 12:44:09,678 | __main__ | misshtbtd | main | 331 |  INFO | ('MSHBT: hb_common values ', 7, 'RUNNING', '102413e8af4a-mvp-dcaegen2-heartbeat-static', 1544618625)
		2018-12-12 12:44:09,679 | __main__ | misshtbtd | main | 335 |  INFO | ('MSHBD:pid,srcName,state,time,ctime,timeDiff is', 7, '102413e8af4a-mvp-dcaegen2-heartbeat-static', 'RUNNING', 1544618625, 1544618650, 25)
		2018-12-12 12:44:09,679 | __main__ | misshtbtd | main | 351 |  INFO | ('MSHBD:config status is', 'RUNNING')
		2018-12-12 12:44:09,687 | __main__ | misshtbtd | create_update_hb_common | 143 |  INFO | MSHBT:Updated  hb_common DB with new values
		2018-12-12 12:44:16,313 | urllib3.connectionpool | connectionpool | _make_request | 396 |  DEBUG | http://10.12.5.252:3904 "GET /events/unauthenticated.SEC_HEARTBEAT_INPUT/group1/1?timeout=15000 HTTP/1.1" 200 2
		2018-12-12 12:44:16,313 | __main__ | htbtworker | process_msg | 92 |  INFO | ('HBT:', '[]')
		2018-12-12 12:44:20,422 | __main__ | db_monitoring | db_monitoring | 53 |  INFO | DBM: Active DB Monitoring Instance
		2018-12-12 12:44:26,338 | __main__ | htbtworker | process_msg | 71 |  INFO | ('\n\nHBT:eventnameList values ', ['Heartbeat_S', 'Heartbeat_vFW'])
		2018-12-12 12:44:26,338 | __main__ | htbtworker | process_msg | 77 |  INFO | HBT:Getting :http://10.12.5.252:3904/events/unauthenticated.SEC_HEARTBEAT_INPUT/group1/1?timeout=15000
		2018-12-12 12:44:26,339 | urllib3.connectionpool | connectionpool | _new_conn | 208 |  DEBUG | Starting new HTTP connection (1): 10.12.5.252
		2018-12-12 12:44:34,721 | __main__ | misshtbtd | main | 331 |  INFO | ('MSHBT: hb_common values ', 7, 'RUNNING', '102413e8af4a-mvp-dcaegen2-heartbeat-static', 1544618650)
		2018-12-12 12:44:34,721 | __main__ | misshtbtd | main | 335 |  INFO | ('MSHBD:pid,srcName,state,time,ctime,timeDiff is', 7, '102413e8af4a-mvp-dcaegen2-heartbeat-static', 'RUNNING', 1544618650, 1544618675, 25)
		2018-12-12 12:44:34,721 | __main__ | misshtbtd | main | 351 |  INFO | ('MSHBD:config status is', 'RUNNING')
		2018-12-12 12:44:34,730 | __main__ | misshtbtd | create_update_hb_common | 143 |  INFO | MSHBT:Updated  hb_common DB with new values
		2018-12-12 12:44:40,448 | __main__ | db_monitoring | db_monitoring | 53 |  INFO | DBM: Active DB Monitoring Instance
		2018-12-12 12:44:41,287 | urllib3.connectionpool | connectionpool | _make_request | 396 |  DEBUG | http://10.12.5.252:3904 "GET /events/unauthenticated.SEC_HEARTBEAT_INPUT/group1/1?timeout=15000 HTTP/1.1" 200 2
		2018-12-12 12:44:41,288 | __main__ | htbtworker | process_msg | 92 |  INFO | ('HBT:', '[]')
		2018-12-12 12:44:51,316 | __main__ | htbtworker | process_msg | 71 |  INFO | ('\n\nHBT:eventnameList values ', ['Heartbeat_S', 'Heartbeat_vFW'])
		2018-12-12 12:44:51,316 | __main__ | htbtworker | process_msg | 77 |  INFO | HBT:Getting :http://10.12.5.252:3904/events/unauthenticated.SEC_HEARTBEAT_INPUT/group1/1?timeout=15000
		2018-12-12 12:44:51,317 | urllib3.connectionpool | connectionpool | _new_conn | 208 |  DEBUG | Starting new HTTP connection (1): 10.12.5.252
		2018-12-12 12:44:59,764 | __main__ | misshtbtd | main | 331 |  INFO | ('MSHBT: hb_common values ', 7, 'RUNNING', '102413e8af4a-mvp-dcaegen2-heartbeat-static', 1544618675)
		2018-12-12 12:44:59,764 | __main__ | misshtbtd | main | 335 |  INFO | ('MSHBD:pid,srcName,state,time,ctime,timeDiff is', 7, '102413e8af4a-mvp-dcaegen2-heartbeat-static', 'RUNNING', 1544618675, 1544618700, 25)
		2018-12-12 12:44:59,764 | __main__ | misshtbtd | main | 351 |  INFO | ('MSHBD:config status is', 'RUNNING')
		2018-12-12 12:44:59,773 | __main__ | misshtbtd | create_update_hb_common | 143 |  INFO | MSHBT:Updated  hb_common DB with new values
		2018-12-12 12:45:00,038 | __main__ | cbs_polling | pollCBS | 52 |  INFO | CBSP:ACTIVE Instance:Change the state to RECONFIGURATION
		2018-12-12 12:45:00,046 | misshtbtd | misshtbtd | create_update_hb_common | 143 |  INFO | MSHBT:Updated  hb_common DB with new values
		2018-12-12 12:45:00,055 | __main__ | cbs_polling | pollCBS | 39 |  INFO | ('CBSP:Main process ID in hb_common is %d', 7)
		2018-12-12 12:45:00,055 | __main__ | cbs_polling | pollCBS | 41 |  INFO | ('CBSP:My parent process ID is %d', '7')
		2018-12-12 12:45:00,055 | __main__ | cbs_polling | pollCBS | 43 |  INFO | ('CBSP:CBS Polling interval is %d', 300)
		2018-12-12 12:45:00,485 | __main__ | db_monitoring | db_monitoring | 225 |  INFO | DBM:Inactive instance or hb_common state is not RUNNING
		2018-12-12 12:45:06,290 | urllib3.connectionpool | connectionpool | _make_request | 396 |  DEBUG | http://10.12.5.252:3904 "GET /events/unauthenticated.SEC_HEARTBEAT_INPUT/group1/1?timeout=15000 HTTP/1.1" 200 2
		2018-12-12 12:45:06,291 | __main__ | htbtworker | process_msg | 92 |  INFO | ('HBT:', '[]')
		2018-12-12 12:45:16,308 | __main__ | htbtworker | process_msg | 57 |  INFO | HBT:Waiting for hb_common state to become RUNNING
		2018-12-12 12:45:20,517 | __main__ | db_monitoring | db_monitoring | 225 |  INFO | DBM:Inactive instance or hb_common state is not RUNNING
		2018-12-12 12:45:24,806 | __main__ | misshtbtd | main | 331 |  INFO | ('MSHBT: hb_common values ', 7, 'RECONFIGURATION', '102413e8af4a-mvp-dcaegen2-heartbeat-static', 1544618700)
		2018-12-12 12:45:24,806 | __main__ | misshtbtd | main | 335 |  INFO | ('MSHBD:pid,srcName,state,time,ctime,timeDiff is', 7, '102413e8af4a-mvp-dcaegen2-heartbeat-static', 'RECONFIGURATION', 1544618700, 1544618725, 25)
		2018-12-12 12:45:24,806 | __main__ | misshtbtd | main | 351 |  INFO | ('MSHBD:config status is', 'RECONFIGURATION')
		2018-12-12 12:45:24,806 | __main__ | misshtbtd | main | 357 |  INFO | MSHBD:Reconfiguration is in progress,Starting new processes by killing the present processes
		2018-12-12 12:45:24,806 | onap_dcae_cbs_docker_client.client | client | _get_uri_from_consul | 36 |  DEBUG | Trying to lookup service: http://10.12.6.50:8500/v1/catalog/service/config_binding_service
		2018-12-12 12:45:24,808 | urllib3.connectionpool | connectionpool | _new_conn | 208 |  DEBUG | Starting new HTTP connection (1): 10.12.6.50
		2018-12-12 12:45:24,810 | urllib3.connectionpool | connectionpool | _make_request | 396 |  DEBUG | http://10.12.6.50:8500 "GET /v1/catalog/service/config_binding_service HTTP/1.1" 200 375
		2018-12-12 12:45:24,814 | urllib3.connectionpool | connectionpool | _new_conn | 208 |  DEBUG | Starting new HTTP connection (1): 10.12.6.50
		2018-12-12 12:45:24,820 | urllib3.connectionpool | connectionpool | _make_request | 396 |  DEBUG | http://10.12.6.50:10000 "GET /service_component/mvp-dcaegen2-heartbeat-static HTTP/1.1" 200 1015
		2018-12-12 12:45:24,821 | onap_dcae_cbs_docker_client.client | client | _get_path | 83 |  INFO | get_config returned the following configuration: {"heartbeat_config": {"vnfs": [{"eventName": "Heartbeat_S", "heartbeatcountmissed": 3, "heartbeatinterval": 60, "closedLoopControlName": "ControlLoopEvent1", "policyVersion": "1.0.0.5", "policyName": "vFireWall", "policyScope": "resource=sampleResource,type=sampletype,CLName=sampleCLName", "target_type": "VM", "target": "genVnfName", "version": "2.0"}, {"eventName": "Heartbeat_vFW", "heartbeatcountmissed": 3, "heartbeatinterval": 60, "closedLoopControlName": "ControlLoopEvent1", "policyVersion": "1.0.0.5", "policyName": "vFireWall", "policyScope": "resource=sampleResource,type=sampletype,CLName=sampleCLName", "target_type": "VNF", "target": "genVnfName", "version": "2.0"}]}, "streams_publishes": {"ves_heartbeat": {"dmaap_info": {"topic_url": "http://10.12.5.252:3904/events/unauthenticated.DCAE_CL_OUTPUT/"}, "type": "message_router"}}, "streams_subscribes": {"ves_heartbeat": {"dmaap_info": {"topic_url": "http://10.12.5.252:3904/events/unauthenticated.SEC_HEARTBEAT_INPUT/"}, "type": "message_router"}}}
		2018-12-12 12:45:24,821 | __main__ | misshtbtd | fetch_json_file | 254 |  INFO | MSHBD:current config logged to : ../etc/download.json
		2018-12-12 12:45:24,828 | __main__ | misshtbtd | fetch_json_file | 272 |  INFO | ('MSHBT: The json file is - ', '../etc/config.json')
		2018-12-12 12:45:24,829 | __main__ | misshtbtd | create_update_db | 281 |  INFO | ('MSHBT: DB parameters -', '10.0.4.1', '5432', 'postgres', 'abc', 'hb_vnf')
		2018-12-12 12:45:24,840 | __main__ | misshtbtd | create_update_vnf_table_1 | 162 |  INFO | MSHBT:Set Validity flag to zero in vnf_table_1 table
		2018-12-12 12:45:24,841 | __main__ | misshtbtd | create_update_vnf_table_1 | 191 |  INFO | MSHBT:Updated vnf_table_1 as per the json configuration file
		2018-12-12 12:45:24,843 | __main__ | misshtbtd | main | 362 |  INFO | ('MSHBD: parameters  passed to DBM and HB are %d and %s', 7)
		2018-12-12 12:45:24,852 | __main__ | misshtbtd | create_update_hb_common | 143 |  INFO | MSHBT:Updated  hb_common DB with new values
		2018-12-12 12:45:26,325 | __main__ | htbtworker | process_msg | 71 |  INFO | ('\n\nHBT:eventnameList values ', ['Heartbeat_S', 'Heartbeat_vFW'])
		2018-12-12 12:45:26,325 | __main__ | htbtworker | process_msg | 77 |  INFO | HBT:Getting :http://10.12.5.252:3904/events/unauthenticated.SEC_HEARTBEAT_INPUT/group1/1?timeout=15000
		2018-12-12 12:45:26,326 | urllib3.connectionpool | connectionpool | _new_conn | 208 |  DEBUG | Starting new HTTP connection (1): 10.12.5.252
		2018-12-12 12:45:40,549 | __main__ | db_monitoring | db_monitoring | 53 |  INFO | DBM: Active DB Monitoring Instance
		2018-12-12 12:45:41,267 | urllib3.connectionpool | connectionpool | _make_request | 396 |  DEBUG | http://10.12.5.252:3904 "GET /events/unauthenticated.SEC_HEARTBEAT_INPUT/group1/1?timeout=15000 HTTP/1.1" 200 2
		2018-12-12 12:45:41,268 | __main__ | htbtworker | process_msg | 92 |  INFO | ('HBT:', '[]')
		2018-12-12 12:45:49,885 | __main__ | misshtbtd | main | 331 |  INFO | ('MSHBT: hb_common values ', 7, 'RUNNING', '102413e8af4a-mvp-dcaegen2-heartbeat-static', 1544618725)
		2018-12-12 12:45:49,886 | __main__ | misshtbtd | main | 335 |  INFO | ('MSHBD:pid,srcName,state,time,ctime,timeDiff is', 7, '102413e8af4a-mvp-dcaegen2-heartbeat-static', 'RUNNING', 1544618725, 1544618750, 25)
		2018-12-12 12:45:49,886 | __main__ | misshtbtd | main | 351 |  INFO | ('MSHBD:config status is', 'RUNNING')
		2018-12-12 12:45:49,894 | __main__ | misshtbtd | create_update_hb_common | 143 |  INFO | MSHBT:Updated  hb_common DB with new values
		2018-12-12 12:45:51,291 | __main__ | htbtworker | process_msg | 71 |  INFO | ('\n\nHBT:eventnameList values ', ['Heartbeat_S', 'Heartbeat_vFW'])
		2018-12-12 12:45:51,291 | __main__ | htbtworker | process_msg | 77 |  INFO | HBT:Getting :http://10.12.5.252:3904/events/unauthenticated.SEC_HEARTBEAT_INPUT/group1/1?timeout=15000
		2018-12-12 12:45:51,292 | urllib3.connectionpool | connectionpool | _new_conn | 208 |  DEBUG | Starting new HTTP connection (1): 10.12.5.252
		2018-12-12 12:46:00,585 | __main__ | db_monitoring | db_monitoring | 53 |  INFO | DBM: Active DB Monitoring Instance
