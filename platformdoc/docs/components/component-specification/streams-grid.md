
# Streams Formatting Quick Reference

Each of the following tables represents an example of a publisher and its subscriber, which are of course, different components. This focuses on the fields that are ‘different’ for each of these TYPEs, to illustrate the relationship between `config_key`, dmaap connection object, and the generated configuration. Some notes on specific properties:

* `config_key`  is an arbitrary string, chosen by the component developer. It  is returned in the  generated configuration where it contains specific values for the target connection
* `format`, `version`, and `type` properties in the subscriber would match these properties in the publisher
* `aaf_username` and `aaf_password` may be different between the publisher and the subscriber



### Using http

#### *Publishing Component*

| component spec | runtime platform generated config |
|----------------|-----------------------------------|
|"streams":{<br>&nbsp;&nbsp;&nbsp;"publishes":[{<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"config_key":"prediction",<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"format":"some-format",<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"type":"http",<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"version":"0.1.0"<br>&nbsp;&nbsp;&nbsp;}]<br>}<br>|"streams_publishes":{<br>&nbsp;&nbsp;&nbsp;"prediction":["10.100.1.100:32567/data"] |

#### *Subscribing Component*

| component spec | runtime platform generated config |
|----------------|-----------------------------------|
|"streams":{<br>&nbsp;&nbsp;&nbsp;"subscribes":[{<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"route":"/data",<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"format":"some-format",<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"type":"http",<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"version":"0.1.0"<br>&nbsp;&nbsp;&nbsp;}]<br>}<br>|"N/A"|



### Using Message Router

#### *Publishing Component*

Note: When deploying, this component should be deployed first so satisfy downstream dependencies. Refer to the –force option in component ‘run’ command for more information.

| component spec | Dmaap Connection Object | runtime platform generated config |
|----------------|-------------------------| --------------------------------- |
|"streams":{<br>&nbsp;&nbsp;&nbsp;"publishes":[{<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"config_key":"mr_output",<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"format":"some-format",<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"type":"message_router",<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"version":"0.1.0"<br>&nbsp;&nbsp;&nbsp;}]<br>} | {<br>&nbsp;&nbsp;&nbsp; "type":"message_router",<br> &nbsp;&nbsp;&nbsp;&nbsp;"dmaap_info": {<br>&nbsp;&nbsp;&nbsp; "topic_url": "https://we-are-message-router.us:3905/events/some-topic" }<br>} <br><br>*Note: For message router, this object is identical for the publisher and the subscriber* | "streams_publishes":{<br>&nbsp;&nbsp;&nbsp;"mr_output":{<br>&nbsp;&nbsp;&nbsp; "aaf_username":"pub-user",<br>&nbsp;&nbsp;&nbsp; "aaf_password":"pub-pwd",<br>&nbsp;&nbsp;&nbsp;&nbsp;"type":"message_router",<br>&nbsp;&nbsp;&nbsp;"dmaap_info":{<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"topic_url":"https://we-are-message-router.us:3905/events/some-topic"}<br>&nbsp;&nbsp;&nbsp;&nbsp;}<br>},<br> "streams_subscribes":{<br>…<br>} 

#### *Subscribing Component*

| component spec | Dmaap Connection Object | runtime platform generated config |
|----------------|-------------------------| --------------------------------- |
|"streams":{<br>&nbsp;&nbsp;&nbsp;"subscribes":[{<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"config_key":"mr_input",<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"format":"some-format",<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"type":"message_router",<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"version":"0.1.0"<br>&nbsp;&nbsp;&nbsp;}]<br>} | {<br>&nbsp;&nbsp;&nbsp; "type":"message_router",<br> &nbsp;&nbsp;&nbsp;&nbsp;"dmaap_info": {<br>&nbsp;&nbsp;&nbsp; "topic_url": "https://we-are-message-router.us:3905/events/some-topic" }<br>} <br><br>*Note: For message router, this object is identical for the publisher and the subscriber* | "streams_publishes":{<br>…<br>},<br> "streams_subscribes":{<br>&nbsp;&nbsp;&nbsp;"mr_input":{<br>&nbsp;&nbsp;&nbsp; "aaf_username":"sub-user",<br>&nbsp;&nbsp;&nbsp; "aaf_password":"sub-pwd",<br>&nbsp;&nbsp;&nbsp;&nbsp;"type":"message_router",<br>&nbsp;&nbsp;&nbsp;&nbsp;"dmaap_info":{<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"topic_url":"https://we-are-message-router.us:3905/events/some-topic"}<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;}<br>}




### Using Data Router

#### *Publishing Component*

| component spec | Dmaap Connection Object | runtime platform generated config |
|----------------|-------------------------| --------------------------------- |
|"streams":{<br>&nbsp;&nbsp;&nbsp;"publishes":[{<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"config_key":"dr_output",<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"format":"some-format",<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"type":"data_router",<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"version":"0.1.0"<br>&nbsp;&nbsp;&nbsp;}]<br>} | {<br>&nbsp;&nbsp; "type":"data_router",<br> &nbsp;&nbsp;&nbsp;"dmaap_info": {<br> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"location": "mtc00",<br> &nbsp;&nbsp;&nbsp;&nbsp; "publish_url": "https://we-are-data-router.us/feed/xyz", <br> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"log_url": "https://we-are-data-router.us/feed/xyz/logs",<br> &nbsp;&nbsp;&nbsp;&nbsp; "username": "pub-user",<br> &nbsp;&nbsp;&nbsp;&nbsp; "password": "pub-password",<br> &nbsp;&nbsp;&nbsp;&nbsp; "publisher_id": "123456"}<br>} | streams_publishes":{<br>&nbsp;&nbsp;&nbsp;"dr_output":{<br>&nbsp;&nbsp;&nbsp;&nbsp; "type":"data_router",<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"dmaap_info":{<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"location":"mtc00",<br> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"publish_url":"https://we-are-data-router.us/feed/xyz",<br> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"log_url":"https://we-are-data-router.us/feed/xyz/logs",<br> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; "username":"pub-user",<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; "password":"pub-password",<br> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; "publisher_id":"123456"}<br>&nbsp;&nbsp;&nbsp;}<br>},<br> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; "streams_subscribes":{<br> …<br> } 

#### *Subscribing Component*

| component spec | Dmaap Connection Object | runtime platform generated config |
|----------------|-------------------------| --------------------------------- |
|"streams":{<br>&nbsp;&nbsp;&nbsp;"subscribes":[{<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"config_key":"dr_input",<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"format":"some-format",<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"type":"data_router",<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"version":"0.1.0",<br> &nbsp;&nbsp;&nbsp;&nbsp;"route":"/target-path"<br>&nbsp;&nbsp;&nbsp;}]<br>} | {<br>&nbsp;&nbsp; "type":"data_router",<br> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"dmaap_info": {<br> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"location": "mtc00",<br> &nbsp;&nbsp;&nbsp;&nbsp; "delivery_url": "https://my-subscriber-app.dcae:8080/target-path", <br>&nbsp;&nbsp;&nbsp;&nbsp;"username": "sub-user",<br> &nbsp;&nbsp;&nbsp;&nbsp; "password": "sub-password",<br> &nbsp;&nbsp;&nbsp;&nbsp; "subscriber_id": "789012"}<br>} | "streams_publishes":{<br> …<br> },<br> "streams_subscribes":{<br>&nbsp;&nbsp;&nbsp;"dr_input":{<br> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; "type":"data_router",<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"dmaap_info":{<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"location":"mtc00",<br> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"delivery_url":"https://my-subscriber-app.dcae:8080/target-path",<br> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; "username":"sub-user",<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; "password":"sub-password",<br> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; "subscriber_id":"789012"}<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;}<br>}

