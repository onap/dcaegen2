.. This work is licensed under a Creative Commons Attribution 4.0 International License.
.. http://creativecommons.org/licenses/by/4.0

.. _data-formats:


Data Formats
============

Data formats are descriptions of data; they are the data contract
between your component and other components. When the components are
‘composed’ into services in the SDC tool, they can only be matched with
components that have compatible data formats. Data formats will be
onboarded to SDC and assigned a UUID at that time. This UUID is then
used to ensure compatibility amoung components. (If component X outputs
data format ‘DF-Y’, and another component Z specifies ‘DF-Y’ as its
input data format, then X is said to be ``composable`` with component
Z).

Since data formats will be shared across components, the onboarding
catalog should be checked first to see if the desired data format is
available before creating one. The vision is to have a repository of
shared data formats that developers and teams can re-use and also
provide them the means to extend and create new custom data formats. A
data format is referenced by its data format id and version number.

JSON schema
-----------

  The data format specification is represented (and validated) against
  this `Data Format json schema <https://gerrit.onap.org/r/gitweb?p=dcaegen2/platform/cli.git;a=blob;f=component-json-schemas/data-format/dcae-cli-v1/data-format-schema.json;h=66aa2ab77449e3cafc6afb5c959c5eb793ad86c1;hb=HEAD>`__
  and described below:

Meta Schema Definition
~~~~~~~~~~~~~~~~~~~~~~

The “Meta Schema” implementation defines how data format JSON schemas
can be written to define user input. It is itself a JSON schema (thus it
is a “meta schema”). It requires the name of the data format entry, the
data format entry version and allows a description under “self” object.
The meta schema version must be specified as the value of the
“dataformatversion” key. Then the input schema itself is described as
one of the four types listed below:

+------------------+---------------------------------------------------+
| Type             | Description                                       |
+==================+===================================================+
| jsonschema       | inline standard JSON Schema definitions of JSON   |
|                  | inputs                                            |
+------------------+---------------------------------------------------+
| delimitedschema  | delimited data input using a JSON description and |
|                  | defined delimiter                                 |
+------------------+---------------------------------------------------+
| unstructured     | unstructured text, and reference that allows a    |
|                  | pointer to another artifact for a schema.         |
+------------------+---------------------------------------------------+
| reference        | allows for XML and Protocol Buffers schema,       |
|                  | but can be used to reference other JSON,          |
|                  | delimitedschema and unstructured schemas as well. |
+------------------+---------------------------------------------------+


Example Schemas
---------------

By reference example - Common Event Format 
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

First the full JSON schema description of the Common Event Format would
be loaded with a name of “Common Event Format” and the current version
of “25.0.0”.

Then the data format description is loaded by this schema:

::

    {
        "self": {
            "name": "Common Event Format Definition",
            "version": "25.0.0",
            "description": "Common Event Format Definition"
     
        },
        "dataformatversion": "1.0.0",
        "reference": {
            "name": "Common Event Format",
            "format": "JSON",
            "version": "25.0.0"
       }
    }



Simple JSON Example
~~~~~~~~~~~~~~~~~~~~~~~~


::

    {
        "self": {
            "name": "Simple JSON Example",
            "version": "1.0.0",
            "description": "An example of unnested JSON schema for Input and output"
    
        },
        "dataformatversion": "1.0.0",
        "jsonschema": {
            "$schema": "http://json-schema.org/draft-04/schema#",
            "type": "object",
            "properties": {
                "raw-text": {
                    "type": "string"
                }
            },
            "required": ["raw-text"],
            "additionalProperties": false
        }
    }

Nested JSON Example
~~~~~~~~~~~~~~~~~~~~~~~~

::

    {
        "self": {
            "name": "Nested JSON Example",
            "version": "1.0.0",
            "description": "An example of nested JSON schema for Input and output"
    
        },
        "dataformatversion": "1.0.0",
        "jsonschema": {
            "$schema": "http://json-schema.org/draft-04/schema#",
            "properties": {
                "numFound": {
                    "type": "integer"
                },
                "start": {
                    "type": "integer"
                },
                "engagements": {
                    "type": "array",
                    "items": {
                        "properties": {
                            "engagementID": {
                                "type": "string",
                                "transcript": {
                                    "type": "array",
                                    "items": {
                                        "type": {
                                            "type": "string"
                                        },
                                        "content": {
                                            "type": "string"
                                        },
                                        "senderName": {
                                            "type": "string"
                                        },
                                        "iso": {
                                            "type": "string"
                                        },
                                        "timestamp": {
                                            "type": "integer"
                                        },
                                        "senderId": {
                                            "type": "string"
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            },
            "additionalProperties": false
        }
    }

Unstructured Example
~~~~~~~~~~~~~~~~~~~~~~~~~

::

    {
        "self": {
            "name": "Unstructured Text Example",
            "version": "25.0.0",
            "description": "An example of a unstructured text used for both input and output for "
    
        },
        "dataformatversion": "1.0.0",
        "unstructured": {
            "encoding": "UTF-8"
        }
    }


An example of a delimited schema
--------------------------------

::

    {
        "self": {
            "name": "Delimited Format Example",
            "version": "1.0.0",
            "description": "Delimited format example just for testing"

        },
        "dataformatversion": "1.0.0",
        "delimitedschema": {
            "delimiter": "|",
            "fields": [{
                "name": "field1",
                "description": "test field1",
                "fieldtype": "string"
            }, {
                "name": "field2",
                "description": "test field2",
                "fieldtype": "boolean"
            }]
        }
    }

Note: The referenced data format (in this case, a schema named “Common
Event Format” with version of “25.0.0”) must already exist in the
onboarding catalog.

Working with Data Formats
-------------------------

Data Formats can be added to the onboarding catalog (which first
validates them) by using the :doc:`dcae_cli Tool <dcae-cli/quickstart/>`.
Here you can also list all of your data formats, show the contents of a
data format, publish your data format, and even generate a data format
from a input sample file. For a list of these capabilities, see :any:`Data Format Commands <dcae_cli_data_format>`.
