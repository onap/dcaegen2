.. This work is licensed under a Creative Commons Attribution 4.0 International License.
.. http://creativecommons.org/licenses/by/4.0

Build and Setup procedure
=========================

ONAP Repository
---------------

Use the below repository for Heartbeat Microservice.

   https://gerrit.onap.org/r/#/admin/projects/dcaegen2/services/heartbeat

POD 25 access
-------------

To run heartbeat Micro Service in development environment, POD25
access is required. Please get the access and install Openvpn.

Connect to POD25 setup using Openvpn and the credentials obtained.

Docker build procedure
----------------------

Clone the code using below command

::
      git clone --depth 1 https://gerrit.onap.org/r/dcaegen2/services/heartbeat 

give executable permission to mvn-phase-script.sh if not there
already

::
      chmod +x mvn-phase-script.sh

**Setting up the postgres DB, group/consumer IDs, CBS download and
CBS polling. The following environment variables are to be set.**

   For postgres and CBS download, the environment setting file to be
   passed while running the Docker. The file would contain following
   parameters. The sample values are shown for reference.

    ::
	   pg_ipAddress=10.0.4.1
	   pg_portNum=5432
	   pg_userName=postgres
	   pg_passwd=abc
	   #Below parameters for CBS download
	   SERVICE_NAME=mvp-dcaegen2-heartbeat-static
	   CONSUL_HOST=10.12.6.50
	   HOSTNAME=mvp-dcaegen2-heartbeat-static
	   #Below parameter for heartbeat worker process to receive message
	   groupID=group1
	   consumerID=1

   If the postgres parameters are not there in environment setting file,
   then it takes the values from    miss_htbt_service/config/hbproperties.yaml 
   file. Make sure that postgres running in the machine where pg_ipAddress 
   parameter is mentioned. 
   
   Run below netstat command to check postgres port number and IP address are fine.

::

      netstat -ant

   If CBS parameters are not there in the environment setting file, then
   local config file (etc/config.json) is considered as a default
   configuration file.

   For CBS polling CBS_polling_allowed & CBS_polling_interval to be set
   appropriately in miss_htbt_service/config/hbproperties.yaml file

   The sample values in miss_htbt_service/config/hbproperties.yaml file
   are as follows

::
	
	   pg_ipAddress: 10.0.4.1
	   pg_portNum: 5432
	   pg_userName: postgres
	   pg_passwd: postgres
	   pg_dbName: hb_vnf
	   CBS_polling_allowed: True
	   CBS_polling_interval: 300

   PS: Change the groupID and consumerID in the environment accordingly
   for each HB instance so that HB worker process receive the HB event
   correctly. Usually groupID remains the same for all instance of HB
   where as consumerID would be changed for each instance of HB Micro
   service. If groupID and consumerID is not provided, then it takes
   "DefaultGroup" and "1" respectively.

**Setting CBS configuration parameters using the consule KV URL.**

   The sample consul KV is as below.
   ::
   
     http://10.12.6.50:8500/ui/#/dc1/kv/mvp-dcaegen2-heartbeat-static

   Go to the above link and click on KEY/VALUE tab

   Click on mvp-dcaegen2-heartbeat-static

   Copy the configuration in the box provided and click on update. 
   
   The sample configuration is as below
   
   .. code-block:: json
   
		{
			"heartbeat_config": {
				"vnfs": [{
						"eventName": "Heartbeat_S",
						"heartbeatcountmissed": 3,
						"heartbeatinterval": 60,
						"closedLoopControlName": "ControlLoopEvent1",
						"policyVersion": "1.0.0.5",
						"policyName": "vFireWall",
						"policyScope": "resource=sampleResource,type=sampletype,CLName=sampleCLName",
						"target_type": "VM",
						"target": "genVnfName",
						"version": "2.0"
					},
					{
						"eventName": "Heartbeat_vFW",
						"heartbeatcountmissed": 3,
						"heartbeatinterval": 60,
						"closedLoopControlName": "ControlLoopEvent1",
						"policyVersion": "1.0.0.5",
						"policyName": "vFireWall",
						"policyScope": "resource=sampleResource,type=sampletype,CLName=sampleCLName",
						"target_type": "VNF",
						"target": "genVnfName",
						"version": "2.0"
					}
				]
			},

			"streams_publishes": {
				"ves_heartbeat": {
					"dmaap_info": {
						"topic_url": "http://10.12.5.252:3904/events/unauthenticated.DCAE_CL_OUTPUT/"
					},
					"type": "message_router"
				}
			},
			"streams_subscribes": {
				"ves_heartbeat": {
					"dmaap_info": {
						"topic_url": "http://10.12.5.252:3904/events/unauthenticated.SEC_HEARTBEAT_INPUT/"
					},
					"type": "message_router"
				}
			}
		}

**Build the Docker using below command with a image name**

::

     sudo Docker build --no-cache --network=host -f ./Dockerfile -t
     heartbeat.test1:latest .

 To check whether image is built or not, run below command

::

      sudo Docker images |grep heartbeat.test1

**Run the Docker using below command which uses the environment file
mentioned in the above section.**

::

      sudo Docker run -d --name hb1 --env-file env.list
      heartbeat.test1:latest

 To check the logs, run below command
 
::

      sudo Docker logs -f hb1

**To stop the Docker run**

   Get the Docker container ID from below command

::

       sudo Docker ps -a \| grep heartbeat.test1

   Run below commands to stop the Docker run
   
::
   
       sudo Docker stop <Docker container ID)
       sudo Docker rm -f hb1

**Initiate the maven build**

   To run the maven build, execute any one of them.
   
:: 

      sudo mvn -s settings.xml deploy
      OR
      sudo mvn -s settings.xml -X deploy

   If there is a libxml-xpath related issue, then install the
   libxml-xpath as below. If the issue is something else, follow the
   link given as part of the build failure.

:: 
      sudo apt install libxml-xpath-perl
