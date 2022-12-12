.. This work is licensed under a Creative Commons Attribution 4.0 International License.
.. http://creativecommons.org/licenses/by/4.0


Troubleshooting
===============

**NOTE**

According to **ONAP** logging policy, **HV-VES** logs contain all required markers as well as service and client specific Mapped Diagnostic Context (later referred as MDC)

Default console log pattern:

::

        | %date{&quot;yyyy-MM-dd'T'HH:mm:ss.SSSXXX&quot;, UTC}\t| %thread\t| %highlight(%-5level)\t| %msg\t| %marker\t| %rootException\t| %mdc\t| %thread

A sample, fully qualified message implementing this pattern:

::

        | 2018-12-18T13:12:44.369Z	 | p.dcae.collectors.veshv.impl.socket.NettyTcpServer	 | DEBUG	 | Client connection request received	 | ENTRY	 | 	 | RequestID=d7762b18-854c-4b8c-84aa-95762c6f8e62, InstanceID=9b9799ca-33a5-4f61-ba33-5c7bf7e72d07, InvocationID=b13d34ba-e1cd-4816-acda-706415308107, PartnerName=C=PL, ST=DL, L=Wroclaw, O=Nokia, OU=MANO, CN=dcaegen2-hvves-client, StatusCode=INPROGRESS, ClientIPAddress=192.168.0.9, ServerFQDN=a4ca8f96c7e5	 | reactor-tcp-nio-2


For simplicity, all log messages in this section are shortened to contain only:
    * logger name
    * log level
    * message


Error and warning logs contain also:
    * exception message
    * stack trace

Also exact exception's stack traces has been dropped due to readability

**Do not rely on exact log messages or their presence, as they are often subject to change.**

Deployment/Installation errors
------------------------------

**Missing required parameters**

::

    | org.onap.dcae.collectors.veshv.main | ERROR | Failed to create configuration: Base configuration filepath missing on command line
    | org.onap.dcae.collectors.veshv.main | ERROR | Failed to start a server | org.onap.dcae.collectors.veshv.config.api.model.MissingArgumentException: Base configuration filepath missing on command line

These log messages are printed when the single required parameter, configuration file path, was not specified (via command line, or as an environment variable).
Command line arguments have priority over environment variables. If you configure a parameter in both ways, **HV-VES** applies the one from the command line.
For more information about **HV-VES** configuration parameters, see :ref:`deployment`.

Configuration errors
--------------------

**Consul service not available**

::

    | org.onap.dcae.collectors.veshv.config.impl.CbsConfigurationProvider | ERROR | Failed to retrieve CBS client: consul-server: Temporary failure in name resolution
    | org.onap.dcae.collectors.veshv.config.impl.CbsConfigurationProvider | WARN  | Exception from configuration provider client, retrying subscription | java.net.UnknownHostException: consul-server: Temporary failure in name resolution


**HV-VES** looks for Consul under hostname defined in CONSUL_HOST environment variable. If the service is down, above logs will appear and after few retries collector will shut down.


**Config Binding Service not available**

::

    | org.onap.dcae.services.sdk.rest.services.cbs.client.impl.CbsLookup  | INFO  | Config Binding Service address: config-binding-service:10000
    | org.onap.dcae.collectors.veshv.config.impl.CbsConfigurationProvider | INFO  | CBS client successfully created
    | org.onap.dcae.collectors.veshv.config.impl.CbsConfigurationProvider | ERROR | Error while creating configuration: config-binding-service: Temporary failure in name resolution
    | org.onap.dcae.collectors.veshv.config.impl.CbsConfigurationProvider | WARN  | Exception from configuration provider client, retrying subscription

Logs indicate that **HV-VES** successfully retrieved Config Binding Service (later referred as CBS) connection string from Consul, though the address was either incorrect, or the CBS is down.
Make sure CBS is up and running and the connection string stored in Consul is correct.

====

**Missing configuration on Consul**

::

    | org.onap.dcae.services.sdk.rest.services.cbs.client.impl.CbsLookup	 | INFO	 | Config Binding Service address: config-binding-service:10000
    | org.onap.dcae.collectors.veshv.config.impl.CbsConfigurationProvider	 | INFO	 | CBS client successfully created
    | org.onap.dcae.collectors.veshv.config.impl.CbsConfigurationProvider	 | ERROR | Error while creating configuration: Request failed for URL 'http://config-binding-service:10000/service_component/invalid-resource'. Response code: 404 Not Found
    | org.onap.dcae.collectors.veshv.config.impl.CbsConfigurationProvider	 | WARN	 | Exception from configuration provider client, retrying subscription	 | 	 | org.onap.dcaegen2.services.sdk.rest.services.adapters.http.exceptions.HttpException: Request failed for URL 'http://config-binding-service:10000/service_component/dcae-hv-ves-collector'. Response code: 404 Not Found


