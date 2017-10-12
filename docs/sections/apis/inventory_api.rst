DCAE Inventory API 2.1.0
========================

.. toctree::
    :maxdepth: 3


Description
~~~~~~~~~~~

DCAE Inventory is a web service that provides the following:

1. Real-time data on all DCAE services and their components
2. Comprehensive details on available DCAE service types




Contact Information
~~~~~~~~~~~~~~~~~~~



dcae@lists.openecomp.org






DEFAULT
~~~~~~~




GET ``/dcae-service-types``
---------------------------



Description
+++++++++++

.. raw:: html

    Get a list of `DCAEServiceType` objects.

Parameters
++++++++++

.. csv-table::
    :delim: |
    :header: "Name", "Located in", "Required", "Type", "Format", "Properties", "Description"
    :widths: 20, 15, 10, 10, 10, 20, 30

        typeName | query | No | string |  |  | Filter by service type name
        onlyLatest | query | No | boolean |  | {"default": true} | If set to true, query returns just the latest versions of DCAE service types. If set to false, then all versions are returned. Default is true
        onlyActive | query | No | boolean |  | {"default": true} | If set to true, query returns only *active* DCAE service types. If set to false, then all DCAE service types are returned. Default is true
        vnfType | query | No | string |  |  | Filter by associated vnf type. No wildcards, matches are explicit. This field is treated case insensitive.
        serviceId | query | No | string |  |  | Filter by assocaited service id. Instances with service id null or empty is always returned.
        serviceLocation | query | No | string |  |  | Filter by associated service location. Instances with service location null or empty is always returned.
        asdcServiceId | query | No | string |  |  | Filter by associated asdc design service id. Setting this to `NONE` will return instances that have asdc service id set to null
        asdcResourceId | query | No | string |  |  | Filter by associated asdc design resource id. Setting this to `NONE` will return instances that have asdc resource id set to null
        offset | query | No | integer | int32 |  | Query resultset offset used for pagination (zero-based)


Request
+++++++


Responses
+++++++++

**200**
^^^^^^^

List of `DCAEServiceType` objects


Type: :ref:`InlineResponse200 <d_b1ccd4187d31690b8e704c0aa01b2c59>`

**Example:**

.. code-block:: javascript

    {
        "items": [
            {
                "asdcResourceId": "somestring", 
                "asdcServiceId": "somestring", 
                "asdcServiceURL": "somestring", 
                "blueprintTemplate": "somestring", 
                "created": "2015-01-01T15:00:00.000Z", 
                "deactivated": "2015-01-01T15:00:00.000Z", 
                "owner": "somestring", 
                "selfLink": {
                    "params": {}, 
                    "rel": "somestring", 
                    "rels": [
                        "somestring", 
                        "somestring"
                    ], 
                    "title": "somestring", 
                    "type": "somestring", 
                    "uri": "somestring", 
                    "uriBuilder": {}
                }, 
                "serviceIds": [
                    "somestring", 
                    "somestring"
                ], 
                "serviceLocations": [
                    "somestring", 
                    "somestring"
                ], 
                "typeId": "somestring", 
                "typeName": "somestring", 
                "typeVersion": 1, 
                "vnfTypes": [
                    "somestring", 
                    "somestring"
                ]
            }, 
            {
                "asdcResourceId": "somestring", 
                "asdcServiceId": "somestring", 
                "asdcServiceURL": "somestring", 
                "blueprintTemplate": "somestring", 
                "created": "2015-01-01T15:00:00.000Z", 
                "deactivated": "2015-01-01T15:00:00.000Z", 
                "owner": "somestring", 
                "selfLink": {
                    "params": {}, 
                    "rel": "somestring", 
                    "rels": [
                        "somestring", 
                        "somestring"
                    ], 
                    "title": "somestring", 
                    "type": "somestring", 
                    "uri": "somestring", 
                    "uriBuilder": {}
                }, 
                "serviceIds": [
                    "somestring", 
                    "somestring"
                ], 
                "serviceLocations": [
                    "somestring", 
                    "somestring"
                ], 
                "typeId": "somestring", 
                "typeName": "somestring", 
                "typeVersion": 1, 
                "vnfTypes": [
                    "somestring", 
                    "somestring"
                ]
            }
        ], 
        "links": {
            "nextLink": {
                "params": {}, 
                "rel": "somestring", 
                "rels": [
                    "somestring", 
                    "somestring"
                ], 
                "title": "somestring", 
                "type": "somestring", 
                "uri": "somestring", 
                "uriBuilder": {}
            }, 
            "previousLink": {
                "params": {}, 
                "rel": "somestring", 
                "rels": [
                    "somestring", 
                    "somestring"
                ], 
                "title": "somestring", 
                "type": "somestring", 
                "uri": "somestring", 
                "uriBuilder": {}
            }
        }, 
        "totalCount": 1
    }





DELETE ``/dcae-service-types/{typeId}``
---------------------------------------



Description
+++++++++++

.. raw:: html

    Deactivates existing `DCAEServiceType` instances

Parameters
++++++++++

.. csv-table::
    :delim: |
    :header: "Name", "Located in", "Required", "Type", "Format", "Properties", "Description"
    :widths: 20, 15, 10, 10, 10, 20, 30

        typeId | path | Yes | string |  |  | 


Request
+++++++


Responses
+++++++++

**200**
^^^^^^^

