.. This work is licensed under a Creative Commons Attribution 4.0 International License.
.. http://creativecommons.org/licenses/by/4.0

.. _ves-openapi-manager-use-cases:

VES OpenAPI Manager use cases
=============================
The main VES OpenAPI Manager use case is to validate specific artifacts from distributed in SDC Services and return
validation result to user in SDC UI.

The general flow of VES OpenAPI Manager is available here :ref:`ves-openapi-manager-flow`.

Basing on the referenced flow, there are few possible behaviours of VES OpenAPI Manager. In this section two main flows:
successful and unsuccessful validation will be described step by step.

Validation requirements
-----------------------
Validation phase takes place only when specific conditions are met.

1) VES OpenAPI Manager is properly configured: client is connected to SDC and mapping file is present and pointed in configuration. Configuration is described in detail here: :ref:`ves-openapi-manager-deployment`.
2) Distribution of a Service takes place in SDC.
3) Service contains an *VES_EVENT* type artifact.
4) Artifact content is correctly downloaded.

Validation description
----------------------
When *schemaReference* field from artifact is being validated, only the part of the URI that indicates public file
location is taken into consideration.

For example when *schemaReference* with value
*https://forge.3gpp.org/rep/sa5/MnS/blob/SA88-Rel16/OpenAPI/faultMnS.yaml#/components/schemas/NotifyNewAlarm*
is found in artifact, then only the part before # sign (public file location URI part) is being validated. This way part
which is validated is *https://forge.3gpp.org/rep/sa5/MnS/blob/SA88-Rel16/OpenAPI/faultMnS.yaml*.

Mapping file must have a predefined JSON format of list of objects (mappings) with publicURL and localURL fields.
When *schemaReference* is split, it's compared to each publicURL from mapping file. If there is no publicURL in mapping
file which matches schemaReference, then schemaReference is marked as invalid. All invalid references are returned to
user via SDC UI after whole validation ends.

Basing on returned information with invalid references user can take action and e.g. add mappings and schemas to VES
Collector by editing ConfigMaps which store them.

+-----------------------------------------+-------------------------+
| ConfigMap name                          | Content                 |
+=========================================+=========================+
| dcae-external-repo-configmap-schema-map | Mapping file            |
+-----------------------------------------+-------------------------+
| dcae-external-repo-configmap-sa88-rel16 | OpenAPI schemas content |
+-----------------------------------------+-------------------------+


Successful validation case
--------------------------
There are two ways to get a successful validation status - *DEPLOY_OK*.

1) When artifact *VES_EVENT* does not contain *stndDefined* events definitions. Only *stndDefined* event are validated.
2) When artifact *VES_EVENT* contains *stndDefined* events definitions and each *schemaReference* of the event is present in the mapping file.

VES_EVENT artifact may contain more than one event definition. Examples of valid artifacts with single events are below.

Example of valid artifact without *stndDefined* event definition:

.. literalinclude:: resources/artifact-no-stndDefined.yaml
    :language: yaml

Example of artifact with *stndDefined* event definition:

.. literalinclude:: resources/artifact-stndDefined.yaml
    :language: yaml

which is valid when mapping file contains a mapping of schemaReference field.
Example of mapping file which makes example artifact valid:

.. literalinclude:: resources/schema-map-valid.json
    :language: json

Unsuccessful validation case
----------------------------
Another case is an unsuccessful validation case which sends status *DEPLOY_ERROR* with error message containing listed
*schemaReference* that are missing from mapping file. Fail case might occur:

1) When artifact *VES_EVENT* contains *stndDefined* events definitions and any of *schemaReference* is not present in mapping file.

Example of artifact with *stndDefined* event definition:

.. literalinclude:: resources/artifact-stndDefined.yaml
    :language: yaml

which is invalid when mapping file does not contain a mapping of schemaReference field.
Example of mapping file which makes example artifact invalid:

.. literalinclude:: resources/schema-map-invalid.json
    :language: json

Validation results
------------------
There are two ways to receive validation results.

1) Via SDC UI. Results are avaliable in *Service->Distributions* view. To see results in SDC UI user has to wait up to few minutes.
2) In VES OpenAPI Manager logs. They are printed right after validation.