deployment-handler API 4.2.0
============================

.. toctree::
    :maxdepth: 3


Description
~~~~~~~~~~~

High-level API for deploying/undeploying composed DCAE services using Cloudify Manager.





License
~~~~~~~


`Apache 2.0 <http://www.apache.org/licenses/LICENSE-2.0.html>`_




DCAE-DEPLOYMENTS
~~~~~~~~~~~~~~~~


operations on dcae-deployments





DELETE ``/dcae-deployments/{deploymentId}``
-------------------------------------------



Description
+++++++++++

.. raw:: html

    Uninstall the DCAE service and remove all associated data from the orchestrator.


Parameters
++++++++++

.. csv-table::
    :delim: |
    :header: "Name", "Located in", "Required", "Type", "Format", "Properties", "Description"
    :widths: 20, 15, 10, 10, 10, 20, 30

        deploymentId | path | Yes | string |  |  | Deployment identifier for the service to be uninstalled. 


Request
+++++++


Responses
+++++++++

**202**
^^^^^^^

Success:  The dispatcher has initiated the uninstall operation.



Type: :ref:`DCAEDeploymentResponse <d_6157bd3de5c8c7de78f2ab86397667e0>`

**Example:**

.. code-block:: javascript

    {
        "links": {
            "self": "somestring",
            "status": "somestring"
        },
        "requestId": "somestring"
    }

**400**
^^^^^^^

Bad request: See the message in the response for details.



Type: :ref:`DCAEErrorResponse <d_74f3f4f847dfb6bd181fcae06ad880b4>`

**Example:**

.. code-block:: javascript

    {
        "message": "somestring",
        "status": 1
    }

**500**
^^^^^^^

Problem on the server side.  See the message
in the response for more details.



Type: :ref:`DCAEErrorResponse <d_74f3f4f847dfb6bd181fcae06ad880b4>`

**Example:**

.. code-block:: javascript

    {
        "message": "somestring",
        "status": 1
    }

**502**
^^^^^^^

Error reported to the dispatcher by a downstream system.  See the message
in the response for more details.



Type: :ref:`DCAEErrorResponse <d_74f3f4f847dfb6bd181fcae06ad880b4>`

**Example:**

.. code-block:: javascript

    {
        "message": "somestring",
        "status": 1
    }

**504**
^^^^^^^

Error communicating with a downstream system.  See the message
in the response for more details.



Type: :ref:`DCAEErrorResponse <d_74f3f4f847dfb6bd181fcae06ad880b4>`

**Example:**

.. code-block:: javascript

    {
        "message": "somestring",
        "status": 1
    }





GET ``/dcae-deployments``
-------------------------



Description
+++++++++++

.. raw:: html

    List service deployments known to the orchestrator, optionally restricted to a single service type


Parameters
++++++++++

.. csv-table::
    :delim: |
    :header: "Name", "Located in", "Required", "Type", "Format", "Properties", "Description"
    :widths: 20, 15, 10, 10, 10, 20, 30

        serviceTypeId | query | No | string |  |  | Service type identifier for the type whose deployments are to be listed 


Request
+++++++


Responses
+++++++++

**200**
^^^^^^^

Success. (Note that if no matching deployments are found, the request is still a success; the
deployments array is empty in that case.)



Type: :ref:`DCAEDeploymentsListResponse <d_c51e57d9583f6119caf83dd017cf214c>`

**Example:**

.. code-block:: javascript

    {
        "deployments": [
            {
                "href": "somestring"
            },
            {
                "href": "somestring"
            }
        ],
        "requestId": "somestring"
    }

**500**
^^^^^^^

Problem on the server side.  See the message
in the response for more details.



Type: :ref:`DCAEErrorResponse <d_74f3f4f847dfb6bd181fcae06ad880b4>`

**Example:**

.. code-block:: javascript

    {
        "message": "somestring",
        "status": 1
    }

**502**
^^^^^^^

Error reported to the dispatcher by a downstream system.  See the message
in the response for more details.



Type: :ref:`DCAEErrorResponse <d_74f3f4f847dfb6bd181fcae06ad880b4>`

**Example:**

.. code-block:: javascript

    {
        "message": "somestring",
        "status": 1
    }

**504**
^^^^^^^

Error communicating with a downstream system.  See the message
in the response for more details.



Type: :ref:`DCAEErrorResponse <d_74f3f4f847dfb6bd181fcae06ad880b4>`

**Example:**

.. code-block:: javascript

    {
        "message": "somestring",
        "status": 1
    }





