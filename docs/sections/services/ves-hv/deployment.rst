.. This work is licensed under a Creative Commons Attribution 4.0 International License.
.. http://creativecommons.org/licenses/by/4.0


.. _deployment:

Deployment
============

To run HV-VES Collector container, you need to specify required parameters by passing them as command
line arguments either by using long form (--long-form) or short form (-s) followed by argument if needed.

All parameters can also be configured by specifying environment variables. These variables have to be named after command line option name
rewritten using `UPPER_SNAKE_CASE` and prepended with `VESHV_` prefix, for example `VESHV_LISTEN_PORT`.

Command line options have precedence over environment variables.

+-------------+------------+-------------------+----------+-----+-------------------------------------------------+
| Long form   | Short form | Env form          | Required | Arg | Description                                     |
+=============+============+===================+==========+=====+=================================================+
| listen-port | p          | VESHV_LISTEN_PORT | yes      | yes | Port on which HV-VES listens internally         |
+-------------+------------+-------------------+----------+-----+-------------------------------------------------+
| config-url  | c          | VESHV_CONFIG_URL  | yes      | yes | URL of HV-VES configuration on Consul service   |
+-------------+------------+-------------------+----------+-----+-------------------------------------------------+

HV-VES requires also to specify if SSL should be used when handling incoming TCP connections.
This can be done by passing the flag below to the command line.

+-------------+------------+-------------------+----------+-----+-------------------------------------------------+
| Long form   | Short form | Env form          | Required | Arg | Description                                     |
+=============+============+===================+==========+=====+=================================================+
| ssl-disable | l          | VESHV_SSL_DISABLE | no       | no  | Disables SSL encryption                         |
+-------------+------------+-------------------+----------+-----+-------------------------------------------------+


Minimal command for running the container:

.. code-block:: bash

    docker run nexus3.onap.org:10001/onap/org.onap.dcaegen2.collectors.hv-ves.hv-collector-main --listen-port 6061 --config-url http://consul:8500/v1/kv/dcae-hv-ves-collector --ssl-disable

Optional configuration parameters:

+-----------------------+------------+----------------------------+----------+-----+-----------------+-------------------------------------------------------+
| Long form             | Short form | Env form                   | Required | Arg | Default         | Description                                           |
+=======================+============+============================+==========+=====+=================+=======================================================+
| health-check-api-port | H          | VESHV_HEALTHCHECK_API_PORT | no       | yes | 6060            | Health check REST API listen port                     |
+-----------------------+------------+----------------------------+----------+-----+-----------------+-------------------------------------------------------+
| first-request-delay   | d          | VESHV_FIRST_REQUEST_DELAY  | no       | yes | 10              | Delay of first request to Consul service in seconds   |
+-----------------------+------------+----------------------------+----------+-----+-----------------+-------------------------------------------------------+
| request-interval      | I          | VESHV_REQUEST_INTERVAL     | no       | yes | 5               | Interval of Consul configuration requests in seconds  |
+-----------------------+------------+----------------------------+----------+-----+-----------------+-------------------------------------------------------+
| idle-timeout-sec      | i          | VESHV_IDLE_TIMEOUT_SEC     | no       | yes | 60              | Idle timeout for remote hosts. After given time       |
|                       |            |                            |          |     |                 | without any data exchange, the connection             |
|                       |            |                            |          |     |                 | might be closed.                                      |
+-----------------------+------------+----------------------------+----------+-----+-----------------+-------------------------------------------------------+
| max-payload-size      | m          | VESHV_MAX_PAYLOAD_SIZE     | no       | yes | 1048576 (1 MiB) | Maximum supported payload size in bytes               |
+-----------------------+------------+----------------------------+----------+-----+-----------------+-------------------------------------------------------+
| log-level             | ll         | VESHV_LOG_LEVEL            | no       | yes | INFO            | Log level on which HV-VES publishes all log messages  |
|                       |            |                            |          |     |                 | Valid argument values are (case insensitive): ERROR,  |
|                       |            |                            |          |     |                 | WARN, INFO, DEBUG, TRACE.                             |
+-----------------------+------------+----------------------------+----------+-----+-----------------+-------------------------------------------------------+

As part of experimental API if you do not specify `ssl-disable` flag, there is need to specify additional
parameters for security configuration.

+-----------------------+------------+----------------------------+----------+-----+------------------------+--------------------------------------------------------------+
| Long form             | Short form | Env form                   | Required | Arg | Default                | Description                                                  |
+=======================+============+============================+==========+=====+========================+==============================================================+
| key-store             | k          | VESHV_KEY_STORE            | no       | yes | /etc/ves-hv/server.p12 | Key store in PKCS12 format path                              |
+-----------------------+------------+----------------------------+----------+-----+------------------------+--------------------------------------------------------------+
| key-store-password    | kp         | VESHV_KEY_STORE_PASSWORD   | no       | yes |                        | Key store password                                           |
+-----------------------+------------+----------------------------+----------+-----+------------------------+--------------------------------------------------------------+
| trust-store           | t          | VESHV_TRUST_STORE          | no       | yes | /etc/ves-hv/trust.p12  | File with trusted certificate bundle in PKCS12 format path   |
+-----------------------+------------+----------------------------+----------+-----+------------------------+--------------------------------------------------------------+
| trust-store-password  | tp         | VESHV_TRUST_STORE_PASSWORD | no       | yes |                        | Trust store password                                         |
+-----------------------+------------+----------------------------+----------+-----+------------------------+--------------------------------------------------------------+

Passwords are mandatory without ssl-disable flag. If key-store or trust-store location is not specified, HV-VES will try to read them from default locations.

These parameters can be configured either by passing command line option during `docker run` call or
by specifying environment variables named after command line option name
rewritten using `UPPER_SNAKE_CASE` and prepended with `VESHV_` prefix e.g. `VESHV_LISTEN_PORT`.

Horizontal Scaling
==================

Kubernetes command line tool (`kubectl`) is recommended for manual horizontal scaling of HV-VES Collector.

To scale HV-VES deployment you need to determine its name and namespace in which it is deployed.
For default OOM deployment, HV-VES full deployment name is `deployment/dep-dcae-hv-ves-collector` and it is installed under `onap` namespace.

1. If the namespace is unknown, execute the following command to determine possible namespaces.

.. code-block:: bash

    kubectl get namespaces

2. Find desired deployment (in case of huge output you can try final call in combination with `grep hv-ves` command).
You can also see current replicas amount under a corresponding column.

.. code-block:: bash

    ONAP_NAMESPACE=onap
    kubectl get --namespace ${ONAP_NAMESPACE} deployment

3. To scale deployment execute:

.. code-block:: bash

    DEPLOYMENT_NAME=deployment/dep-dcae-hv-ves-collector
    ONAP_NAMESPACE=onap
    DESIRED_REPLICAS_AMOUNT=5
    kubectl scale --namespace ${ONAP_NAMESPACE} ${DEPLOYMENT_NAME} --replicas=${DESIRED_REPLICAS_AMOUNT}

Result:

.. code-block:: bash

    kubectl get pods --namespace ${ONAP_NAMESPACE} --selector app=dcae-hv-ves-collector

Healthcheck
===========

Inside HV-VES docker container runs small http service for healthcheck - exact port for this service can be configured
at deployment using `--health-check-api-port` command line option.

This service exposes single endpoint **GET /health/ready** which returns **HTTP 200 OK** in case HV-VES is healthy
and ready for connections. Otherwise it returns **HTTP 503 Service Unavailable** with short reason of unhealthiness.
