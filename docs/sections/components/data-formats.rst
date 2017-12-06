.. This work is licensed under a Creative Commons Attribution 4.0 International License.
.. http://creativecommons.org/licenses/by/4.0

.. _data-formats:

Data Formats
============

| Because the DCAE designer composes your component with others at
  service design time, in most cases you do not know what specific
  component(s) your component will send data to during runtime. Thus, it
  is vital that DCAE has a language of describing the data passed
  between components, so that it is known which components are
  composable with others. Data formats are descriptions of data—they are
  the data contract between your component and other components. You
  need to describe the available outputs and assumed inputs of your
  components as data formats. These data descriptions are onboarded into
  ASDC, and each receives a UUID. If component X outputs data format
  DF-Y, and another component Z specifies DF-Y as their input data
  format, then X is said to be *composable* with that component. The
  data formats are referenced in the component specifications by the
  data format’s id and version.
| The vision is to have a repository of shared data formats that
  developers and teams can re-use and also provide them the means to
  extend and create new custom data formats.

.. _dataformat_metadata:

Meta Schema Definition
----------------------

The “Meta Schema” implementation defines how data format JSON schemas
can be written to define user input. It is itself a JSON schema (thus it
is a “meta schema”). It requires the name of the data format entry, the
data format entry version and allows a description under “self” object.
The meta schema version must be specified as the value of the
“dataformatversion” key. Then the input schema itself is described.
There are four types of schema descriptions objects - jsonschema for
inline standard JSON Schema definitions of JSON inputs, delimitedschema
for delimited data input using a defined JSON description, unstructured
for unstructured text, and reference that allows a pointer to another
artifact for a schema. The reference allows for XML schema, but can be
used as a pointer to JSON, Delimited Format, and Unstructured schemas as
well.

The current Meta Schema implementation is defined below:

::

    {
        "$schema": "http://json-schema.org/draft-04/schema#",
        "title": "Data format specification schema Version 1.0",
        "type": "object",
        "oneOf": [{
            "properties": {
                "self": {
                    "$ref": "#/definitions/self"
                },
                "dataformatversion": {
                    "$ref": "#/definitions/dataformatversion"
                },
                "reference": {
    
                    "type": "object",
                    "description": "A reference to an external schema - name/version is used to access the artifact",
                    "properties": {
                        "name": {
                            "$ref": "#/definitions/name"
                        },
                        "version": {
                            "$ref": "#/definitions/version"
                        },
                        "format": {
                            "$ref": "#/definitions/format"
                        }
                    },
                    "required": [
                        "name",
                        "version",
                        "format"
                    ],
                    "additionalProperties": false
                }
            },
            "required": ["self", "dataformatversion", "reference"],
            "additionalProperties": false
        }, {
            "properties": {
                "self": {
                    "$ref": "#/definitions/self"
                },
                "dataformatversion": {
                    "$ref": "#/definitions/dataformatversion"
                },
                "jsonschema": {
                    "$schema": "http://json-schema.org/draft-04/schema#",
                    "description": "The actual JSON schema for this data format"
                }
    
            },
            "required": ["self", "dataformatversion", "jsonschema"],
            "additionalProperties": false
        }, {
            "properties": {
                "self": {
                    "$ref": "#/definitions/self"
                },
                "dataformatversion": {
                    "$ref": "#/definitions/dataformatversion"
                },
                "delimitedschema": {
                    "type": "object",
                    "description": "A JSON schema for delimited files",
                    "properties": {
                        "delimiter": {
                            "enum": [",", "|", "\t", ";"]
                        },
                        "fields": {
                            "type": "array",
                            "description": "Array of field descriptions",
                            "items": {
                                "$ref": "#/definitions/field"
                            }
                        }
                    },
                    "additionalProperties": false
                }
            },
            "required": ["self", "dataformatversion", "delimitedschema"],
            "additionalProperties": false
        }, {
            "properties": {
                "self": {
                    "$ref": "#/definitions/self"
                },
                "dataformatversion": {
                    "$ref": "#/definitions/dataformatversion"
                },
                "unstructured": {
                    "type": "object",
                    "description": "A JSON schema for unstructured text",
                    "properties": {
                        "encoding": {
                            "type": "string",
                            "enum": ["ASCII", "UTF-8", "UTF-16", "UTF-32"]
                        }
                    },
                    "additionalProperties": false
    
                }
            },
            "required": ["self", "dataformatversion", "unstructured"],
            "additionalProperties": false
        }],
        "definitions": {
            "name": {
                "type": "string"
            },
            "version": {
                "type": "string",
                "pattern": "^(\\d+\\.)(\\d+\\.)(\\*|\\d+)$"
            },
            "self": {
                "description": "Identifying Information for the Data Format - name/version can be used to access the artifact",
                "type": "object",
                "properties": {
                    "name": {
                        "$ref": "#/definitions/name"
                    },
                    "version": {
                        "$ref": "#/definitions/version"
                    },
                    "description": {
                        "type": "string"
                    }
                },
                "required": [
                    "name",
                    "version"
                ],
                "additionalProperties": false
            },
            "format": {
                "description": "Reference schema type",
                "type": "string",
                "enum": [
                    "JSON",
                    "Delimited Format",
                    "XML",
                    "Unstructured"
                ]
            },
            "field": {
                "description": "A field definition for the delimited schema",
                "type": "object",
                "properties": {
                    "name": {
                        "type": "string"
                    },
                    "description": {
                        "type": "string"
                    },
                    "fieldtype": {
                        "description": "the field type - from the XML schema types",
                        "type": "string",
                        "enum": ["string", "boolean",
                            "decimal", "float", "double",
                            "duration", "dateTime", "time",
                            "date", "gYearMonth", "gYear",
                            "gMonthDay", "gDay", "gMonth",
                            "hexBinary", "base64Binary",
                            "anyURI", "QName", "NOTATION",
                            "normalizedString", "token",
                            "language", "IDREFS", "ENTITIES",
                            "NMTOKEN", "NMTOKENS", "Name",
                            "NCName", "ID", "IDREF", "ENTITY",
                            "integer", "nonPositiveInteger",
                            "negativeInteger", "long", "int",
                            "short", "byte",
                            "nonNegativeInteger", "unsignedLong",
                            "unsignedInt", "unsignedShort",
                            "unsignedByte", "positiveInteger"
    
                        ]
                    },
                    "fieldPattern": {
                        "description": "Regular expression that defines the field format",
                        "type": "integer"
                    },
                    "fieldMaxLength": {
                        "description": "The maximum length of the field",
                        "type": "integer"
                    },
                    "fieldMinLength": {
                        "description": "The minimum length of the field",
                        "type": "integer"
                    },
                    "fieldMinimum": {
                        "description": "The minimum numeric value of the field",
                        "type": "integer"
                    },
                    "fieldMaximum": {
                        "description": "The maximum numeric value of the field",
                        "type": "integer"
                    }
                },
                "additionalProperties": false
            },
            "dataformatversion": {
                "type": "string",
                "enum": ["1.0.0"]
            }
        }
    }

Examples
-----------

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