GET ``/dcae-deployments/{deploymentId}/operation/{operationId}``
----------------------------------------------------------------



Description
+++++++++++

.. raw:: html

    Get status of a deployment operation


Parameters
++++++++++

.. csv-table::
    :delim: |
    :header: "Name", "Located in", "Required", "Type", "Format", "Properties", "Description"
    :widths: 20, 15, 10, 10, 10, 20, 30

        deploymentId | path | Yes | string |  |  | 
        operationId | path | Yes | string |  |  | 


Request
+++++++


Responses
+++++++++

**200**
^^^^^^^

Status information retrieved successfully


Type: :ref:`DCAEOperationStatusResponse <d_f0103f05736b04468a4f85fe90da2e16>`

**Example:**

.. code-block:: javascript

    {
        "error": "somestring",
        "links": {
            "self": "somestring",
            "uninstall": "somestring"
        },
        "operationType": "somestring",
        "requestId": "somestring",
        "status": "somestring"
    }

**404**
^^^^^^^

The operation information does not exist (possibly because the service has been uninstalled and deleted).


Type: :ref:`DCAEErrorResponse <d_74f3f4f847dfb6bd181fcae06ad880b4>`

**Example:**

.. code-block:: javascript

    {
        "message": "somestring",
        "status": 1
    }

**500**
^^^^^^^

Problem on the server side.  See the message
in the response for more details.



Type: :ref:`DCAEErrorResponse <d_74f3f4f847dfb6bd181fcae06ad880b4>`

**Example:**

.. code-block:: javascript

    {
        "message": "somestring",
        "status": 1
    }

**502**
^^^^^^^

Error reported to the dispatcher by a downstream system.  See the message
in the response for more details.



Type: :ref:`DCAEErrorResponse <d_74f3f4f847dfb6bd181fcae06ad880b4>`

**Example:**

.. code-block:: javascript

    {
        "message": "somestring",
        "status": 1
    }

**504**
^^^^^^^

Error communicating with a downstream system.  See the message
in the response for more details.



Type: :ref:`DCAEErrorResponse <d_74f3f4f847dfb6bd181fcae06ad880b4>`

**Example:**

.. code-block:: javascript

    {
        "message": "somestring",
        "status": 1
    }





PUT ``/dcae-deployments/{deploymentId}``
----------------------------------------



Description
+++++++++++

.. raw:: html

    Request deployment of a DCAE service


Parameters
++++++++++

.. csv-table::
    :delim: |
    :header: "Name", "Located in", "Required", "Type", "Format", "Properties", "Description"
    :widths: 20, 15, 10, 10, 10, 20, 30

        deploymentId | path | Yes | string |  |  | Unique deployment identifier assigned by the API client. 


Request
+++++++



.. _d_eea14e4929853a5aa415f44cd4868302:

Body
^^^^

Request for deploying a DCAE service.


.. csv-table::
    :delim: |
    :header: "Name", "Required", "Type", "Format", "Properties", "Description"
    :widths: 20, 10, 15, 15, 30, 25

        inputs | No |  |  |  | Object containing inputs needed by the service blueprint to create an instance of the service.

Content of the object depends on the service being deployed.

        serviceTypeId | Yes | string |  |  | The service type identifier (a unique ID assigned by DCAE inventory) for the service to be deployed.


.. _i_08ada55a389e24cd45beef83306fd08e:

**Inputs schema:**


Object containing inputs needed by the service blueprint to create an instance of the service.
Content of the object depends on the service being deployed.




.. code-block:: javascript

    {
        "inputs": {},
        "serviceTypeId": "somestring"
    }

Responses
+++++++++

**202**
^^^^^^^

Success:  The content that was posted is valid, the dispatcher has
  found the needed blueprint, created an instance of the topology in the orchestrator,
  and started an installation workflow.



Type: :ref:`DCAEDeploymentResponse <d_6157bd3de5c8c7de78f2ab86397667e0>`

**Example:**

.. code-block:: javascript

    {
        "links": {
            "self": "somestring",
            "status": "somestring"
        },
        "requestId": "somestring"
    }

**400**
^^^^^^^

Bad request: See the message in the response for details.



Type: :ref:`DCAEErrorResponse <d_74f3f4f847dfb6bd181fcae06ad880b4>`

**Example:**

.. code-block:: javascript

    {
        "message": "somestring",
        "status": 1
    }

**409**
^^^^^^^

A service with the specified deployment Id already exists.  Using PUT to update the service is not a supported operation.



