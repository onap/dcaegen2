Config Binding Service 1.0.0
============================

.. toctree::
    :maxdepth: 3





DEFAULT
~~~~~~~




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

        service_component_name | path | Yes | string |  |  | Service Component Name. service_component_name and  service_component_name:rels must be keys in consul.


Request
+++++++


Responses
+++++++++

**200**
^^^^^^^

OK; the bound config is returned as an object


.. _i_6cb44a56118e2966acccfb86f18d0570:

**Response Schema:**




**Example:**

.. code-block:: javascript

    {}

**404**
^^^^^^^

there is no configuration in Consul for this component






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




  
Data Structures
~~~~~~~~~~~~~~~

