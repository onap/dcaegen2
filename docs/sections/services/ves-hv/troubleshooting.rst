.. This work is licensed under a Creative Commons Attribution 4.0 International License.
.. http://creativecommons.org/licenses/by/4.0

.. _troubleshooting:

Troubleshooting
===============

Deployment/Installation errors
------------------------------

**Missing required parameters**

::

  Unexpected error when parsing command line arguments
  usage: java org.onap.dcae.collectors.veshv.main.MainKt
  Required parameters: p, c
  -c,--config-url <arg>              URL of ves configuration on consul
  -d,--first-request-delay <arg>     Delay of first request to consul in
                    seconds
  -H,--health-check-api-port <arg>   Health check rest api listen port
  -I,--request-interval <arg>        Interval of consul configuration
                    requests in seconds
  -i,--idle-timeout-sec <arg>        Idle timeout for remote hosts. After
                    given time without any data exchange
                    the
                    connection might be closed.
  -k,--key-store <arg>               Key store in PKCS12 format
  -kp,--key-store-password <arg>     Key store password
  -l,--ssl-disable                   Disable SSL encryption
  -m,--max-payload-size <arg>        Maximum supported payload size in
                    bytes
  -p,--listen-port <arg>             Listen port
  -t,--trust-store <arg>             File with trusted certificate bundle
                    in PKCS12 format
  -tp,--trust-store-password <arg>   Trust store password
  -u,--dummy                         If present will start in dummy mode
                    (dummy external services)
  All parameters can be specified as environment variables using
  upper-snake-case full name with prefix `VESHV_`.


This log message is printed when you do not specify the required parameters (via command line, or in environment variables).
As described in the above log message, there are a few required parameters:
**listen port**, **config url** and either **trust store password** and **key store password** if you want to use SSL, or only **ssl disable** if not.

To get rid of this error, specify the required parameters. For example:

- Via command line:

::

    <hv-ves run command> --listen-port 6061 --config-url http://consul-url/key-path --key-store-password password --trust-store-password password

- By defining environment variables:

::

    export VESHV_LISTEN_PORT=6061
    export VESHV_CONFIG_URL=http://consul-url/key-path
    export VESHV_KEY_STORE_PASSWORD=password
    export VESHV_TRUST_STORE_PASSWORD=password

**NOTE**

Command line arguments have priority over environment variables. If you configure a parameter in both ways, **HV-VES** applies the one from the command line.

For more information about **HV-VES** configuration parameters, see :ref:`deployment`.

Configuration errors
--------------------

**Consul service not responding**

::

    ap.dcae.collectors.veshv.impl.adapters.HttpAdapter | 2018-10-16T13:13:01.155Z | ERROR | Failed to get resource on path: http://localhost:8500/v1/hv/veshv-config (Connection refused: localhost/127.0.0.1:8500) |  | reactor-http-client-epoll-8
    ap.dcae.collectors.veshv.impl.adapters.HttpAdapter | 2018-10-16T13:13:01.155Z | DEBUG | Nested exception: | java.net.ConnectException: Connection refused
        ... 10 common frames omitted
    Wrapped by: io.netty.channel.AbstractChannel$AnnotatedConnectException: Connection refused: localhost/127.0.0.1:8500
        at sun.nio.ch.SocketChannelImpl.checkConnect(Native Method)
        at sun.nio.ch.SocketChannelImpl.finishConnect(SocketChannelImpl.java:717)
        at io.netty.channel.socket.nio.NioSocketChannel.doFinishConnect(NioSocketChannel.java:327)
        at io.netty.channel.nio.AbstractNioChannel$AbstractNioUnsafe.finishConnect(AbstractNioChannel.java:340)
        at io.netty.channel.nio.NioEventLoop.processSelectedKey(NioEventLoop.java:616)
        at io.netty.channel.nio.NioEventLoop.processSelectedKeysOptimized(NioEventLoop.java:563)
        at io.netty.channel.nio.NioEventLoop.processSelectedKeys(NioEventLoop.java:480)
        at io.netty.channel.nio.NioEventLoop.run(NioEventLoop.java:442)
        at io.netty.util.concurrent.SingleThreadEventExecutor$5.run(SingleThreadEventExecutor.java:884)
        at java.lang.Thread.run(Thread.java:748)
     | reactor-http-client-epoll-8
    rs.veshv.impl.adapters.ConsulConfigurationProvider | 2018-10-16T13:13:01.163Z | WARN  | Could not get fresh configuration | java.net.ConnectException: Connection refused
        ... 10 common frames omitted
    Wrapped by: io.netty.channel.AbstractChannel$AnnotatedConnectException: Connection refused: localhost/127.0.0.1:8500
        at sun.nio.ch.SocketChannelImpl.checkConnect(Native Method)
        at sun.nio.ch.SocketChannelImpl.finishConnect(SocketChannelImpl.java:717)
        at io.netty.channel.socket.nio.NioSocketChannel.doFinishConnect(NioSocketChannel.java:327)
        at io.netty.channel.nio.AbstractNioChannel$AbstractNioUnsafe.finishConnect(AbstractNioChannel.java:340)
        at io.netty.channel.nio.NioEventLoop.processSelectedKey(NioEventLoop.java:616)
        at io.netty.channel.nio.NioEventLoop.processSelectedKeysOptimized(NioEventLoop.java:563)
        at io.netty.channel.nio.NioEventLoop.processSelectedKeys(NioEventLoop.java:480)
        at io.netty.channel.nio.NioEventLoop.run(NioEventLoop.java:442)
        at io.netty.util.concurrent.SingleThreadEventExecutor$5.run(SingleThreadEventExecutor.java:884)
        at java.lang.Thread.run(Thread.java:748)
     | reactor-http-client-epoll-8



