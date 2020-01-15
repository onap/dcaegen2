.. This work is licensed under a
   Creative Commons Attribution 4.0 International License.

Onboarding HTTP API (MOD)
=========================

.. toctree::
    :maxdepth: 3


Description
~~~~~~~~~~~

Onboarding API is sub-component under MOD provides following function:

1. API to add/update data-formats
2. API to add/update components (component_Spec)

These API can be invoked by MS owners or by Acumos adapter to upload artifact into MOD catalog

.. csv-table::
   :header: "API name", "Swagger"
   :widths: 10,5

   "Inventory", ":download:`link <mod-onboardingapi.json>`"

Base URL
~~~~~~~~

http:///onboarding

ONBOARDING
~~~~~~~~~~


Default namespace





GET ``/components/{component_id}``
----------------------------------



Description
+++++++++++

.. raw:: html

    Get a Component

Parameters
++++++++++

.. csv-table::
    :delim: |
    :header: "Name", "Located in", "Required", "Type", "Format", "Properties", "Description"
    :widths: 20, 15, 10, 10, 10, 20, 30

        component_id | path | Yes | string |  |  |


Request
+++++++


Headers
^^^^^^^

.. code-block:: javascript

    X-Fields: An optional fields mask


Responses
+++++++++

**200**
^^^^^^^

Success


Type: :ref:`component fields <d_41cf5e14516a536474c8079d332e86c7>` extended :ref:`inline <i_34dba329148d5512a1350568d728c028>`

**Example:**

.. code-block:: javascript

    {
        "componentType": "somestring",
        "componentUrl": "somestring",
        "description": "somestring",
        "id": "somestring",
        "modified": "2015-01-01T15:00:00.000Z",
        "name": "somestring",
        "owner": "somestring",
        "spec": {},
        "status": "somestring",
        "version": "somestring",
        "whenAdded": "2015-01-01T15:00:00.000Z"
    }

**404**
^^^^^^^

Component not found in Catalog


Type: :ref:`Error message <d_e8453714bcbe180e59d1dfbfc583c9cb>`

**Example:**

.. code-block:: javascript

    {
        "message": "somestring"
    }

**500**
^^^^^^^

Internal Server Error






GET ``/components``
-------------------



Description
+++++++++++

.. raw:: html

    Get list of Components in the catalog

Parameters
++++++++++

.. csv-table::
    :delim: |
    :header: "Name", "Located in", "Required", "Type", "Format", "Properties", "Description"
    :widths: 20, 15, 10, 10, 10, 20, 30

        name | query | No | string |  |  | Name of component to filter for
        version | query | No | string |  |  | Version of component to filter for


Request
+++++++


Headers
^^^^^^^

.. code-block:: javascript

    X-Fields: An optional fields mask


Responses
+++++++++

**200**
^^^^^^^

Success


Type: :ref:`Component List <d_53b82f243acb3fd79572e5a8e909c801>`

**Example:**

.. code-block:: javascript

    {
        "components": [
            {
                "componentType": "somestring",
                "componentUrl": "somestring",
                "description": "somestring",
                "id": "somestring",
                "modified": "2015-01-01T15:00:00.000Z",
                "name": "somestring",
                "owner": "somestring",
                "status": "somestring",
                "version": "somestring",
                "whenAdded": "2015-01-01T15:00:00.000Z"
            },
            {
                "componentType": "somestring",
                "componentUrl": "somestring",
                "description": "somestring",
                "id": "somestring",
                "modified": "2015-01-01T15:00:00.000Z",
                "name": "somestring",
                "owner": "somestring",
                "status": "somestring",
                "version": "somestring",
                "whenAdded": "2015-01-01T15:00:00.000Z"
            }
        ]
    }

**500**
^^^^^^^

Internal Server Error






GET ``/dataformats/{dataformat_id}``
------------------------------------



Description
+++++++++++

.. raw:: html

    Get a Data Format

Parameters
++++++++++

.. csv-table::
    :delim: |
    :header: "Name", "Located in", "Required", "Type", "Format", "Properties", "Description"
    :widths: 20, 15, 10, 10, 10, 20, 30

        dataformat_id | path | Yes | string |  |  |


Request
+++++++


Headers
^^^^^^^

.. code-block:: javascript

    X-Fields: An optional fields mask


Responses
+++++++++

**200**
^^^^^^^

Success


Type: :ref:`dataformat fields <d_68ab1278c950fd214a4077565fd97922>` extended :ref:`inline <i_19c008f5124504e9d9c719d157dab70f>`

