# Component specification (Docker)

The Docker component specification contains the following groups of information. Many of these are common to both Docker and CDAP components and are therefore described in the common specification.

* [Metadata](common-specification.md#metadata)
* [Interfaces](common-specification.md#interfaces) including the associated [Data Formats](/components/data-formats.md)
* [Parameters](common-specification.md#parameters)
* [Auxiliary Details](#auxiliary-details)
* [List of Artifacts](common-specification.md#artifacts)

## Auxiliary Details

`auxiliary` contains Docker specific details like health check, port mapping, volume mapping, and policy reconfiguration script details.  

Name | Type | Description
------------- | ---- | -----------
healthcheck | JSON object | *Required*.  Health check definition details
ports | JSON array | each array item maps a container port to the host port. See example below.
volume | JSON array | each array item contains a host and container object. See example below. | |
policy | JSON array | *Required*. Policy script details

### Health Check Definition

The platform uses Consul to perform periodic health check calls.  Consul provides different types of [check definitions](https://www.consul.io/docs/agent/checks.html).  The platform currently supports http and docker health checks. 

When choosing a value for interval, consider that too frequent healthchecks will put unnecessary load on Consul and DCAE. If there is a problematic resource, then more frequent healthchecks are warranted (eg 15s or 60s), but as stablility increases, so can these values, (eg 300s).

When choosing a value for timeout, consider that too small a number will result in increasing timeout failures, and too large a number will result in a delay in the notification of resource problem. A suggestion is to start with 5s and workd from there.

#### http 

Property Name | Type | Description
------------- | ---- | -----------
type | string | *Required*.  `http`
interval | string | Interval duration in seconds i.e. `60s`
timeout | string | Timeout in seconds i.e. `5s`
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

#### docker script example

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

### Ports

```json
"auxilary": {
    "ports": ["8080:8000"]
}
```

In the example above, container port 8080 maps to host port 8000.

### Volume Mapping 

```json
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
```

At the top-level:

Property Name | Type | Description
------------- | ---- | -----------
volumes | array | Contains container and host objects

The `container` object contains:

Property Name | Type | Description
------------- | ---- | -----------
bind | string | path to the container volume
mode | string | "ro" - indicates read-only volume
     |        | "" - indicates that the contain can write into the bind mount

The `host` object contains:

Property Name | Type | Description
------------- | ---- | -----------
path | string | path to the host volume

Here's an example of the minimal JSON that must be provided as an input:

```json
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
```

In the example above, the container volume "/tmp/docker.sock" maps to host volume "/var/run/docker.sock".

### Policy 

Policy changes made in the Policy UI will be provided to the Docker component by triggering a script that is defined here.

Property Name | Type | Description
------------- | ---- | -----------
reconfigure_type | string | *Required*.  Current value supported is `policy` 
script_path | string | *Required*.  Current value for 'policy' reconfigure_type must be "/opt/app/reconfigure.sh"

Example:

```json
"auxilary": {
    "policy": {
        "reconfigure_type": "policy",
        "script_path": "/opt/app/reconfigure.sh"
    }
}
```

The docker script interface is as follows: <br><br> `/opt/app/reconfigure.sh $reconfigure_type {"updated policies": <updated policies object>, "application config": <applcation config object>}

Name | Type | Description
---- | ---- | -----------
reconfigure_type | string | "policy"
updated_policies | json | TBD
updated_appl_config | json | complete generated app_config, not fully-resolved, but `policy-enabled` parameters have been updated. In order to get the complete updated app_config, the component would have to call `config-binding-service`.


## Docker Component Spec - Complete Example

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
        "uri": "fake.nexus.com/dcae/kpi_anomaly:1.0.0",
        "type": "docker image"
    }]
}
```

