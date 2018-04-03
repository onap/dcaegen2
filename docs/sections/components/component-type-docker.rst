.. This work is licensed under a Creative Commons Attribution 4.0 International License.
.. http://creativecommons.org/licenses/by/4.0

.. _docker-requirements:

Docker Component Requirements
=============================

Overview
--------

Component developers are required to provide artifacts for the platform
to be able to deploy your component including:

-  :any:`Component specification <docker-specification>`
-  :any:`One or more Data Formats <data-formats>` \*unless they already exist
-  `Docker image <#docker-on-the-platform>`__

In addition, components will have to be enhanced to be compliant with
the DCAE platform in order to correctly be deployed and be managed. This
page will discuss the changes which are grouped into the following
categories:

-  `Service Registration <#service-registration>`__
-  `Configuration management on the new platform <#configuration-management>`__
-  `Docker on the Platform <#docker-on-the-platform>`__
-  `Operational concerns <#operational-concerns>`__

Additional considerations are:

-  `Policy Reconfiguration <#policy-reconfiguration>`__

To help component developers to make and to test the changes needed to
have components run on the platform, a command-line tool called
:doc:`dcae-cli <dcae-cli/quickstart>` is provided by the platform team.
(Testing withing the dcae_cli tool is not yet available for Policy).

Service Registration
--------------------

Every :doc:`Docker component is registered <../components/architecture/service-discovery>` with the platform’s
service discovery layer. Docker components are not expected to make the
explicit make registration calls because that is done by through a
platform 3rd party registration service. A couple things are needed from
component developers in order for this registration to occur
successfully:

1. Docker images must be created from a Dockerfile that has an
   `EXPOSE <https://docs.docker.com/engine/reference/builder/#/expose>`__
   instruction. This applies to components that listen on a port.
2. Component healthcheck details must be provided in the Docker
   auxiliary component specification

Expose port
~~~~~~~~~~~

Components that listen on a specific port must explicitly declare in
their Dockerfile that port using the ``EXPOSE`` instruction before
building the image. Warning! At the current time, you can not expose
multiple ports in your Dockerfile or registration *will not work*
correctly. Warning! Be sure to choose a port that is available. This may
vary by environment.

Health check
~~~~~~~~~~~~

Component developers are required to provide a way for the platform to
periodically check the health of their running components. The platform
uses Consul to perform these periodic calls. Consul provides different
types of `check
definitions <https://www.consul.io/docs/agent/checks.html>`__. The
details of the definition used by your component is to be provided
through the :any:`Docker auxiliary specification <docker-auxiliary-details>`.

Configuration Management
------------------------

All configuration for a component is stored in CONSUL under the
components uniquely generated name which is provided by the environment
variable ``HOSTNAME`` as well as ``SERVICE_NAME``. It is then made
available to the component via a remote HTTP service call to CONFIG
BINDING SERVICE.

The main entry in CONSUL for the component contains its
``generated application configuration``. This is based on the submitted
component specification, and consists of the ``interfaces`` (streams and
services/calls) and ``parameters`` sections. Other entries may exist as
well, under specific keys, such as :dmaap . Each key represents a
specific type of information and is also available to the component by
calling CONFIG BINDING SERVICE. More on this below.

Components are required to pull their
``generated application configuration`` at application startup. The
component must provide an initialization script that retrieves the
application configuration and reference that script in its Dockerfile.
Other calls can be made to CONFIG BINDING SERVICE to retrieve DMaaP, 
or Pollicy Reconfiguration (not yet supported).

You can see more details on the generated application configuration
:any:`here <dcae-cli-view-the-platform>`

.. _config_binding_service:

Config Binding Service
~~~~~~~~~~~~~~~~~~~~~~

The config binding service is a platform HTTP service that is
responsible for providing clients with its fully resolve configuration
JSON at startup, and also other configurations objects 
when requested.

At runtime, components should make an HTTP GET on:

::

    <config binding service hostname>:<port>/service_component/NAME

For Docker components, NAME should be set to ``HOSTNAME``, which is
provided as an ENV variable to the container.

The binding service integrates with the streams and services section of
the component specification. For example, if you specify that you call a
service:

::

    "services": {
        "calls": [{
            "config_key": "vnf-db",
            "request": {
                "format": "dcae.vnf.meta",
                "version": "1.0.0"
                },
            "response": {
                "format": "dcae.vnf.kpi",
                "version": "1.0.0"
                }
        }],
    ...
    }

Then the config binding service will find all available IP addresses of
services meeting the containers needs, and provide them to the container
under your ``config_key``:

::

    // your configuration
    {
        "vbf-db" :                 // see above 
            [IP:Port1, IP:Port2,…] // all of these meet your needs, choose one.
    }

