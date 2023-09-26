.. This work is licensed under a Creative Commons Attribution 4.0 International License.
.. http://creativecommons.org/licenses/by/4.0

SDK Overview
============

.. toctree::
    :maxdepth: 3

Architecture
------------

Introduction
~~~~~~~~~~~~
As most services and collectors deployed on DCAE platform relies on similar microservices a common Software Development Kit has been created. It contains utilities and clients which may be used for getting configuration from CBS, consuming messages from DMaaP, etc. SDK is written in Java.

Some of common function across different services are targeted to build as separate library.

Reactive programming
~~~~~~~~~~~~~~~~~~~~
Most of SDK APIs are using Project Reactor, which is one of available implementations of Reactive Streams (as well as Java 9 Flow). Due to this fact SDK supports both high-performance, non-blocking asynchronous clients and old-school, thread-bound, blocking clients. Reactive programming can solve many cloud-specific problems - if used properly.

Before using DCAE SDK, please take a moment and read `Project Reactor documentation <https://projectreactor.io/docs/core/release/reference/>`_. You should also skim through methods available in `Flux <https://projectreactor.io/docs/core/release/api/reactor/core/publisher/Flux.html>`_ and `Mono <https://projectreactor.io/docs/core/release/api/reactor/core/publisher/Mono.html>`_.

Rx short intro
++++++++++++++
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
+++++++++++++++++++++++++++++++++++
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

Environment substitution
~~~~~~~~~~~~~~~~~~~~~~~~

CBS-client have ability to insert environment variables into loaded application configuration.
Environment variables in configuration file must be in format `${ENV_NAME}` example:

.. code-block:: yaml

    streams_publishes:
      perf3gpp:
        testArray:
          - testPrimitiveArray:
              - "${AAF_USER}"
              - "${AAF_PASSWORD}"

Libraries
~~~~~~~~~~

DmaaP-MR Client
+++++++++++++++
    * Support for DmaaP MR publish and subscribe
    * Support for DmaaP configuration fetching from Consul
    * Support for authenticated topics pub/sub
    * Standardized logging

    From version 1.9.4, as DMaaP is announced as deprecated project, this library uses Kafka directly instead of DMaaP APIs.

ConfigBindingService Client
+++++++++++++++++++++++++++
    Thin client wrapper to fetch configuration based on exposed properties during deployment from the file on a configMap/volume or from CBS api if configMap/volume does not exist. Provides option to periodically query and capture new configuration changes if any should be returned to application.

Crypt Password
++++++++++++++
    Library to generate and match cryptography password using BCrypt algorithm.

High Volume VES Collector Client Producer
+++++++++++++++++++++++++++++++++++++++++
    A reference Java implementation of High Volume VES Collector client. This library is used in xNF simulator which helps us test HV VES Collector in CSIT tests. You may use it as a reference when implementing your code in non-JVM language or directly when using Java/Kotlin/etc.

External Schema Manager
+++++++++++++++++++++++++++++++++++++++++
    Library to validate JSON with mapping of external schemas to local schema files.
