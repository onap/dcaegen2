.. This work is licensed under a Creative Commons Attribution 4.0 International License.
.. http://creativecommons.org/licenses/by/4.0

Onboarding Pre-requisite
========================

Before a component is onboarded into DCAE, the component developer must ensure it 
is compliant with ONAP & DCAE goals and requirement in order to correctly be deployed and be managed. This
page will discuss the changes which are grouped into the following
categories:

-  `Configuration management via ConfigBindingService <#configuration_management>`__
-  `Docker images <#docker_images>`__
-  `Policy Reconfiguration flow support <#policy_reconfiguration>`__
-  `Operational Requirement <#operation_requirement>`__


.. _configuration_management:

Configuration Management
------------------------

All configuration for a component is stored in CONSUL under the
components uniquely generated name which is provided by the environment
variable ``HOSTNAME`` as well as ``SERVICE_NAME``. It is then made
available to the component via a remote HTTP service call to CONFIG
BINDING SERVICE.

The main entry in CONSUL for the component contains its
**generated application configuration**. This is based on the submitted
component specification, and consists of the *interfaces* (streams and
services/calls) and *parameters* sections. Other entries may exist as
well, under specific keys, such as :dmaap . Each key represents a
specific type of information and is also available to the component by
calling CONFIG BINDING SERVICE. More on this below.

Components are required to pull their
**generated application configuration** at application startup using the environment
setting exposed during deployment. 

 
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

DCAE SDK
~~~~~~~~

DCAE has SDK/libraries which can be used for service components for easy integration.

- `Java Library <https://docs.onap.org/en/latest/submodules/dcaegen2.git/docs/sections/sdk/architecture.html>`__
- `Python Modules <https://git.onap.org/dcaegen2/utils/tree/onap-dcae-cbs-docker-client>`__



.. _policy_reconfiguration:

Policy Reconfiguration
~~~~~~~~~~~~~~~~~~~~~~

Components must provide a way to receive policy reconfiguration, that
is, configuration parameters that have been updated via the Policy UI.
The component developer must either periodically poll the ConfigBindingService API
to retrieve/refresh the new configuration or provides a script (defined in the :any:`Docker
auxiliary specification <docker-auxiliary-details>`)
that will be triggered when policy update is detected by the platform.


.. _docker_images:	

Images
~~~~~~

Docker images must be pushed to the environment specific Nexus
repository. This requires tagging your build with the full name of you
image which includes the Nexus repository name.

For ONAP microservices, the components images are expected to pushed into ONAP nexus
part of `ONAP CI jobs <https://wiki.onap.org/display/DW/Using+Standard+Jenkins+Job+%28JJB%29+Templates>`__


.. _operation_requirement:

Operational Requirement
-----------------------

Logging
~~~~~~~

All ONAP MS logging should follow logging specification defined by `logging project <https://wiki.onap.org/pages/viewpage.action?pageId=71831691>`__

The application log configuration must enable operation to choose if to be written into file or stdout or both during deployment.


S3P 
~~~
ONAP S3P (all scaling/resiliency/security/maintainability) goals should meet at the minimum level defined for DCAE project for the targeted release 

If the component is stateful, it should persist its state on external store (eg. pg, redis) to allow support for scaling and resiliency. This should be important design criteria for the component. If the components either publish/subscribe into DMAAP topic, then secure connection to DMAAP must be supported (platform will provide aaf_username/aaf_password for each topic as configuration).

