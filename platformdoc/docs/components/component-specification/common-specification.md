# Common Elements of the Component Specification

This page describes the component specification (JSON) sections that are common to both Docker and CDAP components. Differences for each are pointed out below. Elements that are very different, and described in the CDAP or Docker specific pages. 

## Component Metadata
Metadata refers to the properties found under the `self` JSON.  This group of properties is used to uniquely identify this component specification and identify the component that this specification is used to capture. 

Example:

```
"self": {
    "version": "1.0.0",
    "name": "asimov.component.kpi_anomaly",
    "description": "Classifies VNF KPI data as anomalous",
    "component_type": "docker"
},
```

`self` Schema:

Property Name | Type | Description
------------- | ---- | -----------
version | string | *Required*.  Semantic version for this specification
name | string | *Required*.  Full name of this component which is also used as this component's catalog id.
description | string | *Required*. Human-readable text describing the component and the components functional purpose.
component_type | string | *Required*.  Identify what containerization technology this component uses: `docker` or `cdap`.

## Interfaces
Interfaces are the JSON objects found under the `streams` key and the `services` key.  These are used to describe the interfaces that the component uses and the interfaces that the component provides.  The description of each interface includes the associated [data format](/components/data-formats.md).

### Streams
 * The `streams` JSON is for specifying data produced for consumption by other components, and the streams expected to subscribe to that is produced by other components. These are "fire and forget" type interfaces where the publisher of a stream does not expect or parse a response from the subscriber.
* The term `stream` here is abstract and neither refers to "CDAP streams" or "DMaaP feeds". While a stream is very likely a DMaaP feed, it could be a direct stream of data being routed via HTTP too. It abstractly refers to a sequence of data leaving a publisher.
* Streams have anonymous publish/subscribe semantics, which decouples the production of information from its consumption.
* In general, components are not aware of who they are communicating with.
* Instead, components that are interested in data, subscribe to the relevant stream; components that generate data publish to the relevant stream.
* There can be multiple publishers and subscribers to a stream. Streams are intended for unidirectional, streaming communication.


Streams interfaces that implement an HTTP endpoint must support POST.

Streams are split into:

Property Name | Type | Description
------------- | ---- | -----------
subscribes | JSON list | *Required*.  List of all available stream interfaces that this component has that can be used for subscribing
publishes | JSON list | *Required*.  List of all stream interfaces that this component will publish onto

#### Subscribes

Example:

```json
"streams": {
    "subscribes": [{
        "format": "dcae.vnf.kpi",
        "version": "1.0.0",
        "route": "/data",        // for CDAP this value is not used
        "type": "http"
    }],
...
}
```

This describes that `asimov.component.kpi_anomaly` exposes an HTTP endpoint called `/data` which accepts requests that have the data format of `dcae.vnf.kpi` version `1.0.0`.

`subscribes` Schema:

Property Name | Type | Description
------------- | ---- | -----------
format | string | *Required*.  Data format id of the data format that is used by this interface
version | string | *Required*.  Data format version of the data format that is used by this interface
route | string | *Required for HTTP and data router*.  The HTTP route that this interface listens on
config_key | string | *Required for message_router and data router*.  The HTTP route that this interface listens on
type | string | *Required*. Type of stream: `http`, `message_router`, `data_router`


##### Message router

Message router subscribers are http clients rather than http services and performs a http a `GET` call.  Thus, message router subscribers description is structured like message router publishers and requires `config_key`:

```json
"streams": {
    "subscribes": [{
        "format": "dcae.some-format",
        "version": "1.0.0",
        "config_key": "some_format_handle",
        "type": "message router"
    }],
...
}
```

##### Data router

Data router subscribers are http or https services that handle `PUT` requests from data router.  Developers must provide the `route` or url path/endpoint that is expected to handle data router requests.  This will be used to construct the delivery url needed to register the subscriber to the provisioned feed.  Developers must also provide a `config_key` because there is dynamic configuration information associated with the feed that the application will need e.g. username and password.  See the page on [DMaaP connection objects](../dcae-cli/dmaap-connection-objects) for more details on the configuration information.

Example (not tied to the larger example):

