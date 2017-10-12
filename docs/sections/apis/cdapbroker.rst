CDAP Broker API 4.0.10
======================

.. toctree::
    :maxdepth: 3





DEFAULT
~~~~~~~




DELETE ``/application/{appname}``
---------------------------------



Description
+++++++++++

.. raw:: html

    Remove an app for service and configuration discovery. This will remove the metrics and health endpoints for this app.

Parameters
++++++++++

.. csv-table::
    :delim: |
    :header: "Name", "Located in", "Required", "Type", "Format", "Properties", "Description"
    :widths: 20, 15, 10, 10, 10, 20, 30

        appname | path | Yes | string | text |  | Name of the application.


Request
+++++++


Responses
+++++++++

**200**
^^^^^^^

Successful response


**404**
^^^^^^^

no app with name 'appname' registered with this broker.






GET ``/``
---------



Description
+++++++++++

.. raw:: html

    shows some information about this service


Request
+++++++


Responses
+++++++++

**200**
^^^^^^^

successful response


Type: :ref:`info <d_060ca512d6d771a97a7d0f50886f6b14>`

**Example:**

.. code-block:: javascript

    {
        "broker API version": "somestring", 
        "cdap GUI port": 1, 
        "cdap cluster version": "somestring", 
        "managed cdap url": "somestring", 
        "number of applications registered": 1, 
        "uptime (s)": 1
    }





GET ``/application``
--------------------



Description
+++++++++++

.. raw:: html

    get all applications registered with this broker


Request
+++++++


Responses
+++++++++

**200**
^^^^^^^

successful response


Type: array of :ref:`appname <d_2f6991f1775468c3ce48a2778455be93>`


**Example:**

.. code-block:: javascript

    [
        "somestring", 
        "somestring"
    ]





GET ``/application/{appname}``
------------------------------



Description
+++++++++++

.. raw:: html

    Returns the representation of the application resource, including the links for healthcheck and metrics.

Parameters
++++++++++

.. csv-table::
    :delim: |
    :header: "Name", "Located in", "Required", "Type", "Format", "Properties", "Description"
    :widths: 20, 15, 10, 10, 10, 20, 30

        appname | path | Yes | string | text |  | Name of the application.


Request
+++++++


Responses
+++++++++

**200**
^^^^^^^

Successful response


Type: :ref:`Application <d_2b315c86978b3cd8c6edfbe745f1afa2>`

**Example:**

.. code-block:: javascript

    {
        "appname": "somestring", 
        "connectionurl": "somestring", 
        "healthcheckurl": "somestring", 
        "metricsurl": "somestring", 
        "serviceendpoints": [
            {
                "method": "somestring", 
                "url": "somestring"
            }, 
            {
                "method": "somestring", 
                "url": "somestring"
            }
        ], 
        "url": "somestring"
    }

**404**
^^^^^^^

no app with name 'appname' registered with this broker.






GET ``/application/{appname}/healthcheck``
------------------------------------------



Description
+++++++++++

.. raw:: html

    Perform a healthcheck on the running app appname.

Parameters
++++++++++

.. csv-table::
    :delim: |
    :header: "Name", "Located in", "Required", "Type", "Format", "Properties", "Description"
    :widths: 20, 15, 10, 10, 10, 20, 30

        appname | path | Yes | string | test |  | Name of the application to get the healthcheck for.


Request
+++++++


Responses
+++++++++

**200**
^^^^^^^

Successful response, healthcheck pass


**404**
^^^^^^^

no app with name 'appname' registered with this broker, or the healthcheck has failed (though I would like to disambiguiate from the first case, CDAP returns a 404 for this).






GET ``/application/{appname}/metrics``
--------------------------------------



Description
+++++++++++

.. raw:: html

    Get live (real-time) app specific metrics for the running app appname. Metrics are customized per each app by the component developer

Parameters
++++++++++

.. csv-table::
    :delim: |
    :header: "Name", "Located in", "Required", "Type", "Format", "Properties", "Description"
    :widths: 20, 15, 10, 10, 10, 20, 30

        appname | path | Yes | string | test |  | Name of the application to get metrics for.


Request
+++++++