The above three logs indicate that **HV-VES** cannot connect to the Consul service under url given in **--consul-url** parameter.
Make sure Consul is up and running and the **ip + port** combination is correct.

====

**Missing configuration on Consul**

::

    ap.dcae.collectors.veshv.impl.adapters.HttpAdapter | 2018-10-16T13:52:20.585Z | ERROR | Failed to get resource on path: http://consul:8500/v1/kv/veshv-config (HTTP request failed with code: 404.
    Failing URI: /v1/kv/veshv-config) |  | reactor-http-nio-1
    ap.dcae.collectors.veshv.impl.adapters.HttpAdapter | 2018-10-16T13:52:20.586Z | DEBUG | Nested exception: | reactor.ipc.netty.http.client.HttpClientException: HTTP request failed with code: 404.
    Failing URI: /v1/kv/veshv-config
     | reactor-http-nio-1
    rs.veshv.impl.adapters.ConsulConfigurationProvider | 2018-10-16T13:52:20.591Z | WARN  | Could not get fresh configuration | reactor.ipc.netty.http.client.HttpClientException: HTTP request failed with code: 404.
    Failing URI: /v1/kv/veshv-config
     | reactor-http-nio-1


**HV-VES** logs this information when connected to Consul, but cannot find any json configuration under given key which in this case is **veshv-config**.
For more information, see :ref:`run_time_configuration`

====

**Invalid configuration format**