**Example:**

.. code-block:: javascript

    {
        "dataFormatUrl": "somestring",
        "description": "somestring",
        "id": "somestring",
        "modified": "2015-01-01T15:00:00.000Z",
        "name": "somestring",
        "owner": "somestring",
        "spec": {},
        "status": "somestring",
        "version": "somestring",
        "whenAdded": "2015-01-01T15:00:00.000Z"
    }

**404**
^^^^^^^

Data Format not found in Catalog


Type: :ref:`Error message <d_e8453714bcbe180e59d1dfbfc583c9cb>`

**Example:**

.. code-block:: javascript

    {
        "message": "somestring"
    }

**500**
^^^^^^^

Internal Server Error






GET ``/dataformats``
--------------------



Description
+++++++++++

.. raw:: html

    Get list of Data Formats in the catalog


Request
+++++++


Headers
^^^^^^^

.. code-block:: javascript

    X-Fields: An optional fields mask


Responses
+++++++++

**200**
^^^^^^^

Success


Type: :ref:`Data Format List <d_9479fe3b8fa2fcaeb723c198da99e791>`

**Example:**

.. code-block:: javascript

    {
        "dataFormats": [
            {
                "dataFormatUrl": "somestring",
                "description": "somestring",
                "id": "somestring",
                "modified": "2015-01-01T15:00:00.000Z",
                "name": "somestring",
                "owner": "somestring",
                "status": "somestring",
                "version": "somestring",
                "whenAdded": "2015-01-01T15:00:00.000Z"
            },
            {
                "dataFormatUrl": "somestring",
                "description": "somestring",
                "id": "somestring",
                "modified": "2015-01-01T15:00:00.000Z",
                "name": "somestring",
                "owner": "somestring",
                "status": "somestring",
                "version": "somestring",
                "whenAdded": "2015-01-01T15:00:00.000Z"
            }
        ]
    }

**500**
^^^^^^^

Internal Server Error






PATCH ``/components/{component_id}``
------------------------------------



Description
+++++++++++

.. raw:: html

    Update a Component's status in the Catalog

Parameters
++++++++++

.. csv-table::
    :delim: |
    :header: "Name", "Located in", "Required", "Type", "Format", "Properties", "Description"
    :widths: 20, 15, 10, 10, 10, 20, 30

        component_id | path | Yes | string |  |  |


Request
+++++++



.. _d_fb61d9acd5848e8d882a33934d47ad4f:

Body
^^^^

.. csv-table::
    :delim: |
    :header: "Name", "Required", "Type", "Format", "Properties", "Description"
    :widths: 20, 10, 15, 15, 30, 25

        owner | Yes | string |  |  | User ID
        status | Yes | string |  | {'enum': ['published', 'revoked']} | . . . . .[published] is the only status change supported right now

.. code-block:: javascript

    {
        "owner": "somestring",
        "status": "published"
    }

Responses
+++++++++

**200**
^^^^^^^

Success, Component status updated


**400**
^^^^^^^

Bad Request


Type: :ref:`Error message <d_e8453714bcbe180e59d1dfbfc583c9cb>`

**Example:**

.. code-block:: javascript

    {
        "message": "somestring"
    }

**403**
^^^^^^^

Forbidden Request


Type: :ref:`Error message <d_e8453714bcbe180e59d1dfbfc583c9cb>`

**Example:**

.. code-block:: javascript

    {
        "message": "somestring"
    }

**404**
^^^^^^^

Component not found in Catalog


Type: :ref:`Error message <d_e8453714bcbe180e59d1dfbfc583c9cb>`

**Example:**

.. code-block:: javascript

    {
        "message": "somestring"
    }

**500**
^^^^^^^

Internal Server Error






PATCH ``/dataformats/{dataformat_id}``
--------------------------------------



Description
+++++++++++

.. raw:: html

    Update a Data Format's status in the Catalog

Parameters
++++++++++

.. csv-table::
    :delim: |
    :header: "Name", "Located in", "Required", "Type", "Format", "Properties", "Description"
    :widths: 20, 15, 10, 10, 10, 20, 30

        dataformat_id | path | Yes | string |  |  |


Request
+++++++



.. _d_fb61d9acd5848e8d882a33934d47ad4f:

Body
^^^^