Type: :ref:`DCAEErrorResponse <d_74f3f4f847dfb6bd181fcae06ad880b4>`

**Example:**

.. code-block:: javascript

    {
        "message": "somestring",
        "status": 1
    }

**415**
^^^^^^^

Bad request: The Content-Type header does not indicate that the content is
'application/json'



Type: :ref:`DCAEErrorResponse <d_74f3f4f847dfb6bd181fcae06ad880b4>`

**Example:**

.. code-block:: javascript

    {
        "message": "somestring",
        "status": 1
    }

**500**
^^^^^^^

Problem on the server side.  See the message
in the response for more details.



Type: :ref:`DCAEErrorResponse <d_74f3f4f847dfb6bd181fcae06ad880b4>`

**Example:**

.. code-block:: javascript

    {
        "message": "somestring",
        "status": 1
    }

**502**
^^^^^^^

Error reported to the dispatcher by a downstream system.  See the message
in the response for more details.



Type: :ref:`DCAEErrorResponse <d_74f3f4f847dfb6bd181fcae06ad880b4>`

**Example:**

.. code-block:: javascript

    {
        "message": "somestring",
        "status": 1
    }

**504**
^^^^^^^

Error communicating with a downstream system.  See the message
in the response for more details.



Type: :ref:`DCAEErrorResponse <d_74f3f4f847dfb6bd181fcae06ad880b4>`

**Example:**

.. code-block:: javascript

    {
        "message": "somestring",
        "status": 1
    }



  
INFO
~~~~


version and links





GET ``/``
---------



Description
+++++++++++

.. raw:: html

    Returns version information and links to API operations


Request
+++++++


Responses
+++++++++

**200**
^^^^^^^

Success


.. _i_2e7b26d45eaa7203222963d454a86a88:

**Response Schema:**

.. csv-table::
    :delim: |
    :header: "Name", "Required", "Type", "Format", "Properties", "Description"
    :widths: 20, 10, 15, 15, 30, 25

        apiVersion | No | string |  |  | version of API supported by this server

        links | No | :ref:`links <i_bcea41e897f5de95cd50fa873acb5f65>` |  |  | Links to API resources

        serverVersion | No | string |  |  | version of software running on this server


.. _i_bcea41e897f5de95cd50fa873acb5f65:

**Links schema:**


Links to API resources


.. csv-table::
    :delim: |
    :header: "Name", "Required", "Type", "Format", "Properties", "Description"
    :widths: 20, 10, 15, 15, 30, 25

        events | No | string |  |  | path for the events endpoint

        info | No | string |  |  | path for the server information endpoint



**Example:**

.. code-block:: javascript

    {
        "apiVersion": "somestring",
        "links": {
            "events": "somestring",
            "info": "somestring"
        },
        "serverVersion": "somestring"
    }



  
POLICY
~~~~~~


policy update API consumed by policy-handler and debug API to find policies on components





GET ``/policy/components``
--------------------------



Description
+++++++++++

.. raw:: html

    debug API to find policies on components


Request
+++++++


Responses
+++++++++

**200**
^^^^^^^

deployment-handler found components with or without policies in cloudify






POST ``/policy``
----------------



Description
+++++++++++

.. raw:: html

    policy update API consumed by policy-handler


Request
+++++++



.. _d_6ea6e6f48a0302e963a67833bbd0ff4a:

Body
^^^^

request to update policies on DCAE components.

.. csv-table::
    :delim: |
    :header: "Name", "Required", "Type", "Format", "Properties", "Description"
    :widths: 20, 10, 15, 15, 30, 25

        catch_up | Yes | boolean |  |  | flag to indicate whether the request contains all the policies in PDP or not
        errored_policies | No |  |  |  | whether policy-engine returned an error on the policy.
        errored_scopes | No | array of string |  |  | on cartchup - list of policy scope_prefix values on wchich the policy-engine experienced an error other than not-found data.
        latest_policies | Yes | |  |  | dictionary of (policy_id -> DCAEPolicy object).
        removed_policies | Yes | |  |  | whether policy was removed from policy-engine.
        scope_prefixes | No | array of string |  |  | on catchup - list of all scope_prefixes used by the policy-handler to retrieve the policies from policy-engine.


.. _i_0e88fa72c5312eaae3990753181ce5fe:

**Errored_policies schema:**


whether policy-engine returned an error on the policy.
dictionary of (policy_id -> true).
In example: replace additionalProp1,2,3 with policy_id1,2,3 values