`DCAEServiceType` has been deactivated


Type: :ref:`ApiResponseMessage <d_8a94f348f7df00259702f8d9b7d2ea84>`

**Example:**

.. code-block:: javascript

    {
        "code": 1, 
        "message": "somestring", 
        "type": "somestring"
    }

**404**
^^^^^^^

`DCAEServiceType` not found


Type: :ref:`ApiResponseMessage <d_8a94f348f7df00259702f8d9b7d2ea84>`

**Example:**

.. code-block:: javascript

    {
        "code": 1, 
        "message": "somestring", 
        "type": "somestring"
    }

**410**
^^^^^^^

`DCAEServiceType` already gone


Type: :ref:`ApiResponseMessage <d_8a94f348f7df00259702f8d9b7d2ea84>`

**Example:**

.. code-block:: javascript

    {
        "code": 1, 
        "message": "somestring", 
        "type": "somestring"
    }





GET ``/dcae-service-types/{typeId}``
------------------------------------



Description
+++++++++++

.. raw:: html

    Get a `DCAEServiceType` object.

Parameters
++++++++++

.. csv-table::
    :delim: |
    :header: "Name", "Located in", "Required", "Type", "Format", "Properties", "Description"
    :widths: 20, 15, 10, 10, 10, 20, 30

        typeId | path | Yes | string |  |  | 


Request
+++++++


Responses
+++++++++

**200**
^^^^^^^

Single `DCAEServiceType` object


Type: :ref:`DCAEServiceType <d_b0cb5f12dbde8c0c42487c089983687e>`

**Example:**

.. code-block:: javascript

    {
        "asdcResourceId": "somestring", 
        "asdcServiceId": "somestring", 
        "asdcServiceURL": "somestring", 
        "blueprintTemplate": "somestring", 
        "created": "2015-01-01T15:00:00.000Z", 
        "deactivated": "2015-01-01T15:00:00.000Z", 
        "owner": "somestring", 
        "selfLink": {
            "params": {}, 
            "rel": "somestring", 
            "rels": [
                "somestring", 
                "somestring"
            ], 
            "title": "somestring", 
            "type": "somestring", 
            "uri": "somestring", 
            "uriBuilder": {}
        }, 
        "serviceIds": [
            "somestring", 
            "somestring"
        ], 
        "serviceLocations": [
            "somestring", 
            "somestring"
        ], 
        "typeId": "somestring", 
        "typeName": "somestring", 
        "typeVersion": 1, 
        "vnfTypes": [
            "somestring", 
            "somestring"
        ]
    }

**404**
^^^^^^^

Resource not found


Type: :ref:`DCAEServiceType <d_b0cb5f12dbde8c0c42487c089983687e>`

**Example:**

.. code-block:: javascript

    {
        "asdcResourceId": "somestring", 
        "asdcServiceId": "somestring", 
        "asdcServiceURL": "somestring", 
        "blueprintTemplate": "somestring", 
        "created": "2015-01-01T15:00:00.000Z", 
        "deactivated": "2015-01-01T15:00:00.000Z", 
        "owner": "somestring", 
        "selfLink": {
            "params": {}, 
            "rel": "somestring", 
            "rels": [
                "somestring", 
                "somestring"
            ], 
            "title": "somestring", 
            "type": "somestring", 
            "uri": "somestring", 
            "uriBuilder": {}
        }, 
        "serviceIds": [
            "somestring", 
            "somestring"
        ], 
        "serviceLocations": [
            "somestring", 
            "somestring"
        ], 
        "typeId": "somestring", 
        "typeName": "somestring", 
        "typeVersion": 1, 
        "vnfTypes": [
            "somestring", 
            "somestring"
        ]
    }





POST ``/dcae-service-types``
----------------------------



Description
+++++++++++

.. raw:: html

    Inserts a new `DCAEServiceType` or updates an existing instance. Updates are only allowed iff there are no running DCAE services of the requested type,


Request
+++++++



.. _d_57dc24aa38507ded2f27eec90206336e:

Body
^^^^

.. csv-table::
    :delim: |
    :header: "Name", "Required", "Type", "Format", "Properties", "Description"
    :widths: 20, 10, 15, 15, 30, 25

        asdcResourceId | No | string |  |  | Id of vf/vnf instance this DCAE service type is associated with. Value source is from ASDC's notification event's field `resourceInvariantUUID`.
        asdcServiceId | No | string |  |  | Id of service this DCAE service type is associated with. Value source is from ASDC's notification event's field `serviceInvariantUUID`.
        asdcServiceURL | No | string |  |  | URL to the ASDC service model
        blueprintTemplate | Yes | string |  |  | String representation of a Cloudify blueprint with unbound variables
        owner | Yes | string |  |  | 
        serviceIds | No | array of string |  |  | List of service ids that are used to associate with DCAE service type. DCAE service types with this propery as null or empty means them apply for every service id.
        serviceLocations | No | array of string |  |  | List of service locations that are used to associate with DCAE service type. DCAE service types with this propery as null or empty means them apply for every service location.
        typeName | Yes | string |  |  | Descriptive name for this DCAE service type
        typeVersion | Yes | integer | int32 |  | Version number for this DCAE service type
        vnfTypes | No | array of string |  |  | 

