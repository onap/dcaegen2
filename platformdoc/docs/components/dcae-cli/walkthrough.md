# Walk-through

This section demonstrates the flow and usage of the dcae_cli tool to onboard a typical component to the DCAE platform. The commands are explained in more detail in [dcae_cli Commands](/components/dcae-cli/commands).

* [Add (and validate) a data format](#add-a-data-format)
* [Add (and validate) the component](#add-the-component)
* [View the platform generated configuration](#view-the-platform-generated-configuration)
* [If needed, Create the dmaap file for Dmaap Testing](#create-input-file-for-dmaap-testing)
* [If needed, Create the input file for *Sourced at Deployment* Testing](#create-input-file-for-sourced-at-deployment-testing)
* [Run the component](#run-the-component)
* [If needed, Create the DTI entry in CONSUL for DTI Reconfiguration Testing](#create-DTI-entry-for-reconfiguration)
* [Undeploy the component](#undeploy-the-component)
* [Publish the component and data_format](#publish-the-component-and-data_format) to let others know its ready for reuse
* [List the Catalog Contents](#list-the-catalog-contents) to see your published resources

This walk-through uses example projects that can be found in CodeCloud:

* [laika](https://codecloud.web.att.com/projects/ST_DCAECNTR/repos/laika/browse)
* [CDAP examples](https://codecloud.web.att.com/projects/ST_DCAECNTR/repos/dcae_cli_examples/browse)

-------------------------------------------------------------------

## Add a Data Format
```
$ dcae_cli data_format add $HOME/laika/data-formats/health.json
```

Verify that the data_format was added
```
$ dcae_cli data_format list | grep laika                                                                                              
| sandbox.platform.laika.health | 0.1.0   | Data format used for the /health endpoint                   | staged    | 2017-11-07 21:48:47.736518 |
```

(Note: Each of the data formats for your component need to be added, unless already existing in the onboarding catalog )

-------------------------------------------------------------------

## Add the Component

```
$ dcae_cli component add $HOME/laika/component-spec.json
```

Verify that the component was added
```
$ dcae_cli component list 
Active profile: solutioning

+-------------------------------+---------+--------+---------------------------------------------------------------+--------+----------------------------+-----------+
| Name                          | Version | Type   | Description                                                   | Status | Modified                   | #Deployed |
+-------------------------------+---------+--------+---------------------------------------------------------------+--------+----------------------------+-----------+
| sandbox.platform.laika        | 0.7.0   | docker | Web service used as a stand-alone test DCAE service compone.. | staged | 2017-11-08 20:27:34.168854 | 0         |
+-------------------------------+---------+--------+---------------------------------------------------------------+--------+----------------------------+-----------+
```

-------------------------------------------------------------------

## View the platform generated configuration

The `component dev` command is useful during onboarding. Running this command is part of a multi-step process that sets up a temporary test environment, generates your application configuration, makes it available in that environment, and allows you to view that configuration to help with debugging.

Here is a step-by-step example based on a component specification called `component-spec.json`. 

### Step 1 - Run the component dev command

(This creates a file called env_$ENV (in the current directory)- where $ENV is the name of the active profile. Note: SERVICE_NAME and HOSTNAME always resolve to the same value).

```
$ dcae_cli component dev component-spec.json
Ready for component development

Setup these environment variables. Run "source env_solutioning":

export DOCKER_HOST=realsoldokr00.dcae.solutioning.homer.att.com:2376
export SERVICE_CHECK_INTERVAL=15s
export CONFIG_BINDING_SERVICE=config_binding_service
export HOSTNAME=ph8547.b599cf0e-75e8-484b-b8e2-557576d77036.0-7-0.sandbox-platform-laika
export CONSUL_HOST=realsolcnsl00.dcae.solutioning.homer.att.com
export CDAP_BROKER=cdap_broker
export SERVICE_NAME=ph8547.b599cf0e-75e8-484b-b8e2-557576d77036.0-7-0.sandbox-platform-laika
export SERVICE_CHECK_TIMEOUT=1s
export SERVICE_CHECK_HTTP=/health

Press any key to stop and to clean up
```

### Step 2 - Setup the environment
In another window, setup the temporary testing environment, by executing the environment file created above.

```
$ source env_solutioning
```

(The application configuration is now available under the SERVICE_NAME shown above - `ph8547.b599cf0e-75e8-484b-b8e2-557576d77036.0-7-0.sandbox-platform-laika`).


### Step 3 - Query CONSUL 
Query CONSUL to get the IP/PORT of CONFIG BINDING SERVICE

```
$ curl http://$CONSUL_HOST:8500/v1/catalog/service/$CONFIG_BINDING_SERVICE
[
  {
    "ID": "bfbc220d-4603-7f90-ec2e-611d3c330f20",
    "Node":"realsoldokr00",
    "Address": "10.226.1.15",
    "Datacenter":"solutioning-central",
    "TaggedAddresses": {
      "lan":"10.226.1.15",
      "wan":"10.226.1.15"
    },
    "NodeMeta": {},
    "ServiceID": "472b116f9035:config_binding_service:10000",
    "ServiceName": "config_binding_service",
    "ServiceTags": [],
    "ServiceAddress":"135.205.226.126",
    "ServicePort":10000,
    "ServiceEnableTagOverride": false,
    "CreateIndex":1078990,
    "ModifyIndex":1078990
  }
]
```

Fetch the generated configuration from CONFIG BINDING SERVICE using the 'serviceaddress' and 'serviceport' from above along with $SERVICE_NAME from earlier.

```
$ curl http://135.205.226.126:10000/service_component/ph8547.b599cf0e-75e8-484b-b8e2-557576d77036.0-7-0.sandbox-platform-laika

{"streams_subscribes": {}, "services_calls": {}, "multiplier": 3, "streams_publishes": {}}
```

-------------------------------------------------------------------

## Create the input file for Dmaap Testing

Currently, the dcae-cli tool does not have the capability to provision topics or feeds. Therefore, in order to test with `message router` or `data router` feeds, the developer must manually provision the topic or feed and then provide the connection details in the form of a DMaap JSON file for testing.  This file is then passed in on the `component run` or `component dev` commands by using the argument `--dmaap-file`.

The structure of the DMaaP JSON is an object of config keys with the topic or feed connection details. The config keys are the `config_key` values specified in the component specification streams section where the streams must be type `message router` or `data router`. This file corresponds to the `Dmaap Connection Object` which is generated by the platform and provided to the component at runtime. The exception is that `delivery_url` cannot be provided in the dmaap-file because it is not created until the component is deployed. Refer to [Dmaap Connection Object](/components/component-specification/dmaap-connection-objects), for details on creating the dmaap-file for testing.

-------------------------------------------------------------------

## Create the input file for *Sourced at Deployment* Testing

Components may have configuration parameters whose values are to be sourced at deployment time.  For example, there are components whose configuration parameters are to come from DTI events which are only available when the component is deployed.  This is established in the [component specification](/components/component-specification/common-specification/#parameters) by setting the property `sourced_at_deployment` to `true` for each applicable parameter.

Then, use the `--inputs-file` command-line argument when running the component `dev` or `run` command for your component.  This is to simulate providing the dynamic, deployment time values for those parameters marked as `sourced_at_deployment`.

For example, if your component specification has the following configuration parameters:

```
"parameters": [{
    "name": "vnf-ip",
    "value": "",
    "sourced_at_deployment": true
},
{
    "name": "static-param",
    "value": 5
}]
```

Pass in an input file that looks like:

```
{
    "vnf-ip": "10.100.1.100"
}
```

The  application configuration would look like:

```
{
    "vnf-ip": "10.100.1.100",
    "static-param": 5
}
```

-------------------------------------------------------------------

## Run the component

The `run` operation is to be used for running your application in its container remotely on the activated environment.  Docker containers have the additional option to run locally on your development machine. If the component uses Dmaap, you can specify the Dmaap Connection Object as well. Refer to [Dmaap Connection Object](/components/component-specification/dmaap-connection-objects). 

In order to run the component, the data formats and component must have been added to the onboarding catalog.

To verify what's in the catalog:

```
$ dcae_cli catalog list --expanded                                                                                      
Active profile: solutioning
+-------------------------+---------+--------+---------------------------------------------------------------+--------+----------------------------+-----------+
| Name                    | Version | Type   | Description                                                   | Status | Modified                   | #Deployed |
+-------------------------+---------+--------+---------------------------------------------------------------+--------+----------------------------+-----------+
| sandbox.platform.laika  | 0.7.0   | docker | Web service used as a stand-alone test DCAE service compone.. | staged | 2017-11-08 20:27:34.168854 | 0         |
+-------------------------+---------+--------+---------------------------------------------------------------+--------+----------------------------+-----------+

```


For Docker

**NOTE** Make sure the Docker image has been uploaded to the shared registry.

A docker component can be run in either `attached` or `unattached` mode. (Default is unattached).  

Mode | Description
---- | -----------
attached | component is run in the 'foreground', container logs are streamed to stdout. Ctrl-C is used to terminate the dcae_cli session. 
unattached | component is run in the 'background', container logs are viewed via `docker logs` command, container runs until undeployed with dcae_cli `undeploy` command.  


#### Run a component in attached mode:

```
$ dcae_cli -v component run --attached sandbox.platform.laika:0.7.0
DCAE.Docker | INFO | Running image 'nexus01.research.att.com:18443/repository/solutioning01-mte2-docker/dcae-platform/laika:0.7.0' as 'ph8547.dbb13a3c-d870-487e-b584-89929b856b5c.0-7-0.sandbox-platform-laika'
DCAE.Docker.ph8547.dbb13a3c-d870-487e-b584-89929b856b5c.0-7-0.sandbox-platform-laika | INFO | Consul host: realsolcnsl00.dcae.solutioning.homer.att.com

DCAE.Docker.ph8547.dbb13a3c-d870-487e-b584-89929b856b5c.0-7-0.sandbox-platform-laika | INFO | service name: ph8547.dbb13a3c-d870-487e-b584-89929b856b5c.0-7-0.sandbox-platform-laika

DCAE.Docker.ph8547.dbb13a3c-d870-487e-b584-89929b856b5c.0-7-0.sandbox-platform-laika | INFO | get_config returned the following configuration: {"streams_subscribes": {}, "multiplier": 3, "services_calls": {}, "streams_publishes": {}}

DCAE.Docker.ph8547.dbb13a3c-d870-487e-b584-89929b856b5c.0-7-0.sandbox-platform-laika | INFO |  * Running on http://0.0.0.0:8080/ (Press CTRL+C to quit)

DCAE.Docker.ph8547.dbb13a3c-d870-487e-b584-89929b856b5c.0-7-0.sandbox-platform-laika | INFO | 135.205.226.156 - - [08/Nov/2017 23:27:30] "GET /health HTTP/1.1" 200 -


Hit Ctrl-C to terminate session.

^C
DCAE.Docker | INFO | Stopping container 'ph8547.dbb13a3c-d870-487e-b584-89929b856b5c.0-7-0.sandbox-platform-laika' and cleaning up...
```

#### Run a component in unattached mode:

```
$ dcae_cli -v component run sandbox.platform.laika:0.7.0
DCAE.Docker | INFO | Running image 'nexus01.research.att.com:18443/repository/solutioning01-mte2-docker/dcae-platform/laika:0.7.0' as 'ph8547.22629ebd-417e-4e61-a9a0-f0cb16d4cef2.0-7-0.sandbox-platform-laika'
DCAE.Run | INFO | Deployed ph8547.22629ebd-417e-4e61-a9a0-f0cb16d4cef2.0-7-0.sandbox-platform-laika. Verifying..
DCAE.Run | INFO | Container is up and healthy
```

**NOTE** You must undeploy this component when finished testing. This is important to conserve resources in the environment.

#### Run a component that subscribes to Dmaap Message Router or Data Router

```
$ dcae_cli -v component run $component-that-uses-dmamp --dmaap-file $dmaap-connection-object
```

#### Run a component that expects input that is `sourced at deployment`

```
$ dcae_cli -v component run $component-that-expects-dti --inputs-file $input-file-to-simulate-dti
```

-------------------------------------------------------------------

## Create the DTI Entry for Reconfiguration

Go the the CONSUL UI for the environment that you are working in. Add a `dti` entry to represent one or more instances of `vnfType-vnfFuncId` for your component.

For example, in 1802, go (here)[http://zldcrdm5bdcc2cnsl00.2f3fb3.rdm5b.tci.att.com:8500/ui/#/zldcrdm5bdcc2/kv/).

Do CNTL-F to find your running MS
Click on + to add your entry
Enter your $SERVICE_NAME:dti as the Key 
Paste your JSON into the box, remember to `check` the VALIDATE JSON box
Click on CREATE

Verify that you can retrieve the dti entry you just created as in this example: (Remember to use the 'serviceaddress' and 'serviceport' from above for CONFIG BINDING SERVICE).

```
http://135.203.226.126:10000/dti/<service name>``
```
(You should see the entry you created above)

-------------------------------------------------------------------

## Run the reconfigure script

Execute the components reconfigure script as defined in the Auxilary section of the component spec, such as in this example:

```
/opt/app/reconfigure.sh dti $updated_dti 
```

(Refer to [DTI Reconfiguration](/components/component-specification/docker-specification/#dti-reconfiguration)

Verify that your component received and is processed the updated set of vnfType-vnfFuncId instances.

------------------------------------------------------------------
## Undeploy the component

The `undeploy` command is used to undeploy any instance of a specified component/version that you have deployed.  This includes cleaning up the configuration.

Undeploy `sandbox.platform.laika:0.7.0` that was deployed above:

```
$ dcae_cli -v component undeploy sandbox.platform.laika:0.7.0
DCAE.Undeploy | WARNING | Undeploying components: 1
DCAE.Undeploy | WARNING | Undeployed components: 1
```

-------------------------------------------------------------------

## Publish the component and data_format

Once a component has been tested, it (and the data_format(s)) should be published in the onboarding catalog using the `publish` sub-command for both the `data_format` and `component` command.  

**Note** Before a component can be published, all data_formats that it references must be published.

Publishing will change the status of a component or data_format, indicating that it has been tested, make accessible for other developers to use.

```
$ dcae_cli data_format publish sandbox.platform.laika:0.7.0
Data format has been published

$dcae_cli component publish sandbox.platform.laika:0.7.0
Component has been published

```
-------------------------------------------------------------------

## List the catalog contents

```
$dcae_cli catalog list

$ dcae_cli data_format list | grep sandbox
| sandbox.platform.laika         | 0.7.0   | docker | Web service used as a stand-alone test DCAE service compone..       | ph8547 | published | 2017-11-13 |
| sandbox.platform.laika.health            | 0.1.0   | Data format used for the /health endpoint                          | published | 2017-11-13 17:48:10.121588 |
| sandbox.platform.any                     | 0.1.0   | Data format used when no data format is required.                  | published | 2017-11-13 17:47:51.622607 |
| sandbox.platform.laika.identity.response | 0.1.0   | Data format used for the /identity endpoint response which should  | published | 2017-11-13 17:47:43.234715 |
| sandbox.platform.laika.identity.request  | 0.1.0   | Data format used for the /identity endpoint request. This is       | published | 2017-11-13 17:47:36.693643 |
| sandbox.platform.laika.rollcall.response | 0.1.0   | Data format used for the /rollcall endpoint respon..               | published | 2017-11-13 17:46:30.026846 |
```