Map of {"key":"boolean"}

.. _i_cbc40bad95bddbd536eeab0a92f483af:

**Latest_policies schema:**


dictionary of (policy_id -> DCAEPolicy object).
In example: replace additionalProp1,2,3 with policy_id1,2,3 values


Map of {"key":":ref:`DCAEPolicy <d_1e3e880a733b457b648bd8c99e6c859c>`"}



.. _i_0ce52a29e44aa0cc7929fe7b555551bc:

**Removed_policies schema:**


whether policy was removed from policy-engine.
dictionary of (policy_id -> true).
In example: replace additionalProp1,2,3 with policy_id1,2,3 values


Map of {"key":"boolean"}

.. code-block:: javascript

    {
        "catch_up": true,
        "errored_policies": {},
        "errored_scopes": [
            "somestring",
            "somestring"
        ],
        "latest_policies": {
            "DCAEPolicy": {
                "policy_body": {
                    "config": {},
                    "policyName": "somestring",
                    "policyVersion": "somestring"
                },
                "policy_id": "somestring"
            }
        },
        "removed_policies": {},
        "scope_prefixes": [
            "somestring",
            "somestring"
        ]
    }

Responses
+++++++++

**200**
^^^^^^^

deployment-handler always responds with ok to /policy before processing the request




  
Data Structures
~~~~~~~~~~~~~~~


DCAEDeploymentRequest Model Structure
-------------------------------------

Request for deploying a DCAE service.


.. csv-table::
    :delim: |
    :header: "Name", "Required", "Type", "Format", "Properties", "Description"
    :widths: 20, 10, 15, 15, 30, 25

        inputs | No | |  |  | Object containing inputs needed by the service blueprint to create an instance of the service.
        serviceTypeId | Yes | string |  |  | The service type identifier (a unique ID assigned by DCAE inventory) for the service to be deployed.



**Inputs schema:**


Object containing inputs needed by the service blueprint to create an instance of the service.
Content of the object depends on the service being deployed.




.. _d_6157bd3de5c8c7de78f2ab86397667e0:

DCAEDeploymentResponse Model Structure
--------------------------------------

Response body for a PUT or DELETE to /dcae-deployments/{deploymentId}


.. csv-table::
    :delim: |
    :header: "Name", "Required", "Type", "Format", "Properties", "Description"
    :widths: 20, 10, 15, 15, 30, 25

        links | Yes | :ref:`links <i_4a894329f99280d2268e250444b59376>` |  |  | Links that the API client can access.

        requestId | Yes | string |  |  | Unique identifier for the request


.. _i_4a894329f99280d2268e250444b59376:

**Links schema:**


Links that the API client can access.


.. csv-table::
    :delim: |
    :header: "Name", "Required", "Type", "Format", "Properties", "Description"
    :widths: 20, 10, 15, 15, 30, 25

        self | No | string |  |  | Link used to retrieve information about the service being deployed

        status | No | string |  |  | Link used to retrieve information about the status of the installation workflow

.. _d_c51e57d9583f6119caf83dd017cf214c:

DCAEDeploymentsListResponse Model Structure
-------------------------------------------

Object providing a list of deployments


.. csv-table::
    :delim: |
    :header: "Name", "Required", "Type", "Format", "Properties", "Description"
    :widths: 20, 10, 15, 15, 30, 25

        deployments | Yes | array of :ref:`deployments <i_98a80d81e7d1973d54db7713913d37e8>` |  |  | 
        requestId | Yes | string |  |  | Unique identifier for the request


.. _i_98a80d81e7d1973d54db7713913d37e8:

**Deployments schema:**


.. csv-table::
    :delim: |
    :header: "Name", "Required", "Type", "Format", "Properties", "Description"
    :widths: 20, 10, 15, 15, 30, 25

        href | No | string |  |  | URL for the service deployment


.. _d_74f3f4f847dfb6bd181fcae06ad880b4:

DCAEErrorResponse Model Structure
---------------------------------

Object reporting an error.


.. csv-table::
    :delim: |
    :header: "Name", "Required", "Type", "Format", "Properties", "Description"
    :widths: 20, 10, 15, 15, 30, 25

        message | No | string |  |  | Human-readable description of the reason for the error
        status | Yes | integer |  |  | HTTP status code for the response

.. _d_f0103f05736b04468a4f85fe90da2e16:

DCAEOperationStatusResponse Model Structure
-------------------------------------------

Response body for a request for status of an installation or uninstallation operation.