::

    rs.veshv.impl.adapters.ConsulConfigurationProvider | 2018-10-16T14:06:14.792Z | INFO  | Obtained new configuration from consul:
    {
        "invalidKey": "value"
    } |  | reactor-http-nio-1
    rs.veshv.impl.adapters.ConsulConfigurationProvider | 2018-10-16T14:06:14.796Z | WARN  | Could not get fresh configuration | java.lang.NullPointerException: null
        at org.glassfish.json.JsonObjectBuilderImpl$JsonObjectImpl.getString(JsonObjectBuilderImpl.java:257)
        at org.onap.dcae.collectors.veshv.impl.adapters.ConsulConfigurationProvider.createCollectorConfiguration(ConsulConfigurationProvider.kt:113)
        at org.onap.dcae.collectors.veshv.impl.adapters.ConsulConfigurationProvider.access$createCollectorConfiguration(ConsulConfigurationProvider.kt:44)
        at org.onap.dcae.collectors.veshv.impl.adapters.ConsulConfigurationProvider$invoke$6.invoke(ConsulConfigurationProvider.kt:80)
        at org.onap.dcae.collectors.veshv.impl.adapters.ConsulConfigurationProvider$invoke$6.invoke(ConsulConfigurationProvider.kt:44)
        at org.onap.dcae.collectors.veshv.impl.adapters.ConsulConfigurationProvider$sam$java_util_function_Function$0.apply(ConsulConfigurationProvider.kt)
        at reactor.core.publisher.FluxMap$MapSubscriber.onNext(FluxMap.java:100)
        at reactor.core.publisher.FluxMap$MapSubscriber.onNext(FluxMap.java:108)
        at reactor.core.publisher.FluxFlatMap$FlatMapMain.tryEmitScalar(FluxFlatMap.java:432)
        at reactor.core.publisher.FluxFlatMap$FlatMapMain.onNext(FluxFlatMap.java:366)
        at reactor.core.publisher.FluxMap$MapSubscriber.onNext(FluxMap.java:108)
        at reactor.core.publisher.FluxMap$MapSubscriber.onNext(FluxMap.java:108)
        at reactor.core.publisher.FluxFlatMap$FlatMapMain.tryEmit(FluxFlatMap.java:484)
        at reactor.core.publisher.FluxFlatMap$FlatMapInner.onNext(FluxFlatMap.java:916)
        at reactor.core.publisher.FluxMapFuseable$MapFuseableSubscriber.onNext(FluxMapFuseable.java:115)
        at reactor.core.publisher.Operators$MonoSubscriber.complete(Operators.java:1083)
        at reactor.core.publisher.MonoFlatMap$FlatMapInner.onNext(MonoFlatMap.java:241)
        at reactor.core.publisher.MonoNext$NextSubscriber.onNext(MonoNext.java:76)
        at reactor.core.publisher.FluxMap$MapSubscriber.onNext(FluxMap.java:108)
        at reactor.core.publisher.FluxFilter$FilterSubscriber.onNext(FluxFilter.java:97)
        at reactor.ipc.netty.channel.FluxReceive.drainReceiver(FluxReceive.java:213)
        at reactor.ipc.netty.channel.FluxReceive.onInboundNext(FluxReceive.java:329)
        at reactor.ipc.netty.channel.ChannelOperations.onInboundNext(ChannelOperations.java:311)
        at reactor.ipc.netty.http.client.HttpClientOperations.onInboundNext(HttpClientOperations.java:605)
        at reactor.ipc.netty.channel.ChannelOperationsHandler.channelRead(ChannelOperationsHandler.java:138)
        at io.netty.channel.AbstractChannelHandlerContext.invokeChannelRead(AbstractChannelHandlerContext.java:362)
        at io.netty.channel.AbstractChannelHandlerContext.invokeChannelRead(AbstractChannelHandlerContext.java:348)
        at io.netty.channel.AbstractChannelHandlerContext.fireChannelRead(AbstractChannelHandlerContext.java:340)
        at io.netty.channel.CombinedChannelDuplexHandler$DelegatingChannelHandlerContext.fireChannelRead(CombinedChannelDuplexHandler.java:438)
        at io.netty.handler.codec.ByteToMessageDecoder.fireChannelRead(ByteToMessageDecoder.java:310)
        at io.netty.handler.codec.ByteToMessageDecoder.channelRead(ByteToMessageDecoder.java:284)
        at io.netty.channel.CombinedChannelDuplexHandler.channelRead(CombinedChannelDuplexHandler.java:253)
        at io.netty.channel.AbstractChannelHandlerContext.invokeChannelRead(AbstractChannelHandlerContext.java:362)
        at io.netty.channel.AbstractChannelHandlerContext.invokeChannelRead(AbstractChannelHandlerContext.java:348)
        at io.netty.channel.AbstractChannelHandlerContext.fireChannelRead(AbstractChannelHandlerContext.java:340)
        at io.netty.channel.DefaultChannelPipeline$HeadContext.channelRead(DefaultChannelPipeline.java:1434)
        at io.netty.channel.AbstractChannelHandlerContext.invokeChannelRead(AbstractChannelHandlerContext.java:362)
        at io.netty.channel.AbstractChannelHandlerContext.invokeChannelRead(AbstractChannelHandlerContext.java:348)
        at io.netty.channel.DefaultChannelPipeline.fireChannelRead(DefaultChannelPipeline.java:965)
        at io.netty.channel.nio.AbstractNioByteChannel$NioByteUnsafe.read(AbstractNioByteChannel.java:163)
        at io.netty.channel.nio.NioEventLoop.processSelectedKey(NioEventLoop.java:628)
        at io.netty.channel.nio.NioEventLoop.processSelectedKeysOptimized(NioEventLoop.java:563)
        at io.netty.channel.nio.NioEventLoop.processSelectedKeys(NioEventLoop.java:480)
        at io.netty.channel.nio.NioEventLoop.run(NioEventLoop.java:442)
        at io.netty.util.concurrent.SingleThreadEventExecutor$5.run(SingleThreadEventExecutor.java:884)
        at java.lang.Thread.run(Thread.java:748)
     | reactor-http-nio-1


This log is printed when you upload a configuration in an invalid format (for example, with missing fields). In the first log you can see that configuration on Consul is:

.. code-block:: json

    {
        "invalidKey": "value"
    }

The above is not a valid **HV-VES** configuration, therefore **HV-VES** does not apply it and becomes **unhealthy**.
For more information on **Consul configuration**, see :ref:`run_time_configuration`.


Message handling errors
-----------------------

**Handling messages when invalid kafka url is specified**