.. csv-table::
    :delim: |
    :header: "Name", "Required", "Type", "Format", "Properties", "Description"
    :widths: 20, 10, 15, 15, 30, 25

        owner | Yes | string |  |  | User ID
        status | Yes | string |  | {'enum': ['published', 'revoked']} | . . . . .[published] is the only status change supported right now

.. code-block:: javascript

    {
        "owner": "somestring",
        "status": "published"
    }

Responses
+++++++++

**200**
^^^^^^^

Success, Data Format status updated


**400**
^^^^^^^

Bad Request


Type: :ref:`Error message <d_e8453714bcbe180e59d1dfbfc583c9cb>`

**Example:**

.. code-block:: javascript

    {
        "message": "somestring"
    }

**403**
^^^^^^^

Forbidden Request


Type: :ref:`Error message <d_e8453714bcbe180e59d1dfbfc583c9cb>`

**Example:**

.. code-block:: javascript

    {
        "message": "somestring"
    }

**404**
^^^^^^^

Data Format not found in Catalog


Type: :ref:`Error message <d_e8453714bcbe180e59d1dfbfc583c9cb>`

**Example:**

.. code-block:: javascript

    {
        "message": "somestring"
    }

**500**
^^^^^^^

Internal Server Error






POST ``/components``
--------------------



Description
+++++++++++

.. raw:: html

    Add a Component to the Catalog


Request
+++++++


Headers
^^^^^^^

.. code-block:: javascript

    X-Fields: An optional fields mask



.. _d_fd89ec3540efda71c3748235024e0b4d:

Body
^^^^

.. csv-table::
    :delim: |
    :header: "Name", "Required", "Type", "Format", "Properties", "Description"
    :widths: 20, 10, 15, 15, 30, 25

        owner | No | string |  |  |
        spec | No | :ref:`spec <i_793f480461dccbb35537f2001ab7af5b>` |  |  | The Component Spec schema is here -> https://git.onap.org/dcaegen2/platform/cli/plain/component-json-schemas/component-specification/dcae-cli-v2/component-spec-schema.json

.. _i_793f480461dccbb35537f2001ab7af5b:

**Spec schema:**


The Component Spec schema is here -> https://git.onap.org/dcaegen2/platform/cli/plain/component-json-schemas/component-specification/dcae-cli-v2/component-spec-schema.json



.. code-block:: javascript

    {
        "owner": "somestring",
        "spec": {}
    }

Responses
+++++++++

**200**
^^^^^^^

Success


Type: :ref:`Component post <d_9eafe9d5168f431205b9fce1312b32bb>`

**Example:**

.. code-block:: javascript

    {
        "componentUrl": "somestring"
    }

**400**
^^^^^^^

Bad Request


Type: :ref:`Error message <d_e8453714bcbe180e59d1dfbfc583c9cb>`

**Example:**

.. code-block:: javascript

    {
        "message": "somestring"
    }

**409**
^^^^^^^

Component already exists


Type: :ref:`Error message <d_e8453714bcbe180e59d1dfbfc583c9cb>`

**Example:**

.. code-block:: javascript

    {
        "message": "somestring"
    }

**500**
^^^^^^^

Internal Server Error






POST ``/dataformats``
---------------------



Description
+++++++++++

.. raw:: html

    Add a Data Format to the Catalog


Request
+++++++


Headers
^^^^^^^

.. code-block:: javascript

    X-Fields: An optional fields mask



.. _d_7a085a9ab5ed1527229588d3b6d2c4c2:

Body
^^^^

.. csv-table::
    :delim: |
    :header: "Name", "Required", "Type", "Format", "Properties", "Description"
    :widths: 20, 10, 15, 15, 30, 25

        owner | No | string |  |  |
        spec | No | :ref:`spec <i_24d5c9ce4ae509ac2272fb61bf0e2003>` |  |  | The Data Format Spec schema is here -> https://git.onap.org/dcaegen2/platform/cli/plain/component-json-schemas/data-format/dcae-cli-v1/data-format-schema.json

.. _i_24d5c9ce4ae509ac2272fb61bf0e2003:

**Spec schema:**


The Data Format Spec schema is here -> https://git.onap.org/dcaegen2/platform/cli/plain/component-json-schemas/data-format/dcae-cli-v1/data-format-schema.json



.. code-block:: javascript

    {
        "owner": "somestring",
        "spec": {}
    }

Responses
+++++++++

**200**
^^^^^^^

Success


Type: :ref:`Data Format post <d_6557e42aae4abfe7f132d85f512a1a26>`

**Example:**

.. code-block:: javascript

    {
        "dataFormatUrl": "somestring"
    }