Responses
+++++++++

**200**
^^^^^^^

Successful response


Type: :ref:`MetricsObject <d_5d4c5a47c1043833affa67eb27bf3d9d>`

**Example:**

.. code-block:: javascript

    {
        "appmetrics": {}
    }

**404**
^^^^^^^

no app with name 'appname' registered with this broker.






POST ``/application/delete``
----------------------------



Description
+++++++++++

.. raw:: html

    endpoint to delete multiple applications at once. Returns an array of status codes, where statuscode[i] = response returned from DELETE(application/i)


Request
+++++++



.. _d_c0830b0f8b495da06c2fef152ce05dba:

Body
^^^^

.. csv-table::
    :delim: |
    :header: "Name", "Required", "Type", "Format", "Properties", "Description"
    :widths: 20, 10, 15, 15, 30, 25

        appnames | No | array of :ref:`appname <d_2f6991f1775468c3ce48a2778455be93>` |  |  | 

.. code-block:: javascript

    {
        "appnames": [
            "somestring", 
            "somestring"
        ]
    }

Responses
+++++++++

**200**
^^^^^^^

successful response


Type: array of :ref:`returncode <d_5a28f16eed72be7d9a8279c0e1f05386>`


**Example:**

.. code-block:: javascript

    [
        1, 
        1
    ]





PUT ``/application/{appname}``
------------------------------



Description
+++++++++++

.. raw:: html

    Register an app for service and configuration discovery. This will light up a metrics and health endpoint for this app. `appname` is assumed to also be the key in  consul.

Parameters
++++++++++

.. csv-table::
    :delim: |
    :header: "Name", "Located in", "Required", "Type", "Format", "Properties", "Description"
    :widths: 20, 15, 10, 10, 10, 20, 30

        appname | path | Yes | string | text |  | Name of the application.


Request
+++++++



.. _d_a151b00939024528c17a91cf47a4eae3:

Body
^^^^

.. csv-table::
    :delim: |
    :header: "Name", "Required", "Type", "Format", "Properties", "Description"
    :widths: 20, 10, 15, 15, 30, 25

        app_config | No | :ref:`app_config <i_13b2658afc25a955a6b4b48b9898c1a3>` |  |  | the application config JSON
        app_preferences | No | :ref:`app_preferences <i_57297f6d8a6251aeb045f0872bf38d81>` |  |  | the application preferences JSON
        artifact_name | No | string |  |  | the name of the CDAP artifact to be added
        cdap_application_type | No | string |  | {'enum': ['program-flowlet']} | denotes whether this is a program-flowlet style application or a hydrator pipeline. For program-flowlet style apps, this value must be 'program-flowlet'
        jar_url | No | string |  |  | the URL that the JAR you're deploying resides
        namespace | No | string |  |  | the cdap namespace this is deployed into
        program_preferences | No | array of :ref:`programpref <d_610742fa78204adc388d0f7fbe30ad61>` |  |  | 
        programs | No | array of :ref:`programs <d_7bc8b39312a070aee5928f4e730192ae>` |  |  | 
        services | No | array of :ref:`service_endpoint <d_ad781f0dd64e16123fc1cbfefb4b9ded>` |  |  | 
        streamname | No | string |  |  | name of the CDAP stream to ingest data into this app. Should come from the developer and Tosca model.

.. _i_13b2658afc25a955a6b4b48b9898c1a3:

**App_config schema:**


the application config JSON



.. _i_57297f6d8a6251aeb045f0872bf38d81:

**App_preferences schema:**


the application preferences JSON



.. code-block:: javascript

    {
        "app_config": {}, 
        "app_preferences": {}, 
        "artifact_name": "somestring", 
        "cdap_application_type": "program-flowlet", 
        "jar_url": "somestring", 
        "namespace": "somestring", 
        "program_preferences": [
            {
                "program_id": "somestring", 
                "program_pref": {}, 
                "program_type": "somestring"
            }, 
            {
                "program_id": "somestring", 
                "program_pref": {}, 
                "program_type": "somestring"
            }
        ], 
        "programs": [
            {
                "program_id": "somestring", 
                "program_type": "somestring"
            }, 
            {
                "program_id": "somestring", 
                "program_type": "somestring"
            }
        ], 
        "services": [
            {
                "endpoint_method": "somestring", 
                "service_endpoint": "somestring", 
                "service_name": "somestring"
            }, 
            {
                "endpoint_method": "somestring", 
                "service_endpoint": "somestring", 
                "service_name": "somestring"
            }
        ], 
        "streamname": "somestring"
    }