::

     | reactor-tcp-server-epoll-6
                  org.apache.kafka.clients.ClientUtils | 2018-10-19T08:29:36.917Z | WARN  | Removing server invalid-kafka:9093 from bootstrap.servers as DNS resolution failed for invalid-kafka |  | reactor-tcp-server-epoll-6
       org.apache.kafka.clients.producer.KafkaProducer | 2018-10-19T08:29:36.918Z | INFO  | [Producer clientId=producer-1] Closing the Kafka producer with timeoutMillis = 0 ms. |  | reactor-tcp-server-epoll-6
    org.onap.dcae.collectors.veshv.impl.VesHvCollector | 2018-10-19T08:29:36.962Z | WARN  | Error while handling message stream: org.apache.kafka.common.KafkaException (Failed to construct kafka producer) |  | reactor-tcp-server-epoll-6
    org.onap.dcae.collectors.veshv.impl.VesHvCollector | 2018-10-19T08:29:36.966Z | DEBUG | Detailed stack trace | org.apache.kafka.common.config.ConfigException: No resolvable bootstrap urls given in bootstrap.servers
        at org.apache.kafka.clients.ClientUtils.parseAndValidateAddresses(ClientUtils.java:64)
        at org.apache.kafka.clients.producer.KafkaProducer.<init>(KafkaProducer.java:396)
        ... 24 common frames omitted
    Wrapped by: org.apache.kafka.common.KafkaException: Failed to construct kafka producer
        at org.apache.kafka.clients.producer.KafkaProducer.<init>(KafkaProducer.java:441)
        at org.apache.kafka.clients.producer.KafkaProducer.<init>(KafkaProducer.java:285)
        at reactor.kafka.sender.internals.ProducerFactory.createProducer(ProducerFactory.java:33)
        at reactor.kafka.sender.internals.DefaultKafkaSender.lambda$new$0(DefaultKafkaSender.java:90)
        at reactor.core.publisher.MonoCallable.subscribe(MonoCallable.java:57)
        at reactor.core.publisher.MonoPeekFuseable.subscribe(MonoPeekFuseable.java:74)
        at reactor.core.publisher.Mono.subscribe(Mono.java:3088)
        at reactor.core.publisher.MonoProcessor.add(MonoProcessor.java:531)
        at reactor.core.publisher.MonoProcessor.subscribe(MonoProcessor.java:444)
        at reactor.core.publisher.MonoFlatMapMany.subscribe(MonoFlatMapMany.java:49)
        at reactor.core.publisher.FluxPeek.subscribe(FluxPeek.java:80)
        at reactor.core.publisher.FluxFilter.subscribe(FluxFilter.java:52)
        at reactor.core.publisher.FluxMap.subscribe(FluxMap.java:62)
        at reactor.core.publisher.FluxDefer.subscribe(FluxDefer.java:55)
        at reactor.core.publisher.FluxPeek.subscribe(FluxPeek.java:83)
        at reactor.core.publisher.FluxDoFinally.subscribe(FluxDoFinally.java:73)
        at reactor.core.publisher.FluxOnErrorResume.subscribe(FluxOnErrorResume.java:47)
        at reactor.core.publisher.MonoIgnoreElements.subscribe(MonoIgnoreElements.java:37)
        at reactor.ipc.netty.channel.ChannelOperations.applyHandler(ChannelOperations.java:381)
        at reactor.ipc.netty.channel.ChannelOperations.onHandlerStart(ChannelOperations.java:296)
        at io.netty.util.concurrent.AbstractEventExecutor.safeExecute(AbstractEventExecutor.java:163)
        at io.netty.util.concurrent.SingleThreadEventExecutor.runAllTasks(SingleThreadEventExecutor.java:404)
        at io.netty.channel.epoll.EpollEventLoop.run(EpollEventLoop.java:315)
        at io.netty.util.concurrent.SingleThreadEventExecutor$5.run(SingleThreadEventExecutor.java:884)
        at java.lang.Thread.run(Thread.java:748)
     | reactor-tcp-server-epoll-6
    p.dcae.collectors.veshv.impl.socket.NettyTcpServer | 2018-10-19T08:29:36.971Z | INFO  | Connection from /172.26.0.6:55574 has been closed |  | reactor-tcp-server-epoll-6


**HV-VES** responds with the above when it handles a message and currently applied configuration has invalid Kafka bootstrap server defined.
The configuration read from Consul in this case:

.. code-block:: json

    {
        "dmaap.kafkaBootstrapServers": "invalid-kafka:9093",
        "collector.routing": [
                {
                    "fromDomain": "perf3gpp",
                    "toTopic": "HV_VES_PERF3GPP"
                },
                {
                    "fromDomain": "heartbeat",
                    "toTopic": "HV_VES_HEARTBEAT"
                }
        ]
    }

where **invalid-kafka:9093** is not an existing **ip+port** combination.


====

**First creation of topics on kafka**


On the first try of creating and publishing to a given kafka topic, **HV-VES** logs the following warnings and creates the requested topics anyway.

::

    org.apache.kafka.clients.NetworkClient | 2018-10-22T10:11:53.396Z | WARN  | [Producer clientId=producer-1] Error while fetching metadata with correlation id 1 : {HV_VES_PERF3GPP=LEADER_NOT_AVAILABLE} |  | kafka-producer-network-thread | producer-1
    org.apache.kafka.clients.NetworkClient | 2018-10-22T10:11:53.524Z | WARN  | [Producer clientId=producer-1] Error while fetching metadata with correlation id 3 : {HV_VES_PERF3GPP=LEADER_NOT_AVAILABLE} |  | kafka-producer-network-thread | producer-1
    org.apache.kafka.clients.NetworkClient | 2018-10-22T10:11:53.636Z | WARN  | [Producer clientId=producer-1] Error while fetching metadata with correlation id 4 : {HV_VES_PERF3GPP=LEADER_NOT_AVAILABLE} |  | kafka-producer-network-thread | producer-1
    org.apache.kafka.clients.NetworkClient | 2018-10-22T10:11:53.749Z | WARN  | [Producer clientId=producer-1] Error while fetching metadata with correlation id 5 : {HV_VES_PERF3GPP=LEADER_NOT_AVAILABLE} |  | kafka-producer-network-thread | producer-1

====

**Kafka service became unavailable after producer for a given topic was successfully created**


After receiving a **Ves Common Event**, **HV-VES** creates a producer for a given topic and keeps it for the whole lifetime of an application.
If Kafka service becomes unreachable after the producer creation, you will see the following logs when trying to establish another connection with the Kafka server.

