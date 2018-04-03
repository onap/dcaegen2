.. This work is licensed under a Creative Commons Attribution 4.0 International License.
.. http://creativecommons.org/licenses/by/4.0

.. _common-specification:

Common Elements of the Component Specification
==============================================

This page describes the component specification (JSON) sections that are
common to both Docker and CDAP components. Differences for each are
pointed out below. Elements that are very different, and described in
the CDAP or Docker specific pages.

.. _metaschema: 

Meta Schema Definition
----------------------

The component specification is represented (and validated) against this
`Component Spec json
schema <https://gerrit.onap.org/r/gitweb?p=dcaegen2/platform/cli.git;a=blob;f=component-json-schemas/component-specification/dcae-cli-v1/component-spec-schema.json;h=27d0403af67eac00e03ab89437d5f07aa06fbee3;hb=HEAD>`__
and described below:

The “Meta Schema” implementation defines how component specification
JSON schemas can be written to define user input. It is itself a JSON
schema (thus it is a “meta schema”). It requires the name of the
component entry, component type (either ‘cdap’ or ‘docker’) and a
description under “self” object. The meta schema version must be
specified as the value of the “version” key. Then the input schema
itself is described.

There are four types of schema descriptions objects - jsonschema for
inline standard JSON Schema definitions of JSON inputs, delimitedschema
for delimited data input using a JSON description defined by AT&T,
unstructured for unstructured text, and reference that allows a pointer
to another artifact for a schema. The reference allows for XML and Protocol Buffer schema,
but can be used as a pointer to JSON, Delimited Format, and Unstructured
schemas as well.

.. _metadata:

Component Metadata
------------------

Metadata refers to the properties found under the ``self`` JSON. This
group of properties is used to uniquely identify this component
specification and identify the component that this specification is used
to capture.

Example:

::

    "self": {
        "version": "1.0.0",
        "name": "yourapp.component.kpi_anomaly",
        "description": "Classifies VNF KPI data as anomalous",
        "component_type": "docker"
    },

``self`` Schema:

+-------------+--------+----------------+
| Property    | Type   | Description    |
| Name        |        |                |
+=============+========+================+
| version     | string | *Required*.    |
|             |        | Semantic       |
|             |        | version        |
|             |        | for this       |
|             |        | specification  |
+-------------+--------+----------------+
| name        | string | *Required*.    |
|             |        | Full           |
|             |        | name of        |
|             |        | this           |
|             |        | component      |
|             |        | which is       |
|             |        | also           |
|             |        | used as        |
|             |        | this           |
|             |        | component's    |
|             |        | catalog        |
|             |        | id.            |
+-------------+--------+----------------+
| description | string | *Required*     |
|             |        | Human-readable |
|             |        | text           |
|             |        | describing     |
|             |        | the            |
|             |        | component      |
|             |        | and the        |
|             |        | components     |
|             |        | functional     |
|             |        | purpose.       |
+-------------+--------+----------------+
| component_t\| string | *Required*     |
| ype         |        | Identify       |
|             |        | what           |
|             |        | containe\      |
|             |        | rization       |
|             |        | technolo\      |
|             |        | gy             |
|             |        | this           |
|             |        | componen\      |
|             |        | t              |
|             |        | uses:          |
|             |        | *docker*       |
|             |        | or             |
|             |        | *cdap*.        |
|             |        |                |
+-------------+--------+----------------+

.. _interfaces:

Interfaces
----------

Interfaces are the JSON objects found under the ``streams`` key and the
``services`` key. These are used to describe the interfaces that the
component uses and the interfaces that the component provides. The
description of each interface includes the associated :any:`data
format <data-formats>`.

Streams
~~~~~~~

-  The ``streams`` JSON is for specifying data produced for consumption
   by other components, and the streams expected to subscribe to that is
   produced by other components. These are “fire and forget” type
   interfaces where the publisher of a stream does not expect or parse a
   response from the subscriber.
-  The term ``stream`` here is abstract and neither refers to “CDAP
   streams” or “DMaaP feeds”. While a stream is very likely a DMaaP
   feed, it could be a direct stream of data being routed via HTTP too.
   It abstractly refers to a sequence of data leaving a publisher.
-  Streams have anonymous publish/subscribe semantics, which decouples
   the production of information from its consumption.  Like the component 
   specification, the data format specification is represented/validated against this
   `Data Format json schema <https://gerrit.onap.org/r/gitweb?p=dcaegen2/platform/cli.git;a=blob;f=component-json-schemas/data-format/dcae-cli-v1/data-format-schema.json;h=be1568291300305c7adb9a8d244d39f9e6ddadbd;hb=HEAD>`__
-  In general, components are not aware of who they are communicating
   with.
-  Instead, components that are interested in data, subscribe to the
   relevant stream; components that generate data publish to the
   relevant stream.
-  There can be multiple publishers and subscribers to a stream. Streams
   are intended for unidirectional, streaming communication.

Streams interfaces that implement an HTTP endpoint must support POST.

Streams are split into:

