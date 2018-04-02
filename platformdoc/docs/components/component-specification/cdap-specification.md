# Component specification (CDAP)

The CDAP component specification contains the following groups of information. Many of these are common to both CDAP and Docker components and are therefore described in the common specification.

* [Metadata](common-specification.md#metadata)
* [Interfaces](common-specification.md#interfaces) including the associated [Data Formats](/components/data-formats.md)
* [Parameters](#parameters) - for specifying parameters in your AppConfig, AppPreferences, and ProgramPreferences to the Designer and Policy. This of course is CDAP-specific and is described below. 
* [Auxiliary Details](#auxiliary-details)
* [List of artifacts](common-specification.md#artifacts)


## Current Limitations and TODOs

* The integration of DMD is likely to significantly change the [Interfaces](common-specification.md#interfaces) section in this specification..

## Parameters

There is a `parameters` section in your component specification. This section contains three optional keys: [app_config](#appconfig), [app_preferences](#apppreferences), and [program_preferences](#programpreferences):
```
"parameters" : {
    "app_config" : [ ...],               
    "app_preferences" : [ ...],          
    "program_preferences" : [...]
    // any additional keys are ignored
}
```

* Each section details the parameters that are a part of each of these CDAP constructs (see below).
* All such parameters will be exposed to the designer and to policy for override. 
* These parameters should have default values specified by the component developer where necessary, i.e., parameters that _must_ come from the designer/policy should not have defaults. 
* All of these keys are optional because not every CDAP application uses preferences and not every application uses the AppConfig. However, you should specify at least one, or else your application will have no parameters exposed to policy or to the DCAE designer, which means it would be non-configurable. 
* Despite the AppConfig being optional to *specify* in the case that you have no parameters in your AppConfig, it is *required for processing* in your application. That is because the DCAE platform will place important information into your AppConfig as discussed below. 

### Parameter

The following CDAP specific definitions use `param1` to refer to the common parameter layout in [Parameter](common-specification.md#parameters)

### AppConfig

The `app_config` key refers to the [CDAP AppConfig](http://docs.cask.co/cdap/current/en/reference-manual/http-restful-api/configuration.html). It is expected to be a JSON:
```
"app_config" : [ // list of JSON
    param1,      // common parameter layout
    ...
]
```
Unfortunately, at the time of writing, the AppConfig is a Java map of `string:string`, which means you cannot have more complex structures (than string) as any value in your AppConfig.  However, there is a way to bypass this constraint: you can pass a JSON by encoding the JSON as a string. E.g., the `json.dumps()` and it's converse `loads` methods in Python:
```
>>> import json
>>> json.dumps({"foo" : "bar"})     # This is a real JSON
'{"foo": "bar"}'                    # It is now a string: pass this in as your parameter value
>>> json.loads('{"foo": "bar"}')    # Do the equivelent of this in your application
{u'foo': u'bar'}                    # ...and you'll get back a real JSON 
>>>
```

The final AppConfig (after the designer and policy override parameter values) is passed into CDAP's AppConfig API when starting the application. 

### AppPreferences

In addition to the CDAP AppConfig, the platform supports [Application Preferences](http://docs.cask.co/cdap/current/en/reference-manual/http-restful-api/preferences.html#set-preferences). 
The format of the `app_preferences` value  is the same as the above:
```
"app_preferences" : [   // list of JSON
    param1,      // common parameter layout
    ...
]
```

The final Application Preferences JSON (after the designer and policy override parameter values) is passed into CDAP's Preferences API when starting your application. 

### ProgramPreferences

Preferences can also be specified [per program](http://docs.cask.co/cdap/current/en/reference-manual/http-restful-api/lifecycle.html#program-lifecycle) in CDAP. This key's value is a list of JSON with the following format:
```
"program_preferences" : [                // note: this is a list of JSON 
    {
      "program_id" :   "program name 1",  // the name of this CDAP program
      "program_type" : "e.g., flows",     // "must be one of flows, mapreduce, schedules, spark, workflows, workers, or services",
      "program_pref" : [                  // list of JSON
      param1,      // common parameter layout
          ...
      ]
    },
    // repeat for each program that receives a program_preferences JSON 
]
```
Each `program_pref` JSON is passed into the CDAP API as the preference for `program_id`. 


NOTE: for CDAP, this section is very likely to change when DMD  is available. 
The _future_ vision is that you would publish your data as a series of files on HDFS, and DMD will pick them up and send them to the appropriate DMaaP feeds or directly when needed. 

## Auxiliary Details

`auxiliary` contains details about CDAP specific parameters.

Property Name | Type | Description
------------- | ---- | -----------
streamname | string | *Required*. 
artifact_name | string | 
artifact_version | string | the version of your CDAP JAR artifact
namespace | string | the CDAP namespace to deploy into, default is 'default'
programs | array | contains each CDAP entity represented in the artifact
program_type | string | CDAP entity (eg "flows")
program_id | string | name of CDAP entity (eg "WhoFlow")

Example:

```json
"auxiliary": {
    "streamname" : "who",
    "artifact_name" : "HelloWorld",
    "artifact_version" : "3.4.3",
    "namespace" : "hw",
    "programs" : [
                    {"program_type" : "flows", "program_id" : "WhoFlow"}, 
                    {"program_type" : "services", "program_id" : "Greeting"},
                    ...
                  ],
}
```
The `programs` key is identical to the `program_preferences` key discussed [above](#programpreferences) except:

* each JSON in the list does not contain `program_pref`
* this is required! You must include all of your programs in this, as it is used to start each program as well as for DCAE to perform periodic healthchecks on your application. Don't forget about your services; they are programs too.