::

     org.apache.kafka.clients.NetworkClient | 2018-10-22T10:04:08.604Z | WARN  | [Producer clientId=producer-1] Connection to node 1001 could not be established. Broker may not be available. |  | kafka-producer-network-thread | producer-1
                org.apache.kafka.clients.NetworkClient | 2018-10-22T10:04:11.896Z | WARN  | [Producer clientId=producer-1] Connection to node 1001 could not be established. Broker may not be available. |  | kafka-producer-network-thread | producer-1
                org.apache.kafka.clients.NetworkClient | 2018-10-22T10:04:14.968Z | WARN  | [Producer clientId=producer-1] Connection to node 1001 could not be established. Broker may not be available. |  | kafka-producer-network-thread | producer-1
                org.apache.kafka.clients.NetworkClient | 2018-10-22T10:04:18.040Z | WARN  | [Producer clientId=producer-1] Connection to node 1001 could not be established. Broker may not be available. |  | kafka-producer-network-thread | producer-1
                org.apache.kafka.clients.NetworkClient | 2018-10-22T10:04:21.111Z | WARN  | [Producer clientId=producer-1] Connection to node 1001 could not be established. Broker may not be available. |  | kafka-producer-network-thread | producer-1
     reactor.kafka.sender.internals.DefaultKafkaSender | 2018-10-22T10:04:23.519Z | ERROR | error {} | org.apache.kafka.common.errors.TimeoutException: Expiring 1 record(s) for HV_VES_PERF3GPP-0: 30050 ms has passed since batch creation plus linger time
     | kafka-producer-network-thread | producer-1
    cae.collectors.veshv.impl.adapters.kafka.KafkaSink | 2018-10-22T10:04:23.522Z | WARN  | Failed to send message to Kafka | org.apache.kafka.common.errors.TimeoutException: Expiring 1 record(s) for HV_VES_PERF3GPP-0: 30050 ms has passed since batch creation plus linger time
     | single-1
    org.onap.dcae.collectors.veshv.impl.VesHvCollector | 2018-10-22T10:04:23.528Z | WARN  | Error while handling message stream: org.apache.kafka.common.errors.TimeoutException (Expiring 1 record(s) for HV_VES_PERF3GPP-0: 30050 ms has passed since batch creation plus linger time) |  | single-1

To resolve this issue, **HV-VES** restart is required.

====

**Message with too big payload size**