+-------------+----+----------+
| Property    | Ty\| Descript\|
| Name        | pe | ion      |
+=============+====+==========+
| subscribes  | JS\| *Require\|
|             | ON | d*.      |
|             | li\| List of  |
|             | st | all      |
|             |    | availabl\|
|             |    | e        |
|             |    | stream   |
|             |    | interfac\|
|             |    | es       |
|             |    | that     |
|             |    | this     |
|             |    | componen\|
|             |    | t        |
|             |    | has that |
|             |    | can be   |
|             |    | used for |
|             |    | subscrib\|
|             |    | ing      |
+-------------+----+----------+
| publishes   | JS\| *Require\|
|             | ON | d*.      |
|             | li\| List of  |
|             | st | all      |
|             |    | stream   |
|             |    | interfac\|
|             |    | es       |
|             |    | that     |
|             |    | this     |
|             |    | componen\|
|             |    | t        |
|             |    | will     |
|             |    | publish  |
|             |    | onto     |
+-------------+----+----------+

Subscribes
^^^^^^^^^^

Example:

.. code:: json

    "streams": {
        "subscribes": [{
            "format": "dcae.vnf.kpi",
            "version": "1.0.0",
            "route": "/data",        // for CDAP this value is not used
            "type": "http"
        }],
    ...
    }

This describes that ``yourapp.component.kpi_anomaly`` exposes an HTTP
endpoint called ``/data`` which accepts requests that have the data
format of ``dcae.vnf.kpi`` version ``1.0.0``.

``subscribes`` Schema:

+-------------+----+--------------------+
| Property    | Ty\| Descript\          |
| Name        | pe | ion                |
+=============+====+====================+
| format      | st\| *Require\          |
|             | ri\| d*.                |
|             | ng | Data               |
|             |    | format             |
|             |    | id of              |
|             |    | the data           |
|             |    | format             |
|             |    | that is            |
|             |    | used by            |
|             |    | this               |
|             |    | interfac\          |
|             |    | e                  |
+-------------+----+--------------------+
| version     | st\| *Require\          |
|             | ri\| d*.                |
|             | ng | Data               |
|             |    | format             |
|             |    | version            |
|             |    | of the             |
|             |    | data               |
|             |    | format             |
|             |    | that is            |
|             |    | used by            |
|             |    | this               |
|             |    | interfac\          |
|             |    | e                  |
+-------------+----+--------------------+
| route       | st\| *Require\          |
|             | ri\| d                  |
|             | ng | for HTTP           |
|             |    | and data           |
|             |    | router*.           |
|             |    | The HTTP           |
|             |    | route              |
|             |    | that               |
|             |    | this               |
|             |    | interfac\          |
|             |    | e                  |
|             |    | listens            |
|             |    | on                 |
+-------------+----+--------------------+
| config_key  | st\| *Require\          |
|             | ri\| d \                |
|             | ng | for \              |
|             |    | message_router\    |
|             |    | and data \         |
|             |    | router*.           |
|             |    | The HTTP           |
|             |    | route              |
|             |    | that               |
|             |    | this               |
|             |    | interfac\          |
|             |    | e                  |
|             |    | listens            |
|             |    | on                 |
+-------------+----+--------------------+
| type        | st\| *Require\          |
|             | ri\| d*.                |
|             | ng | Type of            |
|             |    | stream:            |
|             |    | ``http``           |
|             |    | ,                  |
|             |    | ``message_router`` |
|             |    | ,                  |
|             |    | ``data_router``    |
+-------------+----+--------------------+

.. _message-router:

Message router
''''''''''''''

Message router subscribers are http clients rather than http services
and performs a http a ``GET`` call. Thus, message router subscribers
description is structured like message router publishers and requires
``config_key``:

.. code:: json

    "streams": {
        "subscribes": [{
            "format": "dcae.some-format",
            "version": "1.0.0",
            "config_key": "some_format_handle",
            "type": "message router"
        }],
    ...
    }


.. _data-router:

Data router
'''''''''''

Data router subscribers are http or https services that handle ``PUT``
requests from data router. Developers must provide the ``route`` or url
path/endpoint that is expected to handle data router requests. This will
be used to construct the delivery url needed to register the subscriber
to the provisioned feed. Developers must also provide a ``config_key``
because there is dynamic configuration information associated with the
feed that the application will need e.g. username and password. See the
page on :any:`DMaaP connection objects <dmaap-data-router>` for more details on
the configuration information.

Example (not tied to the larger example):

.. code:: json

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

Publishes
^^^^^^^^^

Example:

.. code:: json

    "streams": {
    ...
        "publishes": [{
            "format": "yourapp.format.integerClassification",
            "version": "1.0.0",
            "config_key": "prediction",
            "type": "http"
        }]
    },

This describes that ``yourapp.component.kpi_anomaly`` publishes by making
POST requests to streams that support the data format
``yourapp.format.integerClassification`` version ``1.0.0``.

``publishes`` Schema:

+-------------+----+--------------------+
| Property    | Ty\| Descript\          |
| Name        | pe | ion                |
+=============+====+====================+
| format      | st\| *Require\          |
|             | ri\| d*.                |
|             | ng | Data               |
|             |    | format             |
|             |    | id of              |
|             |    | the data           |
|             |    | format             |
|             |    | that is            |
|             |    | used by            |
|             |    | this               |
|             |    | interfac\          |
|             |    | e                  |
+-------------+----+--------------------+
| version     | st\| *Require\          |
|             | ri\| d*.                |
|             | ng | Data               |
|             |    | format             |
|             |    | version            |
|             |    | of the             |
|             |    | data               |
|             |    | format             |
|             |    | that is            |
|             |    | used by            |
|             |    | this               |
|             |    | interfac\          |
|             |    | e                  |
+-------------+----+--------------------+
| config_key  | st\| *Require\          |
|             | ri\| d*.                |
|             | ng | The JSON           |
|             |    | key in             |
|             |    | the                |
|             |    | generate\          |
|             |    | d                  |
|             |    | applicat           |
|             |    | ion                |
|             |    | configur\          |
|             |    | ation              |
|             |    | that               |
|             |    | will be            |
|             |    | used to            |
|             |    | pass the           |
|             |    | downstre\          |
|             |    | am                 |
|             |    | componen\          |
|             |    | t’s                |
|             |    | (the               |
|             |    | subscrib\          |
|             |    | er’s)              |
|             |    | connecti\          |
|             |    | on                 |
|             |    | informat\          |
|             |    | ion.               |
+-------------+----+--------------------+
| type        | st\| *Require\          |
|             | ri\| d*.                |
|             | ng | Type of            |
|             |    | stream:            |
|             |    | ``http``           |
|             |    | ,                  |
|             |    | ``message_router`` |
|             |    | ,                  |
|             |    | ``data_router``    |
+-------------+----+--------------------+

.. message-router-1:

Message router
''''''''''''''

Message router publishers are http clients of DMaap message_router.
Developers must provide a ``config_key`` because there is dynamic
configuration information associated with the feed that the application
needs to receive e.g. topic url, username, password. See the page on
:any:`DMaaP connection objects <dmaap-message-router>` for more details on
the configuration information.

Example (not tied to the larger example):

.. code:: json

    "streams": {
    ...
        "publishes": [{
            "config_key": "some-pub-mr",
            "format": "sandbox.platform.any",
            "type": "message_router",
            "version": "0.1.0"
        }]
    }

.. data-router-1:

Data router
'''''''''''

Data router publishers are http clients that make ``PUT`` requests to
data router. Developers must also provide a ``config_key`` because there
is dynamic configuration information associated with the feed that the
application will need to receive e.g. publish url, username, password.
See the page on :any:`DMaaP connection objects <dmaap-data-router>` for more details on
the configuration information.

Example (not tied to the larger example):

.. code:: json

    "streams": {
    ...
        "publishes": [{
            "config_key": "some-pub-dr",
            "format": "sandbox.platform.any",
            "type": "data_router",
            "version": "0.1.0"
        }]
    }

Quick Reference
^^^^^^^^^^^^^^^

Refer to this :doc:`Quick Reference <streams-grid>` for a
comparison of the Streams ‘Publishes’ and ‘Subscribes’ sections.

Services
~~~~~~~~

-  The publish / subscribe model is a very flexible communication
   paradigm, but its many-to-many one-way transport is not appropriate
   for RPC request / reply interactions, which are often required in a
   distributed system.
-  Request / reply is done via a Service, which is defined by a pair of
   messages: one for the request and one for the reply.

Services are split into:

+-------------+----+----------+
| Property    | Ty\| Descript\|
| Name        | pe | ion      |
+=============+====+==========+
| calls       | JS\| *Require\|
|             | ON | d*.      |
|             | li\| List of  |
|             | st | all      |
|             |    | service  |
|             |    | interfac\|
|             |    | es       |
|             |    | that     |
|             |    | this     |
|             |    | componen\|
|             |    | t        |
|             |    | will     |
|             |    | call     |
+-------------+----+----------+
| provides    | JS\| *Require\|
|             | ON | d*.      |
|             | li\| List of  |
|             | st | all      |
|             |    | service  |
|             |    | interfac\|
|             |    | es       |
|             |    | that     |
|             |    | this     |
|             |    | componen\|
|             |    | t        |
|             |    | exposes  |
|             |    | and      |
|             |    | provides |
+-------------+----+----------+

Calls
^^^^^

The JSON ``services/calls`` is for specifying that the component relies
on an HTTP(S) service—the component sends that service an HTTP request,
and that service responds with an HTTP reply. An example of this is how
string matching (SM) depends on the AAI Broker. SM performs a
synchronous REST call to the AAI broker, providing it the VMNAME of the
VNF, and the AAI Broker responds with additional details about the VNF.
This dependency is expressed via ``services/calls``. In contrast, the
output of string matching (the alerts it computes) is sent directly to
policy as a fire-and-forget interface, so that is an example of a
``stream``.