Regarding ``<config binding service hostname>:<port>``, there is DNS
work going on to make this resolvable in a convenient way inside of your
container. However, currently you will be given a name as an ENV
variable, ``CONFIG_BINDING_SERVICE``, and you will need to query
Consul’s service discovery to get
``<config binding service hostname>:<port>``.

Generated Application Configuration
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

The DCAE platform uses the component specification to generate the
component’s application configuration provided at deployment time. The
component developer should expect to use this configuration JSON in the
component.

Pro-tip: As you build the component specification, use the :any:`dcae-cli dev command <dcae-cli-view-the-platform>`
to see what the resulting application configuration will look like.

For both Docker and CDAP, when the component is deployed, any
``streams`` and ``services/calls`` specified, will be injected into the
configuration under the following well known structure, along with all
``parameters``. (``services/provides`` is not passed in to the
application config). Your component is required to parse this
information if it has any DMaaP connections or interfaces with another
DCAE component.

This is best served by an example.

The following component spec snippet (from String Matching):

::

    "streams":{  
        "subscribes": [{
          "format": "VES_specification",  
          "version": "4.27.2",    
          "type": "message_router",
          "config_key" : "mr_input"
        }],
        "publishes": [{
          "format": "VES_specification",  
          "version": "4.27.2",    
          "config_key": "mr_output",
          "type": "message_router"
         }]
      },
      "services":{  
        "calls": [{
          "config_key" : "aai_broker_handle",
          "verb": "GET",
          "request": {
            "format": "get_with_query_params",
            "version": "1.0.0"
          },
          "response": {
            "format": "aai_broker_response",
            "version": "3.0.0"
          } 
        }],
        "provides": []
      },

Will result in the following top level keys in the configuration (for
CDAP, this will be under AppConfig)

::

       "streams_publishes":{  
          "mr_output":{                // notice the config key above
             "aaf_password":"XXX",
             "type":"message_router",
             "dmaap_info":{  
                "client_role": null,
                "client_id": null,
                "location": null,
                "topic_url":"https://YOUR_HOST:3905/events/com.att.dcae.dmaap.FTL2.DCAE-CL-EVENT" // just an example
             },
             "aaf_username":"XXX"
          }
       },
       "streams_subscribes":{  
          "mr_input":{                 // notice the config key above
             "aaf_password":"XXX",
             "type":"message_router",
             "dmaap_info":{  
                "client_role": null,
                "client_id": null,
                "location": null,
                "topic_url":"https://YOUR_HOST:3905/events/com.att.dcae.dmaap.FTL2.TerrysStringMatchingTest" // just an example
             },
             "aaf_username":"XXX"
          }
       },
       "services_calls":{  
          "aai_broker_handle":[        // notice the config key above
             "135.205.226.128:32768"   // based on deployment time, just an example
          ]
       }