::

    g.onap.dcae.collectors.veshv.impl.VesHvCollector | 2018-10-19T08:53:18.349Z | WARN  | Error while handling message stream: org.onap.dcae.collectors.veshv.impl.wire.WireFrameException (PayloadSizeExceeded: payload size exceeds the limit (1048576 bytes)) |  | single-1
    org.onap.dcae.collectors.veshv.impl.VesHvCollector | 2018-10-19T08:53:18.349Z | DEBUG | Detailed stack trace | org.onap.dcae.collectors.veshv.impl.wire.WireFrameException: PayloadSizeExceeded: payload size exceeds the limit (1048576 bytes)
        at org.onap.dcae.collectors.veshv.impl.wire.WireChunkDecoder$onError$1$1.invoke(WireChunkDecoder.kt:67)
        at org.onap.dcae.collectors.veshv.impl.wire.WireChunkDecoder$onError$1$1.invoke(WireChunkDecoder.kt:38)
        at arrow.effects.IO$Companion$invoke$1.invoke(IO.kt:28)
        at arrow.effects.IO$Companion$invoke$1.invoke(IO.kt:22)
        at arrow.effects.IORunLoop.step(IORunLoop.kt:50)
        at arrow.effects.IO.unsafeRunTimed(IO.kt:109)
        at arrow.effects.IO.unsafeRunSync(IO.kt:106)
        at org.onap.dcae.collectors.veshv.impl.wire.WireChunkDecoder$generateFrames$1.accept(WireChunkDecoder.kt:61)
        at org.onap.dcae.collectors.veshv.impl.wire.WireChunkDecoder$generateFrames$1.accept(WireChunkDecoder.kt:38)
        at reactor.core.publisher.FluxGenerate.lambda$new$1(FluxGenerate.java:56)
        at reactor.core.publisher.FluxGenerate$GenerateSubscription.slowPath(FluxGenerate.java:262)
        at reactor.core.publisher.FluxGenerate$GenerateSubscription.request(FluxGenerate.java:204)
        at reactor.core.publisher.FluxPeekFuseable$PeekFuseableSubscriber.request(FluxPeekFuseable.java:138)
        at reactor.core.publisher.Operators$MultiSubscriptionSubscriber.set(Operators.java:1454)
        at reactor.core.publisher.Operators$MultiSubscriptionSubscriber.onSubscribe(Operators.java:1328)
        at reactor.core.publisher.FluxPeekFuseable$PeekFuseableSubscriber.onSubscribe(FluxPeekFuseable.java:172)
        at reactor.core.publisher.FluxGenerate.subscribe(FluxGenerate.java:83)
        at reactor.core.publisher.FluxPeekFuseable.subscribe(FluxPeekFuseable.java:86)
        at reactor.core.publisher.FluxDefer.subscribe(FluxDefer.java:55)
        at reactor.core.publisher.Flux.subscribe(Flux.java:6877)
        at reactor.core.publisher.FluxConcatMap$ConcatMapImmediate.drain(FluxConcatMap.java:418)
        at reactor.core.publisher.FluxConcatMap$ConcatMapImmediate.onNext(FluxConcatMap.java:241)
        at reactor.core.publisher.FluxPeek$PeekSubscriber.onNext(FluxPeek.java:185)
        at reactor.core.publisher.FluxPeek$PeekSubscriber.onNext(FluxPeek.java:185)
        at reactor.core.publisher.FluxMap$MapSubscriber.onNext(FluxMap.java:108)
        at reactor.ipc.netty.channel.FluxReceive.drainReceiver(FluxReceive.java:213)
        at reactor.ipc.netty.channel.FluxReceive.onInboundNext(FluxReceive.java:329)
        at reactor.ipc.netty.channel.ChannelOperations.onInboundNext(ChannelOperations.java:311)
        at reactor.ipc.netty.channel.ChannelOperationsHandler.channelRead(ChannelOperationsHandler.java:138)
        at io.netty.channel.AbstractChannelHandlerContext.invokeChannelRead(AbstractChannelHandlerContext.java:362)
        at io.netty.channel.AbstractChannelHandlerContext.invokeChannelRead(AbstractChannelHandlerContext.java:348)
        at io.netty.channel.AbstractChannelHandlerContext.fireChannelRead(AbstractChannelHandlerContext.java:340)
        at io.netty.handler.timeout.IdleStateHandler.channelRead(IdleStateHandler.java:286)
        at io.netty.channel.AbstractChannelHandlerContext.invokeChannelRead(AbstractChannelHandlerContext.java:362)
        at io.netty.channel.AbstractChannelHandlerContext.invokeChannelRead(AbstractChannelHandlerContext.java:348)
        at io.netty.channel.AbstractChannelHandlerContext.fireChannelRead(AbstractChannelHandlerContext.java:340)
        at io.netty.channel.DefaultChannelPipeline$HeadContext.channelRead(DefaultChannelPipeline.java:1434)
        at io.netty.channel.AbstractChannelHandlerContext.invokeChannelRead(AbstractChannelHandlerContext.java:362)
        at io.netty.channel.AbstractChannelHandlerContext.invokeChannelRead(AbstractChannelHandlerContext.java:348)
        at io.netty.channel.DefaultChannelPipeline.fireChannelRead(DefaultChannelPipeline.java:965)
        at io.netty.channel.epoll.AbstractEpollStreamChannel$EpollStreamUnsafe.epollInReady(AbstractEpollStreamChannel.java:808)
        at io.netty.channel.epoll.EpollEventLoop.processReady(EpollEventLoop.java:410)
        at io.netty.channel.epoll.EpollEventLoop.run(EpollEventLoop.java:310)
        at io.netty.util.concurrent.SingleThreadEventExecutor$5.run(SingleThreadEventExecutor.java:884)
        at java.lang.Thread.run(Thread.java:748)
     | single-1
    p.dcae.collectors.veshv.impl.socket.NettyTcpServer | 2018-10-19T08:53:18.351Z | INFO  | Connection from /172.26.0.6:56924 has been closed |  | single-1



The above log is printed when the message payload size is too big. **HV-VES** does not handle messages that exceed specified payload size. Default value is **1048576 bytes (1MiB)**, but it can be configured via cmd or by environment variables.



====

**Other invalid messages**


Messages with **invalid wire frame** or **invalid gpb** data are ommitted and **HV-VES** only logs the connection-related logs as follows:

::

    p.dcae.collectors.veshv.impl.socket.NettyTcpServer | 2018-10-19T09:03:03.345Z | INFO  | Handling connection from /172.26.0.6:57432 |  | reactor-tcp-server-epoll-5
    p.dcae.collectors.veshv.impl.socket.NettyTcpServer | 2018-10-19T09:04:03.351Z | INFO  | Idle timeout of 60 s reached. Closing connection from /172.26.0.6:57432... |  | reactor-tcp-server-epoll-5
    p.dcae.collectors.veshv.impl.socket.NettyTcpServer | 2018-10-19T09:04:03.353Z | INFO  | Connection from /172.26.0.6:57432 has been closed |  | reactor-tcp-server-epoll-5
    p.dcae.collectors.veshv.impl.socket.NettyTcpServer | 2018-10-19T09:04:03.354Z | DEBUG | Channel (/172.26.0.6:57432) closed successfully. |  | reactor-tcp-server-epoll-5


For more information, see the :ref:`hv_ves_behaviors` section.

Authorization related errors
----------------------------

**WARNING: SSL/TLS authorization is a part of an experimental feature for ONAP Casablanca release and should be treated as unstable and subject to change in future releases.**
**For more information, see** :ref:`authorization`.

**Key or trust store missing**

