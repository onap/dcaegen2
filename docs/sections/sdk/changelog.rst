Changelog
=========

**1.5.0-SNAPSHOT**
    - Update sprint boot to version: 2.4.0
    - Update reactor to version: 2020.0.1
    - Update testcontainers to version: 1.15.0

**1.4.4-SNAPSHOT**
    - Fix CbsClientFactory to allow retry on Mono from createCbsClient

**1.4.3-SNAPSHOT**
    - Change parameters of external-schema-manager to JSON notation

**1.4.2-SNAPSHOT**
    - Update spring boot to version: 2.3.3.RELEASE

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
