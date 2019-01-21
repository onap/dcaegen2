.. This work is licensed under a Creative Commons Attribution 4.0 International License.
.. http://creativecommons.org/licenses/by/4.0

.. _dcae_cli_commands:

dcae_cli Commands
=================

The dcae_cli tool has four command groups. Each has several
sub-commands.

``catalog``
-----------

The ``catalog`` command lists and shows resources (components and
data_formats) in the ‘onboarding’ catalog (regardless of the owner). A
resource can have a status of ``staged`` or ``published``. By default,
only ``published`` resources are displayed. To see ``staged`` resources,
add the –expanded argument.

+------------------------------+----------------------------------------+
| Catalog Status               | Meaning                                |
+==============================+========================================+
| staged                       | resource has be added                  |
|                              | (and validated), but                   |
|                              | is under development                   |
+------------------------------+----------------------------------------+
| staged                       | data_formats can only be referenced in |
|                              | their owners component specs           |
+------------------------------+----------------------------------------+
| staged                       | components can only be deployed by     |
|                              | their owners                           |
+------------------------------+----------------------------------------+
| published                    | resource has been                      |
|                              | tested and can be                      |
|                              | shared                                 |
+------------------------------+----------------------------------------+
|                              | published data_formats can be used in  |
|                              | anyone's component spec                |
+------------------------------+----------------------------------------+
|                              | published components and be deployed by|
|                              | anyone                                 |
+------------------------------+----------------------------------------+

::

    $ dcae_cli catalog --help
    Usage: dcae_cli catalog [OPTIONS] COMMAND [ARGS]...

    Options:
      --help  Show this message and exit.

    Commands:
      list      Lists resources in the onboarding catalog
      show      Provides more information about resource

List onboarding catalog contents
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

::

    $ dcae_cli catalog list
    Components:
    +--------------------------------+---------+--------+---------------------------------------------------------------------+--------+-----------+------------+
    | Name                           | Version | Type   | Description                                                         | Owner  | Status    | Published  |
    +--------------------------------+---------+--------+---------------------------------------------------------------------+--------+-----------+------------+
    | DcaeSyslogCollector            | 2.0.0   | docker | DCAE Control Plane Syslog Collector                                 | sh1986 | published | 2017-08-04 |
    | cdap.dmaap.spec.example        | 0.2.0   | cdap   | dmaap spec example. Not a functioning application, only for showing | tc677g | published | 2017-07-24 |
    |                                |         |        | how to pub/sub dmaap. Pretend this is like MAP with VES in and ou.. |        |           |            |
    | cdap.event.proc.enrich.app     | 1.0.3   | cdap   | CDAP Event Processing Enrich application                            | an4828 | published | 2017-09-20 |
    | cdap.event.proc.map.app        | 1.0.3   | cdap   | CDAP Event Processing Map application                               | an4828 | published | 2017-09-20 |

    ...

    Data formats:
    +--------------------------------------------+---------+-----------------------------------------------------------------------+--------+-----------+------------+
    | Name                                       | Version | Description                                                           | Owner  | Status    | Published  |
    +--------------------------------------------+---------+-----------------------------------------------------------------------+--------+-----------+------------+
    | FOI_PM_VHSS_data_format                    | 1.0.0   | CSV pipe delimited data format for VHSS PM files                      | sr229c | published | 2017-09-05 |
    | Map_input                                  | 1.0.0   | The input format for Mapper, that in 1707 is the UCSNMP Collector     | an4828 | published | 2017-07-18 |
    |                                            |         | output format, but will support more formats later                    |        |           |            |
    | Syslog Collector Parsed Json Message       | 1.0.0   | Post processed/parsed collected syslog message                        | sh1986 | published | 2017-08-04 |
    | Syslog Collector Syslog Message Input      | 1.0.0   | The input message for the DCAE syslog collector is free/unstructured  | sh1986 | published | 2017-08-04 |
    |                                            |         | text                                                                  |        |           |            |
    | myapp Alert Definition                     | 1.0.0   | The format of the output event from myapp                               | an4828 | published | 2017-08-10 |
    | VES_specification                          | 5.28.4  | VES spec for 5.4                                                      | vv770d | published | 2017-09-19 |

    ...

Show the contents of an item in the catalog
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