::

    org.onap.dcae.collectors.veshv.main | 2018-10-22T06:51:54.191Z | ERROR | Failed to start a server | java.io.FileNotFoundException: /etc/ves-hv/server.p12 (No such file or directory)
        at java.io.FileInputStream.open0(Native Method)
        at java.io.FileInputStream.open(FileInputStream.java:195)
        at java.io.FileInputStream.<init>(FileInputStream.java:138)
        at org.onap.dcae.collectors.veshv.ssl.boundary.UtilsKt$streamFromFile$1.invoke(utils.kt:79)
        at org.onap.dcae.collectors.veshv.ssl.boundary.UtilsKt$streamFromFile$1.invoke(utils.kt)
        at org.onap.dcae.collectors.veshv.ssl.impl.SslFactories.loadKeyStoreFromFile(SslFactories.kt:50)
        at org.onap.dcae.collectors.veshv.ssl.impl.SslFactories.keyManagerFactory(SslFactories.kt:43)
        at org.onap.dcae.collectors.veshv.ssl.boundary.ServerSslContextFactory.jdkContext(ServerSslContextFactory.kt:42)
        at org.onap.dcae.collectors.veshv.ssl.boundary.SslContextFactory.createSslContextWithConfiguredCerts(SslContextFactory.kt:49)
        at org.onap.dcae.collectors.veshv.ssl.boundary.SslContextFactory.createSslContext(SslContextFactory.kt:39)
        at org.onap.dcae.collectors.veshv.impl.socket.NettyTcpServer.configureServer(NettyTcpServer.kt:61)
        at org.onap.dcae.collectors.veshv.impl.socket.NettyTcpServer.access$configureServer(NettyTcpServer.kt:46)
        at org.onap.dcae.collectors.veshv.impl.socket.NettyTcpServer$start$1$ctx$1.invoke(NettyTcpServer.kt:52)
        at org.onap.dcae.collectors.veshv.impl.socket.NettyTcpServer$start$1$ctx$1.invoke(NettyTcpServer.kt:46)
        at org.onap.dcae.collectors.veshv.impl.socket.NettyTcpServer$sam$java_util_function_Consumer$0.accept(NettyTcpServer.kt)
        at reactor.ipc.netty.tcp.TcpServer.<init>(TcpServer.java:149)
        at reactor.ipc.netty.tcp.TcpServer$Builder.build(TcpServer.java:278)
        at org.onap.dcae.collectors.veshv.impl.socket.NettyTcpServer$start$1.invoke(NettyTcpServer.kt:53)
        at org.onap.dcae.collectors.veshv.impl.socket.NettyTcpServer$start$1.invoke(NettyTcpServer.kt:46)
        at arrow.effects.IO$Companion$invoke$1.invoke(IO.kt:28)
        at arrow.effects.IO$Companion$invoke$1.invoke(IO.kt:22)
        at arrow.effects.IORunLoop.step(IORunLoop.kt:50)
        at arrow.effects.IO.unsafeRunTimed(IO.kt:109)
        at arrow.effects.IO.unsafeRunSync(IO.kt:106)
        at org.onap.dcae.collectors.veshv.utils.arrow.EffectsKt.unsafeRunEitherSync(effects.kt:50)
        at org.onap.dcae.collectors.veshv.main.MainKt.main(main.kt:41)
    | main


The above error is logged when key store is not provided. Similarly, when trust store is not provided, **/etc/ves-hv/trust.p12** file missing is logged.
**server.p12** and **trust.p12** are default names of key and trust stores. They can be changed by specifying **--trust-store** or **--key-store** command line arguments on deployment.

====

**Invalid credentials**

::

    org.onap.dcae.collectors.veshv.main | 2018-10-22T06:59:24.039Z | ERROR | Failed to start a server | java.security.UnrecoverableKeyException: failed to decrypt safe contents entry: javax.crypto.BadPaddingException: Given final block not properly padded. Such issues can arise if a bad key is used during decryption.
        ... 23 common frames omitted
        Wrapped by: java.io.IOException: keystore password was incorrect
        at sun.security.pkcs12.PKCS12KeyStore.engineLoad(PKCS12KeyStore.java:2059)
        at java.security.KeyStore.load(KeyStore.java:1445)
        at org.onap.dcae.collectors.veshv.ssl.impl.SslFactories.loadKeyStoreFromFile(SslFactories.kt:51)
        at org.onap.dcae.collectors.veshv.ssl.impl.SslFactories.keyManagerFactory(SslFactories.kt:43)
        at org.onap.dcae.collectors.veshv.ssl.boundary.ServerSslContextFactory.jdkContext(ServerSslContextFactory.kt:42)
        at org.onap.dcae.collectors.veshv.ssl.boundary.SslContextFactory.createSslContextWithConfiguredCerts(SslContextFactory.kt:49)
        at org.onap.dcae.collectors.veshv.ssl.boundary.SslContextFactory.createSslContext(SslContextFactory.kt:39)
        at org.onap.dcae.collectors.veshv.impl.socket.NettyTcpServer.configureServer(NettyTcpServer.kt:61)
        at org.onap.dcae.collectors.veshv.impl.socket.NettyTcpServer.access$configureServer(NettyTcpServer.kt:46)
        at org.onap.dcae.collectors.veshv.impl.socket.NettyTcpServer$start$1$ctx$1.invoke(NettyTcpServer.kt:52)
        at org.onap.dcae.collectors.veshv.impl.socket.NettyTcpServer$start$1$ctx$1.invoke(NettyTcpServer.kt:46)
        at org.onap.dcae.collectors.veshv.impl.socket.NettyTcpServer$sam$java_util_function_Consumer$0.accept(NettyTcpServer.kt)
        at reactor.ipc.netty.tcp.TcpServer.<init>(TcpServer.java:149)
        at reactor.ipc.netty.tcp.TcpServer$Builder.build(TcpServer.java:278)
        at org.onap.dcae.collectors.veshv.impl.socket.NettyTcpServer$start$1.invoke(NettyTcpServer.kt:53)
        at org.onap.dcae.collectors.veshv.impl.socket.NettyTcpServer$start$1.invoke(NettyTcpServer.kt:46)
        at arrow.effects.IO$Companion$invoke$1.invoke(IO.kt:28)
        at arrow.effects.IO$Companion$invoke$1.invoke(IO.kt:22)
        at arrow.effects.IORunLoop.step(IORunLoop.kt:50)
        at arrow.effects.IO.unsafeRunTimed(IO.kt:109)
        at arrow.effects.IO.unsafeRunSync(IO.kt:106)
        at org.onap.dcae.collectors.veshv.utils.arrow.EffectsKt.unsafeRunEitherSync(effects.kt:50)
        at org.onap.dcae.collectors.veshv.main.MainKt.main(main.kt:41)
    | main


