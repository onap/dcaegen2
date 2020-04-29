.. This work is licensed under a Creative Commons Attribution 4.0 International License.
.. http://creativecommons.org/licenses/by/4.0

.. _docker-requirements:

Docker Component Requirements
=============================

Overview
--------

Component developers are required to provide artifacts for the platform
to be able to deploy your component including:

-  `Component specification <docker-specification>`
-  `One or more Data Formats <data-formats>` \*unless they already exist
-  `Docker image <#docker-on-the-platform>`__

In addition, components will have to be enhanced to be compliant with
the DCAE platform in order to correctly be deployed and be managed. This
page will discuss the changes which are grouped into the following
categories:

-  `Configuration management on the new platform <#configuration-management>`__
-  `Docker on the Platform <#docker-on-the-platform>`__
-  `Operational concerns <#operational-concerns>`__

Additional considerations are:

-  `Policy Reconfiguration <#policy-reconfiguration>`__



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
``generated application configuration`` at application startup. 

DCAE has SDK/libraries which can be used for service components for easy integration.

- `Java Library <https://docs.onap.org/en/latest/submodules/dcaegen2.git/docs/sections/sdk/architecture.html>`__
- `Python Modules` <https://git.onap.org/dcaegen2/utils/tree/onap-dcae-cbs-docker-client>`__
 


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
container. 

For all Kubernetes deployments since El-Alto, an environment variable ``CBS_CONFIG_URL`` will be exposed 
by platform (k8s plugins) providing the exact URL to be used for configuration retrieval. 
Application can use this URL directly instead of constructing URL from HOSTNAME (which refers to ServiceComponentName) 
and CONFIG_BINDING_SERVICE env's.  By default, this URL will use HTTPS CBS interface

If you are integrating with CBS SDK, then the DNS resolution and configuration fetch 
are handled via library functions.

Generated Application Configuration
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

The DCAE platform uses the component specification to generate the
component’s application configuration provided at deployment time. The
component developer should expect to use this configuration JSON in the
component.


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

Will result in the following top level keys in the configuration

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

For ONAP microservices, the components images are expected to pushed into ONAP nexus
part of ONAP CI jobs.

Envs
~~~~

The platform provides a set of environment variables into each Docker
container:

+----------------------------+--------------+----------------------------------------+
| Name                       | Type         | Description                            |
+============================+==============+========================================+
| ``HOSTNAME``               | string       | Unique name of the component instance  |
|                            |              | that is generated                      |
+----------------------------+--------------+----------------------------------------+
| ``CONSUL_HOST``            | string       | Hostname of the platform's Consul      |
|                            |              | instance                               |
+----------------------------+--------------+----------------------------------------+
| ``CONFIG_BINDING_SERVICE`` | string       | Hostname of the platform's config      |
|                            |              | binding service instance               |
|                            |              |                                        |
+----------------------------+--------------+----------------------------------------+
| ``DOCKER_HOST``            | string       | Host of the target platform Docker     |
|                            |              | host to run the container on           |
+----------------------------+--------------+----------------------------------------+
| ``CBS_CONFIG_URL``         | string       | Fully resolved URL to query config     |
|                            |              | from CONSUL via CBS                    |
+----------------------------+--------------+----------------------------------------+

Operational Concerns
--------------------

Logging
~~~~~~~

All ONAP MS logging should follow logging standard defined under https://wiki.onap.org/pages/viewpage.action?pageId=71831691

The application log configuration must enable operation to choose if to be written into file or stdout or both during deployment.



