.. This work is licensed under a Creative Commons Attribution 4.0 International License.
.. http://creativecommons.org/licenses/by/4.0

Available APIs
==============


.. toctree::
    :maxdepth: 3

.. _config_binding_service_sdk:

cbs-client - a Config Binding Service client
--------------------------------------------
CbsClientFactory can be used to lookup for CBS in your application. Returned CbsClient can then be used to get a configuration, poll for configuration or poll for configuration changes.

The following CBS endpoints are supported by means of different CbsRequests:
 - get-configuration created by CbsRequests.getConfiguration method - returns the service configuration
 - get-by-key created by CbsRequests.getByKey method - returns componentName:key entry from Consul
 - get-all created by CbsRequests.getAll method - returns everything which relates to the service (configuration, policies, etc.)

Sample usage:

.. code-block:: java

    // Generate RequestID and InvocationID which will be used when logging and in HTTP requests
    final RequestDiagnosticContext diagnosticContext = RequestDiagnosticContext.create();
    final CbsRequest request = CbsRequests.getConfiguration(diagnosticContext);

    // Read necessary properties from the environment
    final CbsClientConfiguration config = CbsClientConfiguration.fromEnvironment();

    // Create the client and use it to get the configuration
    CbsClientFactory.createCbsClient(config)
            .flatMap(cbsClient -> cbsClient.get(request))
            .subscribe(
                    jsonObject -> {
                        // do a stuff with your JSON configuration using GSON API
                        final int port = Integer.parseInt(jsonObject.get("collector.listen_port").getAsString());
                        // ...
                    },
                    throwable -> {
                        logger.warn("Ooops", throwable);
                    });


Note that a subscribe handler can/will be called in separate thread asynchronously after CBS address lookup succeeds and CBS service call returns a result.

If you are interested in calling CBS periodically and react only when the configuration changed you can use updates method:

.. code-block:: java

    // Generate RequestID and InvocationID which will be used when logging and in HTTP requests
    final RequestDiagnosticContext diagnosticContext = RequestDiagnosticContext.create();
    final CbsRequest request = CbsRequests.getConfiguration(diagnosticContext);

    // Read necessary configuration from the environment
    final CbsClientConfiguration config = CbsClientConfiguration.fromEnvironment();

    // Polling properties
    final Duration initialDelay = Duration.ofSeconds(5);
    final Duration period = Duration.ofMinutes(1);

    // Create the client and use it to get the configuration
    CbsClientFactory.createCbsClient(config)
            .flatMapMany(cbsClient -> cbsClient.updates(request, initialDelay, period))
            .subscribe(
                    jsonObject -> {
                        // do a stuff with your JSON configuration using GSON API
                        final int port = Integer.parseInt(jsonObject.get("collector.listen_port").getAsString());
                        // ...
                    },
                    throwable -> {
                        logger.warn("Ooops", throwable);
                    });

The most significant change is in line 14. We are using flatMapMany since we want to map one CbsClient to many JsonObject updates. After 5 seconds CbsClient will call CBS every minute. If the configuration has changed it will pass the JsonObject downstream - in our case consumer of JsonObject will be called.

Parsing streams' definitions:

- CBS configuration response contains various service-specific entries. It also contains a standardized DCAE streams definitions as streams_publishes and streams_subscribes JSON objects. CBS Client API provides a way of parsing this part of configuration so you can use Java objects instead of low-level GSON API.
- Because streams definitions are a simple value objects we were not able to provide you a nice polymorphic API. Instead you have 2-level API at your disposal:
    - You can extract raw streams  by means of DataStreams.namedSinks (for streams_publishes) and DataStreams.namedSources (for streams_subscribes).
    - Then you will be able to parse the specific entry from returned collection to a desired stream type by means of parsers built by StreamFromGsonParsers factory.

