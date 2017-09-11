# Component specification (Common elements)

This page describes component specification sections that are common (or nearly) to both Docker and CDAP.

## Component Metadata
Metadata refers to the properties found under the `self` JSON.  This group of properties are used to uniquely identify this component specification and identify the component that this specification is used to capture. The metadata section, represented under `self`, is used to uniquely identify your component among all components in the catalog. 

From the specification example above:

```
"self": {
    "version": "1.0.0",
    "name": "asimov.component.kpi_anomaly",
    "description": "Classifies VNF KPI data as anomalous",
    "component_type": "docker"
},
```

Here is a breakdown of the schema:

Property Name | Type | Description
------------- | ---- | -----------
version | string | *Required*.  Semantic version for this specification
name | string | *Required*.  Full name of this component which is also used as this component's catalog id.  The name includes a namespace that is dot-separated.
description | string | Human-readable text blurb describing the component and the components functional purpose.
component_type | string | *Required*.  Identify what containerization technology this component uses: `docker` or `cdap`.

## Interfaces
Interfaces are the JSON objects found under the `streams` key and the `services` key.  These are used to describe the interfaces that the component uses and the interfaces that the component provides.  The description of each interface includes the associated [data format](/components/data-formats.md).

### Streams
 * The `streams` JSON is for specifying that you produce data that can be consumed by other components, and the streams you expect to subscribe to produced by other components. These are "fire and     forget" type interfaces where the publisher of a stream does not expect or parse a response from the subscriber.
* The term `stream` here is abstract and neither refers to "CDAP streams" or "DMaaP feeds": while a stream is very likely a DMaaP feed, it could be a direct stream of data being routed via HTTP too. It     abstractly refers to a sequence of data leaving a publisher.
* Streams have anonymous publish/subscribe semantics, which decouples the production of information from its consumption.
* In general, components are not aware of who they are communicating with.
* Instead, components that are interested in data subscribe to the relevant stream; components that generate data publish to the relevant stream.
* There can be multiple publishers and subscribers to a stream. Streams are intended for unidirectional, streaming communication.

Streams interfaces that implement an HTTP endpoint must support POST.

Streams are split into:

Property Name | Type | Description
------------- | ---- | -----------
subscribes | JSON list | *Required*.  List of all available stream interfaces that this component has that can be used for subscribing
publishes | JSON list | *Required*.  List of all stream interfaces that this component will publish onto

#### Subscribes

From the example specification:

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

The JSON object schema used in `subscribes`:

Property Name | Type | Description
------------- | ---- | -----------
format | string | *Required*.  Data format id of the data format that is used by this interface
version | string | *Required*.  Data format version of the data format that is used by this interface
route | string | *Required*.  The HTTP route that this interface listens on
type | string | *Required*. Type of stream: `http`, `message_router`, `data_router`

##### Message router

Message router subscribers are http clients rather than http services and performs a http `GET` call.  Thus, message router subscribers description is structured like message router publishers and requires `config_key`:

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

Data router subscribers are http or https services that handle `PUT` requests from data router.  Developers must provide the `route` or url path/endpoint that is expected to handle data router requests.  This will be used to construct the delivery url needed to register your subscriber to the provisioned feed.  Developers must also provide a `config_key` because there is dynamic configuration information associated with the feed that your application will need e.g. username and password.  See the page on [DMaaP connection objects](../dcae-cli/dmaap-connection-objects) for more details on the configuration information.

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

From the example specification:

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

The JSON object schema used in `publishes`:

Property Name | Type | Description
------------- | ---- | -----------
format | string | *Required*.  Data format id of the data format that is used by this interface
version | string | *Required*.  Data format version of the data format that is used by this interface
config_key | string | *Required*.  The JSON key in the generated application configuration that will be used to pass the downstream component connection information.
type | string | *Required*. Type of stream: `http`, `message router`

##### Data router

Data router publishers are http clients that make `PUT` requests to data router.  Developers must also provide a `config_key` because there is dynamic configuration information associated with the feed that your application will need to receive e.g. publish url, username, password.  See the page on [DMaaP connection objects](../dcae-cli/dmaap-connection-objects) for more details on the configuration information.

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
The JSON `services/calls` is for specifying that your component relies on an HTTP(S) service---your component sends that service an HTTP request, and that service responds with an HTTP reply.
An example of this is how string matching (SM) depends on the AAI Broker. SM performs a synchronous REST call to the AAI broker, providing it the VMNAME of the VNF, and the AAI Broker responds with additional details about the VNF. This dependency is expressed via `services/calls`. In contrast, the output of string matching (the alerts it computes) is sent directly to policy as a fire-and-forget interface, so that is an example of a `stream`. 

From the example specification:

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

The JSON object schema used in `calls`:

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

From the example specification:

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

The JSON object schema used in `provides`:

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
