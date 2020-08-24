.. This work is licensed under a Creative Commons Attribution 4.0 International License.
.. http://creativecommons.org/licenses/by/4.0

StndDefined Events Collection Mechanisms
========================================

Description
-----------

This mechanism can be used to validate any JSON content incoming as JsonNode. When building the validator, is mapping
of externally located schemas to local schema files.

Validated JSON must have one field that will refer to an external schema, which will be mapped to local file and then
validation of any chosen part of JSON is executed using local schema.

Mapping file is cached on validator creation, so it's not read every time validation is performed.
Schemas' content couldn't be cached due to an external library restrictions (OpenAPI4j).

StndDefined properties
----------------------

There are 5 additional properties related to stndDefined validation in collector.properties file.

+----------------------------------------------+--------------------------------------------------------------------------------+--------------------------------------------------------------------------------+-------------------------------------------------------------------------------+
| Name                                         | Description                                                                    | Example                                                                        | Note                                                                          |
+==============================================+================================================================================+================================================================================+===============================================================================+
| collector.externalSchema.checkflag           | Flag is responsible for turning on/off stndDefined data validation.            | -1 or 1                                                                        |                                                                               |
|                                              | By default this flag is set to 1, which means that the validation is enabled.  |                                                                                |                                                                               |
|                                              | In case flag is set to -1, validation is disabled.                             |                                                                                |                                                                               |
+----------------------------------------------+--------------------------------------------------------------------------------+--------------------------------------------------------------------------------+-------------------------------------------------------------------------------+
| collector.externalSchema.mappingFileLocation | This should be a local filesystem path to file with mappings of public URLs    | etc/externalRepo/schema-map.json                                               |                                                                               |
|                                              | to local URLs.                                                                 |                                                                                |                                                                               |
+----------------------------------------------+--------------------------------------------------------------------------------+--------------------------------------------------------------------------------+-------------------------------------------------------------------------------+
| collector.externalSchema.schemasLocation     | Schemas location is a directory under which stndDefined validator will search  | ./etc/externalRepo/ and first mapping from example mappingFile below is taken, |                                                                               |
|                                              | for local schemas.                                                             | validator will look for schema under the path:                                 |                                                                               |
|                                              |                                                                                | ./etc/externalRepo/3gpp/rep/sa5/data-models/blob/REL-16/OpenAPI/faultMnS.yaml  |                                                                               |
+----------------------------------------------+--------------------------------------------------------------------------------+--------------------------------------------------------------------------------+-------------------------------------------------------------------------------+
| event.externalSchema.schemaRefPath           | This is an internal path from validated JSON. It should define which field     | /event/stndDefinedFields/schemaReference                                       | In SDK version 1.4.2 this path doesn’t use JSON path notation (with . signs). |
|                                              | will be taken as public schema reference, which is later mapped.               |                                                                                | It might change in further versions                                           |
+----------------------------------------------+--------------------------------------------------------------------------------+--------------------------------------------------------------------------------+-------------------------------------------------------------------------------+
| event.externalSchema.stndDefinedDataPath     | This is internal path from validated JSON.                                     | /event/stndDefinedFields/data                                                  | In SDK version 1.4.2 this path doesn’t use JSON path notation (with . signs). |
|                                              | It should define which field will be validated.                                |                                                                                | It might change in further versions                                           |
+----------------------------------------------+--------------------------------------------------------------------------------+--------------------------------------------------------------------------------+-------------------------------------------------------------------------------+

Format of the schema mapping file is a JSON file with list of mappings, as shown in the example below.

.. code-block:: json

    [
        {
            "publicURL": "https://forge.3gpp.org/rep/sa5/data-models/blob/REL-16/OpenAPI/faultMnS.yaml",
            "localURL": "3gpp/rep/sa5/data-models/blob/REL-16/OpenAPI/faultMnS.yaml"
        },
        {
            "publicURL": "https://forge.3gpp.org/rep/sa5/data-models/blob/REL-16/OpenAPI/heartbeatNtf.yaml",
            "localURL": "3gpp/rep/sa5/data-models/blob/REL-16/OpenAPI/heartbeatNtf.yaml"
        },
        {
            "publicURL": "https://forge.3gpp.org/rep/sa5/data-models/blob/REL-16/OpenAPI/PerDataFileReportMnS.yaml",
            "localURL": "3gpp/rep/sa5/data-models/blob/REL-16/OpenAPI/PerDataFileReportMnS.yaml"
        },
        {
            "publicURL": "https://forge.3gpp.org/rep/sa5/data-models/blob/master/OpenAPI/provMnS.yaml",
            "localURL": "3gpp/rep/sa5/data-models/blob/REL-16/OpenAPI/provMnS.yaml"
        }
    ]