- Sample usage:

    .. code-block:: java

        final CbsRequest request = CbsRequests.getConfiguration(RequestDiagnosticContext.create());
        final StreamFromGsonParser<MessageRouterSink> mrSinkParser = StreamFromGsonParsers.messageRouterSinkParser();

        CbsClientFactory.createCbsClient(CbsClientConfiguration.fromEnvironment())
            .flatMapMany(cbsClient -> cbsClient.updates(request, Duration.ofSeconds(5), Duration.ofMinutes(1)))
            .map(DataStreams::namedSinks)
            .map(sinks -> sinks.filter(StreamPredicates.streamOfType(MESSAGE_ROUTER)).map(mrSinkParser::unsafeParse).toList())
            .subscribe(
                mrSinks -> mrSinks.forEach(mrSink -> {
                    logger.info(mrSink.name()); // name = the configuration key
                    logger.info(mrSink.aafCredentials().username()); // = aaf_username
                    logger.info(mrSink.topicUrl());
                    // ...
                }),
                throwable -> logger.warn("Ooops", throwable)
        );

    For details and sample usage please refer to JavaDoc and unit and integration tests. Especially `CbsClientImplIT <https://gerrit.onap.org/r/gitweb?p=dcaegen2/services/sdk.git;a=blob;f=rest-services/cbs-client/src/test/java/org/onap/dcaegen2/services/sdk/rest/services/cbs/client/impl/CbsClientImplIT.java;hb=HEAD>`_, `MessageRouterSinksIT <https://gerrit.onap.org/r/gitweb?p=dcaegen2/services/sdk.git;a=blob;f=rest-services/cbs-client/src/test/java/org/onap/dcaegen2/services/sdk/rest/services/cbs/client/api/streams/MessageRouterSinksIT.java;hb=HEAD>`_ and  `MixedDmaapStreamsIT <https://gerrit.onap.org/r/gitweb?p=dcaegen2/services/sdk.git;a=blob;f=rest-services/cbs-client/src/test/java/org/onap/dcaegen2/services/sdk/rest/services/cbs/client/api/streams/MixedDmaapStreamsIT.java;hb=HEAD>`_ might be useful.

- INFO
    Results of these parsers (MessageRouterSink, MessageRouterSource) can be directly used to connect to DMaaP MR by means of dmaap-client API described below.

crypt-password - an utility for BCrypt passwords
------------------------------------------------
Library to generate and match cryptography password using BCrypt algorithm

.. code-block:: bash

    java -jar crypt-password-${sdk.version}.jar password_to_crypt

    $2a$10$iDEKdKknakPqH5XZb6wEmeBP2SMRwwiWHy8RNioUTNycIomjIqCAO

Can be used like maven dependency to match generated password.

dmaap-client - a DMaaP MR client
--------------------------------
After parsing CBS sink definitions you will get a Source or Sink value object. It can be then directly used to communicate with DMaaP Message Router REST API.

Writing message publisher

.. code-block:: java

    final MessageRouterPublisher publisher = DmaapClientFactory.createMessageRouterPublisher();
    final MessageRouterSink sinkDefinition; //... Sink definition obtained by parsing CBS response
    final MessageRouterPublishRequest request = ImmutableMessageRouterPublishRequest.builder()
            .sinkDefinition(sinkDefinition)
            .build();

    Flux.just(1, 2, 3)
            .map(JsonPrimitive::new)
            .transform(input -> publisher.put(request, input))
            .subscribe(resp -> {
                        if (resp.successful()) {
                            logger.debug("Sent a batch of messages to the MR");
                        } else {
                            logger.warn("Message sending has failed: {}", resp.failReason());
                        }
                    },
                    ex -> {
                        logger.warn("An unexpected error while sending messages to DMaaP", ex);
                    });

Note that we are using Reactor transform operator. As an alternative you could assign Flux of JSON values to the variable and then invoke publisher.put on it. The important performance-related thing to remember is that you should feed the put method with a stream of messages instead of multiple calls with single messages. This way the client API will be able to send them in batches which should significantly improve performance (at least on transfer level).