Responses
+++++++++

**200**
^^^^^^^

Successful response


Type: :ref:`Application <d_2b315c86978b3cd8c6edfbe745f1afa2>`

**Example:**

.. code-block:: javascript

    {
        "appname": "somestring", 
        "connectionurl": "somestring", 
        "healthcheckurl": "somestring", 
        "metricsurl": "somestring", 
        "serviceendpoints": [
            {
                "method": "somestring", 
                "url": "somestring"
            }, 
            {
                "method": "somestring", 
                "url": "somestring"
            }
        ], 
        "url": "somestring"
    }

**400**
^^^^^^^

put was performed but the appname was already registered with the broker, or Invalid PUT body






PUT ``/application*/{appname}``
-------------------------------



Description
+++++++++++

.. raw:: html

    (This is a hacky way of supporting "oneOf" because Swagger does not support oneOf https://github.com/OAI/OpenAPI-Specification/issues/333. This is the same endpoint as PUT /application/appname, except the PUT body is different.)

Register a hydrator app for service and configuration discovery. This will light up a metrics and health endpoint for this app. `appname` is assumed to also be the key in  consul.

Parameters
++++++++++

.. csv-table::
    :delim: |
    :header: "Name", "Located in", "Required", "Type", "Format", "Properties", "Description"
    :widths: 20, 15, 10, 10, 10, 20, 30

        appname | path | Yes | string | text |  | Name of the application.


Request
+++++++



.. _d_d43078a75182938dccdbeac654cea43c:

Body
^^^^

.. csv-table::
    :delim: |
    :header: "Name", "Required", "Type", "Format", "Properties", "Description"
    :widths: 20, 10, 15, 15, 30, 25

        cdap_application_type | Yes | string |  | {'enum': ['hydrator-pipeline']} | denotes whether this is a program-flowlet style application or a hydrator pipeline. For hydrator, this value must be 'hydrator-pipeline'
        dependencies | No | array of :ref:`hydratordep <d_c5aa8c778f283571705fbe7a21d0f5c7>` |  |  | represents a list of dependencies to be loaded for this pipeline. Not required.
        namespace | Yes | string |  |  | the cdap namespace this is deployed into
        pipeline_config_json_url | Yes | string |  |  | the URL of the config.json for this pipeline
        streamname | Yes | string |  |  | name of the CDAP stream to ingest data into this app. Should come from the developer and Tosca model.

.. code-block:: javascript

    {
        "cdap_application_type": "hydrator-pipeline", 
        "dependencies": [
            {
                "artifact_extends_header": "somestring", 
                "artifact_name": "somestring", 
                "artifact_url": "somestring", 
                "artifact_version_header": "somestring", 
                "ui_properties_url": "somestring"
            }, 
            {
                "artifact_extends_header": "somestring", 
                "artifact_name": "somestring", 
                "artifact_url": "somestring", 
                "artifact_version_header": "somestring", 
                "ui_properties_url": "somestring"
            }
        ], 
        "namespace": "somestring", 
        "pipeline_config_json_url": "somestring", 
        "streamname": "somestring"
    }

Responses
+++++++++

**200**
^^^^^^^

Successful response


Type: :ref:`Application <d_2b315c86978b3cd8c6edfbe745f1afa2>`

**Example:**

.. code-block:: javascript

    {
        "appname": "somestring", 
        "connectionurl": "somestring", 
        "healthcheckurl": "somestring", 
        "metricsurl": "somestring", 
        "serviceendpoints": [
            {
                "method": "somestring", 
                "url": "somestring"
            }, 
            {
                "method": "somestring", 
                "url": "somestring"
            }
        ], 
        "url": "somestring"
    }

**400**
^^^^^^^

put was performed but the appname was already registered with the broker, or Invalid PUT body






PUT ``/application/{appname}/reconfigure``
------------------------------------------



Description
+++++++++++

.. raw:: html

    Reconfigures the application.

Parameters
++++++++++

.. csv-table::
    :delim: |
    :header: "Name", "Located in", "Required", "Type", "Format", "Properties", "Description"
    :widths: 20, 15, 10, 10, 10, 20, 30

        appname | path | Yes | string | text |  | Name of the application.


Request
+++++++



.. _d_2a32645bc6d3020744d3d17500c34bc3:

Body
^^^^

.. csv-table::
    :delim: |
    :header: "Name", "Required", "Type", "Format", "Properties", "Description"
    :widths: 20, 10, 15, 15, 30, 25

        config | Yes | :ref:`config <i_6a9d9951a40bf655fda365aa310e1ddc>` |  |  | the config JSON
        reconfiguration_type | Yes | string |  | {'enum': ['program-flowlet-app-config', 'program-flowlet-app-preferences', 'program-flowlet-smart']} | the type of reconfiguration

.. _i_6a9d9951a40bf655fda365aa310e1ddc:

**Config schema:**


the config JSON



.. code-block:: javascript

    {
        "config": {}, 
        "reconfiguration_type": "program-flowlet-app-config"
    }

Responses
+++++++++

**200**
^^^^^^^

Successful response


**400**
^^^^^^^

Bad request. Can happen with 1)  {appname} is not registered with the broker, 2) the required PUT body is wrong, or 3) the smart interface was chosen and none of the config keys match anything in app_config or app_preferences




  
Data Structures
~~~~~~~~~~~~~~~

