.. This work is licensed under a Creative Commons Attribution 4.0 International License.
.. http://creativecommons.org/licenses/by/4.0

.. _docker-specification:

Component specification (Docker)
================================

The Docker component specification contains the following groups of
information. Many of these are common to both Docker and CDAP components
and are therefore described in the common specification.

-  :any:`Metadata <metadata>`
-  :any:`Interfaces <interfaces>` including the
   associated :any:`Data Formats <data-formats>`
-  :any:`Parameters <parameters>`
-  :any:`Auxiliary Details <docker-auxiliary-details>`
-  :any:`List of Artifacts <artifacts>`

.. _docker-auxiliary-details:

Auxiliary Details
-----------------

``auxiliary`` contains Docker specific details like health check, port
mapping, volume mapping, and policy reconfiguration script details.

+-------------+----+----------+
| Name        | Ty\| Descript\|
|             | pe | ion      |
+=============+====+==========+
| healthcheck | JS\| *Require\|
|             | ON | d*.      |
|             | ob\| Health   |
|             | je\| check    |
|             | ct | definiti\|
|             |    | on       |
|             |    | details  |
+-------------+----+----------+
| ports       | JS\| each     |
|             | ON | array    |
|             | ar\| item     |
|             | ra\| maps a   |
|             | y  | containe\|
|             |    | r        |
|             |    | port to  |
|             |    | the host |
|             |    | port.    |
|             |    | See      |
|             |    | example  |
|             |    | below.   |
+-------------+----+----------+
| volume      | JS\| each     |
|             | ON | array    |
|             | ar\| item     |
|             | ra\| contains |
|             | y  | a host   |
|             |    | and      |
|             |    | containe\|
|             |    | r        |
|             |    | object.  |
|             |    | See      |
|             |    | example  |
|             |    | below.   |
+-------------+----+----------+
| policy      | JS\| *Require\|
|             | ON | d*.      |
|             | ar\| Policy   |
|             | ra\| script   |
|             | y  | details  |
+-------------+----+----------+

Health Check Definition
~~~~~~~~~~~~~~~~~~~~~~~

The platform uses Consul to perform periodic health check calls. Consul
provides different types of `check definitions <https://www.consul.io/docs/agent/checks.html>`_. The
platform currently supports http and docker health checks.

When choosing a value for interval, consider that too frequent
healthchecks will put unnecessary load on Consul and DCAE. If there is a
problematic resource, then more frequent healthchecks are warranted (eg
15s or 60s), but as stablility increases, so can these values, (eg
300s).

When choosing a value for timeout, consider that too small a number will
result in increasing timeout failures, and too large a number will
result in a delay in the notification of resource problem. A suggestion
is to start with 5s and workd from there.

http
^^^^

+-------------+----+----------+
| Property    | Ty\| Descript\|
| Name        | pe | ion      |
+=============+====+==========+
| type        | st\| *Require\|
|             | ri\| d*.      |
|             | ng | ``http`` |
+-------------+----+----------+
| interval    | st\| Interval |
|             | ri\| duration |
|             | ng | in       |
|             |    | seconds  |
|             |    | i.e.     |
|             |    | ``60s``  |
+-------------+----+----------+
| timeout     | st\| Timeout  |
|             | ri\| in       |
|             | ng | seconds  |
|             |    | i.e.     |
|             |    | ``5s``   |
+-------------+----+----------+
| endpoint    | st\| *Require\|
|             | ri\| d*.      |
|             | ng | GET      |
|             |    | endpoint |
|             |    | provided |
|             |    | by the   |
|             |    | componen\|
|             |    | t        |
|             |    | for      |
|             |    | Consul   |
|             |    | to call  |
|             |    | to check |
|             |    | health   |
+-------------+----+----------+

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