Example:

.. code:: json

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

This describes that ``yourapp.component.kpi_anomaly`` will make HTTP
calls to a downstream component that accepts requests of data format
``dcae.vnf.meta`` version ``1.0.0`` and is expecting the response to be
``dcae.vnf.kpi`` version ``1.0.0``.

``calls`` Schema:

+-------------+----+----------+
| Property    | Ty\| Descript\|
| Name        | pe | ion      |
+=============+====+==========+
| request     | JS\| *Require\|
|             | ON | d*.      |
|             | ob\| Descript\|
|             | je\| ion      |
|             | ct | of the   |
|             |    | expected |
|             |    | request  |
|             |    | for this |
|             |    | downstre\|
|             |    | am       |
|             |    | interfac\|
|             |    | e        |
+-------------+----+----------+
| response    | JS\| *Require\|
|             | ON | d*.      |
|             | ob\| Descript\|
|             | je\| ion      |
|             | ct | of the   |
|             |    | expected |
|             |    | response |
|             |    | for this |
|             |    | downstre\|
|             |    | am       |
|             |    | interfac\|
|             |    | e        |
+-------------+----+----------+
| config_key  | st\| *Require\|
|             | ri\| d*.      |
|             | ng | The JSON |
|             |    | key in   |
|             |    | the      |
|             |    | generate\|
|             |    | d        |
|             |    | applicat |
|             |    | ion      |
|             |    | configur\|
|             |    | ation    |
|             |    | that     |
|             |    | will be  |
|             |    | used to  |
|             |    | pass the |
|             |    | downstre\|
|             |    | am       |
|             |    | componen |
|             |    | t        |
|             |    | connecti\|
|             |    | on       |
|             |    | informat\|
|             |    | ion.     |
+-------------+----+----------+

The JSON object schema for both ``request`` and ``response``:

+-------------+----+----------+
| Property    | Ty\| Descript\|
| Name        | pe | ion      |
+=============+====+==========+
| format      | st\| *Require\|
|             | ri\| d*.      |
|             | ng | Data     |
|             |    | format   |
|             |    | id of    |
|             |    | the data |
|             |    | format   |
|             |    | that is  |
|             |    | used by  |
|             |    | this     |
|             |    | interfac\|
|             |    | e        |
+-------------+----+----------+
| version     | st\| *Require\|
|             | ri\| d*.      |
|             | ng | Data     |
|             |    | format   |
|             |    | version  |
|             |    | of the   |
|             |    | data     |
|             |    | format   |
|             |    | that is  |
|             |    | used by  |
|             |    | this     |
|             |    | interfac\|
|             |    | e        |
+-------------+----+----------+

Provides
^^^^^^^^

Example:

.. code:: json

    "services": {
    ...
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

This describes that ``yourapp.component.kpi_anomaly`` provides a service
interface and it is exposed on the ``/score-vnf`` HTTP endpoint. The
endpoint accepts requests that have the data format ``dcae.vnf.meta``
version ``1.0.0`` and gives back a response of
``yourapp.format.integerClassification`` version ``1.0.0``.

``provides`` Schema for a Docker component:

+-------------+----+----------+
| Property    | Ty\| Descript\|
| Name        | pe | ion      |
+=============+====+==========+
| request     | JS\| *Require\|
|             | ON | d*.      |
|             | ob\| Descript\|
|             | je\| ion      |
|             | ct | of the   |
|             |    | expected |
|             |    | request  |
|             |    | for this |
|             |    | interfac\|
|             |    | e        |
+-------------+----+----------+
| response    | JS\| *Require\|
|             | ON | d*.      |
|             | ob\| Descript\|
|             | je\| ion      |
|             | ct | of the   |
|             |    | expected |
|             |    | response |
|             |    | for this |
|             |    | interfac\|
|             |    | e        |
+-------------+----+----------+
| route       | st\| *Require\|
|             | ri\| d*.      |
|             | ng | The HTTP |
|             |    | route    |
|             |    | that     |
|             |    | this     |
|             |    | interfac\|
|             |    | e        |
|             |    | listens  |
|             |    | on       |
+-------------+----+----------+

The JSON object schema for both ``request`` and ``response``:

+-------------+----+----------+
| Property    | Ty\| Descript\|
| Name        | pe | ion      |
+=============+====+==========+
| format      | st\| *Require\|
|             | ri\| d*.      |
|             | ng | Data     |
|             |    | format   |
|             |    | id of    |
|             |    | the data |
|             |    | format   |
|             |    | that is  |
|             |    | used by  |
|             |    | this     |
|             |    | interfac\|
|             |    | e        |
+-------------+----+----------+
| version     | st\| *Require\|
|             | ri\| d*.      |
|             | ng | Data     |
|             |    | format   |
|             |    | version  |
|             |    | of the   |
|             |    | data     |
|             |    | format   |
|             |    | that is  |
|             |    | used by  |
|             |    | this     |
|             |    | interfac\|
|             |    | e        |
+-------------+----+----------+

Note, for CDAP, there is a slight variation due to the way CDAP exposes
services:

::

          "provides":[                             // note this is a list of JSON
             {  
                "request":{  ...},
                "response":{  ...},
                "service_name":"name CDAP service", 
                "service_endpoint":"greet",         // E.g the URL is /services/service_name/methods/service_endpoint
                "verb":"GET"                        // GET, PUT, or POST
             }
          ]

``provides`` Schema for a CDAP component:

+-------------+----+-----------+
| Property    | Ty\| Descript\ |
| Name        | pe | ion       |
+=============+====+===========+
| request     | JS\| *Require\ |
|             | ON | d*.       |
|             | ob\| Descript\ |
|             | je\| ion       |
|             | ct | of the    |
|             |    | expected  |
|             |    | request   |
|             |    | data      |
|             |    | format    |
|             |    | for this  |
|             |    | interfac\ |
|             |    | e         |
+-------------+----+-----------+
| response    | JS\| *Require\ |
|             | ON | d*.       |
|             | ob\| Descript\ |
|             | je\| ion       |
|             | ct | of the    |
|             |    | expected  |
|             |    | response  |
|             |    | for this  |
|             |    | interfac\ |
|             |    | e         |
+-------------+----+-----------+
| service_nam\| st\| *Require\ |
| e           | ri\| d*.       |
|             | ng | The CDAP  |
|             |    | service   |
|             |    | name (eg  |
|             |    | “Greetin\ |
|             |    | g”)       |
+-------------+----+-----------+
| service_end | st\| *Require\ |
| point       | ri\| d*.       |
|             | ng | The CDAP  |
|             |    | service   |
|             |    | endpoint  |
|             |    | for this  |
|             |    | service_n\|
|             |    | ame       |
|             |    | (eg       |
|             |    | “/greet”  |
|             |    | )         |
+-------------+----+-----------+
| verb        | st\| *Require\ |
|             | ri\| d*.       |
|             | ng | ‘GET’,    |
|             |    | ‘PUT’ or  |
|             |    | ‘POST’    |
+-------------+----+-----------+

.. _common-specification-parameters:

Parameters
----------

``parameters`` is where to specify the component’s application
configuration parameters that are not connection information.

+---------------+------------+----------------------------------+
| Property Name | Type       | Description                      |
+===============+============+==================================+
| parameters    | JSON array | Each entry is a parameter object |
+---------------+------------+----------------------------------+

Parameter object has the following available properties:

+--------------+----+----------+------+
| Property     | Ty\| Descript\| Defa\|
| Name         | pe | ion      | ult  |
+==============+====+==========+======+
| name         | st\| *Require\|      |
|              | ri\| d*.      |      |
|              | ng | The      |      |
|              |    | property |      |
|              |    | name     |      |
|              |    | that     |      |
|              |    | will be  |      |
|              |    | used as  |      |
|              |    | the key  |      |
|              |    | in the   |      |
|              |    | generate\|      |
|              |    | d        |      |
|              |    | config   |      |
+--------------+----+----------+------+
| value        | an\| *Require\|      |
|              | y  | d*.      |      |
|              |    | The      |      |
|              |    | default  |      |
|              |    | value    |      |
|              |    | for the  |      |
|              |    | given    |      |
|              |    | paramete\|      |
|              |    | r        |      |
+--------------+----+----------+------+
| description  | st\| *Require\|      |
|              | ri\| d*.      |      |
|              | ng | Human-re\|      |
|              |    | adable   |      |
|              |    | text     |      |
|              |    | describi\|      |
|              |    | ng       |      |
|              |    | the      |      |
|              |    | paramete\|      |
|              |    | r        |      |
|              |    | like     |      |
|              |    | what its |      |
|              |    | for      |      |
+--------------+----+----------+------+
| type         | st\| The      |      |
|              | ri\| required |      |
|              | ng | data     |      |
|              |    | type for |      |
|              |    | the      |      |
|              |    | paramete\|      |
|              |    | r        |      |
+--------------+----+----------+------+
| required     | bo\| An       | true |
|              | ol\| optional |      |
|              | ea\| key that |      |
|              | n  | declares |      |
|              |    | a        |      |
|              |    | paramete\|      |
|              |    | r        |      |
|              |    | as       |      |
|              |    | required |      |
|              |    | (true)   |      |
|              |    | or not   |      |
|              |    | (false)  |      |
+--------------+----+----------+------+
| constraints  | ar\| The      |      |
|              | ra\| optional |      |
|              | y  | list of  |      |
|              |    | sequence |      |
|              |    | d        |      |
|              |    | constrai\|      |
|              |    | nt       |      |
|              |    | clauses  |      |
|              |    | for the  |      |
|              |    | paramete\|      |
|              |    | r.       |      |
|              |    | See      |      |
|              |    | below    |      |
+--------------+----+----------+------+
| entry_schem\ | st\| The      |      |
| a            | ri\| optional |      |
|              | ng | key that |      |
|              |    | is used  |      |
|              |    | to       |      |
|              |    | declare  |      |
|              |    | the name |      |
|              |    | of the   |      |
|              |    | Datatype |      |
|              |    | definiti\|      |
|              |    | on       |      |
|              |    | for      |      |
|              |    | entries  |      |
|              |    | of set   |      |
|              |    | types    |      |
|              |    | such as  |      |
|              |    | the      |      |
|              |    | TOSCA    |      |
|              |    | ‘list’   |      |
|              |    | or       |      |
|              |    | ‘map’.   |      |
|              |    | Only 1   |      |
|              |    | level is |      |
|              |    | supporte\|      |
|              |    | d        |      |
|              |    | at this  |      |
|              |    | time     |      |
+--------------+----+----------+------+
| designer_ed\ | bo\| An       |      |
| itable       | ol\| optional |      |
|              | ea\| key that |      |
|              | n  | declares |      |
|              |    | a        |      |
|              |    | paramete\|      |
|              |    | r        |      |
|              |    | to be    |      |
|              |    | editable |      |
|              |    | by       |      |
|              |    | designer |      |
|              |    | (true)   |      |
|              |    | or not   |      |
|              |    | (false)  |      |
+--------------+----+----------+------+
| sourced_at_d\| bo\| An       |      |
| eployment    | ol\| optional |      |
|              | ea\| key that |      |
|              | n  | declares |      |
|              |    | a        |      |
|              |    | paramete\|      |
|              |    | r’s      |      |
|              |    | value to |      |
|              |    | be       |      |
|              |    | assigned |      |
|              |    | at       |      |
|              |    | deployme\|      |
|              |    | nt       |      |
|              |    | time     |      |
|              |    | (true)   |      |
+--------------+----+----------+------+
| policy_edit\ | bo\| An       |      |
| able         | ol\| optional |      |
|              | ea\| key that |      |
|              | n  | declares |      |
|              |    | a        |      |
|              |    | paramete\|      |
|              |    | r        |      |
|              |    | to be    |      |
|              |    | editable |      |
|              |    | by       |      |
|              |    | policy   |      |
|              |    | (true)   |      |
|              |    | or not   |      |
|              |    | (false)  |      |
+--------------+----+----------+------+
| policy_sche\ | ar\| The      |      |
| ma           | ra\| optional |      |
|              | y  | list of  |      |
|              |    | schema   |      |
|              |    | definiti\|      |
|              |    | ons      |      |
|              |    | used for |      |
|              |    | policy.  |      |
|              |    | See      |      |
|              |    | below    |      |
+--------------+----+----------+------+

Example:

.. code:: json

    "parameters": [
        {
            "name": "threshold",
            "value": 0.75,
            "description": "Probability threshold to exceed to be anomalous"
        }
    ]

Many of the parameter properties have been copied from TOSCA model
property definitions and are to be used for service design composition
and policy creation. See `section 3.5.8 *Property
definition* <http://docs.oasis-open.org/tosca/TOSCA-Simple-Profile-YAML/v1.1/TOSCA-Simple-Profile-YAML-v1.1.html>`__.

The property ``constraints`` is a list of objects where each constraint
object:

+--------------+----+----------+
| Property     | Ty\| Descript\|
| Name         | pe | ion      |
+==============+====+==========+
| equal        |    | Constrai\|
|              |    | ns       |
|              |    | a        |
|              |    | property |
|              |    | or       |
|              |    | paramete\|
|              |    | r        |
|              |    | to a     |
|              |    | value    |
|              |    | equal to |
|              |    | (‘=’)    |
|              |    | the      |
|              |    | value    |
|              |    | declared |
+--------------+----+----------+
| greater_tha\ | nu\| Constrai\|
| n            | mb\| ns       |
|              | er | a        |
|              |    | property |
|              |    | or       |
|              |    | paramete |
|              |    | r        |
|              |    | to a     |
|              |    | value    |
|              |    | greater  |
|              |    | than     |
|              |    | (‘>’)    |
|              |    | the      |
|              |    | value    |
|              |    | declared |
+--------------+----+----------+
| greater_or_e\| nu\| Constrai\|
| qual         | mb\| ns       |
|              | er | a        |
|              |    | property |
|              |    | or       |
|              |    | paramete\|
|              |    | r        |
|              |    | to a     |
|              |    | value    |
|              |    | greater  |
|              |    | than or  |
|              |    | equal to |
|              |    | (‘>=’)   |
|              |    | the      |
|              |    | value    |
|              |    | declared |
+--------------+----+----------+
| less_than    | nu\| Constrai\|
|              | mb\| ns       |
|              | er | a        |
|              |    | property |
|              |    | or       |
|              |    | paramete\|
|              |    | r        |
|              |    | to a     |
|              |    | value    |
|              |    | less     |
|              |    | than     |
|              |    | (‘<’)    |
|              |    | the      |
|              |    | value    |
|              |    | declared |
+--------------+----+----------+
| less_or_equ\ | nu\| Constrai\|
| al           | mb\| ns       |
|              | er | a        |
|              |    | property |
|              |    | or       |
|              |    | paramete\|
|              |    | r        |
|              |    | to a     |
|              |    | value    |
|              |    | less     |
|              |    | than or  |
|              |    | equal to |
|              |    | (‘<=’)   |
|              |    | the      |
|              |    | value    |
|              |    | declared |
+--------------+----+----------+
| valid_value\ | ar\| Constrai\|
| s            | ra\| ns       |
|              | y  | a        |
|              |    | property |
|              |    | or       |
|              |    | paramete\|
|              |    | r        |
|              |    | to a     |
|              |    | value    |
|              |    | that is  |
|              |    | in the   |
|              |    | list of  |
|              |    | declared |
|              |    | values   |
+--------------+----+----------+
| length       | nu\| Constrai\|
|              | mb\| ns       |
|              | er | the      |
|              |    | property |
|              |    | or       |
|              |    | paramete\|
|              |    | r        |
|              |    | to a     |
|              |    | value of |
|              |    | a given  |
|              |    | length   |
+--------------+----+----------+
| min_length   | nu\| Constrai\|
|              | mb\| ns       |
|              | er | the      |
|              |    | property |
|              |    | or       |
|              |    | paramete\|
|              |    | r        |
|              |    | to a     |
|              |    | value to |
|              |    | a        |
|              |    | minimum  |
|              |    | length   |
+--------------+----+----------+
| max_length   | nu\| Constrai\|
|              | mb\| ns       |
|              | er | the      |
|              |    | property |
|              |    | or       |
|              |    | paramete\|
|              |    | r        |
|              |    | to a     |
|              |    | value to |
|              |    | a        |
|              |    | maximum  |
|              |    | length   |
+--------------+----+----------+

``threshold`` is the configuration parameter and will get set to 0.75
when the configuration gets generated.

The property ``policy_schema`` is a list of objects where each
policy_schema object:

+-------------+----+----------+------+
| Property    | Ty\| Descript\| Defa\|
| Name        | pe | ion      | ult  |
+=============+====+==========+======+
| name        | st\| *Require\|      |
|             | ri\| d*.      |      |
|             | ng | paramete\|      |
|             |    | r        |      |
|             |    | name     |      |
+-------------+----+----------+------+
| value       | st\| default  |      |
|             | ri\| value    |      |
|             | ng | for the  |      |
|             |    | paramete\|      |
|             |    | r        |      |
+-------------+----+----------+------+
| description | st\| paramete\|      |
|             | ri\| r        |      |
|             | ng | descript\|      |
|             |    | ion      |      |
+-------------+----+----------+------+
| type        | en\| *Require\|      |
|             | um | d*.      |      |
|             |    | data     |      |
|             |    | type of  |      |
|             |    | the      |      |
|             |    | paramete\|      |
|             |    | r,       |      |
|             |    | ‘string’ |      |
|             |    | ,        |      |
|             |    | ‘number’ |      |
|             |    | ,        |      |
|             |    | ‘boolean |      |
|             |    | ’,       |      |
|             |    | ‘datetim\|      |
|             |    | e’,      |      |
|             |    | ‘list’,  |      |
|             |    | or ‘map’ |      |
+-------------+----+----------+------+
| required    | bo\| is       | true |
|             | ol\| paramete\|      |
|             | ea\| r        |      |
|             | n  | required |      |
|             |    | or not?  |      |
+-------------+----+----------+------+
| constraints | ar\| The      |      |
|             | ra\| optional |      |
|             | y  | list of  |      |
|             |    | sequence\|      |
|             |    | d        |      |
|             |    | constrai\|      |
|             |    | nt       |      |
|             |    | clauses  |      |
|             |    | for the  |      |
|             |    | paramete\|      |
|             |    | r.       |      |
|             |    | See      |      |
|             |    | above    |      |
+-------------+----+----------+------+
| entry_schem\| st\| The      |      |
| a           | ri\| optional |      |
|             | ng | key that |      |
|             |    | is used  |      |
|             |    | to       |      |
|             |    | declare  |      |
|             |    | the name |      |
|             |    | of the   |      |
|             |    | Datatype |      |
|             |    | definiti\|      |
|             |    | on       |      |
|             |    | for      |      |
|             |    | certain  |      |
|             |    | types.   |      |
|             |    | entry_sc\|      |
|             |    | hema     |      |
|             |    | must be  |      |
|             |    | defined  |      |
|             |    | when the |      |
|             |    | type is  |      |
|             |    | either   |      |
|             |    | list or  |      |
|             |    | map. If  |      |
|             |    | the type |      |
|             |    | is list  |      |
|             |    | and the  |      |
|             |    | entry    |      |
|             |    | type is  |      |
|             |    | a simple |      |
|             |    | type     |      |
|             |    | (string, |      |
|             |    | number,  |      |
|             |    | bookean, |      |
|             |    | datetime |      |
|             |    | ),       |      |
|             |    | follow   |      |
|             |    | with an  |      |
|             |    | string   |      |
|             |    | to       |      |
|             |    | describe |      |
|             |    | the      |      |
|             |    | entry    |      |
+-------------+----+----------+------+
|             | If |          |      |
|             | th\|          |      |
|             | e  |          |      |
|             | ty\|          |      |
|             | pe |          |      |
|             | is |          |      |
|             | li\|          |      |
|             | st |          |      |
|             | an\|          |      |
|             | d  |          |      |
|             | th\|          |      |
|             | e  |          |      |
|             | en\|          |      |
|             | tr\|          |      |
|             | y  |          |      |
|             | ty\|          |      |
|             | pe |          |      |
|             | is |          |      |
|             | a  |          |      |
|             | ma\|          |      |
|             | p, |          |      |
|             | fo\|          |      |
|             | ll\|          |      |
|             | ow |          |      |
|             | wi\|          |      |
|             | th |          |      |
|             | an |          |      |
|             | ar\|          |      |
|             | ra\|          |      |
|             | y  |          |      |
|             | to |          |      |
|             | de\|          |      |
|             | sc\|          |      |
|             | ri\|          |      |
|             | be |          |      |
|             | th\|          |      |
|             | e  |          |      |
|             | ke\|          |      |
|             | ys |          |      |
|             | fo\|          |      |
|             | r  |          |      |
|             | th\|          |      |
|             | e  |          |      |
|             | en\|          |      |
|             | tr\|          |      |
|             | y  |          |      |
|             | ma\|          |      |
|             | p  |          |      |
+-------------+----+----------+------+
|             | If |          |      |
|             | th\|          |      |
|             | e  |          |      |
|             | ty\|          |      |
|             | pe |          |      |
|             | is |          |      |
|             | li\|          |      |
|             | st |          |      |
|             | an\|          |      |
|             | d  |          |      |
|             | th\|          |      |
|             | e  |          |      |
|             | en\|          |      |
|             | tr\|          |      |
|             | y  |          |      |
|             | ty\|          |      |
|             | pe |          |      |
|             | is |          |      |
|             | a  |          |      |
|             | li\|          |      |
|             | st |          |      |
|             | ,  |          |      |
|             | th\|          |      |
|             | at |          |      |
|             | is |          |      |
|             | no\|          |      |
|             | t  |          |      |
|             | cu\|          |      |
|             | rr\|          |      |
|             | en\|          |      |
|             | tl\|          |      |
|             | y  |          |      |
|             | su\|          |      |
|             | pp\|          |      |
|             | or\|          |      |
|             | te\|          |      |
|             | d \|          |      |
+-------------+----+----------+------+
|             | If |          |      |
|             | th\|          |      |
|             | e  |          |      |
|             | ty\|          |      |
|             | pe |          |      |
|             | is |          |      |
|             | ma\|          |      |
|             | p, |          |      |
|             | fo\|          |      |
|             | ll\|          |      |
|             | ow |          |      |
|             | wi\|          |      |
|             | th |          |      |
|             | an |          |      |
|             | ar\|          |      |
|             | ay |          |      |
|             | to |          |      |
|             | de\|          |      |
|             | sc\|          |      |
|             | ri\|          |      |
|             | be |          |      |
|             | th\|          |      |
|             | e  |          |      |
|             | ke\|          |      |
|             | ys |          |      |
|             | fo\|          |      |
|             | r  |          |      |
|             | th\|          |      |
|             | e  |          |      |
|             | ma\|          |      |
|             | p  |          |      |
+-------------+----+----------+------+

Generated Application Configuration
-----------------------------------

The Platform generates configuration for the component (based on the component spec) at deployment time. The generated application configuration will be made up of the Parameters, Streams, and Services sections, after any provisioning for streams and services. The component developer can see what this configuration will look like by reviewing the :any:`component dev command <dcae-cli-run-the-dev-command>`.


.. _artifacts:

Artifacts
---------

``artifacts`` contains a list of artifacts associated with this
component. For Docker, this is the full path (including the registry) to
the Docker image. For CDAP, this is the full path to the CDAP jar.

+---------------+------------+---------------------------------+
| Property Name | Type       | Description                     |
+===============+============+=================================+
| artifacts     | JSON array | Each entry is a artifact object |
+---------------+------------+---------------------------------+

``artifact`` Schema:

+---------------+--------+--------------------------------------------+
| Property Name | Type   | Description                                |
+===============+========+============================================+
| uri           | string | *Required*. Uri to the artifact, full path |
+---------------+--------+--------------------------------------------+
| type          | string | *Required*. ``docker image`` or ``jar``    |
+---------------+--------+--------------------------------------------+

.. _component_spec:

Working with Component Specs
============================
 
Components can be added to the onboarding catalog (which first validates the component spec) by using the :doc:`dcae_cli Tool <../dcae-cli/quickstart/>` 
Here you can also list the components, show the contents of a component, publish the component, validate the generated configuration for the component, deploy (run) and undeploy the component. For a list of these capabilities, see :any:`Component Commands <dcae_cli_component_commands>`