Requirements for stndDefined validation
---------------------------------------

To run stndDefined validation, both *collector.schema.checkflag* and *collector.externalSchema.checkflag* must be set to 1.

Despite the flag set, the validation will not start when field of event referenced under the property *event.externalSchema.schemaRefPath* (by default */event/stndDefinedFields/schemaReference*):
    - Has an empty value.
    - Does not exist in the incoming event.

Validation scenarios
--------------------

Positive scenario, which returns 202 Accepted HTTP code after successful stndDefined validation:

- *collector.schema.checkflag* and *collector.externalSchema.checkflag* is set to 1
- Mapping file has valid format
- Schema file mapped from referenced in the event is valid
- The incoming event is valid against schema

Below are scenarios when, the stndDefined validation will end with failure and return 400 Bad Request HTTP code:

- One of stndDefined data fields has wrong type or value
- StndDefined data has an empty body or is missing required field
- Field of event referenced under the property event.externalSchema.schemaRefPath has publicURL which is not mapped in the schemas mappings
- Field defining public schema in event (by default */event/stndDefinedFields/schemaReference*) after "#" has non existing reference in schema file

Schemas repository description
------------------------------

Schemas and mapping file location might be configured to any local directory through properties in collector.properties
as described in 'StndDefined properties' section.

By default schemas repository is located under *etc/externalSchema* directory, as well as schemas mapping file called
*schema-map.json*. There are files stored in the project repository which are schemas from 3GPP organisation. Every
organisation which adds or mounts external schemas should store them in folder named by organisation
name. Further folders structure may be whatever as long as schemas are correctly referenced in the mapping file.

Sample directory tree of *etc* directory:

.. code-block:: text

    etc
    ├── ...
    └── externalRepo
        ├── schema-map.json
        └── 3gpp
            └── rep
                └── sa5
                    └── data-models
                        └── blob
                            └── REL-16
                                └── OpenAPI
                                    ├── faultMnS.yaml
                                    ├── heartbeatNtf.yaml
                                    ├── PerDataFileReportMnS.yaml
                                    └── provMnS.yaml

Routing of stndDefined domain events
------------------------------------

All events, expect those with 'stndDefined' domain, are routed to DMaaP topics basing on domain value. Events with
'stndDefined' domain are sent to proper topic basing on field 'stndDefinedNamespace'.

This is the only difference from standard event routing, specific for 'stndDefined' domain. As in every other event
routing value is being mapped for specific DMaaP stream. Stream ID to DMaaP channels mappings are located in
*etc/collector.properties* file under property *collector.dmaap.streamid*. Channels descriptions are in
*etc/DmaapConfig.json*, where destination DMaaP topics are selected.

With stndDefined domain managment 4 new mappings were added. Their routing has been described in the table below:

    +---------------------------+--------------------------------+----------------------------------------------------------------------+
    | Stream ID                 | Channel                        | DMaaP Stream                                                         |
    +===========================+================================+======================================================================+
    | 3GPP-FaultSupervision     | ves-3gpp-fault-supervision     | unauthenticated.SEC_3GPP_FAULTSUPERVISION_OUTPUT                     |
    +---------------------------+--------------------------------+----------------------------------------------------------------------+
    | 3GPP-Heartbeat            | ves-3gpp-heartbeat             | unauthenticated.SEC_3GPP_HEARTBEAT_OUTPUT                            |
    +---------------------------+--------------------------------+----------------------------------------------------------------------+
    | 3GPP-Provisioning         | ves-3gpp-provisioning          | unauthenticated.SEC_3GPP_PROVISIONING_OUTPUT                         |
    +---------------------------+--------------------------------+----------------------------------------------------------------------+
    | 3GPP-PerformanceAssurance | ves-3gpp-performance-assurance | unauthenticated.unauthenticated.SEC_3GPP_PERFORMANCEASSURANCE_OUTPUT |
    +---------------------------+--------------------------------+----------------------------------------------------------------------+


Error scenarios behaviour
----------------------------