**400**
^^^^^^^

Bad Request


Type: :ref:`Error message <d_e8453714bcbe180e59d1dfbfc583c9cb>`

**Example:**

.. code-block:: javascript

    {
        "message": "somestring"
    }

**409**
^^^^^^^

Data Format already exists


Type: :ref:`Error message <d_e8453714bcbe180e59d1dfbfc583c9cb>`

**Example:**

.. code-block:: javascript

    {
        "message": "somestring"
    }

**500**
^^^^^^^

Internal Server Error






PUT ``/components/{component_id}``
----------------------------------



Description
+++++++++++

.. raw:: html

    Replace a Component Spec in the Catalog

Parameters
++++++++++

.. csv-table::
    :delim: |
    :header: "Name", "Located in", "Required", "Type", "Format", "Properties", "Description"
    :widths: 20, 15, 10, 10, 10, 20, 30

        component_id | path | Yes | string |  |  |


Request
+++++++



.. _d_fd89ec3540efda71c3748235024e0b4d:

Body
^^^^

.. csv-table::
    :delim: |
    :header: "Name", "Required", "Type", "Format", "Properties", "Description"
    :widths: 20, 10, 15, 15, 30, 25

        owner | No | string |  |  |
        spec | No | :ref:`spec <i_793f480461dccbb35537f2001ab7af5b>` |  |  | The Component Spec schema is here -> https://git.onap.org/dcaegen2/platform/cli/plain/component-json-schemas/component-specification/dcae-cli-v2/component-spec-schema.json

.. _i_793f480461dccbb35537f2001ab7af5b:

**Spec schema:**


The Component Spec schema is here -> https://git.onap.org/dcaegen2/platform/cli/plain/component-json-schemas/component-specification/dcae-cli-v2/component-spec-schema.json



.. code-block:: javascript

    {
        "owner": "somestring",
        "spec": {}
    }

Responses
+++++++++

**200**
^^^^^^^

Success, Component replaced


**400**
^^^^^^^

Bad Request


Type: :ref:`Error message <d_e8453714bcbe180e59d1dfbfc583c9cb>`

**Example:**

.. code-block:: javascript

    {
        "message": "somestring"
    }

**404**
^^^^^^^

Component not found in Catalog


Type: :ref:`Error message <d_e8453714bcbe180e59d1dfbfc583c9cb>`

**Example:**

.. code-block:: javascript

    {
        "message": "somestring"
    }

**500**
^^^^^^^

Internal Server Error






PUT ``/dataformats/{dataformat_id}``
------------------------------------



Description
+++++++++++

.. raw:: html

    Replace a Data Format Spec in the Catalog

Parameters
++++++++++

.. csv-table::
    :delim: |
    :header: "Name", "Located in", "Required", "Type", "Format", "Properties", "Description"
    :widths: 20, 15, 10, 10, 10, 20, 30

        dataformat_id | path | Yes | string |  |  |


Request
+++++++



.. _d_7a085a9ab5ed1527229588d3b6d2c4c2:

Body
^^^^

.. csv-table::
    :delim: |
    :header: "Name", "Required", "Type", "Format", "Properties", "Description"
    :widths: 20, 10, 15, 15, 30, 25

        owner | No | string |  |  |
        spec | No | :ref:`spec <i_24d5c9ce4ae509ac2272fb61bf0e2003>` |  |  | The Data Format Spec schema is here -> https://git.onap.org/dcaegen2/platform/cli/plain/component-json-schemas/data-format/dcae-cli-v1/data-format-schema.json

.. _i_24d5c9ce4ae509ac2272fb61bf0e2003:

**Spec schema:**


The Data Format Spec schema is here -> https://git.onap.org/dcaegen2/platform/cli/plain/component-json-schemas/data-format/dcae-cli-v1/data-format-schema.json



.. code-block:: javascript

    {
        "owner": "somestring",
        "spec": {}
    }

Responses
+++++++++

**200**
^^^^^^^

Success, Data Format added


**400**
^^^^^^^

Bad Request


Type: :ref:`Error message <d_e8453714bcbe180e59d1dfbfc583c9cb>`

**Example:**

.. code-block:: javascript

    {
        "message": "somestring"
    }

**404**
^^^^^^^

Data Format not found in Catalog


Type: :ref:`Error message <d_e8453714bcbe180e59d1dfbfc583c9cb>`

**Example:**

.. code-block:: javascript

    {
        "message": "somestring"
    }

**500**
^^^^^^^