.. csv-table::
    :delim: |
    :header: "Name", "Required", "Type", "Format", "Properties", "Description"
    :widths: 20, 10, 15, 15, 30, 25

        error | No | string |  |  | If status is 'failed', this field will be present and contain additional information about the reason the operation failed.

        links | No | :ref:`links <i_2feace8c1d3584ec637edc0eb1b92699>` |  |  | If the operation succeeded, links that the client can follow to take further action.  Note that a successful 'uninstall' operation removes the DCAE service instance completely, so there are no possible further actions, and no links.

        operationType | Yes | string |  |  | Type of operation being reported on. ('install' or 'uninstall')

        requestId | Yes | string |  |  | A unique identifier assigned to the request.  Useful for tracing a request through logs.

        status | Yes | string |  |  | Status of the installation or uninstallation operation.  Possible values are 'processing',


.. _i_2feace8c1d3584ec637edc0eb1b92699:

**Links schema:**


If the operation succeeded, links that the client can follow to take further action.  Note that a successful 'uninstall' operation removes the DCAE service instance completely, so there are no possible further actions, and no links.


.. csv-table::
    :delim: |
    :header: "Name", "Required", "Type", "Format", "Properties", "Description"
    :widths: 20, 10, 15, 15, 30, 25

        self | No | string |  |  | Link used to retrieve information about the service.

        uninstall | No | string |  |  | Link used to trigger an 'uninstall' operation for the service.  (Use the DELETE method.)

.. _d_1e3e880a733b457b648bd8c99e6c859c:

DCAEPolicy Model Structure
--------------------------

policy object

.. csv-table::
    :delim: |
    :header: "Name", "Required", "Type", "Format", "Properties", "Description"
    :widths: 20, 10, 15, 15, 30, 25

        policy_body | Yes | :ref:`DCAEPolicyBody <d_7ffe00ee1aaae6811199d64ff3fea344>` |  |  | 
        policy_id | Yes | string |  |  | unique identifier of policy regardless of its version

.. _d_7ffe00ee1aaae6811199d64ff3fea344:

DCAEPolicyBody Model Structure
------------------------------

policy_body - the whole object received from policy-engine

.. csv-table::
    :delim: |
    :header: "Name", "Required", "Type", "Format", "Properties", "Description"
    :widths: 20, 10, 15, 15, 30, 25

        config | Yes | :ref:`config <i_ba9593ef6832fb8401f266e173acaa5c>` |  |  | the policy-config - the config data provided by policy owner
        policyName | Yes | string |  |  | unique policy name that contains the version and extension
        policyVersion | Yes | string |  |  | stringified int that is autoincremented by policy-engine

.. _i_ba9593ef6832fb8401f266e173acaa5c:

**Config schema:**


the policy-config - the config data provided by policy owner



.. _d_6ea6e6f48a0302e963a67833bbd0ff4a:

DCAEPolicyRequest Model Structure
---------------------------------

request to update policies on DCAE components.

.. csv-table::
    :delim: |
    :header: "Name", "Required", "Type", "Format", "Properties", "Description"
    :widths: 20, 10, 15, 15, 30, 25

        catch_up | Yes | boolean |  |  | flag to indicate whether the request contains all the policies in PDP or not
        errored_policies | No |  |  |  | whether policy-engine returned an error on the policy.
        errored_scopes | No | array of string |  |  | on cartchup - list of policy scope_prefix values on wchich the policy-engine experienced an error other than not-found data.
        latest_policies | Yes | |  |  | dictionary of (policy_id -> DCAEPolicy object).
        removed_policies | Yes | |  |  | whether policy was removed from policy-engine.
        scope_prefixes | No | array of string |  |  | on catchup - list of all scope_prefixes used by the policy-handler to retrieve the policies from policy-engine.


**Errored_policies schema:**


whether policy-engine returned an error on the policy.
dictionary of (policy_id -> true).
In example: replace additionalProp1,2,3 with policy_id1,2,3 values


Map of {"key":"boolean"}

**Latest_policies schema:**


dictionary of (policy_id -> DCAEPolicy object).
In example: replace additionalProp1,2,3 with policy_id1,2,3 values


Map of {"key":":ref:`DCAEPolicy <d_1e3e880a733b457b648bd8c99e6c859c>`"}



**Removed_policies schema:**


whether policy was removed from policy-engine.
dictionary of (policy_id -> true).
In example: replace additionalProp1,2,3 with policy_id1,2,3 values


Map of {"key":"boolean"}

