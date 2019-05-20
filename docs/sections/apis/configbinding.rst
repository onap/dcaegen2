Config Binding Service
======================

.. toctree::
    :maxdepth: 3

.. csv-table::
   :header: "API name", "Swagger JSON", "Swagger YAML"
   :widths: 10,5,5

   "Config Binding Service", ":download:`link <configbinding.json>`", ":download:`link <configbinding.yaml>`"

GET ``/service_component_all/{service_component_name}``
-------------------------------------------------------

Description
+++++++++++

.. raw:: html

    Binds the configuration for service_component_name and returns the bound configuration, policies, and any other keys that are in Consul

Parameters
++++++++++

.. csv-table::
    :delim: |
    :header: "Name", "Located in", "Required", "Type", "Format", "Properties", "Description"
    :widths: 20, 15, 10, 10, 10, 20, 30

    service_component_name | path | Yes | string |  |  | Service Component Name. service_component_name must be a key in consul.

Request
+++++++

Responses
+++++++++

**200**
^^^^^^^

OK; returns {config : ..., policies : ....., k : ...} for all other k in Consul

.. _i_4d863967ef9a9d9efdadd1b250c76bd6:

**Response Schema:**

**Example:**

.. code-block:: javascript

    {}

**404**
^^^^^^^

there is no configuration in Consul for this component

GET ``/service_component/{service_component_name}``
---------------------------------------------------

Description
+++++++++++

.. raw:: html

    Binds the configuration for service_component_name and returns the bound configuration as a JSON

Parameters
++++++++++

.. csv-table::
    :delim: |
    :header: "Name", "Located in", "Required", "Type", "Format", "Properties", "Description"
    :widths: 20, 15, 10, 10, 10, 20, 30

    service_component_name | path | Yes | string |  |  | Service Component Name. service_component_name must be a key in consul.

Request
+++++++

Responses
+++++++++

**200**
^^^^^^^

OK; the bound config is returned as an object

**Response Schema:**

**Example:**

.. code-block:: javascript

    {}

**404**
^^^^^^^

there is no configuration in Consul for this component

GET ``/{key}/{service_component_name}``
---------------------------------------

Description
+++++++++++

.. raw:: html

    this is an endpoint that fetches a generic service_component_name:key out of Consul. The idea is that we don't want to tie components to Consul directly in case we swap out the backend some day, so the CBS abstracts Consul from clients. The structuring and weird collision of this new API with the above is unfortunate but due to legacy concerns.

Parameters
++++++++++

.. csv-table::
    :delim: |
    :header: "Name", "Located in", "Required", "Type", "Format", "Properties", "Description"
    :widths: 20, 15, 10, 10, 10, 20, 30

    key | path | Yes | string |  |  | this endpoint tries to pull service_component_name:key; key is the key after the colon
    service_component_name | path | Yes | string |  |  | Service Component Name.

Request
+++++++

Responses
+++++++++

**200**
^^^^^^^

OK; returns service_component_name:key

**Response Schema:**

**Example:**

.. code-block:: javascript

    {}

**400**
^^^^^^^

bad request. Currently this is only returned on :policies, which is a complex
object, and should be gotten through service_component_all

**404**
^^^^^^^

key does not exist

GET ``/healthcheck``
--------------------

Description
+++++++++++

.. raw:: html

    This is the  health check endpoint. If this returns a 200, the server is alive and consul can be reached. If not a 200, either dead, or no connection to consul

Request
+++++++

Responses
+++++++++

**200**
^^^^^^^

Successful response

**503**
^^^^^^^

the config binding service cannot reach Consul