Writing message subscriber

.. code-block:: java

    final MessageRouterSource sourceDefinition; //... Source definition obtained by parsing CBS response
    final MessageRouterSubscribeRequest request = ImmutableMessageRouterSubscribeRequest.builder()
            .sourceDefinition(sourceDefinition)
            .build();

    cut.subscribeForElements(request, Duration.ofMinutes(1))
            .map(JsonElement::getAsJsonObject)
            .subscribe(json -> {
                    // application logic
                },
                ex -> {
                    logger.warn("An unexpected error while receiving messages from DMaaP", ex);
                });

******************************************
Configure timeout when talking to DMaaP-MR
******************************************

* publisher:

.. code-block:: java

   final MessageRouterPublishRequest request = ImmutableMessageRouterPublishRequest.builder()
                .timeoutConfig(ImmutableDmaapTimeoutConfig.builder()
                        .timeout(Duration.ofSeconds(2))
                        .build())
                .
                .
                .
                .build();

* subscriber:

.. code-block:: java

  final MessageRouterSubscribeRequest request = ImmutableMessageRouterSubscribeRequest.builder()
                .timeoutConfig(ImmutableDmaapTimeoutConfig.builder()
                        .timeout(Duration.ofSeconds(2))
                        .build())
                .
                .
                .
                .build();

The default timeout value (4 seconds) can be used:

.. code-block:: java

   ImmutableDmaapTimeoutConfig.builder().build()

For timeout exception following message is return as failReason in DmaapResponse:

.. code-block:: RST

   408 Request Timeout
   {"requestError":{"serviceException":{"messageId":"SVC0001","text":"Client timeout exception occurred, Error code is %1","variables":["408"]}}}

*************************
Configure retry mechanism
*************************

* publisher:

.. code-block:: java

       final MessageRouterPublisherConfig config = ImmutableMessageRouterPublisherConfig.builder()
                .retryConfig(ImmutableDmaapRetryConfig.builder()
                        .retryIntervalInSeconds(2)
                        .retryCount(2)
                        .build())
                .
                .
                .
                .build();
       final MessageRouterPublisher publisher = DmaapClientFactory.createMessageRouterPublisher(config);

* subscriber:

.. code-block:: java

    final MessageRouterSubscriberConfig config = ImmutableMessageRouterSubscriberConfig.builder()
                .retryConfig(ImmutableDmaapRetryConfig.builder()
                        .retryIntervalInSeconds(2)
                        .retryCount(2)
                        .build())
                .
                .
                .
                .build();
    final MessageRouterSubscriber subscriber = DmaapClientFactory.createMessageRouterSubscriber(config);

The default retry config (retryCount=3, retryIntervalInSeconds=1) can be used:

.. code-block:: java

    ImmutableDmaapRetryConfig.builder().build()

Retry functionality works for:
 - DMaaP MR HTTP response status codes: 404, 408, 413, 429, 500, 502, 503, 504
 - Java Exception classes: ReadTimeoutException, ConnectException

**************************************
Configure custom persistent connection
**************************************

* publisher:

.. code-block:: java

       final MessageRouterPublisherConfig connectionPoolConfiguration = ImmutableMessageRouterPublisherConfig.builder()
                 .connectionPoolConfig(ImmutableDmaapConnectionPoolConfig.builder()
                        .connectionPool(16)
                        .maxIdleTime(10) //in seconds
                        .maxLifeTime(20) //in seconds
                        .build())
                .build();
       final MessageRouterPublisher publisher = DmaapClientFactory.createMessageRouterPublisher(connectionPoolConfiguration);

* subscriber:

.. code-block:: java

    final MessageRouterSubscriberConfig connectionPoolConfiguration = ImmutableMessageRouterSubscriberConfig.builder()
                    .connectionPoolConfig(ImmutableDmaapConnectionPoolConfig.builder()
                        .connectionPool(16)
                        .maxIdleTime(10) //in seconds
                        .maxLifeTime(20) //in seconds
                        .build())
                .build();
    final MessageRouterSubscriber subscriber = DmaapClientFactory.createMessageRouterSubscriber(connectionPoolConfiguration);

The default custom persistent connection configuration (connectionPool=16, maxLifeTime=2147483647, maxIdleTime=2147483647) can be used:

.. code-block:: java

    ImmutableDmaapConnectionPoolConfig.builder().build()

***************************************
Configure request for authorized topics
***************************************

* publisher:

.. code-block:: java

    final MessageRouterSink sink = ImmutableMessageRouterSink.builder()
                .aafCredentials(ImmutableAafCredentials.builder()
                        .username("username")
                        .password("password").build())
                .
                .
                .
                .build();

    final MessageRouterPublishRequest request = ImmutableMessageRouterPublishRequest.builder()
                .sinkDefinition(sink)
                .
                .
                .
                .build();

* subscriber:

.. code-block:: java

    final MessageRouterSource sourceDefinition = ImmutableMessageRouterSource.builder()
                .aafCredentials(ImmutableAafCredentials.builder()
                        .username("username")
                        .password("password")
                        .build())
                .
                .
                .
                .build();

    final MessageRouterSubscribeRequest request = ImmutableMessageRouterSubscribeRequest.builder()
                .sourceDefinition(sourceDefinition)
                .
                .
                .
                .build();

AAF Credentials are optional for subscribe/publish requests.
Username and password are used for basic authentication header during sending HTTP request to dmaap-mr.

hvvesclient-producer - a reference Java implementation of High Volume VES Collector client
------------------------------------------------------------------------------------------
This library is used in xNF simulator which helps us test HV VES Collector in CSIT tests. You may use it as a reference when implementing your code in non-JVM language or directly when using Java/Kotlin/etc.

Sample usage:

.. code-block:: java

    final ProducerOptions producerOptions = ImmutableProducerOptions.builder()
            .collectorAddresses(HashSet.of(
                    InetSocketAddress.createUnresolved("dcae-hv-ves-collector", 30222)))
            .build();
    final HvVesProducer hvVesProducer = HvVesProducerFactory.create(producerOptions);

    Flux<VesEvent> events; // ...
    Mono.from(hvVesProducer.send(events))
            .doOnSuccess(() -> logger.info("All events has been sent"))
            .doOnError(ex -> logger.warn("Failed to send one or more events", ex))
            .subscribe();

external-schema-manager - JSON Validator with schema mapping
------------------------------------------------------------
This library can be used to validate any JSON content incoming as JsonNode. What differs it from other validation
libraries is mapping of externally located schemas to local schema files.

Validated JSON must have one field that will refer to an external schema, which will be mapped to local file and then
validation of any chosen part of JSON is executed using local schema.

Mapping file is cached on validator creation, so it's not read every time validation is performed.
Schemas' content couldn't be cached due to external library restrictions (OpenAPI4j).

Example JSON:

.. code-block:: json

    {
        "schemaReference": "https://forge.3gpp.org/rep/sa5/data-models/blob/REL-16/OpenAPI/faultMnS.yaml",
        "data":
        {
            "exampleData: "SAMPLE_VALUE"
        }
    }

Interface:

There are two methods, that are interface of this sub-project.

Validator builder:

.. code-block:: java

    new StndDefinedValidator.ValidatorBuilder()
            .mappingFilePath(mappingFilePath)
            .schemasPath(schemasPath)
            .schemaRefPath(schemaRefPath)
            .stndDefinedDataPath(stndDefinedDataPath)
            .build();


Validator usage:

.. code-block:: java

    stndDefinedValidator.validate(event);

There are 4 string parameters of the builder:

.. csv-table:: **String parameters of the builder**
    :header: "Name", "Description", "Example", "Note"
    :widths: 10, 20, 20, 20

    "mappingFilePath", "This should be a local filesystem path to file with mappings of public URLs to local URLs. Format of the schema mapping file is a JSON file with list of mappings", "etc/externalRepo/schema-map.json", " "
    "schemasPath", "Schemas path is a directory under which external-schema-manager will search for local schemas", "./etc/externalRepo/ and first mapping from example mappingFile is taken, validator will look for schema under the path: ./etc/externalRepo/3gpp/rep/sa5/data-models/blob/REL-16/OpenAPI/faultMnS.yaml", " "
    "schemaRefPath", "This is an internal path from validated JSON. It should define which field will be taken as public schema reference, which is later mapped", "/event/stndDefinedFields/schemaReference", "In SDK version 1.4.2 this path doesn't use JSON path notation (with . signs). It might change in further versions"
    "stndDefinedDataPath", "This is path to stndDefined data in JSON. This fields will be validated during stndDefined validation.", "/event/stndDefinedFields/data", "In SDK version 1.4.2 this path doesn't use JSON path notation (with . signs). It might change in further versions."


Format of the schema mapping file is a JSON file with list of mappings, as shown in the example below.

.. code-block:: json

    [
        {
            "publicURL": "https://forge.3gpp.org/rep/sa5/data-models/blob/REL-16/OpenAPI/faultMnS.yaml",
            "localURL": "3gpp/rep/sa5/data-models/blob/REL-16/OpenAPI/faultMnS.yaml"
        },
        {
            "publicURL": "https://forge.3gpp.org/rep/sa5/data-models/blob/REL-16/OpenAPI/heartbeatNtf.yaml",
            "localURL": "3gpp/rep/sa5/data-models/blob/REL-16/OpenAPI/heartbeatNtf.yaml"
        },
        {
            "publicURL": "https://forge.3gpp.org/rep/sa5/data-models/blob/REL-16/OpenAPI/PerDataFileReportMnS.yaml",
            "localURL": "3gpp/rep/sa5/data-models/blob/REL-16/OpenAPI/PerDataFileReportMnS.yaml"
        },
        {
            "publicURL": "https://forge.3gpp.org/rep/sa5/data-models/blob/master/OpenAPI/provMnS.yaml",
            "localURL": "3gpp/rep/sa5/data-models/blob/REL-16/OpenAPI/provMnS.yaml"
        }
    ]

**Possible scenarios when using external-schema-manger:**

When the schema-map file, the schema and the sent event are correct, then the validation is successful and the log
shows "Validation of stndDefinedDomain has been successful".

Errors in the schema-map - none of the mappings are cached:

- When no schema-map file exists, "Unable to read mapping file. Mapping file path: {}" is logged.
- When a schema-map file exists, but has an incorrect format, a warning is logged: "Schema mapping file has incorrect format. Mapping file path: {}"

Errors in one of the mappings in schema-map - this mapping is not cached, a warning is logged "Mapping for publicURL ({}) will not be cached to validator.":

- When the local url in the schema-map file references a file that does not exist, the warning "Local schema resource missing. Schema file with path {} has not been found."
- When the schema file is empty, the information "Schema file is empty. Schema path: {}" is logged
- When a schema file has an incorrect format (not a yaml), the following information is logged: Schema has incorrect YAML structure. Schema path: {} "

Errors in schemaRefPath returns errors:

- If in the schemaRef path in the event we provide an url that refers to an existing schema, but the part after # refers to a non-existent part of it, then an error is thrown: IncorrectInternalFileReferenceException ("Schema reference refer to existing file, but internal reference (after #) is incorrect.") "
- When in the schemaRef path in the event, we provide a url that refers to a non-existent mapping from public to localURL, a NoLocalReferenceException is thrown, which logs to the console: "Couldn't find mapping for public url. PublicURL: {}"
