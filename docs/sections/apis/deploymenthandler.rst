deployment-handler API 4.1.0
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

        inputs | No | :ref:`inputs <i_51dfb5d178ebacb6d6617c15cefffa86>` |  |  | Object containing inputs needed by the service blueprint to create an instance of the service.
Content of the object depends on the service being deployed.

        serviceTypeId | Yes | string |  |  | The service type identifier (a unique ID assigned by DCAE inventory) for the service to be deployed.


.. _i_51dfb5d178ebacb6d6617c15cefffa86:

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


Type: :ref:`DispatcherInfo <d_01a325801d3165f9b15dbdaa15b94815>`

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

        latest_policies | Yes | :ref:`latest_policies <i_22fec92398d6fc407cf75f0b4c0f3614>` |  |  | dictionary of (policy_id -> Policy object).  In example: replace additionalProp1,2,3 with policy_id1,2,3 values

.. _i_22fec92398d6fc407cf75f0b4c0f3614:

**Latest_policies schema:**


dictionary of (policy_id -> Policy object).  In example: replace additionalProp1,2,3 with policy_id1,2,3 values

Map of {"key":":ref:`DCAEPolicy <d_1e3e880a733b457b648bd8c99e6c859c>`"}



.. code-block:: javascript

    {
        "latest_policies": {
            "DCAEPolicy": {
                "policy_body": {
                    "config": {}, 
                    "policyName": "somestring", 
                    "policyVersion": "somestring"
                }, 
                "policy_id": "somestring"
            }
        }
    }

Responses
+++++++++

**200**
^^^^^^^

deployment-handler always responds with ok to /policy before processing the request




  
Data Structures
~~~~~~~~~~~~~~~

.. _d_eea14e4929853a5aa415f44cd4868302:

DCAEDeploymentRequest Model Structure
-------------------------------------

Request for deploying a DCAE service.


.. csv-table::
    :delim: |
    :header: "Name", "Required", "Type", "Format", "Properties", "Description"
    :widths: 20, 10, 15, 15, 30, 25

        inputs | No | :ref:`inputs <i_51dfb5d178ebacb6d6617c15cefffa86>` |  |  | Object containing inputs needed by the service blueprint to create an instance of the service.
Content of the object depends on the service being deployed.

        serviceTypeId | Yes | string |  |  | The service type identifier (a unique ID assigned by DCAE inventory) for the service to be deployed.


.. _i_51dfb5d178ebacb6d6617c15cefffa86:

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

        links | No | :ref:`DCAEDeploymentResponse_links <d_e5951c399cff33430222aefe098fbbbb>` |  |  | 
        requestId | Yes | string |  |  | Unique identifier for the request


.. _d_e5951c399cff33430222aefe098fbbbb:

DCAEDeploymentResponse_links Model Structure
--------------------------------------------

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

        deployments | Yes | array of :ref:`DCAEDeploymentsListResponse_deployments <d_bf53389ec58f942852b6e44f2f35173c>` |  |  | 
        requestId | Yes | string |  |  | Unique identifier for the request


.. _d_bf53389ec58f942852b6e44f2f35173c:

DCAEDeploymentsListResponse_deployments Model Structure
-------------------------------------------------------

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

        links | No | :ref:`DCAEOperationStatusResponse_links <d_d0c8dc90669705fbfd08cca966a5fcae>` |  |  | 
        operationType | Yes | string |  |  | Type of operation being reported on. ('install' or 'uninstall')

        requestId | Yes | string |  |  | A unique identifier assigned to the request.  Useful for tracing a request through logs.

        status | Yes | string |  |  | Status of the installation or uninstallation operation.  Possible values are 'processing',
'succeeded', and 'failed'


.. _d_d0c8dc90669705fbfd08cca966a5fcae:

DCAEOperationStatusResponse_links Model Structure
-------------------------------------------------

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

        config | Yes | :ref:`config <i_4926bbee050a2d1f47c3281f6c9095cf>` |  |  | the policy-config - the config data provided by policy owner
        policyName | Yes | string |  |  | unique policy name that contains the version and extension
        policyVersion | Yes | string |  |  | stringified int that is autoincremented by policy-engine

.. _i_4926bbee050a2d1f47c3281f6c9095cf:

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

        latest_policies | Yes | :ref:`latest_policies <i_22fec92398d6fc407cf75f0b4c0f3614>` |  |  | dictionary of (policy_id -> Policy object).  In example: replace additionalProp1,2,3 with policy_id1,2,3 values

.. _i_22fec92398d6fc407cf75f0b4c0f3614:

**Latest_policies schema:**


dictionary of (policy_id -> Policy object).  In example: replace additionalProp1,2,3 with policy_id1,2,3 values

Map of {"key":":ref:`DCAEPolicy <d_1e3e880a733b457b648bd8c99e6c859c>`"}



.. _d_01a325801d3165f9b15dbdaa15b94815:

DispatcherInfo Model Structure
------------------------------

.. csv-table::
    :delim: |
    :header: "Name", "Required", "Type", "Format", "Properties", "Description"
    :widths: 20, 10, 15, 15, 30, 25

        apiVersion | No | string |  |  | version of API supported by this server

        links | No | :ref:`DispatcherInfo_links <d_0a18e12425d91480a8516b17efe05340>` |  |  | 
        serverVersion | No | string |  |  | version of software running on this server


.. _d_0a18e12425d91480a8516b17efe05340:

DispatcherInfo_links Model Structure
------------------------------------

Links to API resources


.. csv-table::
    :delim: |
    :header: "Name", "Required", "Type", "Format", "Properties", "Description"
    :widths: 20, 10, 15, 15, 30, 25

        events | No | string |  |  | path for the events endpoint

        info | No | string |  |  | path for the server information endpoint


