### DCAE Controller - Deployment Guide 1707

#### 1) Download latest deployer tar file to your cloudify bootstrap/cli server.

Say, your working directory is ${WORKING-DIR}
````
cd ${WORKING-DIR}
$ wget http://dockercentral.it.att.com:8093/nexus/repository/rawcentral/com.att.ecompcntr/opstools/dcae-deployer-5.0.tar
$ tar -xvf dcae-deployer-5.0.tar
$ cd ${WORKING-DIR}/dcae-deployer
````
#### 2) Clone the auto generated inputs files from code cloud and save it in <inputDirectory>
````
$ git clone ssh://<userid>@codecloud.web.att.com:7999/st_dcae/com.att.ecomp.dcae.operational.staging.ftl.git <inputsDirectory>

````
#### 3) Clone the latest consulAgent.sh 
````
$ git clone ssh://git@codecloud.web.att.com:7999/st_ecompcntr/platform_installation.git
NOTE: consulAgent.sh will be inside ec-deployer-v2.5.1/ec-deployer/bin
````
#### 4) Update app-inputs.conf with user defined values
````
$ cd ${WORKING-DIR}/dcae-deployer/conf
$ vi app-inputs.conf
 
 -- Update the following values -
	  * CLOUDIFY_INPUT=<complete path to the auto generated inputs.json for cloudify ( downloaded in inputsDirectory from Step 2 )>
	     e.g. /home/attcloud/dcae/dcae-deployer/testing/1710-FTL3/cloudify-gen/inputs/bootstrap/bootstrap/rdm5adcc1/inputs.json
	  * CONSUL_INPUT=<complete path to the auto generated inputs.json for consul ( downloaded in inputsDirectory from Step 2 )>
	     e.g. /home/attcloud/dcae/dcae-deployer/testing/1710-FTL3/cloudify-gen/inputs/consul/consul/rdm5adcc1/inputs.json
	  * CONSUL_BLUEPRINT=<complete path to the zip for consul on dockercentral>
	       - git clone ssh://git@codecloud.web.att.com:7999/st_ecompcntr/blueprints.git
	      e.g. /home/attcloud/blueprints/serviceConfigRegistry/blueprint/consul.yaml
	      Note: consul.yaml will be inside blueprints/serviceConfigRegistry/blueprint
	  * OPENSTACK_KEYFILE=<complete path the pem file used for bootstraping>
	      e.g. '/home/attcloud/dcae-m82823u.pem'
	  * OPENSTACK_KEY=<name of the keypair used in openstack>
	      e.g. 'dcae-m82823'
	  * CLOUDIFY_USERNAME=<Username for Cloudify>
	  * CLOUDIFY_PASSWORD=<Password for Cloudify>
	  * CONSUL_AGENT=<complete path to the extracted consulAgent.sh from Step 3>
	      e.g. /home/attcloud/dcae/dcae-deployer/bin/install/bin/consulAgent.sh
	  * LOCATION=<put the value of location_id from consul inputs.json file( downloaded in inputsDirectory from Step 2 )>	  
	 
Save the file and exit!!
````
#### 3) Run the ./deploy.sh script for building entire environment. (This includes, spinning up cloudify manager VM, bootstrapping cloudify manager, and deploying consul blueprint)
````
#####  Option-1: Just bootstrapping cloudify manager on new VM
       Note: This will instantiate a new VM and will bootstrap it with cloudify 3.4.0
       $ ./deploy.sh --action bootstrap
````
````
##### Option-2: Bootstrap cloudify manager on existing centOS VM
	  Note : This will bootstrap the provide IP-ADDRESS with the cloudify 3.4.0 
      $ ./deploy.sh --action bootstrap --cloudify-ip <IP-ADDRESS>
````
````
##### Option-3: Teardown cloudify manager
      Note: This will tear down the cloudify from the provided IP-ADDRESS but will not remove the VM
      $ ./deploy.sh --action teardown --cloudify-ip <IP-ADDRESS>
````
````
##### Option-4: Deploy consul
      Note: This will deploy the consul on provided IP-ADDRESS and will instantiate 3 new VMs
	  $ ./deploy.sh --action deploy --cloudify-ip <IP-ADDRESS> --component consul
````
````
##### Option-5: Undeploy consul
      Note : This will undeploy the consul from the provide IP-ADDRESS and will remove the 3 VMs
      $ ./deploy.sh --action undeploy --cloudify-ip <IP-ADDRESS> --component consul
````