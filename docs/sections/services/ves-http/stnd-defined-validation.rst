.. This work is licensed under a Creative Commons Attribution 4.0 International License.
.. http://creativecommons.org/licenses/by/4.0

StndDefined Events Collection Mechanism
=======================================

Description
-----------

The target of that development was to allow collection of events defined by standards organizations using VES Collector,
and providing them for consumption by analytics applications running on top of DCAE platform. The following features
have been implemented:

- Event routing, based on a new CommonHeader field "stndDefinedNamespace"
- Standards-organization defined events can be included using a dedicated stndDefinedFields.data property
- Standards-defined events can be validated using openAPI descriptions provided by standards organizations, and indicated in stndDefinedFields.schemaReference

StndDefined properties
----------------------

There are 5 additional properties related to stndDefined validation in collector.properties file.

+----------------------------------------------+--------------------------------------------------------------------------------+------------------------------------------------------------------------------------------------------+
| Name                                         | Description                                                                    | Example                                                                                              |
+==============================================+================================================================================+======================================================================================================+
| collector.externalSchema.checkflag           | Flag is responsible for turning on/off stndDefined data validation.            | -1 or 1                                                                                              |
|                                              | By default this flag is set to 1, which means that the validation is enabled.  |                                                                                                      |
|                                              | In case flag is set to -1, validation is disabled.                             |                                                                                                      |
+----------------------------------------------+--------------------------------------------------------------------------------+------------------------------------------------------------------------------------------------------+
| collector.externalSchema.mappingFileLocation | This should be a local filesystem path to file with mappings of public URLs    | /opt/app/VESCollector/etc/externalRepo/schema-map.json                                               |
|                                              | to local URLs.                                                                 |                                                                                                      |
+----------------------------------------------+--------------------------------------------------------------------------------+------------------------------------------------------------------------------------------------------+
| collector.externalSchema.schemasLocation     | Schemas location is a directory context for localURL paths set in mapping file.| /opt/app/VESCollector/etc/externalRepo/ ,                                                            |
|                                              | Result path of schema is collector.externalSchema.schemasLocation + localURL.  | when first mapping from example mapping file below this table is taken, validator will look for      |
|                                              | This path is not related to mapping file path and may point to any location.   | schema under the path:                                                                               |
|                                              |                                                                                | /opt/app/VESCollector/etc/externalRepo/3gpp/rep/sa5/data-models/blob/REL-16/OpenAPI/faultMnS.yaml    |
+----------------------------------------------+--------------------------------------------------------------------------------+------------------------------------------------------------------------------------------------------+
| event.externalSchema.schemaRefPath           | This is an internal path from validated JSON. It should define which field     | $.event.stndDefinedFields.schemaReference                                                            |
|                                              | will be taken as public schema reference, which is later mapped.               |                                                                                                      |
+----------------------------------------------+--------------------------------------------------------------------------------+------------------------------------------------------------------------------------------------------+
| event.externalSchema.stndDefinedDataPath     | This is internal path from validated JSON.                                     | $.event.stndDefinedFields.data                                                                       |
|                                              | It should define which field will be validated.                                |                                                                                                      |
+----------------------------------------------+--------------------------------------------------------------------------------+------------------------------------------------------------------------------------------------------+

Format of the schema mapping file is a JSON file with list of mappings, as shown in the example below.

.. code-block:: json

    [
      {
        "publicURL": "https://forge.3gpp.org/rep/sa5/MnS/blob/SA88-Rel16/OpenAPI/faultMnS.yaml",
        "localURL": "3gpp/rep/sa5/MnS/blob/SA88-Rel16/OpenAPI/faultMnS.yaml"
      },
      {
        "publicURL": "https://forge.3gpp.org/rep/sa5/MnS/blob/SA88-Rel16/OpenAPI/heartbeatNtf.yaml",
        "localURL": "3gpp/rep/sa5/MnS/blob/SA88-Rel16/OpenAPI/heartbeatNtf.yaml"
      },
      {
        "publicURL": "https://forge.3gpp.org/rep/sa5/MnS/blob/SA88-Rel16/OpenAPI/PerDataFileReportMnS.yaml",
        "localURL": "3gpp/rep/sa5/MnS/blob/SA88-Rel16/OpenAPI/PerDataFileReportMnS.yaml"
      },
      {
        "publicURL": "https://forge.3gpp.org/rep/sa5/MnS/blob/SA88-Rel16/OpenAPI/provMnS.yaml",
        "localURL": "3gpp/rep/sa5/MnS/blob/SA88-Rel16/OpenAPI/provMnS.yaml"
      }
    ]

External schema config maps
---------------------------

The mapping and schema files content can be changed by editing a proper config map.


+----------------------------------------------+-----------------------------------------------------------------------------------------------------+
| Config map name                              | Description                                                                                         |
+==============================================+=====================================================================================================+
| dcae-external-repo-configmap-schema-map      | Defines a content of the /opt/app/VESCollector/etc/externalRepo/schema-map.json file.               |
+----------------------------------------------+-----------------------------------------------------------------------------------------------------+
| dcae-external-repo-configmap-sa88-rel16      | Defines a content of schemas stored in the /opt/app/VESCollector/etc/externalRepo folder.           |
+----------------------------------------------+-----------------------------------------------------------------------------------------------------+