These keys will always be populated whether they are empty or not. So
the minimum configuration you will get, (in the case of a component that
provides an HTTP service, doesn’t call any services, and has no streams,
is:

::

        "streams_publishes":{},
        "streams_subscribes":{},
        "services_calls":{}

Thus your component should expect these well-known top level keys.


DMaaP
~~~~~

Components can be publishers or subscribers to either message router
topics or data router feeds. This is defined in the component
specification under the ``streams`` section where you can specify
whether your component is expected to subscribe or to publish to a
:any:`message router <message-router>`
topic or to a :any:`data router <data-router>`
feed. Given a composition with components that use DMaaP, the platform
will provision the topic or feed and provide the necessary :doc:`connection
details <./component-specification/dmaap-connection-objects>`
at runtime for each DMaaP dependent component. These connection details
are provided through your application’s generated configuration.

In order to test DMaaP connections in onboarding, the developer
(currently) must provision all test topics and feeds manually and
provide the :any:`dcae-cli with the connection details <dcae-cli-walkthrough-dmaap-testing>` when deploying your
application.

Even thought the DMaaP connection information is included in the
generated application configuration, it may be obtained by doing a call
as in this example:

::

    curl http://<config binding service>:<port>/dmaap/jm416b.d345ada1-cc31-4121-a741-9007b9f64808.1-0-1.dcae-collectors-cli-pm

This would return the following:

::

    {"cli_gamma_cisco_pm_config_stat": 
        {
        "publish_url": "https://YOUR_HOST/publish/1362", 
        "username": "mtl5-0", 
        "log_url": null, 
        "location": "mtl5-0", 
        "password": "i5qji048hdm2e38f0bg872tnqd", 
        "publisher_id": "1234"
        }
    }

Policy Reconfiguration
~~~~~~~~~~~~~~~~~~~~~~

*(not yet supported)*

Components must provide a way to receive policy reconfiguration, that
is, configuration parameters that have been updated via the Policy UI.
The component developer provides a docker script (defined in the :any:`Docker
auxiliary specification <docker-auxiliary-details>`)
that will be triggered when this occurs.

Docker on the platform
----------------------

Images
~~~~~~

Docker images must be pushed to the environment specific Nexus
repository. This requires tagging your build with the full name of you
image which includes the Nexus repository name.

Use the Docker command-line to
`tag <https://docs.docker.com/engine/reference/commandline/tag/>`__ your
Docker image where the *target image* must contain the registry host
name and port.

For example, an application called yourapp has been tagged for an example
Nexus registry:

::

    YOUR_NEXUS_DOCKER_REGISTRY/yourapp                                                 0.4.0               154cc382df61        7 weeks ago         710.5 MB
    yourapp                                                                                    0.4.0               154cc382df61        7 weeks ago         710.5 MB

The solutioning evironment’s Nexus host for the Docker registry is
``YOUR_NEXSUS_HOST:18443``. You must run
``docker login YOUR_NEXSUS_HOST:18443`` to access the registry.
Please contact the DCAE platform team to provide you with the
credentials.

::

    docker login YOUR_NEXSUS_HOST:18443

Tag your image:

::

    docker tag yourapp:0.4.0 YOUR_NEXSUS_HOST:18443/dcae-platform/yourapp:0.4.0

Or build and tag:

::

    docker build -t YOUR_NEXSUS_HOST:18443/dcae-platform/yourapp:0.4.0 .

After tagging, upload your image to the remote registry using the Docker
`push
command <https://docs.docker.com/engine/reference/commandline/push/>`__.
Note that the registry may require a login. Use the Docker `login
command <https://docs.docker.com/engine/reference/commandline/login/>`__
before pushing in that case.

::

    docker push YOUR_NEXSUS_HOST:18443/dcae-platform/yourapp:0.4.0

*NOTE* Replace ``dcae-platform`` with the group directory that is
applicable to your image. Replace ``yourapp`` with your application’s
name. Replace the ``0.4.0`` version with your application’s version.

Dockerfile
~~~~~~~~~~

The Dockerfile must contain the name of the container’s initialization
script. This will be called when the container is deployed, and must
call Config Binding Service as described in `Config Binding
Service <#config-binding-service>`__

.. _dcae-cli-docker-ports:

Ports
~~~~~

On the DCAE platform, Docker components are run with the
``--publish-all`` or ``-P`` argument. This means the Docker container
for your component will be listening on a random port and that random
port will be mapped to the port `you exposed <#service-registration>`__.

Envs
~~~~

The platform provides a set of environment variables into each Docker
container:

+--------------+--------------+----------------------------------------+
| Name         | Type         | Description                            |
+==============+==============+========================================+
| ``HOSTNAME`` | string       | Unique name of the component instance  |
|              |              | that is generated                      |
+--------------+--------------+----------------------------------------+
| ``CONSUL_HOS | string       | Hostname of the platform’s Consul      |
| T``          |              | instance                               |
+--------------+--------------+----------------------------------------+
| ``CONFIG_BIN | string       | Hostname of the platform’s config      |
| DING_SERVICE |              | binding service instance               |
| ``           |              |                                        |
+--------------+--------------+----------------------------------------+
| ``DOCKER_HOS | string       | Host of the target platform Docker     |
| T``          |              | host to run the container on           |
+--------------+--------------+----------------------------------------+

Operational Concerns
--------------------

Logging
~~~~~~~

Currently the platform uses the default ``json-file`` logging driver for
Docker. For onboarding testing, component developers can access their
logs from their Docker containers either by running their component
using the ``--attached`` flag or by using the ``docker logs`` command.
The requirement is that applications must write to stdout and/or stderr.

To use the ``docker logs`` command for your deployed running Docker
container,

-  You must have Docker installed on your local machine
-  Have the generated name of your component. This is generated for you
   when you execute ``dcae_cli component dev`` or
   ``dcae_cli component run``.
-  Find the target Docker host using the ``dcae_cli profiles show``
   command:

::

    $ dcae_cli profiles show solutioning
    {
        "cdap_broker": "cdap_broker",
        "config_binding_service": "config_binding_service",
        "consul_host": "YOUR_CONSUL_HOST",
        "docker_host": "YOUR_DOCKER_HOST:2376"
    }

-  Set your Docker client to point to the target Docker host:

::

    $ export DOCKER_HOST="tcp://YOUR_DOCKER_HOST:2376"

-  Use the ``docker logs`` command:

::

    $ docker logs <generated component name>