**HV-VES** logs this information when connected to Consul, but cannot find JSON configuration under given key which in this case is **invalid-resource**.
For more information, see :ref:`run_time_configuration`

====

**Invalid configuration format**

::

    | org.onap.dcae.services.sdk.rest.services.cbs.client.impl.CbsLookup    | INFO  | Config Binding Service address: config-binding-service:10000
    | org.onap.dcae.collectors.veshv.config.impl.CbsConfigurationProvider   | INFO  | CBS client successfully created
    | org.onap.dcae.collectors.veshv.config.impl.CbsConfigurationProvider   | INFO  | Received new configuration:
    | {"streams_publishes":{"perf3gpp":{"typo":"kafka","kafka_info":{"bootstrap_servers":"message-router-kafka:9092","topic_name":"HV_VES_PERF3GPP"}}}}
    | org.onap.dcae.collectors.veshv.config.impl.CbsConfigurationProvider   | ERROR | Error while creating configuration: Could not find sub-node 'type'. Actual sub-nodes: typo, kafka_info
    | org.onap.dcae.collectors.veshv.config.impl.CbsConfigurationProvider   | WARN  | Exception from configuration provider client, retrying subscription | org.onap.dcaegen2.services.sdk.rest.services.cbs.client.api.exceptions.StreamParsingException: Could not find sub-node 'type'. Actual sub-nodes: typo, kafka_info


This log is printed when you upload a configuration in an invalid format
Received json contains invalid Streams configuration, therefore **HV-VES** does not apply it and becomes **unhealthy**.
For more information on dynamic configuration, see :ref:`run_time_configuration`.


Message handling errors
-----------------------

**Handling messages when invalid Kafka url is specified**

::

    | org.onap.dcae.collectors.veshv.impl.socket.NettyTcpServer	| INFO | Handling new client connection
    | org.apache.kafka.clients.ClientUtils	                    | WARN | Removing server invalid-message-router-kafka:9092 from bootstrap.servers as DNS resolution failed for invalid-message-router-kafka
    | org.apache.kafka.clients.producer.KafkaProducer	        | INFO | [Producer clientId=producer-1] Closing the Kafka producer with timeoutMillis = 0 ms.
    | org.onap.dcae.collectors.veshv.impl.HvVesCollector	    | WARN | Error while handling message stream: org.apache.kafka.common.KafkaException (Failed to construct kafka producer)
    | org.onap.dcae.collectors.veshv.impl.socket.NettyTcpServer	| INFO | Connection has been close0d


**HV-VES** responds with the above when it handles a message with domain that has invalid bootstrap_servers specified in **streams_publishes** configuration.
To fix this problem, you have to correct **streams_publishes** configuration stored in Consul.
For more information, see: :ref:`run_time_configuration`.

====

**Kafka service became unavailable after producer has been created**

**HV-VES** lazily creates Kafka producer for each domain.
If Kafka service becomes unreachable after producer initialization, appropriate logs are shown and **HV-VES** fails to deliver future messages to that Kafka service.

::

    | org.apache.kafka.clients.NetworkClient	                        | WARN | [Producer clientId=producer-1] Connection to node 1001 could not be established. Broker may not be available.
    | org.apache.kafka.clients.NetworkClient	                        | WARN | [Producer clientId=producer-1] Connection to node 1001 could not be established. Broker may not be available.
    | org.apache.kafka.clients.NetworkClient	                        | WARN | [Producer clientId=producer-1] Connection to node 1001 could not be established. Broker may not be available.
    | org.apache.kafka.clients.NetworkClient	                        | WARN | [Producer clientId=producer-1] Connection to node 1001 could not be established. Broker may not be available.
    | org.onap.dcae.collector.veshv.impl.socket.NettyTcpServer          | INFO | Handling new client connection
    | org.onap.dcae.collector.veshv.impl.socket.NettyTcpServer          | INFO | Connection has been closed
    | org.apache.kafka.clients.NetworkClient	                        | WARN | [Producer clientId=producer-1] Connection to node 1001 could not be established. Broker may not be available
    | org.onap.dcae.collector.veshv.impl.adapters.kafka.KafkaPublisher  | WARN | Failed to send message to Kafka. Reason: Expiring 1 record(s) for HV_VES_PERF3GPP-0: 30007 ms has passed since batch creation plus linger time
    | org.onap.dcae.collectors.veshv.impl.HvVesCollector                | WARN | Error while handling message stream: org.apache.kafka.common.errors.TimeoutException (Expiring 1 record(s) for HV_VES_PERF3GPP-0: 30007 ms has passed since batch creation plus linger time)
    | org.apache.kafka.clients.NetworkClient	                        | WARN | [Producer clientId=producer-1] Error connecting to node message-router-kafka:9092 (id: 1001 rack: null)


