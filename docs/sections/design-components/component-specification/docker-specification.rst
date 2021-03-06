.. This work is licensed under a Creative Commons Attribution 4.0 International License.
.. http://creativecommons.org/licenses/by/4.0

.. _docker-requirements:

Component Spec Requirements
===========================

The component specification contains the following groups of
information. 

-  :any:`Metadata <metadata>`
-  :any:`Interfaces <interfaces>` including the
   associated :any:`Data Formats <data-formats>`
-  :any:`Parameters <common-specification-parameters>`
-  :any:`Auxiliary Details <docker-auxiliary-details>`
-  :any:`List of Artifacts <artifacts>`

.. _docker-auxiliary-details:

Auxiliary Details
-----------------

``auxiliary`` contains Docker specific details like health check, port
mapping, volume mapping and policy reconfiguration script details.


+--------------------------------+---------+---------------------------+
| Name                           | Type    | Description               |
+================================+=========+===========================+
| healthcheck                    | JSON    | *Required*. Health check  |
|                                | object  | definition details        |
+--------------------------------+---------+---------------------------+
| ports                          | JSON    | each array item maps a    |
|                                | array   | container port to the     |
|                                |         | host port. See example    |
|                                |         | below.                    |
+--------------------------------+---------+---------------------------+
| volumes                        | JSON    | each array item contains  |
|                                | array   | volume definition of eith\|
|                                |         | er: host path or config m\|
|                                |         | ap volume.                |
+--------------------------------+---------+---------------------------+
| policy                         | JSON    | *Required*. Policy        |
|                                | array   | reconfiguration script    |
|                                |         | details                   |
+--------------------------------+---------+---------------------------+
| tls_info                       | JSON    | *Optional*. Information   |
|                                | object  | about usage of tls certif\|
|                                |         | icates                    |
+--------------------------------+---------+---------------------------+

Health Check Definition
~~~~~~~~~~~~~~~~~~~~~~~

The platform currently supports http and docker script based health checks. 

When choosing a value for interval, consider that too frequent
healthchecks will put unnecessary load on the platform. If there is a
problematic resource, then more frequent healthchecks are warranted (eg
15s or 60s), but as stability increases, so can these values, (eg
300s).

When choosing a value for timeout, consider that too small a number will
result in increasing timeout failures, and too large a number will
result in a delay in the notification of the resource problem. A
suggestion is to start with 5s and work from there.

http
^^^^

+--------------------------------+---------+---------------------------+
| Property Name                  | Type    | Description               |
+================================+=========+===========================+
| type                           | string  | *Required*. ``http``      |
+--------------------------------+---------+---------------------------+
| interval                       | string  | Interval duration in      |
|                                |         | seconds i.e. ``60s``      |
+--------------------------------+---------+---------------------------+
| timeout                        | string  | Timeout in seconds i.e.   |
|                                |         | ``5s``                    |
+--------------------------------+---------+---------------------------+
| endpoint                       | string  | *Required*. GET endpoint  |
|                                |         | provided by the component |
|                                |         | for checking health       |
+--------------------------------+---------+---------------------------+

Example:

.. code:: json

    "auxilary": {
        "healthcheck": {
            "type": "http",
            "interval": "15s",
            "timeout": "1s",
            "endpoint": "/my-health"
        }
    }

docker script example
^^^^^^^^^^^^^^^^^^^^^

+--------------------------------+---------+---------------------------+
| Property Name                  | Type    | Description               |
+================================+=========+===========================+
| type                           | string  | *Required*. ``docker``    |
+--------------------------------+---------+---------------------------+
| interval                       | string  | Interval duration in      |
|                                |         | seconds i.e. ``15s``      |
+--------------------------------+---------+---------------------------+
| timeout                        | string  | Timeout in seconds i.e.   |
|                                |         | ``1s``                    |
+--------------------------------+---------+---------------------------+
| script                         | string  | *Required*. Full path of  |
|                                |         | script that exists in the |
|                                |         | Docker container to be    |
|                                |         | executed                  |
+--------------------------------+---------+---------------------------+