.. code-block:: javascript

    {
        "asdcResourceId": "somestring", 
        "asdcServiceId": "somestring", 
        "asdcServiceURL": "somestring", 
        "blueprintTemplate": "somestring", 
        "owner": "somestring", 
        "serviceIds": [
            "somestring", 
            "somestring"
        ], 
        "serviceLocations": [
            "somestring", 
            "somestring"
        ], 
        "typeName": "somestring", 
        "typeVersion": 1, 
        "vnfTypes": [
            "somestring", 
            "somestring"
        ]
    }

Responses
+++++++++

**200**
^^^^^^^

Single `DCAEServiceType` object.


Type: :ref:`DCAEServiceType <d_b0cb5f12dbde8c0c42487c089983687e>`

**Example:**

.. code-block:: javascript

    {
        "asdcResourceId": "somestring", 
        "asdcServiceId": "somestring", 
        "asdcServiceURL": "somestring", 
        "blueprintTemplate": "somestring", 
        "created": "2015-01-01T15:00:00.000Z", 
        "deactivated": "2015-01-01T15:00:00.000Z", 
        "owner": "somestring", 
        "selfLink": {
            "params": {}, 
            "rel": "somestring", 
            "rels": [
                "somestring", 
                "somestring"
            ], 
            "title": "somestring", 
            "type": "somestring", 
            "uri": "somestring", 
            "uriBuilder": {}
        }, 
        "serviceIds": [
            "somestring", 
            "somestring"
        ], 
        "serviceLocations": [
            "somestring", 
            "somestring"
        ], 
        "typeId": "somestring", 
        "typeName": "somestring", 
        "typeVersion": 1, 
        "vnfTypes": [
            "somestring", 
            "somestring"
        ]
    }

**400**
^^^^^^^

Bad request provided.


Type: :ref:`ApiResponseMessage <d_8a94f348f7df00259702f8d9b7d2ea84>`

**Example:**

.. code-block:: javascript

    {
        "code": 1, 
        "message": "somestring", 
        "type": "somestring"
    }

**409**
^^^^^^^

Failed to update because there are still DCAE services of the requested type running.


Type: :ref:`ApiResponseMessage <d_8a94f348f7df00259702f8d9b7d2ea84>`

**Example:**

.. code-block:: javascript

    {
        "code": 1, 
        "message": "somestring", 
        "type": "somestring"
    }





GET ``/dcae-services``
----------------------



Description
+++++++++++

.. raw:: html

    Get a list of `DCAEService` objects.

Parameters
++++++++++

.. csv-table::
    :delim: |
    :header: "Name", "Located in", "Required", "Type", "Format", "Properties", "Description"
    :widths: 20, 15, 10, 10, 10, 20, 30

        typeId | query | No | string |  |  | DCAE service type name
        vnfId | query | No | string |  |  | 
        vnfType | query | No | string |  |  | Filter by associated vnf type. This field is treated case insensitive.
        vnfLocation | query | No | string |  |  | 
        componentType | query | No | string |  |  | Use to filter by a specific DCAE service component type
        shareable | query | No | boolean |  |  | Use to filter by DCAE services that have shareable components or not
        created | query | No | string |  |  | Use to filter by created time
        offset | query | No | integer | int32 |  | Query resultset offset used for pagination (zero-based)


Request
+++++++


Responses
+++++++++

**200**
^^^^^^^

List of `DCAEService` objects


Type: :ref:`InlineResponse2001 <d_31bb361a8900a0bed20df49b94f1e33b>`

**Example:**

