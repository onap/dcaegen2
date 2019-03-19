.. This work is licensed under a Creative Commons Attribution 4.0 International License.
.. http://creativecommons.org/licenses/by/4.0


.. _deployment:

Deployment
============

To run HV-VES Collector container you need to specify required command line options and environment variables.

Command line parameters can be specified either by using long form (--long-form) or short form (-s) followed by argument if needed (see `Arg` column in table below). These parameters can be omitted if corresponding environment variables are set. These variables are named after command line option name rewritten using `UPPER_SNAKE_CASE` and prepended with `VESHV_` prefix, for example `VESHV_CONFIGURATION_FILE`.

Command line options have precedence over environment variables in cases when both are present.

Currently HV-VES requires single command line parameter which points to base configuration file.

.. csv-table::
    :widths: auto
    :delim: ;
    :header: Long form , Short form , Arg , Env form , Description

    configuration-file ; c ; yes ; VESHV_CONFIGURATION_FILE  ; Path to JSON file containing HV-VES configuration

Environment variables that are required by HV-VES are used by collector for provisioning of run-time configuration and are usually provided by DCAE platform.

.. csv-table::
    :widths: auto
    :delim: ;
    :header: Environment variable name , Description

    CONSUL_HOST            ; Hostname under which Consul service is available
    CONFIG_BINDING_SERVICE ; Hostname under which Config Binding Service is available
    HOSTNAME               ; Configuration key of HV-VES as seen by CBS, usually *dcae-hv-ves-collector*

There is also optional command line parameter which configures container-internal port for Healthcheck Server API (see :ref:`healthcheck_and_monitoring`).

.. csv-table::
    :widths: auto
    :delim: ;
    :header: Long form , Short form , Arg , Env form , Description

    health-check-api-port ; H ; yes ; VESHV_HEALTH_CHECK_API_PORT  ; Health check rest api listen port

.. _configuration_file:

Configuration file
------------------

File provides base configuration for HV-VES Collector in JSON format. This configuration should include variables that are not expected to change during container lifetime (e.g. internal listening port, healthcheck server port etc.).

Some entries in configuration can also be obtained from Config Binding Service (see :ref:`run_time_configuration`). **Every entry defined in configuration file will be OVERRIDEN if it is also present in run-time configuration.** Moreover, placement of entries in configuration or entry naming are not guaranteed to directly correspond to run-time configuration.

Following JSON shows every possible configuration option and is shipped as default file inside of HV-VES container.

.. literalinclude:: resources/base-configuration.json
    :language: json


The configuration is split into smaller sections, please note again that sectioning or naming of entries does not need to conform with run-time configuration.

Tables show restrictions on fields in file configuration and short description.

.. csv-table::
    :widths: auto
    :delim: ;
    :header-rows: 2

    Server
    Key                  ; Value type ; Description
    listenPort           ; number     ; Port on which HV-VES listens internally
    healthCheckApiPort   ; number     ; Health check REST API listen port
    idleTimeoutSec       ; number     ; Idle timeout for remote hosts. After given time without any data exchange, the connection might be closed.
    maxPayloadSizeBytes  ; number     ; Maximum supported payload size in bytes

.. csv-table::
    :widths: auto
    :delim: ;
    :header-rows: 2

    Config Binding Service
    Key                  ; Value type ; Description
    firstRequestDelaySec ; number     ; Delay of first request to Config Binding Service in seconds
    requestIntervalSec   ; number     ; Interval of configuration requests in seconds

.. csv-table::
    :widths: auto
    :delim: ;
    :header-rows: 2

    Security
    Key                  ; Value type ; Description
    sslDisable           ; boolean    ; Disables SSL encryption
    keyStoreFile         ; String     ; Key store in PKCS12 format path used in HV-VES incoming connections
    keyStorePassword     ; String     ; Key store password used in HV-VES incoming connections
    trustStoreFile       ; String     ; File with trusted certificate bundle in PKCS12 format path used in HV-VES incoming connections
    trustStorePassword   ; String     ; Trust store password used in HV-VES incoming connections

All security entries are mandatory with `sslDisable` set to `false`. Otherwise only `sslDisable` needs to be specified.

.. csv-table::
    :widths: auto
    :delim: ;
    :header-rows: 2

    VES Collector
    Key                  ; Value type ; Description
    maxRequestSizeBytes  ; number     ; Max Request Size property of Kafka Producer configuration in bytes

.. csv-table::
    :widths: auto
    :delim: ;
    :header-rows: 2

    Uncategorized
    Key                  ; Value type ; Description
    logLevel             ; String     ; Log level on which HV-VES publishes all log messages. Valid argument values are (case insensitive): ERROR, WARN, INFO, DEBUG, TRACE.


Horizontal Scaling
------------------

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
    DESIRED_REPLICAS_AMOUNT=5
    kubectl scale --namespace ${ONAP_NAMESPACE} ${DEPLOYMENT_NAME} --replicas=${DESIRED_REPLICAS_AMOUNT}

Result:

.. code-block:: bash

    kubectl get pods --namespace ${ONAP_NAMESPACE} --selector app=dcae-hv-ves-collector
