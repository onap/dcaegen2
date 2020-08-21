Available APIs
==============

.. toctree::
    :depth: 3


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

.. code-block:: java

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
------------------------------------------------------------------------------------------
This library can be used to validate any JSON content incoming as JsonNode. What differs it from other validation
libraries is mapping of externally located schemas to local schema files.

Validated JSON must have one field that will refer to an external schema, which will be mapped to local file and then
validation of any chosen part of JSON is executed using local schema.

Mapping file is cached on validator creation, so it's not read every time validation is performed.
Schemas couldn't be mapped due to external library restrictions (OpenAPI4j).

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

There are 4 string parameters of the builder.

- mappingFilePath: this should be a local filesystem path to file with mappings of public URLs to localURLs.
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

- schemasPath: schemas path is a directory under which external-schema-manager will search for local schemas.
For example, when this parameter is set to: "./etc/externalRepo/" and first mapping from example mappingFile is taken,
validator will look for schema under the path:
./etc/externalRepo/3gpp/rep/sa5/data-models/blob/REL-16/OpenAPI/faultMnS.yaml

- schemaRefPath: this is internal path from validated JSON. It should define which field will be taken as public
schema reference, which is later mapped. Example: "/event/stndDefinedFields/schemaReference".

NOTE: in SDK version 1.4.2 this path doesn't use JSON path notation (with . signs). It might change in further versions.

- schemaRefPath: this is internal path from validated JSON. It should define which field will be validated.
Example: "/event/stndDefinedFields/data".

NOTE: in SDK version 1.4.2 this path doesn't use JSON path notation (with . signs). It might change in further versions.

Possible scenarios when using external-schema-manger:
// todo