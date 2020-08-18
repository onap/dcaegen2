.. This work is licensed under a Creative Commons Attribution 4.0 International License.
.. http://creativecommons.org/licenses/by/4.0

Architecture
============

Introduction
------------
As most services and collectors deployed on DCAE platform relies on similar microservices a common Software Development Kit has been created. It contains utilities and clients which may be used for getting configuration from CBS, consuming messages from DMaaP, interacting with A&AI, etc. SDK is written in Java.

Some of common function across different services are targeted to build as separate library.

Reactive programming
--------------------
Most of SDK APIs are using Project Reactor, which is one of available implementations of Reactive Streams (as well as Java 9 Flow). Due to this fact SDK supports both high-performance, non-blocking asynchronous clients and old-school, thread-bound, blocking clients. Reactive programming can solve many cloud-specific problems - if used properly.

Before using DCAE SDK, please take a moment and read `Project Reactor documentation <https://projectreactor.io/docs/core/release/reference/>`_. You should also skim through methods available in `Flux <https://projectreactor.io/docs/core/release/api/reactor/core/publisher/Flux.html>`_ and `Mono <https://projectreactor.io/docs/core/release/api/reactor/core/publisher/Mono.html>`_.

Rx short intro
~~~~~~~~~~~~~~
For general introduction please read `3rd section of Reactor Documentation <https://projectreactor.io/docs/core/release/reference/#intro-reactive>`_.

Some general notes:
    - In Project Reactor you have two reactive streams' types at your disposal: Mono which may emit at most 1 element and Flux which may emit 0, finite or infinite number of elements.
    - Both of them may end with error. In such situation the stream ends immediately. After stream is terminated (normally or because of error) it won't emit any new elements. You may use retry operators to resubscribe to events in case of error. In cloud environment retryWhen is especially usable: you may use it together with `reactor-extra retry functionality <https://projectreactor.io/docs/extra/release/api/reactor/retry/Retry.html>`_ in order to support more advanced reaction to unreachable peer microservice.
    - If you do not have any background in functional operators like map, flatMap,  please take a time to understand them. The general meaning is similar as in Java 8 Streams API. They are the most common operators used in reactive applications. Especially flatMap is very powerful despite its simplicity.
    - There is a large group of operators which deal with time dimension of the stream, eg. buffer, window,  delay*, timeout etc.
    - Be aware that calling aggregation operators (count, collect, etc.) on infinite Flux makes no sense. In worst case scenario you can end JVM with OoM error.
    - There is a nice intro to operators in `Appendix A of Reactor Documentation <https://projectreactor.io/docs/core/release/reference/#which-operator>`_. You should also learn how to read Marble Diagrams which concisely describe operators in a graphical form. Fortunately they are quite easy to grasp.
    - Do not block in any of handlers which are passed to operators defined by Reactor. The library uses a set of Schedulers (think thread-pools) which are suitable for different jobs. `More details <https://projectreactor.io/docs/core/release/reference/#schedulers>`_ can be found in the documentation. If possible try to use non-blocking APIs.
    - Most of operators support back-pressure. That means that a demand for new messages will be signalized from downstream subscribers. For instance if you have a flux.flatMap(this::doThis).map(this::doThat).subscribe() then if doThis is very slow it will not request many items from source flux and it will emit items at it's own pace for doThat to process. So usually there will be no buffering nor blocking needed between flux and doThis.
    - (Almost) nothing will happen without subscribing to the Flux/Mono. These reactive streams are lazy, so the demand will be signaled only when subscription is being made ie. by means of subscribe or block* methods.
    - If you are going to go fully-reactive then you should probably not call subscribe/block anywhere in your code. For instance, when using Reactor Netty or Spring Web Flux you should return Mono/Flux from your core methods and it will be subscribed somewhere by the library you are using.
    - Return Mono<Void> in case you want to return from the method a listener to some processing being done. You may be tempted to return Disposable (result of subscribe()) but it won't compose nicely in reactive flow. Using then() operator is generally better as you can handle onComplete and onError events in the client code.

