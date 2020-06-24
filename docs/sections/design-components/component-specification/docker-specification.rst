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
| volume                         | JSON    | each array item contains  |
|                                | array   | a host and container      |
|                                |         | object. See example       |
|                                |         | below.                    |
+--------------------------------+---------+---------------------------+
| policy                         | JSON    | *Required*. Policy        |
|                                | array   | reconfiguration script    |
|                                |         | details                   |
+--------------------------------+---------+---------------------------+
| external tls_info              | JSON    | *Optional*. Information   |
|                                | object  | about usage of tls certif\|
|                                |         | icates for external commu\|
|                                |         | nication.                 |
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

Kubernetes execs the script in the container (using the `docker exec API
 <https://docs.docker.com/engine/api/v1.29/#tag/Exec>`__ ). 
It will examine the
script result to identify whether your component is healthy. Your
component is considered healthy when the script returns ``0`` otherwise
your component is considered not healthy.

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
            }
        ]
    }

At the top-level:

+---------------+-------+-------------------------------------+
| Property Name | Type  | Description                         |
+===============+=======+=====================================+
| volumes       | array | Contains container and host objects |
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

Here’s an example of the minimal JSON that must be provided as an input:

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

External TLS Info
~~~~~~~~~~~~~~~~~

External TLS Info is used to trigger addition of init container that can provide main containers with certificates for
external communication.

+--------------------------------+---------+---------------------------------------------------------------------------+
| Property Name                  | Type    | Description                                                               |
+================================+=========+===========================================================================+
| external_cert_directory        | string  | *Required*. Directory where operator certificate and trusted certs should |
|                                |         | be created.                                                               |
|                                |         | (should have matching volume entry)                                       |
|                                |         | i.e. ``/opt/app/dcae-certificate/external_cert``                          |
+--------------------------------+---------+---------------------------------------------------------------------------+
| use_external_tls               | boolean | *Required*. A boolean that indicates whether the component uses AAF Cert\ |
|                                |         | Service to acquire operator certificate to protect external (between xNFs |
|                                |         | and ONAP) traffic. For a time being only operator certificate from CMPv2  |
|                                |         | server is supported.                                                      |
|                                |         | i.e ``true``                                                              |
+--------------------------------+---------+---------------------------------------------------------------------------+
| ca_name                        | string  | *Required*. Name of Certificate Authority configured on CertService side. |
|                                |         | i.e. ``RA``                                                               |
+--------------------------------+---------+---------------------------------------------------------------------------+
| external_certificate_parameters| JSON    | *Required*. Contains common name and sans for external certificates.      |
|                                | object  |                                                                           |
+--------------------------------+---------+---------------------------------------------------------------------------+
| common_name                    | string  | *Required*. Common name which should be present in certificate. Specific  |
|                                |         | for every blueprint.                                                      |
|                                |         | i.e. ``simpledemo.onap.org``                                              |
+--------------------------------+---------+---------------------------------------------------------------------------+
| sans                           | string  | *Required*. List of Subject Alternative Names (SANs) which should be pre\ |
|                                |         | sent in certificate. Delimiter - : Should contain common_name value and   |
|                                |         | other FQDNs under which given component is accessible.                    |
|                                |         | i.e. ``simpledemo.onap.org;ves.simpledemo.onap.org;ves.onap.org``         |
+--------------------------------+---------+---------------------------------------------------------------------------+

Example:

.. code:: json

	"auxilary": {
		"external_tls_info": {
			"external_cert_directory": "/opt/app/dcae-certificate/external_cert",
			"use_external_tls": true,
			"ca_name": "RA",
			"external_certificate_parameters": {
				"common_name": "simpledemo.onap.org",
				"sans": "simpledemo.onap.org;ves.simpledemo.onap.org;ves.onap.org"
			}
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