```json
"streams": {
    "subscribes": [{
        "config_key": "some-sub-dr",
        "format": "sandbox.platform.any",
        "route": "/identity",
        "type": "data_router",
        "version": "0.1.0"
    }],
...
}
```

#### Publishes

Example:

```json
"streams": {
...
    "publishes": [{
        "format": "asimov.format.integerClassification",
        "version": "1.0.0",
        "config_key": "prediction",
        "type": "http"
    }]
},

```

This describes that `asimov.component.kpi_anomaly` publishes by making POST requests to streams that support the data format `asimov.format.integerClassification` version `1.0.0`.

`publishes` Schema:

Property Name | Type | Description
------------- | ---- | -----------
format | string | *Required*.  Data format id of the data format that is used by this interface
version | string | *Required*.  Data format version of the data format that is used by this interface
config_key | string | *Required*.  The JSON key in the generated application configuration that will be used to pass the downstream component's (the subscriber's) connection information.
type | string | *Required*. Type of stream: `http`, `message router`, `data router`

##### Message router

Message router publishers are http clients of DMaap message_router.  Developers must provide a `config_key` because there is dynamic configuration information associated with the feed that the application will need to receive e.g. topic url, username, password.  See the page on [DMaaP connection objects](../dcae-cli/dmaap-connection-objects/#message_router) for more details on the configuration information.

Example (not tied to the larger example):

```json
"streams": {
...
    "publishes": [{
        "config_key": "some-pub-mr",
        "format": "sandbox.platform.any",
        "type": "message_router",
        "version": "0.1.0"
    }]
}
```

##### Data router

Data router publishers are http clients that make `PUT` requests to data router.  Developers must also provide a `config_key` because there is dynamic configuration information associated with the feed that the application will need to receive e.g. publish url, username, password.  See the page on [DMaaP connection objects](../dcae-cli/dmaap-connection-objects) for more details on the configuration information.

Example (not tied to the larger example):

```json
"streams": {
...
    "publishes": [{
        "config_key": "some-pub-dr",
        "format": "sandbox.platform.any",
        "type": "data_router",
        "version": "0.1.0"
    }]
}
```

#### Quick Reference

Refer to this [Quick Reference](/components/component-specification/streams-grid.md) for a comparison of the Streams 'Publishes' and 'Subscribes' sections.


### Services

* The publish / subscribe model is a very flexible communication paradigm, but its many-to-many one-way transport is not appropriate for RPC
request / reply interactions, which are often required in a distributed system.
* Request / reply is done via a Service, which is defined by a pair of messages: one for the request and one for the reply.

Services are split into:

Property Name | Type | Description
------------- | ---- | -----------
calls | JSON list | *Required*.  List of all service interfaces that this component will call
provides | JSON list | *Required*.  List of all service interfaces that this component exposes and provides

#### Calls
The JSON `services/calls` is for specifying that the component relies on an HTTP(S) service---the component sends that service an HTTP request, and that service responds with an HTTP reply.
An example of this is how string matching (SM) depends on the AAI Broker. SM performs a synchronous REST call to the AAI broker, providing it the VMNAME of the VNF, and the AAI Broker responds with additional details about the VNF. This dependency is expressed via `services/calls`. In contrast, the output of string matching (the alerts it computes) is sent directly to policy as a fire-and-forget interface, so that is an example of a `stream`. 

Example:

```json
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
```

This describes that `asimov.component.kpi_anomaly` will make HTTP calls to a downstream component that accepts requests of data format `dcae.vnf.meta` version `1.0.0` and is expecting the response to be `dcae.vnf.kpi` version `1.0.0`.

`calls` Schema:

Property Name | Type | Description
------------- | ---- | -----------
request | JSON object | *Required*.  Description of the expected request for this downstream interface
response | JSON object | *Required*.  Description of the expected response for this downstream interface
config_key | string | *Required*.  The JSON key in the generated application configuration that will be used to pass the downstream component connection information.

The JSON object schema for both `request` and `response`:

Property Name | Type | Description
------------- | ---- | -----------
format | string | *Required*.  Data format id of the data format that is used by this interface
version | string | *Required*.  Data format version of the data format that is used by this interface

#### Provides

Example:

```json
"services": {
...
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
```

This describes that `asimov.component.kpi_anomaly` provides a service interface and it is exposed on the `/score-vnf` HTTP endpoint.  The endpoint accepts requests that have the data format `dcae.vnf.meta` version `1.0.0` and gives back a response of `asimov.format.integerClassification` version `1.0.0`.

`provides` Schema for a Docker component:

Property Name | Type | Description
------------- | ---- | -----------
request | JSON object | *Required*.  Description of the expected request for this interface
response | JSON object | *Required*.  Description of the expected response for this interface
route | string | *Required*.  The HTTP route that this interface listens on

The JSON object schema for both `request` and `response`:

Property Name | Type | Description
------------- | ---- | -----------
format | string | *Required*.  Data format id of the data format that is used by this interface
version | string | *Required*.  Data format version of the data format that is used by this interface

Note, for CDAP, there is a slight variation due to the way CDAP exposes services:
```
      "provides":[                             // note this is a list of JSON
         {  
            "request":{  ...},
            "response":{  ...},
            "service_name":"name CDAP service", 
            "service_endpoint":"greet",         // E.g the URL is /services/service_name/methods/service_endpoint
            "verb":"GET"                        // GET, PUT, or POST
         }
      ]
```

`provides` Schema for a CDAP component:

Property Name | Type | Description
------------- | ---- | -----------
request | JSON object | *Required*.  Description of the expected request data format for this interface
response | JSON object | *Required*.  Description of the expected response for this interface
service_name | string | *Required*.  The CDAP service name (eg "Greeting")
service_endpoint | string | *Required*.  The CDAP service endpoint for this service_name (eg "/greet")
verb | string | *Required*.  'GET', 'PUT' or 'POST'


## Parameters

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
constraints | array | The optional list of sequenced constraint clauses for the parameter. See below | 
entry_schema | string | The optional key that is used to declare the name of the Datatype definition for entries of set types such as the TOSCA 'list' or 'map'. Only 1 level is supported at this time | 
designer_editable | boolean | An optional key that declares a parameter to be editable by designer (true) or not (false) | true
sourced_at_deployment | boolean | An optional key that declares a parameter's value to be assigned at deployment time (true) | false
policy_editable | boolean | An optional key that declares a parameter to be editable by policy (true) or not (false) | true
policy_schema | array | The optional list of schema definitions used for policy. See below |

Example:

```json
"parameters": [
    {
        "name": "threshold",
        "value": 0.75,
        "description": "Probability threshold to exceed to be anomalous"
    }
]
```

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

`threshold` is the configuration parameter and will get set to 0.75 when the configuration gets generated.

The property `policy_schema` is a list of objects where each policy_schema object:

Property Name | Type | Description | Default
------------- | ---- | ----------- | -------
name | string | *Required*. parameter name 
value | string | default value for the parameter
description | string | parameter description
type | enum | *Required*. data type of the parameter, 'string', 'number', 'boolean', 'datetime', 'list', or 'map'
required | boolean | is parameter required or not? | true
constraints | array | The optional list of sequenced constraint clauses for the parameter. See above | 
entry_schema | string | The optional key that is used to declare the name of the Datatype definition for certain types. entry_schema must be defined when the type is either list or map. If the type is list and the entry type is a simple type (string, number, bookean, datetime), follow with an string to describe the entry |
| | If the type is list and the entry type is a map, follow with an array to describe the keys for the entry map | 
| | If the type is list and the entry type is a list, that is not currently supported
| | If the type is map, follow with an aray to describe the keys for the map | 

## Generated Application Configuration

The above example for component `asimov.component.kpi_anomaly` will get transformed into the following application configuration JSON that is fully resolved and provided at runtime by calling the `config binding service`:

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

## Artifacts

`artifacts` contains a list of artifacts associated with this component.  For Docker, this is the full path (including the registry) to the Docker image. For CDAP, this is the full path to the CDAP jar.

Property Name | Type | Description
------------- | ---- | -----------
artifacts | JSON array | Each entry is a artifact object

`artifact` Schema:

Property Name | Type | Description
------------- | ---- | -----------
uri | string | *Required*. Uri to the artifact, full path
type | string | *Required*. `docker image` or `jar`