.. code-block:: javascript

    {
        "items": [
            {
                "components": [
                    {
                        "componentId": "somestring", 
                        "componentLink": {
                            "params": {}, 
                            "rel": "somestring", 
                            "rels": [
                                "somestring", 
                                "somestring"
                            ], 
                            "title": "somestring", 
                            "type": "somestring", 
                            "uri": "somestring", 
                            "uriBuilder": {}
                        }, 
                        "componentSource": "DCAEController", 
                        "componentType": "somestring", 
                        "created": "2015-01-01T15:00:00.000Z", 
                        "location": "somestring", 
                        "modified": "2015-01-01T15:00:00.000Z", 
                        "shareable": 1, 
                        "status": "somestring"
                    }, 
                    {
                        "componentId": "somestring", 
                        "componentLink": {
                            "params": {}, 
                            "rel": "somestring", 
                            "rels": [
                                "somestring", 
                                "somestring"
                            ], 
                            "title": "somestring", 
                            "type": "somestring", 
                            "uri": "somestring", 
                            "uriBuilder": {}
                        }, 
                        "componentSource": "DCAEController", 
                        "componentType": "somestring", 
                        "created": "2015-01-01T15:00:00.000Z", 
                        "location": "somestring", 
                        "modified": "2015-01-01T15:00:00.000Z", 
                        "shareable": 1, 
                        "status": "somestring"
                    }
                ], 
                "created": "2015-01-01T15:00:00.000Z", 
                "deploymentRef": "somestring", 
                "modified": "2015-01-01T15:00:00.000Z", 
                "selfLink": {
                    "params": {}, 
                    "rel": "somestring", 
                    "rels": [
                        "somestring", 
                        "somestring"
                    ], 
                    "title": "somestring", 
                    "type": "somestring", 
                    "uri": "somestring", 
                    "uriBuilder": {}
                }, 
                "serviceId": "somestring", 
                "typeLink": {
                    "params": {}, 
                    "rel": "somestring", 
                    "rels": [
                        "somestring", 
                        "somestring"
                    ], 
                    "title": "somestring", 
                    "type": "somestring", 
                    "uri": "somestring", 
                    "uriBuilder": {}
                }, 
                "vnfId": "somestring", 
                "vnfLink": {
                    "params": {}, 
                    "rel": "somestring", 
                    "rels": [
                        "somestring", 
                        "somestring"
                    ], 
                    "title": "somestring", 
                    "type": "somestring", 
                    "uri": "somestring", 
                    "uriBuilder": {}
                }, 
                "vnfLocation": "somestring", 
                "vnfType": "somestring"
            }, 
            {
                "components": [
                    {
                        "componentId": "somestring", 
                        "componentLink": {
                            "params": {}, 
                            "rel": "somestring", 
                            "rels": [
                                "somestring", 
                                "somestring"
                            ], 
                            "title": "somestring", 
                            "type": "somestring", 
                            "uri": "somestring", 
                            "uriBuilder": {}
                        }, 
                        "componentSource": "DCAEController", 
                        "componentType": "somestring", 
                        "created": "2015-01-01T15:00:00.000Z", 
                        "location": "somestring", 
                        "modified": "2015-01-01T15:00:00.000Z", 
                        "shareable": 1, 
                        "status": "somestring"
                    }, 
                    {
                        "componentId": "somestring", 
                        "componentLink": {
                            "params": {}, 
                            "rel": "somestring", 
                            "rels": [
                                "somestring", 
                                "somestring"
                            ], 
                            "title": "somestring", 
                            "type": "somestring", 
                            "uri": "somestring", 
                            "uriBuilder": {}
                        }, 
                        "componentSource": "DCAEController", 
                        "componentType": "somestring", 
                        "created": "2015-01-01T15:00:00.000Z", 
                        "location": "somestring", 
                        "modified": "2015-01-01T15:00:00.000Z", 
                        "shareable": 1, 
                        "status": "somestring"
                    }
                ], 
                "created": "2015-01-01T15:00:00.000Z", 
                "deploymentRef": "somestring", 
                "modified": "2015-01-01T15:00:00.000Z", 
                "selfLink": {
                    "params": {}, 
                    "rel": "somestring", 
                    "rels": [
                        "somestring", 
                        "somestring"
                    ], 
                    "title": "somestring", 
                    "type": "somestring", 
                    "uri": "somestring", 
                    "uriBuilder": {}
                }, 
                "serviceId": "somestring", 
                "typeLink": {
                    "params": {}, 
                    "rel": "somestring", 
                    "rels": [
                        "somestring", 
                        "somestring"
                    ], 
                    "title": "somestring", 
                    "type": "somestring", 
                    "uri": "somestring", 
                    "uriBuilder": {}
                }, 
                "vnfId": "somestring", 
                "vnfLink": {
                    "params": {}, 
                    "rel": "somestring", 
                    "rels": [
                        "somestring", 
                        "somestring"
                    ], 
                    "title": "somestring", 
                    "type": "somestring", 
                    "uri": "somestring", 
                    "uriBuilder": {}
                }, 
                "vnfLocation": "somestring", 
                "vnfType": "somestring"
            }
        ], 
        "links": {
            "nextLink": {
                "params": {}, 
                "rel": "somestring", 
                "rels": [
                    "somestring", 
                    "somestring"
                ], 
                "title": "somestring", 
                "type": "somestring", 
                "uri": "somestring", 
                "uriBuilder": {}
            }, 
            "previousLink": {
                "params": {}, 
                "rel": "somestring", 
                "rels": [
                    "somestring", 
                    "somestring"
                ], 
                "title": "somestring", 
                "type": "somestring", 
                "uri": "somestring", 
                "uriBuilder": {}
            }
        }, 
        "totalCount": 1
    }

**502**
^^^^^^^

Bad response from DCAE controller


Type: :ref:`ApiResponseMessage <d_8a94f348f7df00259702f8d9b7d2ea84>`

**Example:**

.. code-block:: javascript

    {
        "code": 1, 
        "message": "somestring", 
        "type": "somestring"
    }

**504**
^^^^^^^

Failed to connect with DCAE controller


Type: :ref:`ApiResponseMessage <d_8a94f348f7df00259702f8d9b7d2ea84>`

**Example:**

.. code-block:: javascript

    {
        "code": 1, 
        "message": "somestring", 
        "type": "somestring"
    }





GET ``/dcae-services-groupby/{propertyName}``
---------------------------------------------



Description
+++++++++++

.. raw:: html

    Get a list of unique values for the given `propertyName`

Parameters
++++++++++

.. csv-table::
    :delim: |
    :header: "Name", "Located in", "Required", "Type", "Format", "Properties", "Description"
    :widths: 20, 15, 10, 10, 10, 20, 30

        propertyName | path | Yes | string |  |  | Property to find unique values. Restricted to `type`, `vnfType`, `vnfLocation`


Request
+++++++


Responses
+++++++++

**200**
^^^^^^^

List of unique property values


Type: :ref:`DCAEServiceGroupByResults <d_a6dc4f986873bc126fc916189ffa5e91>`

**Example:**

