.. This work is licensed under a Creative Commons Attribution 4.0 International License.
.. http://creativecommons.org/licenses/by/4.0

.. _dcae-component-schema:

DCAE Component JSON Schema
==========================

::

 {
  "$schema": "http://json-schema.org/draft-04/schema#",
  "title": "Component specification schema",
  "type": "object",
  "properties": {
    "self": {
      "type": "object",
      "properties": {
        "version": {
          "$ref": "#/definitions/version"
        },
        "description": {
          "type": "string"
        },
        "component_type": {
          "type": "string",
          "enum": [
            "docker",
            "cdap"
          ]
        },
        "name": {
          "$ref": "#/definitions/name"
        }
      },
      "required": [
        "version",
        "name",
        "description",
        "component_type"
      ]
    },
    "streams": {
      "type": "object",
      "properties": {
        "publishes": {
          "type": "array",
          "uniqueItems": true,
          "items": {
            "oneOf": [
                { "$ref": "#/definitions/publisher_http" },
                { "$ref": "#/definitions/publisher_message_router" },
                { "$ref": "#/definitions/publisher_data_router" }
            ]
          }
        },
        "subscribes": {
          "type": "array",
          "uniqueItems": true,
          "items": {
            "oneOf": [
                { "$ref": "#/definitions/subscriber_http" },
                { "$ref": "#/definitions/subscriber_message_router" },
                { "$ref": "#/definitions/subscriber_data_router" }
            ]
          }
        }
      },
      "required": [
        "publishes",
        "subscribes"
      ]
    },
    "services": {
      "type": "object",
      "properties": {
        "calls": {
          "type": "array",
          "uniqueItems": true,
          "items": {
            "$ref": "#/definitions/caller"
          }
        },
        "provides": {
          "type": "array",
          "uniqueItems": true,
          "items": {
            "$ref": "#/definitions/provider"
          }
        }
      },
      "required": [
        "calls",
        "provides"
      ]
    },
   "parameters" : {
      "anyOf" : [
        {"$ref": "#/definitions/docker-parameters"},
        {"$ref": "#/definitions/cdap-parameters"}
      ]
    },
    "auxilary": {
      "oneOf" : [
        {"$ref": "#/definitions/auxilary_cdap"},
        {"$ref": "#/definitions/auxilary_docker"}
      ]
    },
    "artifacts": {
      "type": "array",
      "description": "List of component artifacts",
      "items": {
        "$ref": "#/definitions/artifact"
      }
    }
  },
  "required": [
    "self",
    "streams",
    "services",
    "parameters",
    "auxilary",
    "artifacts"
  ],
  "additionalProperties": false,
  "definitions": {
    "cdap-parameters": {
      "description" : "There are three seperate ways to pass parameters to CDAP: app config, app preferences, program preferences. These are all treated as optional.",
      "type": "object",
      "properties" : {
        "program_preferences": {
          "description" : "A list of {program_id, program_type, program_preference} objects where program_preference is an object passed into program_id of type program_type",
          "type": "array",
          "uniqueItems": true,
          "items": {
            "$ref": "#/definitions/program_preference"
          }
        },
        "app_preferences" : {
          "description" : "Parameters Passed down to the CDAP preference API",
          "type": "array",
            "uniqueItems": true,
            "items": {
              "$ref": "#/definitions/parameter"
            }
        },
        "app_config" : {
          "description" : "Parameters Passed down to the CDAP App Config",
          "type": "array",
            "uniqueItems": true,
            "items": {
              "$ref": "#/definitions/parameter"
            }
        }
      }
    },
    "program_preference": {
      "type": "object",
      "properties": {
        "program_type": {
          "$ref": "#/definitions/program_type"
        },
        "program_id": {
          "type": "string"
        },
        "program_pref":{
          "description" : "Parameters that the CDAP developer wants pushed to this program's preferences API. Optional",
            "type": "array",
            "uniqueItems": true,
            "items": {
              "$ref": "#/definitions/parameter"
            }
        }
      },
      "required": ["program_type", "program_id", "program_pref"]
    },
    "program_type": {
      "type": "string",
      "enum": ["flows","mapreduce","schedules","spark","workflows","workers","services"]
    },
    "docker-parameters": {
      "type": "array",
      "uniqueItems": true,
      "items": {
        "$ref": "#/definitions/parameter"
      }
    },
    "parameter": {
      "type": "object",
      "properties": {
        "name": {
          "type": "string"
        },
        "value": {
          "description": "Default value for the parameter"
        },
        "description": {
          "description": "Description for the parameter.",
          "type": "string"
        },
        "type": {
          "description": "The required data type for the parameter.",
          "type": "string",
          "enum": [ "string", "number", "boolean", "datetime" ]
        },
        "required": {
          "description": "An optional key that declares a parameter as required (true) or not (false). Default is true.",
          "type": "boolean",
          "default": true
        },
        "constraints": {
          "description": "The optional list of sequenced constraint clauses for the parameter.",
          "type": "array",
          "items": {
            "$ref": "#/definitions/parameter-constraints"
          }
        },
        "entry_schema": {
            "description": "used for complex data type in the future. 'type' must be map or array for entry_schema to kick_in. ",
            "type": "string"
        },
        "designer_editable": {
          "description": "A required property that declares a parameter as editable by designer in SDC Tool (true) or not (false).",
          "type": "boolean"
        },
        "policy_editable": {
          "description": "A required property that declares a parameter as editable by DevOps in Policy UI (true) or not (false).",
          "type": "boolean"
        },
        "sourced_at_deployment": {
          "description": "A required property that declares that a parameter is assigned at deployment time (true) or not (false).",
          "type": "boolean"
        },
        "policy_schema" :{
          "type": "array",
          "uniqueItems": true,
          "items": {"$ref": "#/definitions/policy_schema_parameter"}
        }
      },
      "required": [
        "name",
        "value",
        "description",
        "designer_editable",
        "policy_editable",
        "sourced_at_deployment"
      ],
      "additionalProperties": false,
      "dependencies": { "policy_schema": ["policy_editable"]}
    },
    "policy_schema_parameter": {
        "type": "object",
        "properties": {
            "name": {
                "type": "string"
            },
            "value": {
                "description": "Default value for the parameter"
            },
            "description": {
                "description": "Description for the parameter.",
                "type": "string"
            },
            "type": {
                "description": "The required data type for the parameter.",
                "type": "string",
                "enum": [ "string", "number", "boolean", "datetime", "list", "map" ]
            },
            "required": {
                "description": "An optional key that declares a parameter as required (true) or not (false). Default is true.",
                "type": "boolean",
                "default": true
            },
            "constraints": {
                "description": "The optional list of sequenced constraint clauses for the parameter.",
                "type": "array",
                "items": {
                    "$ref": "#/definitions/parameter-constraints"
                }
            },
            "entry_schema": {
                "description": "The optional key that is used to declare the name of the Datatype definition for entries of certain types. entry_schema must be defined when the type is either list or map. If the type is list and the entry type is a simple type (string, number, boolean, datetime), follow with a simple string to describe the entry type. If the type is list and the entry type is a map, follow with an array to describe the keys for the entry map. If the type is list and the entry type is also list, this is not currently supported here. If the type is map, then follow with an array to describe the keys for this map. ",
                "type": "array", "uniqueItems": true, "items": {"$ref": "#/definitions/policy_schema_parameter"}
            }
       },
        "required": [
            "name",
            "type"
            ],
      "additionalProperties": false
    },
    "parameter-constraints": {
      "type": "object",
      "additionalProperties": false,
      "properties": {
        "equal": {
          "description": "Constrains a property or parameter to a value equal to ('=') the value declared."
        },
        "greater_than": {
          "description": "Constrains a property or parameter to a value greater than ('>') the value declared.",
          "type": "number"
        },
        "greater_or_equal": {
          "description": "Constrains a property or parameter to a value greater than or equal to ('>=') the value declared.",
          "type": "number"
        },
        "less_than": {
          "description": "Constrains a property or parameter to a value less than '<') the value declared.",
          "type": "number"
        },
        "less_or_equal": {
          "description": "Constrains a property or parameter to a value less than or equal to ('<=') the value declared.",
          "type": "number"
        },
        "valid_values": {
          "description": "Constrains a property or parameter to a value that is in the list of declared values.",
          "type": "array"
        },
        "length": {
          "description": "Constrains the property or parameter to a value of a given length.",
          "type": "number"
        },
        "min_length": {
          "description": "Constrains the property or parameter to a value to a minimum length.",
          "type": "number"
        },
        "max_length": {
          "description": "Constrains the property or parameter to a value to a maximum length.",
          "type": "number"
        }
      }
    },
    "stream_message_router": {
      "type": "object",
      "properties": {
        "format": {
          "$ref": "#/definitions/name"
        },
        "version": {
          "$ref": "#/definitions/version"
        },
        "config_key": {
          "type": "string"
        },
        "type": {
          "description": "Type of stream to be used",
          "type": "string",
          "enum": [
            "message router", "message_router"
          ]
        }
      },
      "required": [
        "format",
        "version",
        "config_key",
        "type"
      ]
    },
    "publisher_http": {
      "type": "object",
      "properties": {
        "format": {
          "$ref": "#/definitions/name"
        },
        "version": {
          "$ref": "#/definitions/version"
        },
        "config_key": {
          "type": "string"
        },
        "type": {
          "description": "Type of stream to be used",
          "type": "string",
          "enum": [
            "http",
            "https"
          ]
        }
      },
      "required": [
        "format",
        "version",
        "config_key",
        "type"
      ]
    },
    "publisher_message_router": {
      "$ref": "#/definitions/stream_message_router"
    },
    "publisher_data_router": {
      "type": "object",
      "properties": {
        "format": {
          "$ref": "#/definitions/name"
        },
        "version": {
          "$ref": "#/definitions/version"
        },
        "config_key": {
          "type": "string"
        },
        "type": {
          "description": "Type of stream to be used",
          "type": "string",
          "enum": [
            "data router", "data_router"
          ]
        }
      },
      "required": [
        "format",
        "version",
        "config_key",
        "type"
      ]
    },
    "subscriber_http": {
      "type": "object",
      "properties": {
        "format": {
          "$ref": "#/definitions/name"
        },
        "version": {
          "$ref": "#/definitions/version"
        },
        "route": {
          "type": "string"
        },
        "type": {
          "description": "Type of stream to be used",
          "type": "string",
          "enum": [
            "http",
            "https"
          ]
        }
      },
      "required": [
        "format",
        "version",
        "route",
        "type"
      ]
    },
    "subscriber_message_router": {
      "$ref": "#/definitions/stream_message_router"
    },
    "subscriber_data_router": {
      "type": "object",
      "properties": {
        "format": {
          "$ref": "#/definitions/name"
        },
        "version": {
          "$ref": "#/definitions/version"
        },
        "route": {
          "type": "string"
        },
        "type": {
          "description": "Type of stream to be used",
          "type": "string",
          "enum": [
            "data router", "data_router"
          ]
        },
        "config_key": {
          "description": "Data router subscribers require config info to setup their endpoints to handle requests. For example, needs username and password",
          "type": "string"
        }
      },
      "required": [
        "format",
        "version",
        "route",
        "type",
        "config_key"
      ]
    },
    "provider" : {
      "oneOf" : [
        {"$ref": "#/definitions/docker-provider"},
        {"$ref": "#/definitions/cdap-provider"}
      ]
    },
    "cdap-provider" : {
      "type": "object",
      "properties" : {
         "request": {
           "$ref": "#/definitions/formatPair"
         },
         "response": {
           "$ref": "#/definitions/formatPair"
         },
         "service_name" : {
           "type" : "string"
         },
         "service_endpoint" : {
           "type" : "string"
         },
         "verb" : {
           "type": "string",
           "enum": ["GET", "PUT", "POST", "DELETE"]
        }
      },
      "required" : [
        "request", 
        "response",
        "service_name",
        "service_endpoint",
        "verb"
        ]
    },
    "docker-provider": {
      "type": "object",
      "properties": {
        "request": {
          "$ref": "#/definitions/formatPair"
        },
        "response": {
          "$ref": "#/definitions/formatPair"
        },
        "route": {
          "type": "string"
        },
        "verb": {
          "type": "string",
          "enum": ["GET", "PUT", "POST", "DELETE"]
        }
      },
      "required": [
        "request",
        "response",
        "route"
      ]
    },
    "caller": {
      "type": "object",
      "properties": {
        "request": {
          "$ref": "#/definitions/formatPair"
        },
        "response": {
          "$ref": "#/definitions/formatPair"
        },
        "config_key": {
          "type": "string"
        }
      },
      "required": [
        "request",
        "response",
        "config_key"
      ]
    },
    "formatPair": {
      "type": "object",
      "properties": {
        "format": {
          "$ref": "#/definitions/name"
        },
        "version": {
          "$ref": "#/definitions/version"
        }
      }
    },
    "name": {
      "type": "string"
    },
    "version": {
      "type": "string",
      "pattern": "^(\\d+\\.)(\\d+\\.)(\\*|\\d+)$"
    },
    "artifact": {
      "type": "object",
      "description": "Component artifact object",
      "properties": {
        "uri": {
          "type": "string",
          "description": "Uri to artifact"
        },
        "type": {
          "type": "string",
          "enum": ["jar", "docker image"]
        }
      },
      "required": ["uri", "type"]
    },

    "auxilary_cdap": {
      "title": "cdap component specification schema",
      "type": "object",
      "properties": {
        "streamname": {
          "type": "string"
        },
        "artifact_name" : {
          "type": "string"
        },
        "artifact_version" : {
          "type": "string",
          "pattern": "^(\\d+\\.)(\\d+\\.)(\\*|\\d+)$"
        },
        "namespace":{
          "type": "string",
          "description" : "optional"
        },
        "programs": {
          "type": "array",
          "uniqueItems": true,
          "items": {
            "$ref": "#/definitions/cdap_program"
          }
        }
      },
      "required": [
        "streamname",
        "programs",
        "artifact_name",
        "artifact_version"
      ]
    },
    "cdap_program_type": {
      "type": "string",
      "enum": ["flows","mapreduce","schedules","spark","workflows","workers","services"]
    },
    "cdap_program": {
      "type": "object",
      "properties": {
        "program_type": {
          "$ref": "#/definitions/cdap_program_type"
        },
        "program_id": {
          "type": "string"
        }
      },
      "required": ["program_type", "program_id"]
    },

    "auxilary_docker": {
      "title": "Docker component specification schema",
      "type": "object",
      "properties": {
        "healthcheck": {
          "description": "Define the health check that Consul should perfom for this component",
          "type": "object",
          "oneOf": [
            { "$ref": "#/definitions/docker_healthcheck_http" },
            { "$ref": "#/definitions/docker_healthcheck_script" }
          ]
        },
        "ports": {
          "description": "Port mapping to be used for Docker containers. Each entry is of the format <container port>:<host port>.",
          "type": "array",
          "items": {
            "type": "string"
          }
        },
        "reconfigs": {
           "properties": {  
             "dti": {
                "description": "Script command that will be executed for reconfiguration",
                "type": "string"
             }
           } 
        }, 
        "volumes": {
          "description": "Volume mapping to be used for Docker containers. Each entry is of the format below",
          "type": "array",
          "items": {
          "type": "object",
            "properties": {
              "host":{
              "type":"object",
                "path": {"type": "string"}
              },
              "container":{
              "type":"object",
                "bind": { "type": "string"},
                "mode": { "type": "string"}
              }
            }
          }
        }
      },
      "required": [
        "healthcheck"
      ],
      "additionalProperties": false
    },
    "docker_healthcheck_http": {
      "properties": {
        "type": {
          "description": "Consul health check type",
          "type": "string",
          "enum": [
            "http",
            "https"
          ]
        },
        "interval": {
          "description": "Interval duration in seconds i.e. 10s",
          "default": "15s",
          "type": "string"
        },
        "timeout": {
          "description": "Timeout in seconds i.e. 10s",
          "default": "1s",
          "type": "string"
        },
        "endpoint": {
          "description": "Relative endpoint used by Consul to check health by making periodic HTTP GET calls",
          "type": "string"
        }
      },
      "required": [
        "type",
        "endpoint"
        ]
    },
    "docker_healthcheck_script": {
      "properties": {
        "type": {
          "description": "Consul health check type",
          "type": "string",
          "enum": [
            "script",
            "docker"
          ]
        },
        "interval": {
          "description": "Interval duration in seconds i.e. 10s",
          "default": "15s",
          "type": "string"
        },
        "timeout": {
          "description": "Timeout in seconds i.e. 10s",
          "default": "1s",
          "type": "string"
        },
        "script": {
          "description": "Script command that will be executed by Consul to check health",
          "type": "string"
        }
      },
      "required": [
        "type",
        "script"
        ]
      }
    }
  }