During deployment, the K8S plugin maps the healthcheck defined into 
into a Kubernetes readiness probe.  

Kubernetes execs the script in the container (using the `docker exec API <https://docs.docker.com/engine/api/v1.29/#tag/Exec>`__ ). 
It will examine the script result to identify whether your component is healthy. Your
component is considered healthy when the script returns ``0`` otherwise your component is considered not healthy.

Example:

.. code:: json

    "auxilary": {
        "healthcheck": {
            "type": "docker",
            "script": "/app/resources/check_health.py",
            "timeout": "30s",
            "interval": "180s"
        }
    }

Ports
~~~~~

This method of exposing/mapping a local port to a host port is NOT
RECOMMENDED because of the possibility of port conflicts. If multiple
instances of a docker container will be running, there definitely will
be port conflicts. Use at your own risk. (The preferred way to expose a
port is to do so in the Dockerfile as described
:any:`here <dcae-cli-docker-ports>`).

.. code:: json

    "auxilary": {
        "ports": ["8080:8000"]
    }

In the example above, container port 8080 maps to host port 8000.

Volume Mapping
~~~~~~~~~~~~~~

.. code:: json

    "auxilary": {
        "volumes": [
            {
               "container": {
                   "bind": "/tmp/docker.sock",
                   "mode": "ro"
                },
                "host": {
                    "path": "/var/run/docker.sock"
                }
            },
            {
               "container": {
                   "bind": "/tmp/mount_path"
                   "mode": "ro"
                },
                "config_volume": {
                    "name": "config_map_name"
                }
            }
        ]
    }

At the top-level:

+---------------+-------+-------------------------------------+
| Property Name | Type  | Description                         |
+===============+=======+=====================================+
| volumes       | array | Contains container with host/config\|
|               |       | _volume objects                     |
+---------------+-------+-------------------------------------+

The ``container`` object contains:


+-----------------------+-----------------------+-------------------------------+
| Property Name         | Type                  | Description                   |
+=======================+=======================+===============================+
| bind                  | string                | path to the container         |
|                       |                       | volume                        |
+-----------------------+-----------------------+-------------------------------+
| mode                  | string                | ro - indicates                |
|                       |                       | read-only volume              |
+-----------------------+-----------------------+-------------------------------+
|                       |                       | w - indicates that            |
|                       |                       | the contain can write         |
|                       |                       | into the bind mount           |
+-----------------------+-----------------------+-------------------------------+

The ``host`` object contains:

+---------------+--------+-------------------------+
| Property Name | Type   | Description             |
+===============+========+=========================+
| path          | string | path to the host volume |
+---------------+--------+-------------------------+

The ``config_volume`` object contains:

+---------------+--------+-------------------------+
| Property Name | Type   | Description             |
+===============+========+=========================+
| name          | string | name of config map      |
+---------------+--------+-------------------------+

Here is an example of the minimal JSON with host path volume that must be provided as an input:

.. code:: json

    "auxilary": {
        "volumes": [
            {
               "container": {
                   "bind": "/tmp/docker.sock"
                },
                "host": {
                    "path": "/var/run/docker.sock"
                }
            }
        ]
    }

In the example above, the container volume “/tmp/docker.sock” maps to
host volume “/var/run/docker.sock”.

Here is an example of the minimal JSON with config map volume that must be provided as an input:

.. code:: json

    "auxilary": {
        "volumes": [
            {
               "container": {
                   "bind": "/tmp/mount_path"
                },
                "config_volume": {
                    "name": "config_map_name"
                }
            }
        ]
    }

In the example above, config map named "config_map_name" is mounted at "/tmp/mount_path".

Policy 
~~~~~~~

Policy changes made in the Policy UI will be provided to the Docker
component by triggering a script that is defined here.

+--------------------------------+---------+---------------------------+
| Property Name                  | Type    | Description               |
+================================+=========+===========================+
| reconfigure_type               | string  | *Required*. Current value |
|                                |         | supported is ``policy``   |
+--------------------------------+---------+---------------------------+
| script_path                    | string  | *Required*. Current value |
|                                |         | for ‘policy’              |
|                                |         | reconfigure_type must be  |
|                                |         | “/opt/app/reconfigure.sh” |
+--------------------------------+---------+---------------------------+