Handling errors in reactive streams
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
As noted above a reactive stream (Flux/Mono) terminates on first exception in any of the stream operators. For instance if Flux.map throws an exception, downstream operators won't receive onNext event. onError event will be propagated instead. It is a terminal event so the stream will be finished. This fail-fast behavior is a reasonable default but sometimes you will want to avoid it. For instance when polling for the updates from a remote service you may want to retry the call when the remote service is unavailable at a given moment. In such cases you might want to retry the stream using `one of retry* operators <https://projectreactor.io/docs/core/release/api/reactor/core/publisher/Flux.html#retry-->`_.

.. code-block:: java

    // Simple retry on error with error type check/
    // It will immediately retry stream failing with IOException
    public Mono<String> fetchSomething() {
        Mono<Response> restResponse = ...
        return restResponse
                .retry(ex -> ex instanceof IOException)
                .map(resp -> ...);
    }

    // Fancy retry using reactor-extra library
    // It will retry stream on IOException after some random time as specified in randomBackoff JavaDoc
    public Mono<String> fetchSomething() {
        Mono<Response> restResponse = ...
        Retry retry = Retry.anyOf(IOException.class)
                     .randomBackoff(Duration.ofMillis(100), Duration.ofSeconds(60));
        return restResponse
                .retryWhen(retry)
                .map(resp -> ...);
    }

Libraries:
----------

DmaaP-MR Client
~~~~~~~~~~~~~~~
    * Support for DmaaP MR publish and subscribe
    * Support for DmaaP configuration fetching from Consul
    * Support for authenticated topics pub/sub
    * Standardized logging

ConfigBindingService Client
~~~~~~~~~~~~~~~~~~~~~~~~~~~
    Thin client wrapper to invoke CBS api to fetch configuration based on exposed properties during deployment. Provides option to periodically query and capture new configuration changes if any should be returned to application.

Changelog
---------
**1.4.1-SNAPSHOT**
    - Update spring boot to version: 2.2.9.RELEASE
    - Update testcontainers version:  1.14.3
    - Fix deprecation warnings

**1.4.0-SNAPSHOT**
    - Add new component external-schema-manager for json validation with schema stored in local cache

**1.3.5-SNAPSHOT**
    - Create jar without dependencies for crypt-password module

**1.3.4-SNAPSHOT**
    - Usage of Java 11

**1.3.3-SNAPSHOT**
    - Upgrade CBS to support SSL
    - Fix static code vulnerabilities
    - Exclude IT from tests
    - Remove AAI client from SDK

**1.3.2-SNAPSHOT**
    - Restructure AAI client

    - Get rid of common-dependency module
    - Rearrange files in packages inside rest-services

**1.3.1-SNAPSHOT**
    - Bugfix release: AAI client
        - Make AaiGetServiceInstanceClient build correct path to the service resource in AAI

**1.3.0-SNAPSHOT (ElAlto - under development)**
    - All El-Alto work noted under 1.2.0-SNAPSHOT will roll into this version
    - Version update was done for tracking global-jjb migration work and corresponding submission - https://gerrit.onap.org/r/#/c/dcaegen2/services/sdk/+/89902/

**1.2.0-SNAPSHOT (replaced by 1.3.0)**
    - WARNING: This is a work in progress. Do not use unless you know what you are doing!

    - DMaaP client
        - Change the factory so it's more configurable
        - Old DMaaP client is now deprecated
        - Integration tests are now using TestContainers with an actual DMaaP in order to confirm compatibility with a particular DMaaP version.
        - Breaking change: MessageRouterSubscribeResponse now contains list of JsonElement instead of JsonArray
    - CBS client
        - Use new, simplified CBS lookup method
        - Breaking change: CbsClientConfiguration replaces old EnvProperties. This way the class reflects overall SDK naming convention.
    - Crypt Password
        - Additional command line usage options (read password from stdin)
        - Enhanced test coverage
    - Internals/others
        - Remove CloudHttpClient and use RxHttpClient instead which should unify REST API consumption across client libraries
    - Moher (MOnitoring and HEalthcheck Rest API)
        - This API is in incubation stage. Do not use it yet.
        - Initial PoC for new module which should help when implementing these features in a DCAE service
        - Expose Prometheus-compliant monitoring endpoint

**1.1.6**
    - Bugfix release: (Old) DMaaP client:
        - Security keys was always loaded from JAR instead of given file system path. Only code using SecurityKeysUtil class had been affected. If you do not use SecurityKeysUtil class or you are using the new DMaaP MR client API (org.onap.dcaegen2.services.sdk.rest.services.dmaap.client.{api, model} packages) then you are safe and the update is not required.