+-------------+----+------------+
| Property    | Ty\| Descript\  |
| Name        | pe | ion        |
+=============+====+============+
| type        | st\| *Require\  |
|             | ri\| d*.        |
|             | ng | ``docker`` |
+-------------+----+------------+
| interval    | st\| Interval   |
|             | ri\| duration   |
|             | ng | in         |
|             |    | seconds    |
|             |    | i.e.       |
|             |    | ``15s``    |
+-------------+----+------------+
| timeout     | st\| Timeout    |
|             | ri\| in         |
|             | ng | seconds    |
|             |    | i.e.       |
|             |    | ``1s``     |
+-------------+----+------------+
| script      | st\| *Require\  |
|             | ri\| d*.        |
|             | ng | Full       |
|             |    | path of    |
|             |    | script     |
|             |    | that       |
|             |    | exists     |
|             |    | in the     |
|             |    | Docker     |
|             |    | containe\  |
|             |    | r          |
|             |    | to be      |
|             |    | executed   |
+-------------+----+------------+

Consul will use the `Docker exec API <https://docs.docker.com/engine/api/v1.29/#tag/Exec>`_ to
periodically call your script in your container. It will examine the
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

+----------------------+----------------------+----------------------+
| Property Name        | Type                 | Description          |
+======================+======================+======================+
| bind                 | string               | path to the          |
|                      |                      | container volume     |
+----------------------+----------------------+----------------------+
| mode                 | string               | “ro” - indicates     |
|                      |                      | read-only volume     |
|                      |                      | “” - indicates that  |
|                      |                      | the container can    |
|                      |                      | write into the bind  |
|                      |                      | mount                |
+----------------------+----------------------+----------------------+

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
~~~~~~

Policy changes made in the Policy UI will be provided to the Docker
component by triggering a script that is defined here.

+-------------+----+------------+
| Property    | Ty\| Descript\  |
| Name        | pe | ion        |
+=============+====+============+
| reconfigure | st\| *Require\  |
| _type       | ri\| d*.        |
|             | ng | Current    |
|             |    | value      |
|             |    | supporte   |
|             |    | d          |
|             |    | is         |
|             |    | ``policy`` |
+-------------+----+------------+
| script_path | st\| *Require\  |
|             | ri\| d*.        |
|             | ng | Current    |
|             |    | value      |
|             |    | for        |
|             |    | ‘policy’   |
|             |    | reconfig\  |
|             |    | ure_type   |
|             |    | must be    |
|             |    | “/opt/ap\  |
|             |    | p/reconf\  |
|             |    | igure.sh   |
|             |    | ”          |
+-------------+----+------------+

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

+-----+----+---------------------------+
| Na\ | Ty\| Descript\                 |
| me  | pe | ion                       |
+=====+====+===========================+
| re\ | st\| “policy”                  |
| co\ | ri\|                           |
| nf\ | ng |                           |
| ig\ |    |                           |
| ur\ |    |                           |
| e_t\|    |                           |
| y\  |    |                           |
| pe\ |    |                           |
+-----+----+---------------------------+
| up\ | js\| TBD                       |
| da\ | on |                           |
| te\ |    |                           |
| d_p\|    |                           |
| o\  |    |                           |
| li\ |    |                           |
| ci\ |    |                           |
| es  |    |                           |
+-----+----+---------------------------+
| up\ | js\| complete                  |
| da\ | on | generate\                 |
| te\ |    | d                         |
| d_a\|    | app_conf\                 |
| p\  |    | ig,                       |
| pl\ |    | not                       |
| _c\ |    | fully-re\                 |
| on\ |    | solved,                   |
| fi\ |    | but                       |
| g   |    | ``policy-enabled``        |
|     |    | paramete\                 |
|     |    | rs                        |
|     |    | have                      |
|     |    | been                      |
|     |    | updated.                  |
|     |    | In order                  |
|     |    | to get                    |
|     |    | the                       |
|     |    | complete                  |
|     |    | updated                   |
|     |    | app_conf\                 |
|     |    | ig,                       |
|     |    | the                       |
|     |    | componen\                 |
|     |    | t                         |
|     |    | would                     |
|     |    | have to                   |
|     |    | call                      |
|     |    | ``config-binding-service``|
|     |    | .                         |
+-----+----+---------------------------+

Docker Component Spec - Complete Example
----------------------------------------

.. code:: json

    {
        "self": {
            "version": "1.0.0",
            "name": "asimov.component.kpi_anomaly",
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
                "format": "asimov.format.integerClassification",
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
                    "format": "asimov.format.integerClassification",
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
            "uri": "fake.nexus.com/dcae/kpi_anomaly:1.0.0",
            "type": "docker image"
        }]
    }