Example:

.. code:: json

    "auxilary": {
        "policy": {
            "reconfigure_type": "policy",
            "script_path": "/opt/app/reconfigure.sh"
        }
    }

The docker script interface is as follows: \`/opt/app/reconfigure.sh
$reconfigure_type {“updated policies”: , “application config”: }

+---------------------+--------------+----------------------------------------+
| Name                | Type         | Description                            |
+=====================+==============+========================================+
| reconfigure_type    | string       | policy                                 |
+---------------------+--------------+----------------------------------------+
| updated_policies    | json         | TBD                                    |
+---------------------+--------------+----------------------------------------+
| updated_appl_config | json         | complete generated app_config, not     |
|                     |              | fully-resolved, but ``policy-enabled`` |
|                     |              | parameters have been updated. In order |
|                     |              | to get the complete updated            |
|                     |              | app_config, the component would have   |
|                     |              | to call ``config-binding-service``.    |
+---------------------+--------------+----------------------------------------+

TLS Info
~~~~~~~~~~~~~~~~~

TLS Info is used to trigger addition of init containers that can provide main application containers with certificates
for internal and external communication.

+--------------------------------+---------+---------------------------------------------------------------------------+
| Property Name                  | Type    | Description                                                               |
+================================+=========+===========================================================================+
| cert_directory                 | string  | *Required*. Directory where certificates should be created.               |
|                                |         | i.e. ``/opt/app/dcae-certificate``                                        |
+--------------------------------+---------+---------------------------------------------------------------------------+
| use_tls                        | boolean | *Required*. A boolean that indicates whether server certificates for int\ |
|                                |         | ernal communication should be added to the main container                 |
|                                |         | i.e ``true``                                                              |
+--------------------------------+---------+---------------------------------------------------------------------------+
| use_external_tls               | boolean | *Optional*. A boolean that indicates whether the component uses OOM Cert\ |
|                                |         | Service to acquire operator certificate to protect external (between xNFs |
|                                |         | and ONAP) traffic. For a time being only operator certificate from CMPv2  |
|                                |         | server is supported.                                                      |
|                                |         | i.e ``true``                                                              |
+--------------------------------+---------+---------------------------------------------------------------------------+


Example:

.. code:: json

	"auxilary": {
		"tls_info": {
			"cert_directory": "/opt/app/dcae-certificate",
			"use_tls": true
			"use_external_tls": true,
		}
	},

Docker Component Spec - Complete Example
----------------------------------------

.. code:: json

    {
        "self": {
            "version": "1.0.0",
            "name": "yourapp.component.kpi_anomaly",
            "description": "Classifies VNF KPI data as anomalous",
            "component_type": "docker"
        },
        "streams": {
            "subscribes": [{
                "format": "dcae.vnf.kpi",
                "version": "1.0.0",
                "route": "/data",
                "type": "http"
            }],
            "publishes": [{
                "format": "yourapp.format.integerClassification",
                "version": "1.0.0",
                "config_key": "prediction",
                "type": "http"
            }]
        },
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
            "provides": [{
                "route": "/score-vnf",
                "request": {
                    "format": "dcae.vnf.meta",
                    "version": "1.0.0"
                    },
                "response": {
                    "format": "yourapp.format.integerClassification",
                    "version": "1.0.0"
                    }
            }]
        },
        "parameters": [
            {
                "name": "threshold",
                "value": 0.75,
                "description": "Probability threshold to exceed to be anomalous"
            }
        ],
        "auxilary": {
            "healthcheck": {
                "type": "http",
                "interval": "15s",
                "timeout": "1s",
                "endpoint": "/my-health"
            }
        },
        "artifacts": [{
            "uri": "fake.nexus.att.com/dcae/kpi_anomaly:1.0.0",
            "type": "docker image"
        }]
    }