.. _d_2b315c86978b3cd8c6edfbe745f1afa2:

Application Model Structure
---------------------------

.. csv-table::
    :delim: |
    :header: "Name", "Required", "Type", "Format", "Properties", "Description"
    :widths: 20, 10, 15, 15, 30, 25

        appname | No | string |  |  | application name
        connectionurl | No | string |  |  | input URL that you can POST data into (URL of the CDAP stream)
        healthcheckurl | No | string |  |  | fully qualified url to perform healthcheck
        metricsurl | No | string |  |  | fully qualified url to get metrics from
        serviceendpoints | No | array of :ref:`service_method <d_e5edc5fd82a1190817cf350e70cb7e0e>` |  |  | a list of HTTP services exposed by this CDAP application
        url | No | string |  |  | fully qualified url of the resource

.. _d_5d4c5a47c1043833affa67eb27bf3d9d:

MetricsObject Model Structure
-----------------------------

key,value object where the key is 'appmetrics' and the value is an app dependent json and specified by the component developer

.. csv-table::
    :delim: |
    :header: "Name", "Required", "Type", "Format", "Properties", "Description"
    :widths: 20, 10, 15, 15, 30, 25

        appmetrics | No | :ref:`appmetrics <i_6cb44a56118e2966acccfb86f18d0570>` |  |  | 

.. _i_6cb44a56118e2966acccfb86f18d0570:

**Appmetrics schema:**




.. _d_2f6991f1775468c3ce48a2778455be93:

appname Model Structure
-----------------------

an application name

.. csv-table::
    :delim: |
    :header: "Name", "Required", "Type", "Format", "Properties", "Description"
    :widths: 20, 10, 15, 15, 30, 25

        appname | No | string |  |  | an application name

.. _d_a151b00939024528c17a91cf47a4eae3:

appput Model Structure
----------------------