**1.1.5**
    - DMaaP client
        - Force non-chunked transfer encoding, because DMaaP MR does not support chunks.
        - DMaaP MR client API should be used in new code. Some minor incompatible changes can occur but it's more or less done.

**1.1.4**
    - Config Binding Service client
        - predefined parsers for input and output streams
            - remove the need for a DCAE application to manually interpret streams_publishes (Sinks) and streams_subscribes (Sources) parts of the configuration
            - available parsers for DMaaP Message Router and DMaaP Data Router streams
            - experimental support for Kafka streams
        - support for other CBS endpoints besides get-configuration: get-by-key, get-all (introduces minor but breaking changes)
    - DMaaP client
        - New, experimental DMaaP client. It's not ready for use yet (not integration tested with DMaaP instance). However, you can use this API if you target El Alto release (note that some minor interface changes might be introduced).
    - Internals:
        - Improved http client: RxHttpClient
        - RxHttpClient uses chunked transfer-encoding only when content-length is NOT specified.

Migration guide

All CbsClient methods gets CbsRequest as a first parameter instead of RequestDiagnosticContext. The CbsRequest may be created by calling CbsRequests factory methods. For existing code to work you will need to do the following change:

.. code-block:: java

    // From this:
    CbsClientFactory.createCbsClient(env)
        .flatMap(cbsClient -> cbsClient.get(diagnosticContext))
        ...

    // To this:
    final CbsRequest request = CbsRequests.getConfiguration(diagnosticContext);
    CbsClientFactory.createCbsClient(env)
        .flatMap(cbsClient -> cbsClient.get(request))
        ...


The similar changes will be required for other CbsClient methods (periodic get and periodic updates).

**1.1.3 (initial release)**
    - Config Binding Service client
        - basic functionality
        - CBS service discovery
        - get application configuration as JsonObject
        - periodic query + periodic updates query
    - BCrypt password utility

FAQ
---

General SDK questions
~~~~~~~~~~~~~~~~~~~~~

Where can I find Java Doc API description?
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
JavaDoc JAR package is published together with compiled classes to the ONAP Nexus repository. You can download JavaDoc in your IDE so you will get documentation hints. Alternatively you can use Maven Dependency plugin (classifier=javadoc).

Which Java version is supported?
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
For now we are compiling SDK using JDK 11. Hence we advice to use SDK on JDK 11.

Are you sure Java 11 is supported? I can see a debug log from Netty.
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
If you have enabled a debug log level for Netty packages you might have seen the following log:

.. code-block:: java

    [main] DEBUG i.n.util.internal.PlatformDependent0 - jdk.internal.misc.Unsafe.allocateUninitializedArray(int): unavailable


Background: this is a result of  moving sun.misc.Unsafe to jdk.internal.misc.Unsafe in JDK 9, so if Netty wants to support both pre and post Java 9 it has to check the JDK version and use the class from available package.

It does not have any impact on SDK. SDK still works with this log. You might want to change log level for io.netty package to INFO.

CBS Client
~~~~~~~~~~

When cbsClient.updates() will yield an event?
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
updates will emit changes to the configuration, ie. it will yield an event only when newJsonObject != lastJsonObject (using standard Java equals for comparison). Every check is performed at the specified interval (= it's poll-based).

What does a single JsonObject returned from CbsClient contain?
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
It will consist of the complete JSON representing what CBS/Consul keeps for microservice (and not only the changes).

Note:
 - We have started an implementation for listening to changes in a subtree of JsonObject based on Merkle Tree data structure. For now we are recommending to first convert the JsonObject to domain classes and then subscribe to changes in these objects if you want to have a fine-grained control over update handling. It's an experimental API so it can change or be removed in future releases.

An issue arises when the Flux stream terminates with an error. In that case, since error is a terminal event, stream that updates from Consul is finished. In order to restart periodic CBS fetches, it must be re-subscribed. What is the suggestion about it?
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Please use one of retry operators as described in Handling errors in reactive streams section of DCAE SDK main page. You should probably use a retry operator with a back-off so you won't be retrying immediately (which can result in DDoS attack on CBS).