.. code-block:: javascript

    {
        "propertyName": "somestring", 
        "propertyValues": [
            {
                "count": 1, 
                "dcaeServiceQueryLink": {
                    "params": {}, 
                    "rel": "somestring", 
                    "rels": [
                        "somestring", 
                        "somestring"
                    ], 
                    "title": "somestring", 
                    "type": "somestring", 
                    "uri": "somestring", 
                    "uriBuilder": {}
                }, 
                "propertyValue": "somestring"
            }, 
            {
                "count": 1, 
                "dcaeServiceQueryLink": {
                    "params": {}, 
                    "rel": "somestring", 
                    "rels": [
                        "somestring", 
                        "somestring"
                    ], 
                    "title": "somestring", 
                    "type": "somestring", 
                    "uri": "somestring", 
                    "uriBuilder": {}
                }, 
                "propertyValue": "somestring"
            }
        ]
    }





DELETE ``/dcae-services/{serviceId}``
-------------------------------------



Description
+++++++++++

.. raw:: html

    Remove an existing `DCAEService` object.

Parameters
++++++++++

.. csv-table::
    :delim: |
    :header: "Name", "Located in", "Required", "Type", "Format", "Properties", "Description"
    :widths: 20, 15, 10, 10, 10, 20, 30

        serviceId | path | Yes | string |  |  | 


Request
+++++++


Responses
+++++++++

**200**
^^^^^^^

DCAE service has been removed


**404**
^^^^^^^

Unknown DCAE service


Type: :ref:`ApiResponseMessage <d_8a94f348f7df00259702f8d9b7d2ea84>`

**Example:**

.. code-block:: javascript

    {
        "code": 1, 
        "message": "somestring", 
        "type": "somestring"
    }





GET ``/dcae-services/{serviceId}``
----------------------------------



Description
+++++++++++

.. raw:: html

    Get a `DCAEService` object.

Parameters
++++++++++

.. csv-table::
    :delim: |
    :header: "Name", "Located in", "Required", "Type", "Format", "Properties", "Description"
    :widths: 20, 15, 10, 10, 10, 20, 30

        serviceId | path | Yes | string |  |  | 


Request
+++++++


Responses
+++++++++

**200**
^^^^^^^

Single `DCAEService` object


Type: :ref:`DCAEService <d_ae85cd292c2b4046e1ea1bbb02c7ea63>`

**Example:**

.. code-block:: javascript

    {
        "components": [
            {
                "componentId": "somestring", 
                "componentLink": {
                    "params": {}, 
                    "rel": "somestring", 
                    "rels": [
                        "somestring", 
                        "somestring"
                    ], 
                    "title": "somestring", 
                    "type": "somestring", 
                    "uri": "somestring", 
                    "uriBuilder": {}
                }, 
                "componentSource": "DCAEController", 
                "componentType": "somestring", 
                "created": "2015-01-01T15:00:00.000Z", 
                "location": "somestring", 
                "modified": "2015-01-01T15:00:00.000Z", 
                "shareable": 1, 
                "status": "somestring"
            }, 
            {
                "componentId": "somestring", 
                "componentLink": {
                    "params": {}, 
                    "rel": "somestring", 
                    "rels": [
                        "somestring", 
                        "somestring"
                    ], 
                    "title": "somestring", 
                    "type": "somestring", 
                    "uri": "somestring", 
                    "uriBuilder": {}
                }, 
                "componentSource": "DCAEController", 
                "componentType": "somestring", 
                "created": "2015-01-01T15:00:00.000Z", 
                "location": "somestring", 
                "modified": "2015-01-01T15:00:00.000Z", 
                "shareable": 1, 
                "status": "somestring"
            }
        ], 
        "created": "2015-01-01T15:00:00.000Z", 
        "deploymentRef": "somestring", 
        "modified": "2015-01-01T15:00:00.000Z", 
        "selfLink": {
            "params": {}, 
            "rel": "somestring", 
            "rels": [
                "somestring", 
                "somestring"
            ], 
            "title": "somestring", 
            "type": "somestring", 
            "uri": "somestring", 
            "uriBuilder": {}
        }, 
        "serviceId": "somestring", 
        "typeLink": {
            "params": {}, 
            "rel": "somestring", 
            "rels": [
                "somestring", 
                "somestring"
            ], 
            "title": "somestring", 
            "type": "somestring", 
            "uri": "somestring", 
            "uriBuilder": {}
        }, 
        "vnfId": "somestring", 
        "vnfLink": {
            "params": {}, 
            "rel": "somestring", 
            "rels": [
                "somestring", 
                "somestring"
            ], 
            "title": "somestring", 
            "type": "somestring", 
            "uri": "somestring", 
            "uriBuilder": {}
        }, 
        "vnfLocation": "somestring", 
        "vnfType": "somestring"
    }

**404**
^^^^^^^

DCAE service not found


Type: :ref:`ApiResponseMessage <d_8a94f348f7df00259702f8d9b7d2ea84>`

**Example:**

.. code-block:: javascript

    {
        "code": 1, 
        "message": "somestring", 
        "type": "somestring"
    }

**502**
^^^^^^^

Bad response from DCAE controller


Type: :ref:`ApiResponseMessage <d_8a94f348f7df00259702f8d9b7d2ea84>`

**Example:**

.. code-block:: javascript

    {
        "code": 1, 
        "message": "somestring", 
        "type": "somestring"
    }

**504**
^^^^^^^

Failed to connect with DCAE controller


Type: :ref:`ApiResponseMessage <d_8a94f348f7df00259702f8d9b7d2ea84>`

**Example:**

.. code-block:: javascript

    {
        "code": 1, 
        "message": "somestring", 
        "type": "somestring"
    }





