# Walk-through

The goal of this quickstart is to provide an overview of the functionalities of the `dcae-cli` and walk you through the capabilities:

* [Adding data formats](#adding-data-formats)
* [Adding component](#adding-component)
* [Setting profile](#setting-profile)
* [Development and testing](#development-and-testing)
* [Publishing component](#publishing-component)
* [Shared catalog](#shared-catalog)

This walk-through uses example projects:

* [laika](ONAP URL TBD)
* [CDAP examples](ONAP URL TBD)

## Adding data formats

`data_format` is the sub-command that is used to execute operations that manage [data formats](../data-formats.md).

```
$ dcae_cli data_format --help
Usage: dcae_cli data_format [OPTIONS] COMMAND [ARGS]...

Options:
  --help  Show this message and exit.

Commands:
  add      Tracks a data format file SPECIFICATION...
  generate Generates a data format file from JSON input examples
  list     Lists all your data formats
  publish  Publishes data format to make publicly...
  show     Provides more information about FORMAT
```

Your data format must be in the catalog in order to use in the component specification.  Check the catalog using the `data_format list` sub-command:

```
$ dcae_cli data_format list

Data formats for mh677g
+------+---------+-------------+--------+----------+
| Name | Version | Description | Status | Modified |
+------+---------+-------------+--------+----------+
|      |         |             |        |          |
+------+---------+-------------+--------+----------+
```

The fields `name`, `version`, `description` are referenced from the data format JSON from the `self` JSON.

There are no data formats so you must add the data formats that your component specification references.  Use the `data_format add` sub-command:

Here's an example command:

```
dcae_cli data_format add health.json
```

Verify that it was added:

```
$ dcae_cli data_format list

Data formats for mh677g
+-------------------------------+---------+-------------------------------------------+--------+----------------------------+
| Name                          | Version | Description                               | Status | Modified                   |
+-------------------------------+---------+-------------------------------------------+--------+----------------------------+
| sandbox.platform.laika.health | 0.1.0   | Data format used for the /health endpoint | staged | 2017-05-23 04:02:38.952799 |
+-------------------------------+---------+-------------------------------------------+--------+----------------------------+
```

Go ahead and add other referenced data formats.

If you have JSON input you can generate a data format like this:

```
$ dcae_cli data_format --keywords generate myname:1.0.0  myjsoninputfile
```

where `myname` is the name of your data format, `1.0.0` is an example version, and `myjsoninputfile` is an example JSON input file (a directory of input JSON files can also be provided).   The `--keywords` option adds additional data attributes that can be completed to provide a more detailed data characterization. In any event the output should be reviewed for accuracy.  The data format is written to stdout.   

## Adding component

`component` is the sub-command that is used to work with operations for components:

```
$ dcae_cli component --help
Usage: dcae_cli component [OPTIONS] COMMAND [ARGS]...

Options:
  --help  Show this message and exit.

Commands:
  add
  dev       Set up component in development for...
  list      Lists components in the public catalog.
  publish   Pushes COMPONENT to the public catalog
  run       Runs the latest version of COMPONENT.
  show      Provides more information about COMPONENT
  undeploy  Undeploys the latest version of COMPONENT.
```

Your component must be accessible from the catalog in order for it to be used.  Check the catalog using the `component list` sub-command:

```
$ dcae_cli component list
Active profile: solutioning

+------+---------+------+-------------+--------+----------+-----------+
| Name | Version | Type | Description | Status | Modified | #Deployed |
+------+---------+------+-------------+--------+----------+-----------+
|      |         |      |             |        |          |           |
+------+---------+------+-------------+--------+----------+-----------+

Use the "--deployed" option to see more details on deployments
```

The fields `name`, `version`, `type`, `description` are referenced from the component specification's `self` JSON.

There are no components so you must add your component.  Use the `component add` sub-command.  The command is the same for docker and cdap components:

```
$ dcae_cli component add --help
Usage: dcae_cli component add [OPTIONS] SPECIFICATION

Options:
  --update  Updates a locally added component if it has not been already
            pushed
  --help    Show this message and exit.
```

*Note* use the `--update` flag to replace existing staged instances.

The `component dev` sub-command can be useful in validating and experimenting when crafting your component specification.  See details about `dev` under [Development and testing](#development-and-testing).

Once we add the components laika and helloworld, let's verify that they got added ok:

```
$ dcae_cli component list
Active profile: solutioning

+-------------------------+---------+--------+---------------------------------------------------------------+--------+----------------------------+-----------+
| Name                    | Version | Type   | Description                                                   | Status | Modified                   | #Deployed |
+-------------------------+---------+--------+---------------------------------------------------------------+--------+----------------------------+-----------+
| cdap.helloworld.endnode | 0.8.0   | cdap   | cdap test component                                           | staged | 2017-05-23 04:14:35.588075 | 0         |
| sandbox.platform.laika  | 0.5.0   | docker | Web service used as a stand-alone test DCAE service compone.. | staged | 2017-05-23 04:07:44.065610 | 0         |
+-------------------------+---------+--------+---------------------------------------------------------------+--------+----------------------------+-----------+

Use the "--deployed" option to see more details on deployments
```

## Setting profile

`profile` is the sub-command that is used to manage profiles.  These profiles contain environment variables used to connect to different environments.  This is used in the running and deployment of your component using the `dcae_cli component run` command.  The `dcae-cli` ships with profiles for `solutioning` and `rework`.

```
$ dcae_cli profiles --help
Usage: dcae_cli profiles [OPTIONS] COMMAND [ARGS]...

Options:
  --help  Show this message and exit.

Commands:
  activate  Sets profile NAME as the active profile
  create    Creates a new profile NAME initialized with...
  delete    Deletes profile NAME
  list      Lists available profiles
  set       Updates profile NAME such that KEY=VALUE
  show      Prints the profile dictionary
```

To see what variables a profile contains, you can use the `show` command, as in `dcae_cli profiles show PROFILE_NAME`

Use the `create` sub-command to create your own profile and assign new values using the `set` command.  Afterwards you will need to `activate` the profile you wish to use.  First take a look at which profile is active:

```
$ dcae_cli profiles list
   rework
*  solutioning
```

The active profile is `solutioning` so to activate *rework* to use `rework`:

```
$ dcae_cli profiles activate rework
```

Check

```
$ dcae_cli profiles list
*  rework
   solutioning
```

## Development and testing

The following operations under the sub-command `component` are aimed to help developers with testing:

* `run`
* `undeploy`
* `dev`

### `run`

The `run` operation is to be used for running your application in its container remotely on the activated environment.  Docker containers have the additional option to run locally on your development machine.

In order to run your application, you must have added your data formats and your component to your catalog.

Let's verify that your component is in the catalog:

```
$ dcae_cli component list                                                                                       
Active profile: solutioning

+-------------------------+---------+--------+---------------------------------------------------------------+--------+----------------------------+-----------+
| Name                    | Version | Type   | Description                                                   | Status | Modified                   | #Deployed |
+-------------------------+---------+--------+---------------------------------------------------------------+--------+----------------------------+-----------+
| cdap.helloworld.endnode | 0.8.0   | cdap   | cdap test component                                           | staged | 2017-05-23 04:14:35.588075 | 0         |
| sandbox.platform.laika  | 0.5.0   | docker | Web service used as a stand-alone test DCAE service compone.. | staged | 2017-05-23 04:07:44.065610 | 0         |
+-------------------------+---------+--------+---------------------------------------------------------------+--------+----------------------------+-----------+

Use the "--deployed" option to see more details on deployments
```

#### Docker

**NOTE** Make sure your Docker image has been uploaded to the shared registry.

For Docker containers, you can run either attached or unattached.  Attached means that the dcae-cli tool will launch the container and not terminate.  The dcae-cli while attached will stream in the logs of the Docker container.  Doing a Ctrl-C will terminate the run session which means undeploy your container and force a clean up automatically.

Running unattached means simply deploy your container.  You will need to execute `undeploy` when you are done testing.
#### CDAP

**NOTE** Make sure your CDAP jar has been uploaded to Nexus.

TODO

### `undeploy`

The `undeploy` operation is to be used to undeploy any instances of a specified component, version that you have deployed.  This includes cleaning up of configuration.

Let's undeploy `sandbox.platform.laika` that was deployed from the previous section:

```
$ dcae_cli component undeploy sandbox.platform.laika:0.5.0
DCAE.Undeploy | WARNING | Undeploying components: 1
DCAE.Undeploy | WARNING | Undeployed components: 1
```

### `dev`

The `dev` operation is a convenient operation that can be useful for the development and testing of your component.  It can be used to:

* Help validate your experimental component specification before uploading to the catalog
* Generate the application configuration from the component specification and make it available in a test environment.  This allows you to view your resulting configuration for local development and to help debug potential related issues.

Let's say you have a component specification called `component-spec.json`:

```
$ dcae_cli component dev component-spec.json 
Ready for component development

Setup these environment varibles. Run "source env_solutioning":

export DOCKER_HOST=SOME_DOCKER_HOST:2376
export SERVICE_CHECK_INTERVAL=15s
export CONFIG_BINDING_SERVICE=config_binding_service
export HOSTNAME=mh677g.95740959-63d2-492a-b964-62a6dce2591d.0-6-0.sandbox-platform-laika
export CONSUL_HOST=SOME_CONSUL_HOST
export CDAP_BROKER=cdap_broker
export SERVICE_NAME=mh677g.95740959-63d2-492a-b964-62a6dce2591d.0-6-0.sandbox-platform-laika
export SERVICE_CHECK_TIMEOUT=1s
export SERVICE_CHECK_HTTP=/health

Press any key to stop and to clean up
```

Your application configuration is now available under the name `mh677g.95740959-63d2-492a-b964-62a6dce2591d.0-6-0.sandbox-platform-laika`.

To view the resulting configuration, you can `curl` a request to the config binding service or programmatically fetch your configuration within your application.

You need to first query Consul to get the ip and port of config binding service:

```
curl http://$CONSUL_HOST:8500/v1/catalog/service/$CONFIG_BINDING_SERVICE
[
  {
    "ID": "983d5c94-c508-4a8a-9be3-5912bd09786b",
    "Node": "realsolcnsl00",
    "Address": "10.226.1.22",
    "TaggedAddresses": {
      "lan": "10.226.1.22",
      "wan": "10.226.1.22"
    },
    "NodeMeta": {},
    "ServiceID": "5f371f295c90:config_binding_service:10000",
    "ServiceName": "config_binding_service",
    "ServiceTags": [],
    "ServiceAddress": "XXXX",
    "ServicePort": 32770,
    "ServiceEnableTagOverride": false,
    "CreateIndex": 487,
    "ModifyIndex": 487
  }
]
```

### DMaaP testing

Currently, the dcae-cli does not have the capability of provisioning topics.  In order to do testing with message router topics or with data router feeds, the developer must provision the topic or the feed manually and provide the connection details in the form of a JSON in a file to the dcae-cli.  This file is to be passed in when using the `run` and `dev` commands with the option `--dmaap-file`.

The structure of the DMaaP JSON is an object of config keys to matching topic or feed connection details.  Config keys are the `config_key` values specified in your component specification streams section where the streams must be type message router or data router.  Information about the associated connection details can be found on [this page](dmaap-connection-objects.md).  Please check it out.

For example, if you have a component specification that has the following streams entry:

```json
"streams": {
    "publishes": [{
        "format": "ves",
        "version": "1.0.0",
        "type": "message router",
        "config_key": "ves_connection"
    }]
}
```

Then to deploy and to run your component, you must use the `--dmaap-file` command and pass in a JSON that looks like:

```json
{
    "ves_connection": {
        "type": "message_router",
        "dmaap_info": {
            "topic_url": "https://we-are-message-router.us:3905/events/some-topic"
        }
    }
}
```

The provided DMaaP JSON is used to simulate the output of provisioning and will be used to merge with the generated application configuration at runtime.

Your final application config will look like:

```json
{
    "streams_publishes": {
        "ves_connection": {
            "type": "message_router",
            "dmaap_info": {
                "topic_url": "https://we-are-message-router.us:3905/events/some-topic"
            }
        }
    }
}
```

#### Data router subscribers

Note for data router subscriber testing, you will need the delivery url in order to provision the subscriber to the feed.  This is constructed at deployment time and will be provided by the dcae-cli after you deploy your component.  The delivery urls will be displayed to the screen:

```
DCAE.Run | WARNING | Your component is a data router subscriber. Here are the delivery urls: 

        some-sub-dr: http://SOME_IP:32838/identity

```

### *Sourced at deployment* testing

Components may have configuration parameters whose values are to be sourced at deployment time.  For example, there are components whose configuration parameters are to come from DTI events which are only available when the component is getting deployed.  These configuration parameters must be setup correctly in the [component specification](http://localhost:8000/components/component-specification/docker-specification/#configuration-parameters) by setting the property `sourced_at_deployment` to `true` for each and every parameter that is expected to come in at deployment time.

Once your component specification has been updated correctly, you must use the `--inputs-file` command-line argument when running the commands `dev` or `run` with your component.  This is to simulate providing the dynamic, deployment time values for those parameters marked as `sourced_at_deployment`.

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

You would have to pass in an inputs file that looks like:

```
{
    "vnf-ip": "10.100.1.100"
}
```

Your application configuration would look like:

```
{
    "vnf-ip": "10.100.1.100",
    "static-param": 5
}
```

## Publishing component

Once components have their component specifications crafted and validated and have been tested, components should be published in the shared onboarding catalog using the `publish` sub-command for both data formats and components.  You must publish all data formats of a component before publishing a component.

Publishing will change the status of a component, be made accessible for other developers to use, and will generate the associated TOSCA models for use in designing of compositions.

```
dcae_cli component publish sandbox.platform.laika:0.5.0
```

## Shared catalog

`catalog` is the sub-command used to access and to browse the shared onboarding catalog to view components and data formats that have been published and that are being worked on.  Components and data formats have two statuses `staged` and `published`.

Staged means that the resource has been simply added and is under development.  It is to be used only by the owner.  Published means that the resource has been fully developed and tested and is ready to be shared.

Published components can be deployed by non-owners and published data formats can be used in component specifications of non-owners.

There are two available operations:

```
$ dcae_cli catalog --help
Usage: dcae_cli catalog [OPTIONS] COMMAND [ARGS]...

Options:
  --help  Show this message and exit.

Commands:
  list
  show
```

Staged components can be viewed under the `list` operation using the `--expanded` flag.