.. csv-table::
    :delim: |
    :header: "Name", "Required", "Type", "Format", "Properties", "Description"
    :widths: 20, 10, 15, 15, 30, 25

        app_config | No | :ref:`app_config <i_13b2658afc25a955a6b4b48b9898c1a3>` |  |  | the application config JSON
        app_preferences | No | :ref:`app_preferences <i_57297f6d8a6251aeb045f0872bf38d81>` |  |  | the application preferences JSON
        artifact_name | No | string |  |  | the name of the CDAP artifact to be added
        cdap_application_type | No | string |  | {'enum': ['program-flowlet']} | denotes whether this is a program-flowlet style application or a hydrator pipeline. For program-flowlet style apps, this value must be 'program-flowlet'
        jar_url | No | string |  |  | the URL that the JAR you're deploying resides
        namespace | No | string |  |  | the cdap namespace this is deployed into
        program_preferences | No | array of :ref:`programpref <d_610742fa78204adc388d0f7fbe30ad61>` |  |  | 
        programs | No | array of :ref:`programs <d_7bc8b39312a070aee5928f4e730192ae>` |  |  | 
        services | No | array of :ref:`service_endpoint <d_ad781f0dd64e16123fc1cbfefb4b9ded>` |  |  | 
        streamname | No | string |  |  | name of the CDAP stream to ingest data into this app. Should come from the developer and Tosca model.

.. _i_13b2658afc25a955a6b4b48b9898c1a3:

**App_config schema:**


the application config JSON



.. _i_57297f6d8a6251aeb045f0872bf38d81:

**App_preferences schema:**


the application preferences JSON



.. _d_d43078a75182938dccdbeac654cea43c:

hydratorappput Model Structure
------------------------------

.. csv-table::
    :delim: |
    :header: "Name", "Required", "Type", "Format", "Properties", "Description"
    :widths: 20, 10, 15, 15, 30, 25

        cdap_application_type | Yes | string |  | {'enum': ['hydrator-pipeline']} | denotes whether this is a program-flowlet style application or a hydrator pipeline. For hydrator, this value must be 'hydrator-pipeline'
        dependencies | No | array of :ref:`hydratordep <d_c5aa8c778f283571705fbe7a21d0f5c7>` |  |  | represents a list of dependencies to be loaded for this pipeline. Not required.
        namespace | Yes | string |  |  | the cdap namespace this is deployed into
        pipeline_config_json_url | Yes | string |  |  | the URL of the config.json for this pipeline
        streamname | Yes | string |  |  | name of the CDAP stream to ingest data into this app. Should come from the developer and Tosca model.

.. _d_c5aa8c778f283571705fbe7a21d0f5c7:

hydratordep Model Structure
---------------------------

represents a hydrator pipeline dependency. An equivelent to the following CURLs are formed with the below four params shown in CAPS 'curl -v -w'\n' -X POST http://cdapurl:11015/v3/namespaces/setelsewhere/artifacts/ARTIFACT_NAME -H 'Artifact-Extends:ARTIFACT_EXTENDS_HEADER'  -H “Artifact-Version:ARTIFACT_VERSION_HEADER” --data-binary @(DOWNLOADED FROM ARTIFACT_URL)','curl -v -w'\n' -X PUT http://cdapurl:11015/v3/namespaces/setelsewhere/artifacts/ARTIFACT_NAME/versions/ARTIFACT_VERSION_HEADER/properties -d (DOWNLOADED FROM UI_PROPERTIES_URL)'

.. csv-table::
    :delim: |
    :header: "Name", "Required", "Type", "Format", "Properties", "Description"
    :widths: 20, 10, 15, 15, 30, 25

        artifact_extends_header | Yes | string |  |  | the value of the header that gets passed in for artifact-extends, e.g., 'Artifact-Extends:system:cdap-data-pipeline[4.0.1,5.0.0)'
        artifact_name | Yes | string |  |  | the name of the artifact
        artifact_url | Yes | string |  |  | the URL of the artifact JAR
        artifact_version_header | Yes | string |  |  | the value of the header that gets passed in for artifact-version, e.g., 'Artifact-Version:1.0.0-SNAPSHOT'
        ui_properties_url | No | string |  |  | the URL of the properties.json if the custom artifact has UI properties. This is optional.

.. _d_060ca512d6d771a97a7d0f50886f6b14:

info Model Structure
--------------------

some broker information

.. csv-table::
    :delim: |
    :header: "Name", "Required", "Type", "Format", "Properties", "Description"
    :widths: 20, 10, 15, 15, 30, 25

        broker API version | No | string |  |  | the API version of this running broker
        cdap GUI port | No | integer |  |  | The GUI port of the CDAP cluster this broker is managing. Mostly to help users of this API check their application in cdap. Note, will return UNKNOWN_CDAP_VERSION if it cannot be determined.
        cdap cluster version | No | string |  |  | the version of the CDAP cluster this broker is managing. Note, will return UKNOWN_CDAP_VERSION if it cannot be determined.
        managed cdap url | No | string |  |  | the url of the CDAP cluster API this broker is managing
        number of applications registered | No | integer |  |  | 
        uptime (s) | No | integer |  |  | 