PUT ``/dcae-services/{serviceId}``
----------------------------------



Description
+++++++++++

.. raw:: html

    Put a new or update an existing `DCAEService` object.

Parameters
++++++++++

.. csv-table::
    :delim: |
    :header: "Name", "Located in", "Required", "Type", "Format", "Properties", "Description"
    :widths: 20, 15, 10, 10, 10, 20, 30

        serviceId | path | Yes | string |  |  | 


Request
+++++++



.. _d_81c18e0dd7a3af8fb1ba658e72907e7b:

Body
^^^^

.. csv-table::
    :delim: |
    :header: "Name", "Required", "Type", "Format", "Properties", "Description"
    :widths: 20, 10, 15, 15, 30, 25

        components | Yes | array of :ref:`DCAEServiceComponentRequest <d_55af22c43245c290d643f75be1f4f254>` |  |  | List of DCAE service components that this service is composed of
        deploymentRef | No | string |  |  | Reference to a Cloudify deployment
        typeId | Yes | string |  |  | Id of the associated DCAE service type
        vnfId | Yes | string |  |  | Id of the associated VNF that this service is monitoring
        vnfLocation | Yes | string |  |  | Location identifier of the associated VNF that this service is monitoring
        vnfType | Yes | string |  |  | The type of the associated VNF that this service is monitoring

.. code-block:: javascript

    {
        "components": [
            {
                "componentId": "somestring", 
                "componentSource": "DCAEController", 
                "componentType": "somestring", 
                "shareable": 1
            }, 
            {
                "componentId": "somestring", 
                "componentSource": "DCAEController", 
                "componentType": "somestring", 
                "shareable": 1
            }
        ], 
        "deploymentRef": "somestring", 
        "typeId": "somestring", 
        "vnfId": "somestring", 
        "vnfLocation": "somestring", 
        "vnfType": "somestring"
    }

Responses
+++++++++

**200**
^^^^^^^

Single `DCAEService` object


Type: :ref:`DCAEService <d_ae85cd292c2b4046e1ea1bbb02c7ea63>`

**Example:**

.. code-block:: javascript

    {
        "components": [
            {
                "componentId": "somestring", 
                "componentLink": {
                    "params": {}, 
                    "rel": "somestring", 
                    "rels": [
                        "somestring", 
                        "somestring"
                    ], 
                    "title": "somestring", 
                    "type": "somestring", 
                    "uri": "somestring", 
                    "uriBuilder": {}
                }, 
                "componentSource": "DCAEController", 
                "componentType": "somestring", 
                "created": "2015-01-01T15:00:00.000Z", 
                "location": "somestring", 
                "modified": "2015-01-01T15:00:00.000Z", 
                "shareable": 1, 
                "status": "somestring"
            }, 
            {
                "componentId": "somestring", 
                "componentLink": {
                    "params": {}, 
                    "rel": "somestring", 
                    "rels": [
                        "somestring", 
                        "somestring"
                    ], 
                    "title": "somestring", 
                    "type": "somestring", 
                    "uri": "somestring", 
                    "uriBuilder": {}
                }, 
                "componentSource": "DCAEController", 
                "componentType": "somestring", 
                "created": "2015-01-01T15:00:00.000Z", 
                "location": "somestring", 
                "modified": "2015-01-01T15:00:00.000Z", 
                "shareable": 1, 
                "status": "somestring"
            }
        ], 
        "created": "2015-01-01T15:00:00.000Z", 
        "deploymentRef": "somestring", 
        "modified": "2015-01-01T15:00:00.000Z", 
        "selfLink": {
            "params": {}, 
            "rel": "somestring", 
            "rels": [
                "somestring", 
                "somestring"
            ], 
            "title": "somestring", 
            "type": "somestring", 
            "uri": "somestring", 
            "uriBuilder": {}
        }, 
        "serviceId": "somestring", 
        "typeLink": {
            "params": {}, 
            "rel": "somestring", 
            "rels": [
                "somestring", 
                "somestring"
            ], 
            "title": "somestring", 
            "type": "somestring", 
            "uri": "somestring", 
            "uriBuilder": {}
        }, 
        "vnfId": "somestring", 
        "vnfLink": {
            "params": {}, 
            "rel": "somestring", 
            "rels": [
                "somestring", 
                "somestring"
            ], 
            "title": "somestring", 
            "type": "somestring", 
            "uri": "somestring", 
            "uriBuilder": {}
        }, 
        "vnfLocation": "somestring", 
        "vnfType": "somestring"
    }

**422**
^^^^^^^

Bad request provided


Type: :ref:`ApiResponseMessage <d_8a94f348f7df00259702f8d9b7d2ea84>`

**Example:**

.. code-block:: javascript

    {
        "code": 1, 
        "message": "somestring", 
        "type": "somestring"
    }



  
Data Structures
~~~~~~~~~~~~~~~

.. _d_8a94f348f7df00259702f8d9b7d2ea84:

ApiResponseMessage Model Structure
----------------------------------

.. csv-table::
    :delim: |
    :header: "Name", "Required", "Type", "Format", "Properties", "Description"
    :widths: 20, 10, 15, 15, 30, 25

        code | No | integer | int32 |  | 
        message | No | string |  |  | 
        type | No | string |  |  | 

.. _d_ae85cd292c2b4046e1ea1bbb02c7ea63:

DCAEService Model Structure
---------------------------

.. csv-table::
    :delim: |
    :header: "Name", "Required", "Type", "Format", "Properties", "Description"
    :widths: 20, 10, 15, 15, 30, 25

        components | No | array of :ref:`DCAEServiceComponent <d_51674dafcc623be79f21ecea545c345d>` |  |  | 
        created | No | string | date-time |  | 
        deploymentRef | No | string |  |  | Reference to a Cloudify deployment
        modified | No | string | date-time |  | 
        selfLink | No | :ref:`Link <d_add3c3fd2e145f9e5a78be6e7b208ebb>` |  |  | Link.title is serviceId
        serviceId | No | string |  |  | 
        typeLink | No | :ref:`Link <d_add3c3fd2e145f9e5a78be6e7b208ebb>` |  |  | Link.title is typeId
        vnfId | No | string |  |  | 
        vnfLink | No | :ref:`Link <d_add3c3fd2e145f9e5a78be6e7b208ebb>` |  |  | Link.title is vnfId
        vnfLocation | No | string |  |  | Location information of the associated VNF
        vnfType | No | string |  |  | 

.. _d_51674dafcc623be79f21ecea545c345d:

DCAEServiceComponent Model Structure
------------------------------------

.. csv-table::
    :delim: |
    :header: "Name", "Required", "Type", "Format", "Properties", "Description"
    :widths: 20, 10, 15, 15, 30, 25

        componentId | Yes | string |  |  | The id format is unique to the source
        componentLink | Yes | :ref:`Link <d_add3c3fd2e145f9e5a78be6e7b208ebb>` |  |  | Link to the underlying resource of this component
        componentSource | Yes | string |  | {'enum': ['DCAEController', 'DMaaPController']} | Specifies the name of the underying source service that is responsible for this components
        componentType | Yes | string |  |  | 
        created | Yes | string | date-time |  | 
        location | No | string |  |  | Location information of the component
        modified | Yes | string | date-time |  | 
        shareable | Yes | integer | int32 |  | Used to determine if this component can be shared amongst different DCAE services
        status | No | string |  |  | 

.. _d_55af22c43245c290d643f75be1f4f254:

DCAEServiceComponentRequest Model Structure
-------------------------------------------

.. csv-table::
    :delim: |
    :header: "Name", "Required", "Type", "Format", "Properties", "Description"
    :widths: 20, 10, 15, 15, 30, 25

        componentId | Yes | string |  |  | The id format is unique to the source
        componentSource | Yes | string |  | {'enum': ['DCAEController', 'DMaaPController']} | Specifies the name of the underying source service that is responsible for this components
        componentType | Yes | string |  |  | 
        shareable | Yes | integer | int32 |  | Used to determine if this component can be shared amongst different DCAE services

.. _d_a6dc4f986873bc126fc916189ffa5e91:

DCAEServiceGroupByResults Model Structure
-----------------------------------------

.. csv-table::
    :delim: |
    :header: "Name", "Required", "Type", "Format", "Properties", "Description"
    :widths: 20, 10, 15, 15, 30, 25

        propertyName | No | string |  |  | Property name of DCAE service that the group by operation was performed on
        propertyValues | No | array of :ref:`DCAEServiceGroupByResultsPropertyValues <d_0119caa52e274e5e2311b367df38d686>` |  |  | 

.. _d_0119caa52e274e5e2311b367df38d686:

DCAEServiceGroupByResultsPropertyValues Model Structure
-------------------------------------------------------

.. csv-table::
    :delim: |
    :header: "Name", "Required", "Type", "Format", "Properties", "Description"
    :widths: 20, 10, 15, 15, 30, 25

        count | No | integer | int32 |  | 
        dcaeServiceQueryLink | No | :ref:`Link <d_add3c3fd2e145f9e5a78be6e7b208ebb>` |  |  | Link.title is the DCAE service property value. Following this link will provide a list of DCAE services that all have this property value.
        propertyValue | No | string |  |  | 

.. _d_81c18e0dd7a3af8fb1ba658e72907e7b:

DCAEServiceRequest Model Structure
----------------------------------

.. csv-table::
    :delim: |
    :header: "Name", "Required", "Type", "Format", "Properties", "Description"
    :widths: 20, 10, 15, 15, 30, 25

        components | Yes | array of :ref:`DCAEServiceComponentRequest <d_55af22c43245c290d643f75be1f4f254>` |  |  | List of DCAE service components that this service is composed of
        deploymentRef | No | string |  |  | Reference to a Cloudify deployment
        typeId | Yes | string |  |  | Id of the associated DCAE service type
        vnfId | Yes | string |  |  | Id of the associated VNF that this service is monitoring
        vnfLocation | Yes | string |  |  | Location identifier of the associated VNF that this service is monitoring
        vnfType | Yes | string |  |  | The type of the associated VNF that this service is monitoring

.. _d_b0cb5f12dbde8c0c42487c089983687e:

DCAEServiceType Model Structure
-------------------------------