Key or trust store password provided in configuration is invalid.

====

**Invalid key store file**

::

    org.onap.dcae.collectors.veshv.main | 2018-10-22T09:11:38.200Z | ERROR | Failed to start a server | java.io.IOException: DerInputStream.getLength(): lengthTag=111, too big.
        at sun.security.util.DerInputStream.getLength(DerInputStream.java:599)
        at sun.security.util.DerValue.init(DerValue.java:391)
        at sun.security.util.DerValue.<init>(DerValue.java:332)
        at sun.security.util.DerValue.<init>(DerValue.java:345)
        at sun.security.pkcs12.PKCS12KeyStore.engineLoad(PKCS12KeyStore.java:1938)
        at java.security.KeyStore.load(KeyStore.java:1445)
        at org.onap.dcae.collectors.veshv.ssl.impl.SslFactories.loadKeyStoreFromFile(SslFactories.kt:51)
        at org.onap.dcae.collectors.veshv.ssl.impl.SslFactories.keyManagerFactory(SslFactories.kt:43)
        at org.onap.dcae.collectors.veshv.ssl.boundary.ServerSslContextFactory.jdkContext(ServerSslContextFactory.kt:42)
        at org.onap.dcae.collectors.veshv.ssl.boundary.SslContextFactory.createSslContextWithConfiguredCerts(SslContextFactory.kt:49)
        at org.onap.dcae.collectors.veshv.ssl.boundary.SslContextFactory.createSslContext(SslContextFactory.kt:39)
        at org.onap.dcae.collectors.veshv.impl.socket.NettyTcpServer.configureServer(NettyTcpServer.kt:61)
        at org.onap.dcae.collectors.veshv.impl.socket.NettyTcpServer.access$configureServer(NettyTcpServer.kt:46)
        at org.onap.dcae.collectors.veshv.impl.socket.NettyTcpServer$start$1$ctx$1.invoke(NettyTcpServer.kt:52)
        at org.onap.dcae.collectors.veshv.impl.socket.NettyTcpServer$start$1$ctx$1.invoke(NettyTcpServer.kt:46)
        at org.onap.dcae.collectors.veshv.impl.socket.NettyTcpServer$sam$java_util_function_Consumer$0.accept(NettyTcpServer.kt)
        at reactor.ipc.netty.tcp.TcpServer.<init>(TcpServer.java:149)
        at reactor.ipc.netty.tcp.TcpServer$Builder.build(TcpServer.java:278)
        at org.onap.dcae.collectors.veshv.impl.socket.NettyTcpServer$start$1.invoke(NettyTcpServer.kt:53)
        at org.onap.dcae.collectors.veshv.impl.socket.NettyTcpServer$start$1.invoke(NettyTcpServer.kt:46)
        at arrow.effects.IO$Companion$invoke$1.invoke(IO.kt:28)
        at arrow.effects.IO$Companion$invoke$1.invoke(IO.kt:22)
        at arrow.effects.IORunLoop.step(IORunLoop.kt:50)
        at arrow.effects.IO.unsafeRunTimed(IO.kt:109)
        at arrow.effects.IO.unsafeRunSync(IO.kt:106)
        at org.onap.dcae.collectors.veshv.utils.arrow.EffectsKt.unsafeRunEitherSync(effects.kt:50)
        at org.onap.dcae.collectors.veshv.main.MainKt.main(main.kt:41)
    | main

The above is logged when provided keystore has invalid or corrupted content.
This log also appears when you try to use key store/trust store in archive format other than **PKCS12** (the only supported by **HV-VES** store type).