::

    $ dcae_cli catalog show FOI_PM_VHSS_data_format

    Data format
    -----------
    {
        "dataformatversion": "1.0.0", 
        "delimitedschema": {
            "delimiter": "|", 
            "fields": [
                {
                    "description": "System ID", 
                    "fieldtype": "string", 
                    "name": "SYSTEM"
                }, 
                {
                    "description": "Date", 
                    "fieldtype": "string", 
                    "name": "DATE"
                }, 
                {
                    "description": "Time", 
                    "fieldtype": "string", 
                    "name": "TIME"
                }, 

    ...

.. _dcae_cli_component_commands:

--------------

``component``
-------------

The ``component`` command is for validating (adding), listing, showing,
verifying generated configuration, running, undeploying, and publishing
components that YOU own.

::

    $ dcae_cli component --help
    Usage: dcae_cli component [OPTIONS] COMMAND [ARGS]...

    Options:
      --help  Show this message and exit.

    Commands:
      add
      dev       Set up component in development for...
      list      Lists components in the onboarding catalog.
      publish   Pushes COMPONENT to the onboarding catalog
      run       Runs the latest version of COMPONENT.
      show      Provides more information about COMPONENT
      undeploy  Undeploys the latest version of COMPONENT.

--------------

.. _dcae_cli_add_a_component:

Add a Component
~~~~~~~~~~~~~~~

A component must be added to the onboarding catalog in order to be
tested by the dcae_cli tool. The process of adding a component also
validates it’s component specification. In order to add a component, the
component docker image (or CDAP jar) must exist locally.

Components in the onboarding catalog can be run by others, once they are
``published.`` ``Published`` components cannot be modified or deleted.
Rather a new version can be created instead.

Validated component specs are used later to generate Tosca models and
Cloudify Blueprints for the component, which makes them available for
use in the SDC Tool for creating services.

::

    $ dcae_cli component add --help
    Usage: dcae_cli component add [OPTIONS] COMPONENT-SPECIFICATION

    Options:
      --update  Updates a previously added component if it has not been already
                published
      --help    Show this message and exit.

::

    $ dcae_cli component add component-spec.json 

--------------

List Components
~~~~~~~~~~~~~~~

List components in the onboarding catalog that owned by YOUR userid..

::

    $ dcae_cli component list
    Active profile: solutioning
    +-------------------------+---------+--------+---------------------------------------------------------------+--------+----------------------------+-----------+
    | Name                    | Version | Type   | Description                                                   | Status | Modified                   | #Deployed |
    +-------------------------+---------+--------+---------------------------------------------------------------+--------+----------------------------+-----------+
    | cdap.helloworld.endnode | 0.8.0   | cdap   | cdap test component                                           | staged | 2017-05-23 04:14:35.588075 | 0         |
    | sandbox.platform.yourapp| 0.5.0   | docker | Web service used as a stand-alone test DCAE service compone.. | staged | 2017-05-23 04:07:44.065610 | 0         |
    +-------------------------+---------+--------+---------------------------------------------------------------+--------+----------------------------+-----------+

The fields ``Name``, ``Version``, ``Type``, ``Description`` are
referenced from the component specification’s ``self`` JSON. Use the
“–deployed” argument to see more details on deployed components

--------------

.. _dcae_cli_run_a_component:

Run a Component
~~~~~~~~~~~~~~~

The ``run`` operation is to be used for running your application in its
container remotely on the activated environment. Docker containers have
the additional option to run locally on your development machine. If the
component uses Dmaap, you can specify the Dmaap Connection Object as
well. Refer to :doc:`Dmaap Connection Object <../component-specification/dmaap-connection-objects>`.

When you run a component via the dcae_cli Tool, remember the blueprint
has not been created and is not used for deployment.

In order to run the component, the data formats and component must have
been added to the onboarding catalog.

**DOCKER NOTE:** Make sure the Docker image has been uploaded to the
shared registry.

A docker component can be run in either ``attached`` or ``unattached``
mode. (Default is unattached).

+------------------+---------------------------------------------------+
| Mode             | Description                                       |
+==================+===================================================+
| attached         | component is run in the ‘foreground’, container   |
|                  | logs are streamed to stdout. Ctrl-C is used to    |
|                  | terminate the dcae_cli session.                   |
+------------------+---------------------------------------------------+
| unattached       | component is run in the ‘background’, container   |
|                  | logs are viewed via ``docker logs`` command,      |
|                  | container runs until undeployed with dcae_cli     |
|                  | ``undeploy`` command.                             |
+------------------+---------------------------------------------------+

Run a component in attached mode:
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

::

    $ dcae_cli -v component run --attached sandbox.platform.yourapp:0.5.0

    DCAE.Docker | INFO | Running image 'registry.proto.server.com/dcae-rework/yourapp:0.4.0' as 'user1.b7287639-37f5-4f25-8d54-8a2087f4c8da.0-5-0.sandbox-platform-yourapp'
    DCAE.Docker.user1.b7287639-37f5-4f25-8d54-8a2087f4c8da.0-5-0.sandbox-platform-yourapp | INFO | Consul host: yourconsulhost.com

    DCAE.Docker.user1.b7287639-37f5-4f25-8d54-8a2087f4c8da.0-5-0.sandbox-platform-yourapp | INFO | service name: mh677g.b7287639-37f5-4f25-8d54-8a2087f4c8da.0-5-0.sandbox-platform-yourapp

    DCAE.Docker.user1.b7287639-37f5-4f25-8d54-8a2087f4c8da.0-5-0.sandbox-platform-yourapp | INFO | Generated config: {'multiplier': 3}

    DCAE.Docker.user1.b7287639-37f5-4f25-8d54-8a2087f4c8da.0-5-0.sandbox-platform-yourapp | INFO |  * Running on http://0.0.0.0:8080/ (Press CTRL+C to quit)

    DCAE.Docker.user1.b7287639-37f5-4f25-8d54-8a2087f4c8da.0-5-0.sandbox-platform-yourapp | INFO | 127.0.0.1 - - [24/May/2017 03:37:57] "GET /health HTTP/1.1" 200 -

    DCAE.Docker.user1.b7287639-37f5-4f25-8d54-8a2087f4c8da.0-5-0.sandbox-platform-yourapp | INFO | 127.0.0.1 - - [24/May/2017 03:38:12] "GET /health HTTP/1.1" 200 -

Hit Ctrl-C to terminate session.

::

    ^CDCAE.Docker | INFO | Stopping container 'user1.b7287639-37f5-4f25-8d54-8a2087f4c8da.0-5-0.sandbox-platform-yourapp' and cleaning up...

Run a component in unattached mode:
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

::

    $ dcae_cli -v component run sandbox.platform.yourapp:0.5.0
    DCAE.Docker | INFO | Running image 'registry.proto.server.com/dcae-rework/yourapp:0.4.0' as 'user1.4811da0e-08d5-429f-93bf-bf6814924577.0-5-0.sandbox-platform-yourapp'
    DCAE.Run | INFO | Deployed /user1.4811da0e-08d5-429f-93bf-bf6814924577.0-5-0.sandbox-platform-yourapp

**NOTE** You must undeploy this component when finished testing. This is
important to conserve resources in the environment.

Run a component that subscribes to Dmaap MR or DR
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

::

    $ dcae_cli -v component run --attached --dmaap-file $dmaap-connection-file sandbox.platform.yourapp:0.5.0 

--------------

Undeploy a Component
~~~~~~~~~~~~~~~~~~~~

The ``undeploy`` command is used to undeploy any instance of a specified
component/version that you have deployed. This includes cleaning up the
configuration.

::

    $ dcae_cli component undeploy sandbox.platform.yourapp:0.5.0
    DCAE.Undeploy | WARNING | Undeploying components: 1
    DCAE.Undeploy | WARNING | Undeployed components: 1

--------------

Publish a component
~~~~~~~~~~~~~~~~~~~

| Once a component has been tested, it should be published in the
  onboarding catalog using the ``publish`` sub-command .
| Publishing will change the status of the component (from ``staged`` to
  ``published``), indicating that it has been tested, and making it
  accessible for other developers to use.

**Note** Before a component can be published, all data_formats that it
references must be published.

::

    dcae_cli component publish sandbox.platform.yourapp:0.5.0

--------------

Show a Component
~~~~~~~~~~~~~~~~

This will print out the contents of a component and is useful to copy a
component spec.

::

    $ dcae_cli component show

--------------

.. _dcae-cli-run-the-dev-command:

Run the ``dev`` command
~~~~~~~~~~~~~~~~~~~~~~~

The ``dev`` command is used as part of a process to see the platform
generated configuration. It established the environment variables and is
best explained
:any:`here <dcae-cli-view-the-platform>`.

::

    $ dcae_cli component dev component-spec.json
    Ready for component development

--------------

.. _dcae_cli_data_format:

``data_format``
---------------

The ``data_format`` command is for validating (adding), listing,
showing, publishing data_formats that YOU own. data_formats can also be
generated with this command.

::

    $ dcae_cli data_format --help
    Usage: dcae_cli data_format [OPTIONS] COMMAND [ARGS]...

    Options:
      --help  Show this message and exit.

    Commands:
      add       Tracks a data format file DATA_FORMAT-SPECIFICATION...
      generate  Create schema from a file or directory...
      list      Lists all your data formats
      publish   Publishes data format to make available to others...
      show      Provides more information about FORMAT

--------------

.. _dcae_cli_add_a_data_format:

Add a Data Format
~~~~~~~~~~~~~~~~~

A data_format must be in the onboarding catalog in order to be
referenced in the component specification. The process of adding a
data_format also validates it. Data_formats in the onboarding catalog
can be run by others, once they are ``published.`` ``Published``
data_formats cannot be modified or deleted. Rather a new version can be
created instead.

::

    $ dcae_cli data_format add --help
    Usage: dcae_cli data_format add [OPTIONS] DATA_FORMAT-SPECIFICATION

    Options:
      --update  Updates a previously added data_format if it has not been already
                published
      --help    Show this message and exit.

::

    dcae_cli data_format add health.json

--------------

List Data Formats
~~~~~~~~~~~~~~~~~

Only data_formats owned by YOUR userid will be shown.

::

    $ dcae_cli data_format list

    Data formats for user1
    +---------------------------------+---------+-------------------------------------------+--------+----------------------------+
    | Name                            | Version | Description                               | Status | Modified                   |
    +---------------------------------+---------+-------------------------------------------+--------+----------------------------+
    | sandbox.platform.yourapp.health | 0.1.0   | Data format used for the /health endpoint | staged | 2017-05-23 04:02:38.952799 |
    +---------------------------------+---------+-------------------------------------------+--------+----------------------------+

The fields ``name``, ``version``, ``description`` are referenced from
the data format specification’s ``self`` JSON. ``Status`` represents the
status of the data format in the catalog. See `Publish a Data
Format <#publish-a-data-format>`__ for more info.

--------------

Show a Data Format
~~~~~~~~~~~~~~~~~~

This will print out the contents of a data_format and is useful for
copying a data_format.

::

    $ dcae_cli data_format show

--------------

Publish a Data Format
~~~~~~~~~~~~~~~~~~~~~

| Once a data_format has been tested (by referencing it in a component
  spec that has been tested), it should be published in the onboarding
  catalog using the ``publish`` sub-command .
| Publishing will change the status of the data_format (from ``staged``
  to ``published``), indicating that it has been tested, and making it
  accessible for other developers to use.

::

    $ dcae_cli data_format publish data_format.json

--------------

Generate a Data Format
~~~~~~~~~~~~~~~~~~~~~~

If you already have a valid input or output file, you can use the
generate command to create the it’s data format specification.

::

    $ dcae_cli data_format generate name:version file-or-dir-path

--------------

``profiles``
------------

The\ ``profiles`` command is for creating, deleting, listing, showing,
activating, and updating (set) profiles. The profile contains
environment variables used to connect to different environments. This is
used in the running and deployment of a component using the
``dcae_cli component run`` or ``dev`` command.

::

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

--------------

List the available profiles
~~~~~~~~~~~~~~~~~~~~~~~~~~~

::

    $ dcae_cli profiles list
    *  solutioning
       1710
       1802

The \* identifies the active profile. ``dcae-cli`` is currently
installed with profiles for the ``solutioning``, ``1710``, and ``1802``
environments. They are intended for the following:

+-----------------------------------+-----------------------------------+
| Environment                       | Description                       |
+===================================+===================================+
| solutioning                       | default environment; used for     |
|                                   | initial component developer       |
|                                   | testing with the dcae_cli tool.   |
+-----------------------------------+-----------------------------------+
| 1710                              | FTL3 (Functional Testing Lab 3)   |
|                                   | environment, which represents the |
|                                   | 1710 release.                     |
+-----------------------------------+-----------------------------------+
| 1802                              | FTL3a (Functional Testing Lab 3a) |
|                                   | environment, which represents the |
|                                   | 1802 release.                     |
+-----------------------------------+-----------------------------------+

--------------

Show the details of a profile
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

::

    $ dcae_cli profiles show solutioning
    {
        "cdap_broker": "cdap_broker",
        "config_binding_service": "config_binding_service",
        "consul_host": "yourconsulhost.com",
        "docker_host": "yourdockerhost.com:2376"
    }

--------------

.. _dcae_cli_activate_profile:

Activate a profile
~~~~~~~~~~~~~~~~~~

To switch among profiles, use the activate sub-command. A subsequent
``list`` will reveal the change made.

::

    $ dcae_cli profiles activate test

--------------

Create a new profile
~~~~~~~~~~~~~~~~~~~~

If you want to work in a different environment using the dcae_cli tool,
you can make your own profile. (The environment must be a working DCAE
Platform environment).

::

    $ dcae_cli profiles create new-profile

After creating you would assign the variables with the ``set``
sub-command. Then activate it to use.

--------------

Set variables in a profile
~~~~~~~~~~~~~~~~~~~~~~~~~~

::

    $ dcae_cli profiles set $profile $key $value 

--------------

Delete a profile
~~~~~~~~~~~~~~~~

::

    $ dcae_cli profiles delete new-profile


