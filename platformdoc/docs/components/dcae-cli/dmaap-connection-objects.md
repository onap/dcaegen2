# DMaaP connection objects

DMaaP connection objects are JSON objects that:

1. Components should expect at runtime in their application configuration and is to be used to connect to the appropriate DMaaP feed or topic.
2. Developers must provide through the command-line argument `--dmaap-file` to test their component with manually provisioned feeds and topics.

This page is a reference to the specific structure that each type of DMaaP stream requires.

Note for #1 that components should expect the entire object with all properties at runtime where the default will be `null` unless specified otherwise.

Note for #2 that developers are not required to provide the entire object.  The required properties will be labeled with "*required as input*".

## Message router

Publishers and subscribers both have the same JSON object structure.  Here's an example:

```json
{
    "type": "message_router",
    "aaf_username": "some-user",
    "aaf_password": "some-password",
    "dmaap_info": {
        "client_role": "com.dcae.member",
        "client_id": "1500462518108",
        "location": "mtc00",
        "topic_url": "https://we-are-message-router.us:3905/events/some-topic"
    }
}
```

At the top-level:

Property Name | Type | Description
------------- | ---- | -----------
type | string | *Required as input*.  Must be `message_router` for message router topics
aaf_username | string | AAF username message router clients use to authenticate with secure topics
aaf_password | string | AAF password message router clients use to authenticate with secure topics
dmaap_info | JSON object | *Required as input*. Contains the topic connection details

The `dmaap_info` object contains:

Property Name | Type | Description
------------- | ---- | -----------
client_role | string | AAF client role that's requesting publish or subscribe access to the topic
client_id | string | Client id for given AAF client
location | string | DCAE location for the publisher or subscriber, used to set up routing
topic_url | string | *Required as input*. URL for accessing the topic to publish or receive events

Here's an example of the minimal JSON that must be provided as an input:

```json
{
    "type": "message_router",
    "dmaap_info": {
        "topic_url": "https://we-are-message-router.us:3905/events/some-topic"
    }
}
```

## Data router

### Publisher

Here's an example of what the JSON object connection for data router publisher looks like:

```json
{
    "type": "data_router",
    "dmaap_info": {
        "location": "mtc00",
        "publish_url": "https://we-are-data-router.us/feed/xyz",
        "log_url": "https://we-are-data-router.us/feed/xyz/logs",
        "username": "some-user",
        "password": "some-password",
        "publisher_id": "123456"
    } 
}
```

At the top-level:

Property Name | Type | Description
------------- | ---- | -----------
type | string | *Required as input*.  Must be `data_router` for data router feeds
dmaap_info | JSON object | *Required as input*. Contains the topic connection details

The `dmaap_info` object contains:

Property Name | Type | Description
------------- | ---- | -----------
location | string | DCAE location for the publisher, used to set up routing
publish_url | string | *Required as input*. URL to which the publisher makes Data Router publish requests
log_url | string | URL from which log data for the feed can be obtained
username | string | Username the publisher uses to authenticate to Data Router 
password | string | Password the publisher uses to authenticate to Data Router
publisher_id | string | Publisher id in Data Router

Here's an example of the minimal JSON that must be provided as an input:

```json
{
    "type": "data_router",
    "dmaap_info": {
        "publish_url": "https://we-are-data-router.us/feed/xyz"
    }
}
```

### Subscriber

Here's an example of what the JSON object connection for data router subscriber looks like:

```json
{
    "type": "data_router",
    "dmaap_info": {
        "location": "mtc00",
        "delivery_url": "https://my-subscriber-app.dcae:8080/target-path",
        "username": "some-user",
        "password": "some-password",
        "subscriber_id": "789012"
    } 
}
```

At the top-level:

Property Name | Type | Description
------------- | ---- | -----------
type | string | *Required as input*.  Must be `data_router` for data router feeds
dmaap_info | JSON object | *Required as input*. Contains the topic connection details

The `dmaap_info` object contains:

Property Name | Type | Description
------------- | ---- | -----------
location | string | DCAE location for the publisher, used to set up routing
delivery_url | string | URL to which the Data Router should deliver files
username | string | Username Data Router uses to authenticate to the subscriber when delivering files
password | string | Password Data Router uses to authenticate to the subscriber when delivering files
subscriber_id | string | Subscriber id in Data Router

Here's an example of the minimal JSON that must be provided as an input:

```json
{
    "type": "data_router",
    "dmaap_info": {
    }
}
```

Developers are recommended to use `username` and `password` since this is the recommended security practice.

Note that the dcae-cli will construct the `delivery_url` when deploying the component since this can only be known at deployment time.