There are few error scenarios described in 'Validation scenarios' section. This section will describe user point of view
of VES Collector behaviour when they happen. Messages returned as HTTP response contain data described below for each
scenario.

1. Problems with routing of stndDefined domain.

1.1. stndDefinedNamespace field not received in the incoming event.

    +---------------------+-----------------------------------------------------+
    | Property Name       | Property Description                                |
    +=====================+=====================================================+
    | MessageId           | SVC2006                                             |
    +---------------------+-----------------------------------------------------+
    | Text                | Mandatory input %1 %2 is missing from request       |
    +---------------------+-----------------------------------------------------+
    | Variables           | %1 – “attribute”                                    |
    |                     | %2 – "event.commonEventHeader.stndDefinedNamespace" |
    +---------------------+-----------------------------------------------------+
    | HTTP status code(s) | 400 Bad Request                                     |
    +---------------------+-----------------------------------------------------+

1.2. stndDefinedNamespace field present, but value is empty.

    +---------------------+-----------------------------------------------------+
    | Property Name       | Property Description                                |
    +=====================+=====================================================+
    | MessageId           | SVC2006                                             |
    +---------------------+-----------------------------------------------------+
    | Text                | Mandatory input %1 %2 is empty in request           |
    +---------------------+-----------------------------------------------------+
    | Variables           | %1 – “attribute”                                    |
    |                     | %2 – "event.commonEventHeader.stndDefinedNamespace" |
    +---------------------+-----------------------------------------------------+
    | HTTP status code(s) | 400 Bad Request                                     |
    +---------------------+-----------------------------------------------------+

1.3. stndDefinedNamespace field present, but value doesn`t match any stream ID mapping.

    +---------------------+-------------------------------------------------------------------------------------------------------------------------------------------+
    | Property Name       | Property Description                                                                                                                      |
    +=====================+===========================================================================================================================================+
    | MessageId           | SVC2004                                                                                                                                   |
    +---------------------+-------------------------------------------------------------------------------------------------------------------------------------------+
    | Text                | "Invalid input value for %1 %2: %3"                                                                                                       |
    +---------------------+-------------------------------------------------------------------------------------------------------------------------------------------+
    | Variables           | %1 – “attribute”                                                                                                                          |
    |                     | %2 – "event.commonEventHeader.stndDefinedNamespace"                                                                                       |
    |                     | %3 – "stndDefinedNamespace received not present in VES Collector routing configuration. Unable to route event to appropriate DMaaP topic" |
    +---------------------+-------------------------------------------------------------------------------------------------------------------------------------------+
    | HTTP status code(s) | 400 Bad request                                                                                                                           |
    +---------------------+-------------------------------------------------------------------------------------------------------------------------------------------+

2. StndDefined fields validation related errors

2.1. Schema file referred event under path from property event.externalSchema.schemaRefPath (by default /event/stndDefinedFields/schemaReference) not present in the schema repository.

    +---------------------+------------------------------------------------------------------+
    | Property Name       | Property Description                                             |
    +=====================+==================================================================+
    | MessageId           | SVC2004                                                          |
    +---------------------+------------------------------------------------------------------+
    | Text                | "Invalid input value for %1 %2: %3"                              |
    +---------------------+------------------------------------------------------------------+
    | Variables           | %1 – “attribute”                                                 |
    |                     | %2 – "event.stndDefinedFields.schemaReference"                   |
    |                     | %3 – "Referred external schema not present in schema repository" |
    +---------------------+------------------------------------------------------------------+
    | HTTP status code(s) | 400 Bad request                                                  |
    +---------------------+------------------------------------------------------------------+

2.2. stndDefined validation executed, but event contents do not validate with referenced schema.

    +---------------------+---------------------------------------------------------------------------------------------+
    | Property Name       | Property Description                                                                        |
    +=====================+=============================================================================================+
    | MessageId           | SVC2000                                                                                     |
    +---------------------+---------------------------------------------------------------------------------------------+
    | Text                | The following service error occurred: %1. Error code is %2                                  |
    +---------------------+---------------------------------------------------------------------------------------------+
    | Variables           | %1 - "event.stndDefinedFields.data invalid against event.stndDefinedFields.schemaReference" |
    |                     | %2 - "400"                                                                                  |
    +---------------------+---------------------------------------------------------------------------------------------+
    | HTTP status code(s) | 400 Bad request                                                                             |
    +---------------------+---------------------------------------------------------------------------------------------+