Config maps are defined in the `OOM <https://gerrit.onap.org/r/gitweb?p=oom.git;a=tree;f=kubernetes/dcaegen2-services/resources/external>`_ repository
and are installed with dcaegen2-services module.


Properties configuration via Helm chart overrides
-------------------------------------------------

Collector.properties content may be overridden when deploying VES Collector via Helm chart. In case of deploying VES using Helm chart,
a config map "dcae-ves-collector-application-config-configmap" with the application_config.yaml file is created. The application_config.yaml
contains properties, that override values from Collector.properties. In order to change any value, it is sufficient to edit the application_config.yaml
in the config map. The VES application frequently reads the configMap content and applies configuration changes.

The content of "dcae-ves-collector-application-config-configmap" is defined in the values.yaml of the dcae-ves-collector chart
and is installed with dcaegen2-services module.

The following table shows stndDefined related properties added to VES Collector Helm chart. These properties
represent fields from collector.properties file, but also contain configuration of DMaaP topic URLs used for stndDefined
events routing.

**NOTE**: Keep in mind that some properties may use relative path. It is relative to default VES Collector context which
is: */opt/app/VESCollector/*. Final path of etc. *collector.externalSchema.schemasLocation* will be:
*/opt/app/VESCollector/etc/externalRepo/*. Setting absolute path to these properties is also acceptable and won't
generate error.

+-----------------------------------------------------------------------------+---------+---------------------------------------------------------------------------------------------------------------+
| Property name                                                               | Type    | Default value                                                                                                 |
+=============================================================================+=========+===============================================================================================================+
| collector.externalSchema.checkflag                                          | Integer | 1                                                                                                             |
+-----------------------------------------------------------------------------+---------+---------------------------------------------------------------------------------------------------------------+
| collector.externalSchema.mappingFileLocation                                | String  | ./etc/externalRepo/schema-map.json                                                                            |
+-----------------------------------------------------------------------------+---------+---------------------------------------------------------------------------------------------------------------+
| collector.externalSchema.schemasLocation                                    | String  | ./etc/externalRepo/                                                                                           |
+-----------------------------------------------------------------------------+---------+---------------------------------------------------------------------------------------------------------------+
| event.externalSchema.schemaRefPath                                          | String  | $.event.stndDefinedFields.schemaReference                                                                     |
+-----------------------------------------------------------------------------+---------+---------------------------------------------------------------------------------------------------------------+
| event.externalSchema.stndDefinedDataPath                                    | String  | $.event.stndDefinedFields.data                                                                                |
+-----------------------------------------------------------------------------+---------+---------------------------------------------------------------------------------------------------------------+
| streams_publishes.ves-3gpp-fault-supervision.dmaap_info.topic_url           | String  | http://message-router.onap.svc.cluster.local:3904/events/unauthenticated.SEC_3GPP_FAULTSUPERVISION_OUTPUT     |
+-----------------------------------------------------------------------------+---------+---------------------------------------------------------------------------------------------------------------+
| streams_publishes.ves-3gpp-provisioning.dmaap_info.topic_url                | String  | http://message-router.onap.svc.cluster.local:3904/events/unauthenticated.SEC_3GPP_PROVISIONING_OUTPUT         |
+-----------------------------------------------------------------------------+---------+---------------------------------------------------------------------------------------------------------------+
| streams_publishes.ves-3gpp-heartbeat.dmaap_info.topic_url                   | String  | http://message-router.onap.svc.cluster.local:3904/events/unauthenticated.SEC_3GPP_HEARTBEAT_OUTPUT            |
+-----------------------------------------------------------------------------+---------+---------------------------------------------------------------------------------------------------------------+
| streams_publishes.ves-3gpp-performance-assurance.dmaap_info.topic_url       | String  | http://message-router.onap.svc.cluster.local:3904/events/unauthenticated.SEC_3GPP_PERFORMANCEASSURANCE_OUTPUT |
+-----------------------------------------------------------------------------+---------+---------------------------------------------------------------------------------------------------------------+

Validation overview
-------------------

This mechanism can be used to validate any JSON content incoming as JsonNode using OpenAPI standardized schemas.
During validation externally located schemas are mapped to local schema files.

Validated JSON must have one field that will refer to an external schema, which will be mapped to local file and then
validation of any chosen part of JSON is executed using local schema.

StndDefined validation is integrated with the event collecting functionality available under the endpoint
*/eventListener/v7*. Process of event collecting includes steps in the following order:

1. General event validation (1st stage validation)
2. Event transformation
3. **StndDefined event validation** (2nd stage validation)
4. Event routing to DMaaP

Mapping file is cached on stndDefined validator creation, so it's not read every time validation is performed.
Schemas' content couldn't be cached due to an external library restrictions (OpenAPI4j).

The value of the 'stndDefinedNamespace' field in any incoming stndDefined JSON event is used to match the topic from
property *collector.dmaap.streamid*.

