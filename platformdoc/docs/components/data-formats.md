# Data Formats

Because the DCAE designer composes your component with others at service design time, in most cases you do not know what specific component(s) your component will send data to during runtime. 
Thus, it is vital that DCAE has a language of describing the data passed between components, so that it is known which components are composable with others. 
Data formats are descriptions of data---they are the data contract between your component and other components. 
You need to describe the available outputs and assumed inputs of your components as data formats. 
These data descriptions are onboarded into ASDC, and each receives a UUID. 
If component X outputs data format DF-Y, and another component Z specifies DF-Y as their input data format, then X is said to be _composable_ with that component. 
The data formats are referenced in the component specifications by the data format's id and version.  
The vision is to have a repository of shared data formats that developers and teams can re-use and also provide them the means to extend and create new custom data formats.

# Meta Schema Definition

The "Meta Schema" implementation defines how data format JSON schemas can be written to define user input. It is itself a JSON schema (thus it is a "meta schema").  It requires the name of the data format entry, the data format entry version and allows a description under "self" object. The meta schema version must be specified as the value of the "dataformatversion" key.  Then the input schema itself is described.  There are four types of schema descriptions objects - jsonschema for inline standard JSON Schema definitions of JSON inputs, delimitedschema for delimited data input using a defined JSON description, unstructured for unstructured text, and reference that allows a pointer to another artifact for a schema.  The reference allows for XML schema, but can be used as a pointer to JSON, Delimited Format, and Unstructured schemas as well. 

The current Meta Schema implementation is defined at the link below.  

[schema](ONAP URL TBD)

#TCA Example

TCA Input - Common Event Format by reference

First the full JSON schema description of the Common Event Format would be loaded with a name of "Common Event Format" and the current version of "25.0.0".

Then the data format description is loaded by the example at this link:

[tcainput](ONAP URL TBD)

TCA Output JSON inline example: 

[tcaoutput](ONAP URL TBD)

#CUDA Example

CUDA Simple JSON Example:

[simplejson](ONAP URL TBD)

CUDA Nested JSON Example:

[nestedjson](ONAP URL TBD)

CUDA Unstructured Example:

[unstructuredtext](ONAP URL TBD)

# An example of a delimited schema

```
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
```