Internal Server Error





Data Structures
~~~~~~~~~~~~~~~

.. _d_53b82f243acb3fd79572e5a8e909c801:

Component List Model Structure
------------------------------

.. csv-table::
    :delim: |
    :header: "Name", "Required", "Type", "Format", "Properties", "Description"
    :widths: 20, 10, 15, 15, 30, 25

        components | No | array of :ref:`component fields <d_41cf5e14516a536474c8079d332e86c7>` |  |  |

.. _d_fd89ec3540efda71c3748235024e0b4d:

Component Spec Model Structure
------------------------------

.. csv-table::
    :delim: |
    :header: "Name", "Required", "Type", "Format", "Properties", "Description"
    :widths: 20, 10, 15, 15, 30, 25

        owner | No | string |  |  |
        spec | No | :ref:`spec <i_793f480461dccbb35537f2001ab7af5b>` |  |  | The Component Spec schema is here -> https://git.onap.org/dcaegen2/platform/cli/plain/component-json-schemas/component-specification/dcae-cli-v2/component-spec-schema.json

.. _i_793f480461dccbb35537f2001ab7af5b:

**Spec schema:**


The Component Spec schema is here -> https://git.onap.org/dcaegen2/platform/cli/plain/component-json-schemas/component-specification/dcae-cli-v2/component-spec-schema.json



.. _d_9eafe9d5168f431205b9fce1312b32bb:

Component post Model Structure
------------------------------

.. csv-table::
    :delim: |
    :header: "Name", "Required", "Type", "Format", "Properties", "Description"
    :widths: 20, 10, 15, 15, 30, 25

        componentUrl | Yes | string |  |  | . . . . Url to the Component Specification

.. _d_9479fe3b8fa2fcaeb723c198da99e791:

Data Format List Model Structure
--------------------------------

.. csv-table::
    :delim: |
    :header: "Name", "Required", "Type", "Format", "Properties", "Description"
    :widths: 20, 10, 15, 15, 30, 25

        dataFormats | No | array of :ref:`dataformat fields <d_68ab1278c950fd214a4077565fd97922>` |  |  |

.. _d_7a085a9ab5ed1527229588d3b6d2c4c2:

Data Format Spec Model Structure
--------------------------------

.. csv-table::
    :delim: |
    :header: "Name", "Required", "Type", "Format", "Properties", "Description"
    :widths: 20, 10, 15, 15, 30, 25

        owner | No | string |  |  |
        spec | No | :ref:`spec <i_24d5c9ce4ae509ac2272fb61bf0e2003>` |  |  | The Data Format Spec schema is here -> https://git.onap.org/dcaegen2/platform/cli/plain/component-json-schemas/data-format/dcae-cli-v1/data-format-schema.json

.. _i_24d5c9ce4ae509ac2272fb61bf0e2003:

**Spec schema:**


The Data Format Spec schema is here -> https://git.onap.org/dcaegen2/platform/cli/plain/component-json-schemas/data-format/dcae-cli-v1/data-format-schema.json



.. _d_6557e42aae4abfe7f132d85f512a1a26:

Data Format post Model Structure
--------------------------------

.. csv-table::
    :delim: |
    :header: "Name", "Required", "Type", "Format", "Properties", "Description"
    :widths: 20, 10, 15, 15, 30, 25

        dataFormatUrl | Yes | string |  |  | . . . . Url to the Data Format Specification

.. _d_e8453714bcbe180e59d1dfbfc583c9cb:

Error message Model Structure
-----------------------------

.. csv-table::
    :delim: |
    :header: "Name", "Required", "Type", "Format", "Properties", "Description"
    :widths: 20, 10, 15, 15, 30, 25

        message | No | string |  |  | . . . . .Details about the unsuccessful API request

.. _d_fb61d9acd5848e8d882a33934d47ad4f:

Patch Spec Model Structure
--------------------------

.. csv-table::
    :delim: |
    :header: "Name", "Required", "Type", "Format", "Properties", "Description"
    :widths: 20, 10, 15, 15, 30, 25

        owner | Yes | string |  |  | User ID
        status | Yes | string |  | {'enum': ['published', 'revoked']} | . . . . .[published] is the only status change supported right now

.. _d_41cf5e14516a536474c8079d332e86c7:

component fields Model Structure
--------------------------------

