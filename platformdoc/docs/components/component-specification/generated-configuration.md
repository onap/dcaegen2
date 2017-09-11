# Generated configuration

The DCAE platform relies on the component specification to generate the component's application configuration JSON at deployment time.  The component developer should expect to use this configuration JSON in their application to provision themselves.

Pro-tip: As you build your component specification, you can use the [dcae-cli `dev` command](../dcae-cli/walkthrough/#dev) to view what the resulting application configuration will look like.

## Streams and services

For both Docker and CDAP, when your component is deployed, any `streams` and `services/calls` you specified will be injected into your configuration under the following well known structure. 
Your component is required to parse this information if you have any connectivity to DMaaP or are calling another DCAE component.

More details about the DMaaP connection objects are found [here](../dcae-cli/dmaap-connection-objects/).

This is best served with an example.

The following component spec snippet (from String Matching):
```
"streams":{  
    "subscribes": [{
      "format": "VES_specification",  
      "version": "4.27.2",    
      "type": "message_router",
      "config_key" : "mr_input"
    }],
    "publishes": [{
      "format": "VES_specification",  
      "version": "4.27.2",    
      "config_key": "mr_output",
      "type": "message_router"
     }]
  },
  "services":{  
    "calls": [{
      "config_key" : "aai_broker_handle",
      "verb": "GET",
      "request": {
        "format": "get_with_query_params",
        "version": "1.0.0"
      },
      "response": {
        "format": "aai_broker_response",
        "version": "3.0.0"
      } 
    }],
    "provides": []
  },
```

Will turn into the following top level keys in your configuration (for CDAP, this will be under AppConfig)

```
   "streams_publishes":{  
      "mr_output":{                // notice the config key above
         "aaf_password":"XXX",
         "type":"message_router",
         "dmaap_info":{  
            "client_role": null,
            "client_id": null,
            "location": null,
            "topic_url":"XXX"
         },
         "aaf_username":"XXX"
      }
   },
   "streams_subscribes":{  
      "mr_input":{                 // notice the config key above
         "aaf_password":"XXX",
         "type":"message_router",
         "dmaap_info":{  
            "client_role": null,
            "client_id": null,
            "location": null,
            "topic_url":"XXX"
         },
         "aaf_username":"XXX"
      }
   },
   "services_calls":{  
      "aai_broker_handle":[        // notice the config key above
         "SOME_IP:32768"   // based on deployment time, just an example
      ]
   }
```
These keys will always be populated regardless of whether they are empty. So the minimal you will get, in the case of a component that provides an HTTP service and does not call any services and has no streams, is:
```
    "streams_publishes":{},
    "streams_subscribes":{},
    "services_calls":{}
```

Thus your component should expect these well-known top level keys.