Requirements for stndDefined validation
---------------------------------------

To run stndDefined validation, both *collector.schema.checkflag* and *collector.externalSchema.checkflag* must be set to 1.

Despite the flag set, the validation will not start when:

- Domain of the incoming event is not 'stndDefined'.
- General event validation (1st stage) failed.
- Field of event referenced under the property *event.externalSchema.schemaRefPath* (by default */event/stndDefinedFields/schemaReference*):
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

Schema repository description
-----------------------------

Schemas and mapping file location might be configured to any local directory through properties in collector.properties
as described in 'StndDefined properties' section.

By default schemas repository is located under */opt/app/VESCollector/etc/externalSchema* directory, as well as schemas mapping file called
*schema-map.json*. Every organisation which adds or mounts external schemas should store them in folder named by
organisation name. Further folders structure may be whatever as long as schemas are correctly referenced in the mapping
file.

Sample directory tree of */opt/app/VESCollector/etc* directory:

.. code-block:: text

    /opt/app/VESCollector/etc
    ├── ...
    └── externalRepo
        ├── schema-map.json
        └── 3gpp
            └── rep
                └── sa5
                    └── MnS
                        └── blob
                            └── SA88-Rel16
                                └── OpenAPI
                                    ├── faultMnS.yaml
                                    ├── heartbeatNtf.yaml
                                    ├── PerDataFileReportMnS.yaml
                                    └── provMnS.yaml

Routing of stndDefined domain events
------------------------------------

All events, except those with 'stndDefined' domain, are routed to DMaaP topics based on domain value. Events with
'stndDefined' domain are sent to proper topic basing on field 'stndDefinedNamespace'.

This is the only difference from standard event routing, specific for 'stndDefined' domain. As in every other event
routing value is being mapped for specific DMaaP stream. Stream ID to DMaaP channels mappings are located in
*/opt/app/VESCollector/etc/collector.properties* file under property *collector.dmaap.streamid*. Channels descriptions are in
*/opt/app/VESCollector/etc/DmaapConfig.json*, where destination DMaaP topics are selected.

With stndDefined domain managment 4 new mappings were added. Their routing has been described in the table below:

    +---------------------------+--------------------------------+------------------------------------------------------+
    | Stream ID                 | Channel                        | DMaaP Stream                                         |
    +===========================+================================+======================================================+
    | 3GPP-FaultSupervision     | ves-3gpp-fault-supervision     | unauthenticated.SEC_3GPP_FAULTSUPERVISION_OUTPUT     |
    +---------------------------+--------------------------------+------------------------------------------------------+
    | 3GPP-Heartbeat            | ves-3gpp-heartbeat             | unauthenticated.SEC_3GPP_HEARTBEAT_OUTPUT            |
    +---------------------------+--------------------------------+------------------------------------------------------+
    | 3GPP-Provisioning         | ves-3gpp-provisioning          | unauthenticated.SEC_3GPP_PROVISIONING_OUTPUT         |
    +---------------------------+--------------------------------+------------------------------------------------------+
    | 3GPP-PerformanceAssurance | ves-3gpp-performance-assurance | unauthenticated.SEC_3GPP_PERFORMANCEASSURANCE_OUTPUT |
    +---------------------------+--------------------------------+------------------------------------------------------+


Error scenarios behaviour
-------------------------

There are few error scenarios described in 'Validation scenarios' section. This section will describe user point of view
of VES Collector behaviour when they happen. Messages returned as HTTP response contain data described below for each
scenario.

1. StndDefined fields validation related errors

1.1. Schema file referred under the path from property *event.externalSchema.schemaRefPath* (by default */event/stndDefinedFields/schemaReference*) not present in the schema repository.

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

1.2. File referred under the path from property *event.externalSchema.schemaRefPath* (by default */event/stndDefinedFields/schemaReference*) exists, but internal reference (part of URL after #) is incorrect.

    +---------------------+-----------------------------------------------------------------------------------------------------------------------------------+
    | Property Name       | Property Description                                                                                                              |
    +=====================+===================================================================================================================================+
    | MessageId           | SVC2000                                                                                                                           |
    +---------------------+-----------------------------------------------------------------------------------------------------------------------------------+
    | Text                | The following service error occurred: %1. Error code is %2                                                                        |
    +---------------------+-----------------------------------------------------------------------------------------------------------------------------------+
    | Variables           | %1 - "event.stndDefinedFields.schemaReference value does not correspond to any external event schema file in externalSchema repo" |
    |                     | %2 - "400"                                                                                                                        |
    +---------------------+-----------------------------------------------------------------------------------------------------------------------------------+
    | HTTP status code(s) | 400 Bad request                                                                                                                   |
    +---------------------+-----------------------------------------------------------------------------------------------------------------------------------+

1.3. StndDefined validation executed, but event contents do not validate with referenced schema.

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

2. Problems with routing of stndDefined domain.

2.1. StndDefinedNamespace field not received in the incoming event.

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

2.2. StndDefinedNamespace field present, but value is empty.

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

2.3. StndDefinedNamespace field present, but value doesn't match any stream ID mapping.

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