.. _d_c0830b0f8b495da06c2fef152ce05dba:

multideleteput Model Structure
------------------------------

.. csv-table::
    :delim: |
    :header: "Name", "Required", "Type", "Format", "Properties", "Description"
    :widths: 20, 10, 15, 15, 30, 25

        appnames | No | array of :ref:`appname <d_2f6991f1775468c3ce48a2778455be93>` |  |  | 

.. _d_610742fa78204adc388d0f7fbe30ad61:

programpref Model Structure
---------------------------

the list of programs in this CDAP app

.. csv-table::
    :delim: |
    :header: "Name", "Required", "Type", "Format", "Properties", "Description"
    :widths: 20, 10, 15, 15, 30, 25

        program_id | No | string |  |  | the name of the program
        program_pref | No | :ref:`program_pref <i_07225a64d44b62a92699f22d603b563c>` |  |  | the preference JSON to set for this program
        program_type | No | string |  |  | must be one of flows, mapreduce, schedules, spark, workflows, workers, or services

.. _i_07225a64d44b62a92699f22d603b563c:

**Program_pref schema:**


the preference JSON to set for this program



.. _d_7bc8b39312a070aee5928f4e730192ae:

programs Model Structure
------------------------

the list of programs in this CDAP app

.. csv-table::
    :delim: |
    :header: "Name", "Required", "Type", "Format", "Properties", "Description"
    :widths: 20, 10, 15, 15, 30, 25

        program_id | No | string |  |  | the name of the program
        program_type | No | string |  |  | must be one of flows, mapreduce, schedules, spark, workflows, workers, or services

.. _d_2a32645bc6d3020744d3d17500c34bc3:

reconfigput Model Structure
---------------------------

.. csv-table::
    :delim: |
    :header: "Name", "Required", "Type", "Format", "Properties", "Description"
    :widths: 20, 10, 15, 15, 30, 25

        config | Yes | :ref:`config <i_6a9d9951a40bf655fda365aa310e1ddc>` |  |  | the config JSON
        reconfiguration_type | Yes | string |  | {'enum': ['program-flowlet-app-config', 'program-flowlet-app-preferences', 'program-flowlet-smart']} | the type of reconfiguration

.. _i_6a9d9951a40bf655fda365aa310e1ddc:

**Config schema:**


the config JSON



.. _d_5a28f16eed72be7d9a8279c0e1f05386:

returncode Model Structure
--------------------------

an httpreturncode

.. csv-table::
    :delim: |
    :header: "Name", "Required", "Type", "Format", "Properties", "Description"
    :widths: 20, 10, 15, 15, 30, 25

        returncode | No | integer |  |  | an httpreturncode

.. _d_ad781f0dd64e16123fc1cbfefb4b9ded:

service_endpoint Model Structure
--------------------------------

descirbes a service endpoint, including the service name, the method name, and the method type (GET, PUT, etc, most of the time will be GET)

.. csv-table::
    :delim: |
    :header: "Name", "Required", "Type", "Format", "Properties", "Description"
    :widths: 20, 10, 15, 15, 30, 25

        endpoint_method | No | string |  |  | GET, POST, PUT, etc
        service_endpoint | No | string |  |  | the name of the endpoint on the service
        service_name | No | string |  |  | the name of the service

.. _d_e5edc5fd82a1190817cf350e70cb7e0e:

service_method Model Structure
------------------------------

a URL and HTTP method exposed via a CDAP service

.. csv-table::
    :delim: |
    :header: "Name", "Required", "Type", "Format", "Properties", "Description"
    :widths: 20, 10, 15, 15, 30, 25

        method | No | string |  |  | HTTP method you can perform on the URL, e.g., GET, PUT, etc
        url | No | string |  |  | the fully qualified URL in CDAP for this service

