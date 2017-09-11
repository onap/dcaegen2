# Component specification (Docker)

This page contains details specific to Dockerized applications.

The component specification contains the following top-level groups of information:

* [Component metadata](#metadata)
* [Component interfaces](#interfaces) including the associated [data formats](/components/data-formats.md)
* [Configuration parameters](#configuration-parameters)
* [Auxiliary details](#auxilary)
* [List of artifacts](#artifacts)

## Metadata

See [Metadata](common-specification.md#metadata)

## Interfaces

See [Interfaces](common-specification.md#interfaces)

## Configuration parameters

`parameters` is where to specify the component's application configuration parameters that are not connection information.

Property Name | Type | Description
------------- | ---- | -----------
parameters | JSON array | Each entry is a parameter object

Parameter object has the following available properties:

Property Name | Type | Description | Default
------------- | ---- | ----------- | -------
name | string | *Required*. The property name that will be used as the key in the generated config |
value | any | *Required*.  The default value for the given parameter |
description | string | *Required*.  Human-readable text describing the parameter like what its for |
type | string | The required data type for the parameter |
required | boolean | An optional key that declares a parameter as required (true) or not (false) | true
constraints | array | The optional list of sequenced constraint clauses for the parameter | 
entry_schema | string | The optional key that is used to declare the name of the Datatype definition for entries of set types such as the TOSCA list or map | 
designer_editable | boolean | An optional key that declares a parameter to be editable by designer (true) or not (false) | true
policy_editable | boolean | An optional key that declares a parameter to be editable by policy (true) or not (false) | true
policy_schema | array | The optional list of schema definitions used for policy |

Many of the parameter properties have been copied from TOSCA model property definitions and are to be used for service design composition and policy creation.  See [section 3.5.8 *Property definition*](http://docs.oasis-open.org/tosca/TOSCA-Simple-Profile-YAML/v1.1/TOSCA-Simple-Profile-YAML-v1.1.html).

The property `constraints` is a list of objects where each constraint object:

Property Name | Type | Description
------------- | ---- | -----------
equal | | Constrains a property or parameter to a value equal to (‘=’) the value declared
greater_than | number | Constrains a property or parameter to a value greater than (‘>’) the value declared
greater_or_equal | number | Constrains a property or parameter to a value greater than or equal to (‘>=’) the value declared
less_than | number | Constrains a property or parameter to a value less than (‘<’) the value declared
less_or_equal | number | Constrains a property or parameter to a value less than or equal to (‘<=’) the value declared
valid_values | array | Constrains a property or parameter to a value that is in the list of declared values
length | number | Constrains the property or parameter to a value of a given length
min_length | number | Constrains the property or parameter to a value to a minimum length
max_length | number | Constrains the property or parameter to a value to a maximum length

From the example specification:

```json
"parameters": [
    {
        "name": "threshold",
        "value": 0.75,
        "description": "Probability threshold to exceed to be anomalous"
    }
]
```

`threshold` is the configuration parameter and will get set to 0.75 when the configuration gets generated.

## Auxiliary

`auxilary` contains Docker specific details like health check and port mapping information.

Property Name | Type | Description
------------- | ---- | -----------
healthcheck | JSON object | *Required*.  Health check definition details
ports | JSON array | each array item maps a container port to the host port. See example below.

### Health check definition

The platform uses Consul to perform periodic health check calls.  Consul provides different types of [check definitions](https://www.consul.io/docs/agent/checks.html).  The platform currently supports http and docker health checks.

#### http

Property Name | Type | Description
------------- | ---- | -----------
type | string | *Required*.  `http`
interval | string | Interval duration in seconds i.e. `15s`
timeout | string | Timeout in seconds i.e. `1s`
endpoint | string | *Required*. GET endpoint provided by the component for Consul to call to check health

Example:

```json
"auxilary": {
    "healthcheck": {
        "type": "http",
        "interval": "15s",
        "timeout": "1s",
        "endpoint": "/my-health"
    }
}
```

#### docker

Property Name | Type | Description
------------- | ---- | -----------
type | string | *Required*.  `docker`
interval | string | Interval duration in seconds i.e. `15s`
timeout | string | Timeout in seconds i.e. `1s`
script | string | *Required*. Full path of script that exists in the Docker container to be executed

Consul will use the [Docker exec API](https://docs.docker.com/engine/api/v1.29/#tag/Exec) to periodically call your script in your container.  It will examine the script result to identify whether your component is healthy.  Your component is considered healthy when the script returns `0` otherwise your component is considered not healthy.

Example:

```json
"auxilary": {
    "healthcheck": {
        "type": "docker",
        "script": "/app/resources/check_health.py",
        "timeout": "30s",
        "interval": "180s"
    }
}
```

### Ports example

Example:

```json
"auxilary": {
    "ports": ["8080:8000"]
}
```

In the example above, container port 8080 maps to host port 8000.

## Artifacts

`artifacts` contains a list of artifacts associated with this component.  For Docker, this would be where you specify your Docker image full path including registry.

Property Name | Type | Description
------------- | ---- | -----------
artifacts | JSON array | Each entry is a artifact object

Each artifact object has:

Property Name | Type | Description
------------- | ---- | -----------
uri | string | *Required*. Uri to the artifact
type | string | *Required*. `docker image` or `jar`

## Example
Here is a full example of a component spec:

```json
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
        "uri": "YOUR_NEXUS_DOCKER_REGISTRY/kpi_anomaly:1.0.0",
        "type": "docker image"
    }]
}
```

## Generate application configuration

The above example `asimov.component.kpi_anomaly` will get transformed into the following application configuration JSON that is fully resolved and provided at runtime by calling the config binding service:

```json
{
    "streams_publishes": {
        "prediction": ["10.100.1.100:32567"]
    },
    "streams_subscribes": {},
    "threshold": 0.75,
    "services_calls": {
        "vnf-db": ["10.100.1.101:32890"]
    }
}
```