.. csv-table::
    :delim: |
    :header: "Name", "Required", "Type", "Format", "Properties", "Description"
    :widths: 20, 10, 15, 15, 30, 25

        componentType | Yes | string |  |  | . . . . only 'docker'
        componentUrl | Yes | string |  |  | . . . . Url to the Component Specification
        description | Yes | string |  |  | . . . . Description of the component
        id | Yes | string |  |  | . . . . ID of the component
        modified | Yes | string | date-time |  | . . . . When component was last modified
        name | Yes | string |  |  | . . . . Name of the component
        owner | Yes | string |  |  | . . . . ID of who added the component
        status | Yes | string |  |  | . . . . Status of the component
        version | Yes | string |  |  | . . . . Version of the component
        whenAdded | Yes | string | date-time |  | . . . . When component was added to the Catalog

.. _d_c86e31bb6b9a2aaf18cab261f501cdf1:

component fields by id Model Structure
--------------------------------------

:ref:`component fields <d_41cf5e14516a536474c8079d332e86c7>` extended :ref:`inline <i_34dba329148d5512a1350568d728c028>`

.. _i_34dba329148d5512a1350568d728c028:

**Inline schema:**


.. csv-table::
    :delim: |
    :header: "Name", "Required", "Type", "Format", "Properties", "Description"
    :widths: 20, 10, 15, 15, 30, 25

        componentType | Yes | string |  |  | . . . . only 'docker'
        componentUrl | Yes | string |  |  | . . . . Url to the Component Specification
        description | Yes | string |  |  | . . . . Description of the component
        id | Yes | string |  |  | . . . . ID of the component
        modified | Yes | string | date-time |  | . . . . When component was last modified
        name | Yes | string |  |  | . . . . Name of the component
        owner | Yes | string |  |  | . . . . ID of who added the component
        spec | Yes | :ref:`spec <i_ea9c5ae5ca1fb737a10e33ba863d3d34>` |  |  | The Component Specification (json)
        status | Yes | string |  |  | . . . . Status of the component
        version | Yes | string |  |  | . . . . Version of the component
        whenAdded | Yes | string | date-time |  | . . . . When component was added to the Catalog

.. _i_ea9c5ae5ca1fb737a10e33ba863d3d34:

**Spec schema:**


The Component Specification (json)



.. _d_68ab1278c950fd214a4077565fd97922:

dataformat fields Model Structure
---------------------------------

.. csv-table::
    :delim: |
    :header: "Name", "Required", "Type", "Format", "Properties", "Description"
    :widths: 20, 10, 15, 15, 30, 25

        dataFormatUrl | Yes | string |  |  | . . . . Url to the Data Format Specification
        description | Yes | string |  |  | . . . . Description of the data format
        id | Yes | string |  |  | . . . . ID of the data format
        modified | Yes | string | date-time |  | . . . . When data format was last modified
        name | Yes | string |  |  | . . . . Name of the data format
        owner | Yes | string |  |  | . . . . ID of who added the data format
        status | Yes | string |  |  | . . . . Status of the data format
        version | Yes | string |  |  | . . . . Version of the data format
        whenAdded | Yes | string | date-time |  | . . . . When data format was added to the Catalog

.. _d_9c3ce799741cd0dae7f4d25c049e8a79:

dataformat fields by id Model Structure
---------------------------------------

:ref:`dataformat fields <d_68ab1278c950fd214a4077565fd97922>` extended :ref:`inline <i_19c008f5124504e9d9c719d157dab70f>`

.. _i_19c008f5124504e9d9c719d157dab70f:

**Inline schema:**


.. csv-table::
    :delim: |
    :header: "Name", "Required", "Type", "Format", "Properties", "Description"
    :widths: 20, 10, 15, 15, 30, 25

        dataFormatUrl | Yes | string |  |  | . . . . Url to the Data Format Specification
        description | Yes | string |  |  | . . . . Description of the data format
        id | Yes | string |  |  | . . . . ID of the data format
        modified | Yes | string | date-time |  | . . . . When data format was last modified
        name | Yes | string |  |  | . . . . Name of the data format
        owner | Yes | string |  |  | . . . . ID of who added the data format
        spec | Yes | :ref:`spec <i_c9a99411463ded6c619772d83b3882c8>` |  |  | The Data Format Specification (json)
        status | Yes | string |  |  | . . . . Status of the data format
        version | Yes | string |  |  | . . . . Version of the data format
        whenAdded | Yes | string | date-time |  | . . . . When data format was added to the Catalog

.. _i_c9a99411463ded6c619772d83b3882c8:

**Spec schema:**


The Data Format Specification (json)
