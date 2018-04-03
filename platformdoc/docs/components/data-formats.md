# Data Formats

Data formats are descriptions of data; they are the data contract between your component and other components. When the components are 'composed' into services in the SDC tool, they can only be matched with components that have compatible data formats. Data formats will be onboarded to SDC and assigned a UUID at that time. This UUID is then used to ensure compatibility amoung components. (If component X outputs data format 'DF-Y', and another component Z specifies 'DF-Y' as its input data format, then X is said to be `composable` with component Z).

Since data formats will be shared across components, the onboarding catalog should be checked first to see if the desired data format is available before creating one. 
The vision is to have a repository of shared data formats that developers and teams can re-use and also provide them the means to extend and create new custom data formats. 
A data format is referenced by its data format id and version number.  

## JSON schema

The data format specification is represented (and validated) against this  
[Data Format json schema](https://codecloud.web.att.com/projects/ST_DCAECNTR/repos/component-json-schemas/browse/data-format-schema.json) and described below:

### Meta Schema Definition

The "Meta Schema" implementation defines how data format JSON schemas can be written to define user input. It is itself a JSON schema (thus it is a "meta schema").  It requires the name of the data format entry, the data format entry version and allows a description under "self" object. The meta schema version must be specified as the value of the "dataformatversion" key.  Then the input schema itself is described as one of the four types listed below:

Type | Description
---- | -----------
jsonschema | inline standard JSON Schema definitions of JSON inputs
delimitedschema | delimited data input using a JSON description and defined delimiter
unstructured | unstructured text, and reference that allows a pointer to another artifact for a schema. 
reference | allows for XML schema, but can be used to reference other JSON, delimitedschema, and unstructured schemas as well. 

## Example Schemas:

### `jsonschema`

* [TCA output](https://codecloud.web.att.com/projects/ST_DCAECNTR/repos/dcae_cli_examples/browse/tca_hi_lo/tcaoutput.json)

* [CUDA simple example](https://codecloud.web.att.com/projects/ST_DCAECNTR/repos/dcae_cli_examples/browse/cuda/simplejson.json)

* [CUDA nested example](https://codecloud.web.att.com/projects/ST_DCAECNTR/repos/dcae_cli_examples/browse/cuda/nestedjson.json)

### `delimitedschema`

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

### `unstructured`

* [CUDA example](https://codecloud.web.att.com/projects/ST_DCAECNTR/repos/dcae_cli_examples/browse/cuda/unstructuredtext.json)

### `reference`

* [TCA Hi Lo input](https://codecloud.web.att.com/projects/ST_DCAECNTR/repos/dcae_cli_examples/browse/tca_hi_lo/tcainput.json)

Note: The referenced data format (in this case, a schema named "Common Event Format" with version of "25.0.0") must already exist in the onboarding catalog.

## Working with Data Formats

Data Formats can be added to the onboarding catalog (which first validates them) by using the [dcae_cli Tool](http://dcae-platform.research.att.com/components/dcae-cli/quickstart/). Here you can also list all of your data formats, show the contents of a data format, publish your data format, and even generate a data format from a input sample file. For a list of these capabilities, see [Data Format Commands](/components/dcae-cli/commands/#data_format).