.. csv-table::
    :delim: |
    :header: "Name", "Required", "Type", "Format", "Properties", "Description"
    :widths: 20, 10, 15, 15, 30, 25

        asdcResourceId | No | string |  |  | Id of vf/vnf instance this DCAE service type is associated with. Value source is from ASDC's notification event's field `resourceInvariantUUID`.
        asdcServiceId | No | string |  |  | Id of service this DCAE service type is associated with. Value source is from ASDC's notification event's field `serviceInvariantUUID`.
        asdcServiceURL | No | string |  |  | URL to the ASDC service model
        blueprintTemplate | Yes | string |  |  | String representation of a Cloudify blueprint with unbound variables
        created | Yes | string | date-time |  | Created timestamp for this DCAE service type in epoch time
        deactivated | No | string | date-time |  | Deactivated timestamp for this DCAE service type in epoch time
        owner | Yes | string |  |  | 
        selfLink | Yes | :ref:`Link <d_add3c3fd2e145f9e5a78be6e7b208ebb>` |  |  | Link to self where the Link.title is typeName
        serviceIds | No | array of string |  |  | List of service ids that are used to associate with DCAE service type. DCAE service types with this propery as null or empty means them apply for every service id.
        serviceLocations | No | array of string |  |  | List of service locations that are used to associate with DCAE service type. DCAE service types with this propery as null or empty means them apply for every service location.
        typeId | Yes | string |  |  | Unique identifier for this DCAE service type
        typeName | Yes | string |  |  | Descriptive name for this DCAE service type
        typeVersion | Yes | integer | int32 |  | Version number for this DCAE service type
        vnfTypes | No | array of string |  |  | 

.. _d_57dc24aa38507ded2f27eec90206336e:

DCAEServiceTypeRequest Model Structure
--------------------------------------

.. csv-table::
    :delim: |
    :header: "Name", "Required", "Type", "Format", "Properties", "Description"
    :widths: 20, 10, 15, 15, 30, 25

        asdcResourceId | No | string |  |  | Id of vf/vnf instance this DCAE service type is associated with. Value source is from ASDC's notification event's field `resourceInvariantUUID`.
        asdcServiceId | No | string |  |  | Id of service this DCAE service type is associated with. Value source is from ASDC's notification event's field `serviceInvariantUUID`.
        asdcServiceURL | No | string |  |  | URL to the ASDC service model
        blueprintTemplate | Yes | string |  |  | String representation of a Cloudify blueprint with unbound variables
        owner | Yes | string |  |  | 
        serviceIds | No | array of string |  |  | List of service ids that are used to associate with DCAE service type. DCAE service types with this propery as null or empty means them apply for every service id.
        serviceLocations | No | array of string |  |  | List of service locations that are used to associate with DCAE service type. DCAE service types with this propery as null or empty means them apply for every service location.
        typeName | Yes | string |  |  | Descriptive name for this DCAE service type
        typeVersion | Yes | integer | int32 |  | Version number for this DCAE service type
        vnfTypes | No | array of string |  |  | 

.. _d_b1ccd4187d31690b8e704c0aa01b2c59:

InlineResponse200 Model Structure
---------------------------------

.. csv-table::
    :delim: |
    :header: "Name", "Required", "Type", "Format", "Properties", "Description"
    :widths: 20, 10, 15, 15, 30, 25

        items | No | array of :ref:`DCAEServiceType <d_b0cb5f12dbde8c0c42487c089983687e>` |  |  | 
        links | No | :ref:`InlineResponse200Links <d_e52a59e574408d4d622b3f1f61619b1c>` |  |  | 
        totalCount | No | integer | int32 |  | 

.. _d_31bb361a8900a0bed20df49b94f1e33b:

InlineResponse2001 Model Structure
----------------------------------

.. csv-table::
    :delim: |
    :header: "Name", "Required", "Type", "Format", "Properties", "Description"
    :widths: 20, 10, 15, 15, 30, 25

        items | No | array of :ref:`DCAEService <d_ae85cd292c2b4046e1ea1bbb02c7ea63>` |  |  | 
        links | No | :ref:`InlineResponse200Links <d_e52a59e574408d4d622b3f1f61619b1c>` |  |  | 
        totalCount | No | integer | int32 |  | 

.. _d_e52a59e574408d4d622b3f1f61619b1c:

InlineResponse200Links Model Structure
--------------------------------------

Pagination links

.. csv-table::
    :delim: |
    :header: "Name", "Required", "Type", "Format", "Properties", "Description"
    :widths: 20, 10, 15, 15, 30, 25

        nextLink | No | :ref:`Link <d_add3c3fd2e145f9e5a78be6e7b208ebb>` |  |  | 
        previousLink | No | :ref:`Link <d_add3c3fd2e145f9e5a78be6e7b208ebb>` |  |  | 

.. _d_add3c3fd2e145f9e5a78be6e7b208ebb:

Link Model Structure
--------------------

.. csv-table::
    :delim: |
    :header: "Name", "Required", "Type", "Format", "Properties", "Description"
    :widths: 20, 10, 15, 15, 30, 25

        params | No | :ref:`params <i_adf17ca32891d8ece6efd40541d227f2>` |  |  | 
        rel | No | string |  |  | 
        rels | No | array of string |  |  | 
        title | No | string |  |  | 
        type | No | string |  |  | 
        uri | No | string | uri |  | 
        uriBuilder | No | :ref:`UriBuilder <d_a7b6b5c694147ea9dcfb5a5a6cbef017>` |  |  | 

.. _i_adf17ca32891d8ece6efd40541d227f2:

**Params schema:**


Map of {"key":"string"}

.. _d_a7b6b5c694147ea9dcfb5a5a6cbef017:

UriBuilder Model Structure
--------------------------