To resolve this issue, you can either wait for that Kafka service to be available, or just like in previous paragraph, provide alternative Kafka bootstrap server via dynamic configuration (see :ref:`run_time_configuration`.)

====

**Message with too big payload size**

::

    | org.onap.dcae.collectors.veshv.impl.socket.NettyTcpServer | INFO	| Handling new client connection
    | org.onap.dcae.collectors.veshv.impl.wire.WireChunkDecoder | WARN	| Error while handling message stream: org.onap.dcae.collectors.veshv.impl.wire.WireFrameException (PayloadSizeExceeded: payload size exceeds the limit (1048576 bytes))
    | org.onap.dcae.collectors.veshv.impl.socket.NettyTcpServer | INFO	| Connection has been closed


The above log is printed when the message payload size is too big.
**HV-VES** does not handle messages that exceed maximum payload size specified under streams_publishes configuration (see :ref:`dmaap-connection-objects`)

====

**Invalid GPB data**

Messages with invalid Google Protocol Buffers data encoded are omitted. **HV-VES** responds as follows:

::

    | org.onap.dcae.collectors.veshv.impl.socket.NettyTcpServer	 | INFO	 | Handling new client connection
    | org.onap.dcae.collectors.veshv.impl.HvVesCollector	     | WARN	 | Failed to decode ves event header, reason: Protocol message tag had invalid wire type.
    | org.onap.dcae.collectors.veshv.impl.socket.NettyTcpServer	 | INFO	 | Connection has been closed

====

**Invalid Wire Frame**

Messages with invalid Wire Frame, just like those containing invalid GPB data, will be dropped. The exact reason can be found in logs.

::

    | org.onap.dcae.collectors.veshv.impl.socket.NettyTcpServer	 | INFO	 | Handling new client connection
    | org.onap.dcae.collectors.veshv.impl.HvVesCollector	     | WARN	 | Invalid wire frame header, reason: Invalid major version in wire frame header. Expected 1 but was 2
    | org.onap.dcae.collectors.veshv.impl.socket.NettyTcpServer	 | INFO	 | Connection has been closed

====


For more information, see the :ref:`hv_ves_behaviors` section.


Authorization related errors
----------------------------

**For more information, see** :ref:`ssl_tls_authorization`.

**Key or trust store missing**

::

    | org.onap.dcae.collectors.veshv.main | ERROR | Failed to start a server | java.nio.file.NoSuchFileException: /etc/ves-hv/server.p12



The above error is logged when key store is not provided. Similarly, when trust store is not provided, **/etc/ves-hv/trust.p12** file missing is logged.
They can be changed by specifying ``security.keys.trustStore`` or ``security.keys.keyStore`` file configuration entries.

For testing purposes there is possibility to use plain TCP protocol. In order to do this navigate with your browser to consul-ui service and than pick KEY/VALUE tab. Select dcae-hv-ves-collector and change ``security.sslDisable`` to true. Update of configuration should let start TCP server without SSL/TLS configured.

In order to disable TLS/SSL by overriding Cloudify blueprint inputs, see :ref:`running_insecure`.

====

**Invalid credentials**

::

    | org.onap.dcae.collectors.veshv.main | ERROR | Failed to start a server | java.security.UnrecoverableKeyException: failed to decrypt safe contents entry: javax.crypto.BadPaddingException: Given final block not properly padded. Such issues can arise if a bad key is used during decryption.


Key or trust store password provided in configuration is invalid.

====

**Empty line at the end of password file**

::

    | org.onap.dcae.collectors.veshv.main | ERROR | Failed to start a server | java.security.UnrecoverableKeyException: failed to decrypt safe contents entry: java.io.IOException: getSecretKey failed: Password is not ASCII


Password file should not contain empty line at the end, otherwise server startup fails.

====

**Invalid key store file**

::

    | org.onap.dcae.collectors.veshv.main	 | ERROR	 | Failed to start a server	 | java.io.EOFException: Detect premature EOF


The above is logged when provided keystore has invalid or corrupted content.
This log also appears when you try to use key store/trust store in archive format other than inferred from file extension.
