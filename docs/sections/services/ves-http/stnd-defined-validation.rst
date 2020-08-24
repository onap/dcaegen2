.. This work is licensed under a Creative Commons Attribution 4.0 International License.
.. http://creativecommons.org/licenses/by/4.0

StndDefined Events Collection Mechanisms
============

.. toctree::
    :depth: 3

description
-----------

This mechanism can be used to validate any JSON content incoming as JsonNode. When building the validator, is mapping
of externally located schemas to local schema files.

Validated JSON must have one field that will refer to an external schema, which will be mapped to local file and then
validation of any chosen part of JSON is executed using local schema.

Mapping file is cached on validator creation, so it's not read every time validation is performed.
Schemas' content couldn't be cached due to external library restrictions (OpenAPI4j).

new-properties
---------------

There are 5 new properties.
- collector.externalSchema.checkflag: flag is responsible for on/off stndDefined data validation. By default this flag
is set 1, which means that the validation is enabled. In case flag is set to -1, validation is disabled.

- collector.externalSchema.mappingFileLocation: this should be a local filesystem path to file with mappings of public URLs to local URLs.
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

- collector.externalSchema.schemasLocation: schemas path is a directory under which external-schema-manager will search for local schemas.
For example, when this parameter is set to: "./etc/externalRepo/" and first mapping from example mappingFile is taken,
validator will look for schema under the path:
./etc/externalRepo/3gpp/rep/sa5/data-models/blob/REL-16/OpenAPI/faultMnS.yaml

- event.externalSchema.schemaRefPath: this is an internal path from validated JSON. It should define which field will be taken as public
schema reference, which is later mapped. Example: "/event/stndDefinedFields/schemaReference".

NOTE: in SDK version 1.4.2 this path doesn't use JSON path notation (with . signs). It might change in further versions.

- event.externalSchema.stndDefinedDataPath: this is internal path from validated JSON. It should define which field will be validated.
Example: "/event/stndDefinedFields/data".

conditions-to-run-stndDefined-validation
-----------------------------------------

To run stndDefined validation, collector.externalSchema.checkflag should be set to 1.

Below are the cases when, despite the flag set, the validation will not start:

- When field "/event/stndDefinedFields/schemaReference" has an empty value

- When field "/event/stndDefinedFields/schemaReference" does not exist in incoming event

scenarios-with-stndDefined-validation
---------------------------------

When collector.externalSchema.checkflag is set to 1, schema-map.json has valid format, schema file mapped from
"/event/stndDefinedFields/schemaReference" is valid and the incoming event is valid against schema, validation
will end as successful

Below are scenarios when, the stndDefined validation will end as failure:

- One of stndDefined data fields has wrong type

- StndDefined data has an empty body

- Field "/event/stndDefinedFields/schemaReference" has incorrect publicURL

- Field "/event/stndDefinedFields/schemaReference" after "#" has non existing reference in schema file


