.. This work is licensed under a Creative Commons Attribution 4.0 International License.
.. http://creativecommons.org/licenses/by/4.0

.. _troubleshooting:

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

Do not rely on exact log messages or their presence, as they are often subject to change.

Deployment/Installation errors
------------------------------

**Missing required parameters**

::

    Unexpected error when parsing command line arguments
    usage: java org.onap.dcae.collectors.veshv.main.MainKt
    Required parameters: s, p, c
     -c,--config-url <arg>                URL of ves configuration on consul
     -d,--first-request-delay <arg>       Delay of first request to consul in
                                          seconds
     -H,--health-check-api-port <arg>     Health check rest api listen port
     -I,--request-interval <arg>          Interval of consul configuration
                                          requests in seconds
     -i,--idle-timeout-sec <arg>          Idle timeout for remote hosts. After
                                          given time without any data exchange
                                          the
                                          connection might be closed.
     -k,--key-store <arg>                 Key store in PKCS12 format
     -kp,--key-store-password <arg>       Key store password
     -l,--ssl-disable                     Disable SSL encryption
     -m,--max-payload-size <arg>          Maximum supported payload size in
                                          bytes
     -p,--listen-port <arg>               Listen port
     -s,--kafka-bootstrap-servers <arg>   Comma-separated Kafka bootstrap
                                          servers in <host>:<port> format
     -t,--trust-store <arg>               File with trusted certificate bundle
                                          in PKCS12 format
     -tp,--trust-store-password <arg>     Trust store password
     -u,--dummy                           If present will start in dummy mode
                                          (dummy external services)
    All parameters can be specified as environment variables using
    upper-snake-case full name with prefix `VESHV_`.


This log message is printed when you do not specify the required parameters (via command line, or in environment variables).
As described in the above log message, there are a few required parameters:
**listen port**, **config url**, **kafka-bootstrap-servers** and either **trust store password** and **key store password** if you want to use SSL, or only **ssl disable** if not.

To get rid of this error, specify the required parameters. For example:

- Via command line:

::

    <hv-ves run command> --listen-port 6061 --config-url http://consul-url/key-path --kafka-bootstrap-servers message-router-kafka:9092 --key-store-password password --trust-store-password password

- By defining environment variables:

::

    export VESHV_LISTEN_PORT=6061
    export VESHV_CONFIG_URL=http://consul-url/key-path
    export VESHV_KAFKA_BOOTSTRAP_SERVERS=message-router-kafka:9092
    export VESHV_KEY_STORE_PASSWORD=password
    export VESHV_TRUST_STORE_PASSWORD=password

**NOTE**

Command line arguments have priority over environment variables. If you configure a parameter in both ways, **HV-VES** applies the one from the command line.

For more information about **HV-VES** configuration parameters, see :ref:`deployment`.

Configuration errors
--------------------

**Consul service not responding**

::

     | ap.dcae.collectors.veshv.impl.adapters.HttpAdapter	 | ERROR	 | Failed to get resource on path: http://invalid-host:8500/v1/kv/veshv-config?raw=true (consul-server1: Temporary failure in name resolution)
     | ap.dcae.collectors.veshv.impl.adapters.HttpAdapter	 | DEBUG	 | Nested exception:	 | 	 | java.net.UnknownHostException: consul-server1: Temporary failure in name resolution
        at java.base/java.net.Inet4AddressImpl.lookupAllHostAddr(Native Method)
        at java.base/java.net.InetAddress$PlatformNameService.lookupAllHostAddr(InetAddress.java:929)
        at java.base/java.net.InetAddress.getAddressesFromNameService(InetAddress.java:1515)
        at java.base/java.net.InetAddress$NameServiceAddresses.get(InetAddress.java:848)
        at java.base/java.net.InetAddress.getAllByName0(InetAddress.java:1505)
        at java.base/java.net.InetAddress.getAllByName(InetAddress.java:1364)
        at java.base/java.net.InetAddress.getAllByName(InetAddress.java:1298)
        at java.base/java.net.InetAddress.getByName(InetAddress.java:1248)
        at io.netty.util.internal.SocketUtils$8.run(SocketUtils.java:146)
        at io.netty.util.internal.SocketUtils$8.run(SocketUtils.java:143)
        at java.base/java.security.AccessController.doPrivileged(Native Method)
        at io.netty.util.internal.SocketUtils.addressByName(SocketUtils.java:143)
        at io.netty.resolver.DefaultNameResolver.doResolve(DefaultNameResolver.java:43)
        at io.netty.resolver.SimpleNameResolver.resolve(SimpleNameResolver.java:63)
        at io.netty.resolver.SimpleNameResolver.resolve(SimpleNameResolver.java:55)
        at io.netty.resolver.InetSocketAddressResolver.doResolve(InetSocketAddressResolver.java:57)
        at io.netty.resolver.InetSocketAddressResolver.doResolve(InetSocketAddressResolver.java:32)
        at io.netty.resolver.AbstractAddressResolver.resolve(AbstractAddressResolver.java:108)
        at io.netty.bootstrap.Bootstrap.doResolveAndConnect0(Bootstrap.java:208)
        at io.netty.bootstrap.Bootstrap.access$000(Bootstrap.java:49)
        at io.netty.bootstrap.Bootstrap$1.operationComplete(Bootstrap.java:188)
        at io.netty.bootstrap.Bootstrap$1.operationComplete(Bootstrap.java:174)
        at io.netty.util.concurrent.DefaultPromise.notifyListener0(DefaultPromise.java:511)
        at io.netty.util.concurrent.DefaultPromise.notifyListenersNow(DefaultPromise.java:485)
        at io.netty.util.concurrent.DefaultPromise.notifyListeners(DefaultPromise.java:424)
        at io.netty.util.concurrent.DefaultPromise.trySuccess(DefaultPromise.java:103)
        at io.netty.channel.DefaultChannelPromise.trySuccess(DefaultChannelPromise.java:84)
        at io.netty.channel.AbstractChannel$AbstractUnsafe.safeSetSuccess(AbstractChannel.java:978)
        at io.netty.channel.AbstractChannel$AbstractUnsafe.register0(AbstractChannel.java:512)
        at io.netty.channel.AbstractChannel$AbstractUnsafe.access$200(AbstractChannel.java:423)
        at io.netty.channel.AbstractChannel$AbstractUnsafe$1.run(AbstractChannel.java:482)
        at io.netty.util.concurrent.AbstractEventExecutor.safeExecute(AbstractEventExecutor.java:163)
        at io.netty.util.concurrent.SingleThreadEventExecutor.runAllTasks(SingleThreadEventExecutor.java:404)
        at io.netty.channel.epoll.EpollEventLoop.run(EpollEventLoop.java:315)
        at io.netty.util.concurrent.SingleThreadEventExecutor$5.run(SingleThreadEventExecutor.java:884)
        at java.base/java.lang.Thread.run(Thread.java:834)
     | rs.veshv.impl.adapters.ConsulConfigurationProvider	 | WARN 	 | Could not load fresh configuration	 | java.net.UnknownHostException: consul-server1: Temporary failure in name resolution
        at java.base/java.net.Inet4AddressImpl.lookupAllHostAddr(Native Method)
        at java.base/java.net.InetAddress$PlatformNameService.lookupAllHostAddr(InetAddress.java:929)
        at java.base/java.net.InetAddress.getAddressesFromNameService(InetAddress.java:1515)
        at java.base/java.net.InetAddress$NameServiceAddresses.get(InetAddress.java:848)
        at java.base/java.net.InetAddress.getAllByName0(InetAddress.java:1505)
        at java.base/java.net.InetAddress.getAllByName(InetAddress.java:1364)
        at java.base/java.net.InetAddress.getAllByName(InetAddress.java:1298)
        at java.base/java.net.InetAddress.getByName(InetAddress.java:1248)
        at io.netty.util.internal.SocketUtils$8.run(SocketUtils.java:146)
        at io.netty.util.internal.SocketUtils$8.run(SocketUtils.java:143)
        at java.base/java.security.AccessController.doPrivileged(Native Method)
        at io.netty.util.internal.SocketUtils.addressByName(SocketUtils.java:143)
        at io.netty.resolver.DefaultNameResolver.doResolve(DefaultNameResolver.java:43)
        at io.netty.resolver.SimpleNameResolver.resolve(SimpleNameResolver.java:63)
        at io.netty.resolver.SimpleNameResolver.resolve(SimpleNameResolver.java:55)
        at io.netty.resolver.InetSocketAddressResolver.doResolve(InetSocketAddressResolver.java:57)
        at io.netty.resolver.InetSocketAddressResolver.doResolve(InetSocketAddressResolver.java:32)
        at io.netty.resolver.AbstractAddressResolver.resolve(AbstractAddressResolver.java:108)
        at io.netty.bootstrap.Bootstrap.doResolveAndConnect0(Bootstrap.java:208)
        at io.netty.bootstrap.Bootstrap.access$000(Bootstrap.java:49)
        at io.netty.bootstrap.Bootstrap$1.operationComplete(Bootstrap.java:188)
        at io.netty.bootstrap.Bootstrap$1.operationComplete(Bootstrap.java:174)
        at io.netty.util.concurrent.DefaultPromise.notifyListener0(DefaultPromise.java:511)
        at io.netty.util.concurrent.DefaultPromise.notifyListenersNow(DefaultPromise.java:485)
        at io.netty.util.concurrent.DefaultPromise.notifyListeners(DefaultPromise.java:424)
        at io.netty.util.concurrent.DefaultPromise.trySuccess(DefaultPromise.java:103)
        at io.netty.channel.DefaultChannelPromise.trySuccess(DefaultChannelPromise.java:84)
        at io.netty.channel.AbstractChannel$AbstractUnsafe.safeSetSuccess(AbstractChannel.java:978)
        at io.netty.channel.AbstractChannel$AbstractUnsafe.register0(AbstractChannel.java:512)
        at io.netty.channel.AbstractChannel$AbstractUnsafe.access$200(AbstractChannel.java:423)
        at io.netty.channel.AbstractChannel$AbstractUnsafe$1.run(AbstractChannel.java:482)
        at io.netty.util.concurrent.AbstractEventExecutor.safeExecute(AbstractEventExecutor.java:163)
        at io.netty.util.concurrent.SingleThreadEventExecutor.runAllTasks(SingleThreadEventExecutor.java:404)
        at io.netty.channel.epoll.EpollEventLoop.run(EpollEventLoop.java:315)
        at io.netty.util.concurrent.SingleThreadEventExecutor$5.run(SingleThreadEventExecutor.java:884)
        at java.base/java.lang.Thread.run(Thread.java:834)
     | ors.veshv.healthcheck.factory.HealthCheckApiServer	 | DEBUG	 | HV-VES status: OUT_OF_SERVICE, Consul configuration not available. Retrying.



The above three logs indicate that **HV-VES** cannot connect to the Consul service under url given in **--consul-url** parameter.
Make sure Consul is up and running and the **ip + port** combination is correct.

====

**Missing configuration on Consul**

::

     | ap.dcae.collectors.veshv.impl.adapters.HttpAdapter	 | ERROR	 | Failed to get resource on path: http://consul-server:8500/v1/kv/invalid-resource?raw=true (http://consul-server:8500/v1/kv/invalid-resource?raw=true 404 Not Found)
     | ap.dcae.collectors.veshv.impl.adapters.HttpAdapter	 | DEBUG	 | Nested exception:	 | java.lang.IllegalStateException: http://consul-server:8500/v1/kv/invalid-resource?raw=true 404 Not Found
        at org.onap.dcae.collectors.veshv.impl.adapters.HttpAdapter$get$2.apply(HttpAdapter.kt:46)
        at org.onap.dcae.collectors.veshv.impl.adapters.HttpAdapter$get$2.apply(HttpAdapter.kt:34)
        at reactor.netty.http.client.HttpClientFinalizer.lambda$responseSingle$7(HttpClientFinalizer.java:95)
        at reactor.core.publisher.MonoFlatMap$FlatMapMain.onNext(MonoFlatMap.java:118)
        at reactor.core.publisher.FluxRetryPredicate$RetryPredicateSubscriber.onNext(FluxRetryPredicate.java:81)
        at reactor.core.publisher.MonoCreate$DefaultMonoSink.success(MonoCreate.java:147)
        at reactor.netty.http.client.HttpClientConnect$HttpObserver.onStateChange(HttpClientConnect.java:383)
        at reactor.netty.resources.PooledConnectionProvider$DisposableAcquire.onStateChange(PooledConnectionProvider.java:501)
        at reactor.netty.resources.PooledConnectionProvider$PooledConnection.onStateChange(PooledConnectionProvider.java:443)
        at reactor.netty.http.client.HttpClientOperations.onInboundNext(HttpClientOperations.java:494)
        at reactor.netty.channel.ChannelOperationsHandler.channelRead(ChannelOperationsHandler.java:141)
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
        at io.netty.channel.epoll.AbstractEpollStreamChannel$EpollStreamUnsafe.epollInReady(AbstractEpollStreamChannel.java:808)
        at io.netty.channel.epoll.EpollEventLoop.processReady(EpollEventLoop.java:410)
        at io.netty.channel.epoll.EpollEventLoop.run(EpollEventLoop.java:310)
        at io.netty.util.concurrent.SingleThreadEventExecutor$5.run(SingleThreadEventExecutor.java:884)
        at java.base/java.lang.Thread.run(Thread.java:834)
     | rs.veshv.impl.adapters.ConsulConfigurationProvider	 | WARN 	 | Could not load fresh configuration	 | java.lang.IllegalStateException: http://consul-server:8500/v1/kv/invalid-resource?raw=true 404 Not Found
        at org.onap.dcae.collectors.veshv.impl.adapters.HttpAdapter$get$2.apply(HttpAdapter.kt:46)
        at org.onap.dcae.collectors.veshv.impl.adapters.HttpAdapter$get$2.apply(HttpAdapter.kt:34)
        at reactor.netty.http.client.HttpClientFinalizer.lambda$responseSingle$7(HttpClientFinalizer.java:95)
        at reactor.core.publisher.MonoFlatMap$FlatMapMain.onNext(MonoFlatMap.java:118)
        at reactor.core.publisher.FluxRetryPredicate$RetryPredicateSubscriber.onNext(FluxRetryPredicate.java:81)
        at reactor.core.publisher.MonoCreate$DefaultMonoSink.success(MonoCreate.java:147)
        at reactor.netty.http.client.HttpClientConnect$HttpObserver.onStateChange(HttpClientConnect.java:383)
        at reactor.netty.resources.PooledConnectionProvider$DisposableAcquire.onStateChange(PooledConnectionProvider.java:501)
        at reactor.netty.resources.PooledConnectionProvider$PooledConnection.onStateChange(PooledConnectionProvider.java:443)
        at reactor.netty.http.client.HttpClientOperations.onInboundNext(HttpClientOperations.java:494)
        at reactor.netty.channel.ChannelOperationsHandler.channelRead(ChannelOperationsHandler.java:141)
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
        at io.netty.channel.epoll.AbstractEpollStreamChannel$EpollStreamUnsafe.epollInReady(AbstractEpollStreamChannel.java:808)
        at io.netty.channel.epoll.EpollEventLoop.processReady(EpollEventLoop.java:410)
        at io.netty.channel.epoll.EpollEventLoop.run(EpollEventLoop.java:310)
        at io.netty.util.concurrent.SingleThreadEventExecutor$5.run(SingleThreadEventExecutor.java:884)
        at java.base/java.lang.Thread.run(Thread.java:834)
     | ors.veshv.healthcheck.factory.HealthCheckApiServer	 | DEBUG	 | HV-VES status: OUT_OF_SERVICE, Consul configuration not available. Retrying.


**HV-VES** logs this information when connected to Consul, but cannot find any JSON configuration under given key which in this case is **invalid-resource**.
For more information, see :ref:`run_time_configuration`

====

**Invalid configuration format**

::

     | rs.veshv.impl.adapters.ConsulConfigurationProvider	 | INFO 	 | Obtained new configuration from consul:
        { "invalidKey": "value" }
     | 2018-12-20T15:38:14.543Z	 | rs.veshv.impl.adapters.ConsulConfigurationProvider	 | WARN 	 | Could not load fresh configuration	| org.onap.dcae.collectors.veshv.impl.adapters.ParsingException: Failed to parse consul configuration
        at org.onap.dcae.collectors.veshv.impl.adapters.ConsulConfigurationProvider.createCollectorConfiguration(ConsulConfigurationProvider.kt:125)
        at org.onap.dcae.collectors.veshv.impl.adapters.ConsulConfigurationProvider.access$createCollectorConfiguration(ConsulConfigurationProvider.kt:48)
        at org.onap.dcae.collectors.veshv.impl.adapters.ConsulConfigurationProvider$invoke$4.invoke(ConsulConfigurationProvider.kt:80)
        at org.onap.dcae.collectors.veshv.impl.adapters.ConsulConfigurationProvider$invoke$4.invoke(ConsulConfigurationProvider.kt:48)
        at org.onap.dcae.collectors.veshv.impl.adapters.ConsulConfigurationProvider$sam$java_util_function_Function$0.apply(ConsulConfigurationProvider.kt)
        at reactor.core.publisher.FluxMap$MapSubscriber.onNext(FluxMap.java:100)
        at reactor.core.publisher.FluxMap$MapSubscriber.onNext(FluxMap.java:114)
        at reactor.core.publisher.FluxFlatMap$FlatMapMain.tryEmitScalar(FluxFlatMap.java:449)
        at reactor.core.publisher.FluxFlatMap$FlatMapMain.onNext(FluxFlatMap.java:384)
        at reactor.core.publisher.FluxConcatMap$ConcatMapImmediate.innerNext(FluxConcatMap.java:275)
        at reactor.core.publisher.FluxConcatMap$ConcatMapInner.onNext(FluxConcatMap.java:849)
        at reactor.core.publisher.FluxMapFuseable$MapFuseableSubscriber.onNext(FluxMapFuseable.java:121)
        at reactor.core.publisher.FluxPeekFuseable$PeekFuseableSubscriber.onNext(FluxPeekFuseable.java:204)
        at reactor.core.publisher.Operators$MonoSubscriber.complete(Operators.java:1476)
        at reactor.core.publisher.MonoFlatMap$FlatMapInner.onNext(MonoFlatMap.java:241)
        at reactor.core.publisher.FluxDoFinally$DoFinallySubscriber.onNext(FluxDoFinally.java:123)
        at reactor.core.publisher.FluxHandle$HandleSubscriber.onNext(FluxHandle.java:113)
        at reactor.core.publisher.FluxMapFuseable$MapFuseableConditionalSubscriber.onNext(FluxMapFuseable.java:287)
        at reactor.core.publisher.FluxUsing$UsingFuseableSubscriber.onNext(FluxUsing.java:350)
        at reactor.core.publisher.FluxFilterFuseable$FilterFuseableSubscriber.onNext(FluxFilterFuseable.java:113)
        at reactor.core.publisher.FluxPeekFuseable$PeekFuseableConditionalSubscriber.onNext(FluxPeekFuseable.java:486)
        at reactor.core.publisher.Operators$MonoSubscriber.complete(Operators.java:1476)
        at reactor.core.publisher.MonoReduceSeed$ReduceSeedSubscriber.onComplete(MonoReduceSeed.java:156)
        at reactor.core.publisher.FluxMap$MapSubscriber.onComplete(FluxMap.java:136)
        at reactor.netty.channel.FluxReceive.terminateReceiver(FluxReceive.java:378)
        at reactor.netty.channel.FluxReceive.drainReceiver(FluxReceive.java:202)
        at reactor.netty.channel.FluxReceive.onInboundComplete(FluxReceive.java:343)
        at reactor.netty.channel.ChannelOperations.onInboundComplete(ChannelOperations.java:325)
        at reactor.netty.channel.ChannelOperations.terminate(ChannelOperations.java:372)
        at reactor.netty.http.client.HttpClientOperations.onInboundNext(HttpClientOperations.java:522)
        at reactor.netty.channel.ChannelOperationsHandler.channelRead(ChannelOperationsHandler.java:141)
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
        at io.netty.channel.epoll.AbstractEpollStreamChannel$EpollStreamUnsafe.epollInReady(AbstractEpollStreamChannel.java:808)
        at io.netty.channel.epoll.EpollEventLoop.processReady(EpollEventLoop.java:410)
        at io.netty.channel.epoll.EpollEventLoop.run(EpollEventLoop.java:310)
        at io.netty.util.concurrent.SingleThreadEventExecutor$5.run(SingleThreadEventExecutor.java:884)
        at java.base/java.lang.Thread.run(Thread.java:834)
     | ors.veshv.healthcheck.factory.HealthCheckApiServer	 | DEBUG	 | HV-VES status: OUT_OF_SERVICE, Consul configuration not available. Retrying.


This log is printed when you upload a configuration in an invalid format (for example, with missing fields). In the first log you can see that configuration on Consul is:

.. code-block:: json

    {
        "invalidKey": "value"
    }

The above is not a valid **HV-VES** configuration, therefore **HV-VES** does not apply it and becomes **unhealthy**.
For more information on **Consul configuration**, see :ref:`run_time_configuration`.


Message handling errors
-----------------------

**Handling messages when invalid Kafka url is specified**

::

     | p.dcae.collectors.veshv.impl.socket.NettyTcpServer	 | DEBUG	 | Client connection request received
     | p.dcae.collectors.veshv.impl.socket.NettyTcpServer	 | INFO 	 | Handling new connection
     |               org.apache.kafka.clients.ClientUtils	 | WARN 	 | Removing server invalid-kafka-host:9092 from bootstrap.servers as DNS resolution failed for invalid-kafka-host
     | org.onap.dcae.collectors.veshv.impl.VesHvCollector	 | WARN 	 | Error while handling message stream: org.apache.kafka.common.KafkaException (Failed to construct kafka producer)
     | org.onap.dcae.collectors.veshv.impl.VesHvCollector	 | DEBUG	 | Detailed stack trace	| org.apache.kafka.common.config.ConfigException: No resolvable bootstrap urls given in bootstrap.servers
        at org.apache.kafka.clients.ClientUtils.parseAndValidateAddresses(ClientUtils.java:66)
        at org.apache.kafka.clients.producer.KafkaProducer.<init>(KafkaProducer.java:406)
        ... 49 common frames omitted
        Wrapped by: org.apache.kafka.common.KafkaException: Failed to construct kafka producer
        at org.apache.kafka.clients.producer.KafkaProducer.<init>(KafkaProducer.java:457)
        at org.apache.kafka.clients.producer.KafkaProducer.<init>(KafkaProducer.java:289)
        at reactor.kafka.sender.internals.ProducerFactory.createProducer(ProducerFactory.java:33)
        at reactor.kafka.sender.internals.DefaultKafkaSender.lambda$new$0(DefaultKafkaSender.java:96)
        at reactor.core.publisher.MonoCallable.subscribe(MonoCallable.java:56)
        at reactor.core.publisher.MonoPeekFuseable.subscribe(MonoPeekFuseable.java:74)
        at reactor.core.publisher.Mono.subscribe(Mono.java:3590)
        at reactor.core.publisher.MonoProcessor.add(MonoProcessor.java:531)
        at reactor.core.publisher.MonoProcessor.subscribe(MonoProcessor.java:444)
        at reactor.core.publisher.MonoFlatMapMany.subscribe(MonoFlatMapMany.java:49)
        at reactor.core.publisher.FluxPeek.subscribe(FluxPeek.java:83)
        at reactor.core.publisher.FluxMap.subscribe(FluxMap.java:62)
        at reactor.core.publisher.FluxPeek.subscribe(FluxPeek.java:83)
        at reactor.core.publisher.FluxDefer.subscribe(FluxDefer.java:54)
        at reactor.core.publisher.FluxPeek.subscribe(FluxPeek.java:83)
        at reactor.core.publisher.FluxOnErrorResume.subscribe(FluxOnErrorResume.java:47)
        at reactor.core.publisher.FluxDoFinally.subscribe(FluxDoFinally.java:73)
        at reactor.core.publisher.MonoIgnoreElements.subscribe(MonoIgnoreElements.java:37)
        at reactor.netty.tcp.TcpServerHandle.onStateChange(TcpServerHandle.java:64)
        at reactor.netty.tcp.TcpServerBind$ChildObserver.onStateChange(TcpServerBind.java:226)
        at reactor.netty.channel.ChannelOperationsHandler.channelActive(ChannelOperationsHandler.java:112)
        at io.netty.channel.AbstractChannelHandlerContext.invokeChannelActive(AbstractChannelHandlerContext.java:213)
        at io.netty.channel.AbstractChannelHandlerContext.invokeChannelActive(AbstractChannelHandlerContext.java:199)
        at io.netty.channel.AbstractChannelHandlerContext.fireChannelActive(AbstractChannelHandlerContext.java:192)
        at reactor.netty.tcp.SslProvider$SslReadHandler.userEventTriggered(SslProvider.java:720)
        at io.netty.channel.AbstractChannelHandlerContext.invokeUserEventTriggered(AbstractChannelHandlerContext.java:329)
        at io.netty.channel.AbstractChannelHandlerContext.invokeUserEventTriggered(AbstractChannelHandlerContext.java:315)
        at io.netty.channel.AbstractChannelHandlerContext.fireUserEventTriggered(AbstractChannelHandlerContext.java:307)
        at io.netty.handler.ssl.SslHandler.setHandshakeSuccess(SslHandler.java:1530)
        at io.netty.handler.ssl.SslHandler.wrapNonAppData(SslHandler.java:937)
        at io.netty.handler.ssl.SslHandler.unwrap(SslHandler.java:1360)
        at io.netty.handler.ssl.SslHandler.decodeJdkCompatible(SslHandler.java:1199)
        at io.netty.handler.ssl.SslHandler.decode(SslHandler.java:1243)
        at io.netty.handler.codec.ByteToMessageDecoder.decodeRemovalReentryProtection(ByteToMessageDecoder.java:489)
        at io.netty.handler.codec.ByteToMessageDecoder.callDecode(ByteToMessageDecoder.java:428)
        at io.netty.handler.codec.ByteToMessageDecoder.channelRead(ByteToMessageDecoder.java:265)
        at io.netty.channel.AbstractChannelHandlerContext.invokeChannelRead(AbstractChannelHandlerContext.java:362)
        at io.netty.channel.AbstractChannelHandlerContext.invokeChannelRead(AbstractChannelHandlerContext.java:348)
        at io.netty.channel.AbstractChannelHandlerContext.fireChannelRead(AbstractChannelHandlerContext.java:340)
        at io.netty.channel.DefaultChannelPipeline$HeadContext.channelRead(DefaultChannelPipeline.java:1434)
        at io.netty.channel.AbstractChannelHandlerContext.invokeChannelRead(AbstractChannelHandlerContext.java:362)
        at io.netty.channel.AbstractChannelHandlerContext.invokeChannelRead(AbstractChannelHandlerContext.java:348)
        at io.netty.channel.DefaultChannelPipeline.fireChannelRead(DefaultChannelPipeline.java:965)
        at io.netty.channel.nio.AbstractNioByteChannel$NioByteUnsafe.read(AbstractNioByteChannel.java:163)
        at io.netty.channel.nio.NioEventLoop.processSelectedKey(NioEventLoop.java:628)
        at io.netty.channel.nio.NioEventLoop.processSelectedKeysPlain(NioEventLoop.java:528)
        at io.netty.channel.nio.NioEventLoop.processSelectedKeys(NioEventLoop.java:482)
        at io.netty.channel.nio.NioEventLoop.run(NioEventLoop.java:442)
        at io.netty.util.concurrent.SingleThreadEventExecutor$5.run(SingleThreadEventExecutor.java:884)
        at java.base/java.lang.Thread.run(Thread.java:834)
     | org.onap.dcae.collectors.veshv.impl.VesHvCollector	 | DEBUG	 | Released buffer memory after handling message stream


**HV-VES** responds with the above when it handles a message and specified DmaaP MR Kafka bootstrap server is invalid.
Restart with different **--kafka-bootstrap-servers** command line option value is required.
For more information, see: :ref:`deployment`

====

**Kafka service became unavailable after producer has been created**

**HV-VES** lazily creates Kafka consumer after first successfully handled event.
If Kafka service becomes unreachable after consumer initialization, it is removed from bootstrap.servers list on next connection.

Following information is logged:

::

     | org.apache.kafka.clients.NetworkClient   | WARN 	 | [Producer clientId=producer-1] Connection to node 1001 could not be established. Broker may not be available.
     | org.apache.kafka.clients.NetworkClient   | WARN 	 | [Producer clientId=producer-1] Connection to node 1001 could not be established. Broker may not be available.
     | org.apache.kafka.clients.NetworkClient   | WARN 	 | [Producer clientId=producer-1] Connection to node 1001 could not be established. Broker may not be available.
     | org.apache.kafka.clients.NetworkClient   | WARN 	 | [Producer clientId=producer-1] Connection to node 1001 could not be established. Broker may not be available.
     | org.apache.kafka.clients.NetworkClient   | WARN 	 | [Producer clientId=producer-1] Error connecting to node message-router-kafka:9092 (id: 1001 rack: null)	 | 	 | java.nio.channels.UnresolvedAddressException: null
        at java.base/sun.nio.ch.Net.checkAddress(Net.java:130)
        at java.base/sun.nio.ch.SocketChannelImpl.connect(SocketChannelImpl.java:675)
        at org.apache.kafka.common.network.Selector.doConnect(Selector.java:233)
        ... 9 common frames omitted
        Wrapped by: java.io.IOException: Can't resolve address: message-router-kafka:9092
        at org.apache.kafka.common.network.Selector.doConnect(Selector.java:235)
        at org.apache.kafka.common.network.Selector.connect(Selector.java:214)
        at org.apache.kafka.clients.NetworkClient.initiateConnect(NetworkClient.java:864)
        at org.apache.kafka.clients.NetworkClient.access$700(NetworkClient.java:64)
        at org.apache.kafka.clients.NetworkClient$DefaultMetadataUpdater.maybeUpdate(NetworkClient.java:1035)
        at org.apache.kafka.clients.NetworkClient$DefaultMetadataUpdater.maybeUpdate(NetworkClient.java:920)
        at org.apache.kafka.clients.NetworkClient.poll(NetworkClient.java:508)
        at org.apache.kafka.clients.producer.internals.Sender.run(Sender.java:239)
        at org.apache.kafka.clients.producer.internals.Sender.run(Sender.java:163)
        at java.base/java.lang.Thread.run(Thread.java:834)
         | 	 | kafka-producer-network-thread | producer-1
    | p.dcae.collectors.veshv.impl.socket.NettyTcpServer	 | INFO 	 | Handling new connection
    |               org.apache.kafka.clients.ClientUtils	 | WARN 	 | Removing server message-router-kafka:9092 from bootstrap.servers as DNS resolution failed for message-router-kafka
    | org.onap.dcae.collectors.veshv.impl.VesHvCollector	 | WARN 	 | Error while handling message stream: org.apache.kafka.common.KafkaException (Failed to construct kafka producer)
    | org.onap.dcae.collectors.veshv.impl.VesHvCollector	 | DEBUG	 | Detailed stack trace
        at org.apache.kafka.clients.ClientUtils.parseAndValidateAddresses(ClientUtils.java:66)
        at org.apache.kafka.clients.producer.KafkaProducer.<init>(KafkaProducer.java:406)
        ... 48 common frames omitted
        Wrapped by: org.apache.kafka.common.KafkaException: Failed to construct kafka producer
        at org.apache.kafka.clients.producer.KafkaProducer.<init>(KafkaProducer.java:457)
        at org.apache.kafka.clients.producer.KafkaProducer.<init>(KafkaProducer.java:289)
        at reactor.kafka.sender.internals.ProducerFactory.createProducer(ProducerFactory.java:33)
        at reactor.kafka.sender.internals.DefaultKafkaSender.lambda$new$0(DefaultKafkaSender.java:96)
        at reactor.core.publisher.MonoCallable.subscribe(MonoCallable.java:56)
        at reactor.core.publisher.MonoPeekFuseable.subscribe(MonoPeekFuseable.java:74)
        at reactor.core.publisher.Mono.subscribe(Mono.java:3590)
        at reactor.core.publisher.MonoProcessor.add(MonoProcessor.java:531)
        at reactor.core.publisher.MonoProcessor.subscribe(MonoProcessor.java:444)
        at reactor.core.publisher.MonoFlatMapMany.subscribe(MonoFlatMapMany.java:49)
        at reactor.core.publisher.FluxPeek.subscribe(FluxPeek.java:83)
        at reactor.core.publisher.FluxMap.subscribe(FluxMap.java:62)
        at reactor.core.publisher.FluxPeek.subscribe(FluxPeek.java:83)
        at reactor.core.publisher.FluxDefer.subscribe(FluxDefer.java:54)
        at reactor.core.publisher.FluxPeek.subscribe(FluxPeek.java:83)
        at reactor.core.publisher.FluxOnErrorResume.subscribe(FluxOnErrorResume.java:47)
        at reactor.core.publisher.FluxDoFinally.subscribe(FluxDoFinally.java:73)
        at reactor.core.publisher.MonoIgnoreElements.subscribe(MonoIgnoreElements.java:37)
        at reactor.netty.tcp.TcpServerHandle.onStateChange(TcpServerHandle.java:64)
        at reactor.netty.tcp.TcpServerBind$ChildObserver.onStateChange(TcpServerBind.java:226)
        at reactor.netty.channel.ChannelOperationsHandler.channelActive(ChannelOperationsHandler.java:112)
        at io.netty.channel.AbstractChannelHandlerContext.invokeChannelActive(AbstractChannelHandlerContext.java:213)
        at io.netty.channel.AbstractChannelHandlerContext.invokeChannelActive(AbstractChannelHandlerContext.java:199)
        at io.netty.channel.AbstractChannelHandlerContext.fireChannelActive(AbstractChannelHandlerContext.java:192)
        at reactor.netty.tcp.SslProvider$SslReadHandler.userEventTriggered(SslProvider.java:720)
        at io.netty.channel.AbstractChannelHandlerContext.invokeUserEventTriggered(AbstractChannelHandlerContext.java:329)
        at io.netty.channel.AbstractChannelHandlerContext.invokeUserEventTriggered(AbstractChannelHandlerContext.java:315)
        at io.netty.channel.AbstractChannelHandlerContext.fireUserEventTriggered(AbstractChannelHandlerContext.java:307)
        at io.netty.handler.ssl.SslHandler.setHandshakeSuccess(SslHandler.java:1530)
        at io.netty.handler.ssl.SslHandler.unwrap(SslHandler.java:1368)
        at io.netty.handler.ssl.SslHandler.decodeJdkCompatible(SslHandler.java:1199)
        at io.netty.handler.ssl.SslHandler.decode(SslHandler.java:1243)
        at io.netty.handler.codec.ByteToMessageDecoder.decodeRemovalReentryProtection(ByteToMessageDecoder.java:489)
        at io.netty.handler.codec.ByteToMessageDecoder.callDecode(ByteToMessageDecoder.java:428)
        at io.netty.handler.codec.ByteToMessageDecoder.channelRead(ByteToMessageDecoder.java:265)
        at io.netty.channel.AbstractChannelHandlerContext.invokeChannelRead(AbstractChannelHandlerContext.java:362)
        at io.netty.channel.AbstractChannelHandlerContext.invokeChannelRead(AbstractChannelHandlerContext.java:348)
        at io.netty.channel.AbstractChannelHandlerContext.fireChannelRead(AbstractChannelHandlerContext.java:340)
        at io.netty.channel.DefaultChannelPipeline$HeadContext.channelRead(DefaultChannelPipeline.java:1434)
        at io.netty.channel.AbstractChannelHandlerContext.invokeChannelRead(AbstractChannelHandlerContext.java:362)
        at io.netty.channel.AbstractChannelHandlerContext.invokeChannelRead(AbstractChannelHandlerContext.java:348)
        at io.netty.channel.DefaultChannelPipeline.fireChannelRead(DefaultChannelPipeline.java:965)
        at io.netty.channel.nio.AbstractNioByteChannel$NioByteUnsafe.read(AbstractNioByteChannel.java:163)
        at io.netty.channel.nio.NioEventLoop.processSelectedKey(NioEventLoop.java:628)
        at io.netty.channel.nio.NioEventLoop.processSelectedKeysPlain(NioEventLoop.java:528)
        at io.netty.channel.nio.NioEventLoop.processSelectedKeys(NioEventLoop.java:482)
        at io.netty.channel.nio.NioEventLoop.run(NioEventLoop.java:442)
        at io.netty.util.concurrent.SingleThreadEventExecutor$5.run(SingleThreadEventExecutor.java:884)
        at java.base/java.lang.Thread.run(Thread.java:834)
     | org.onap.dcae.collectors.veshv.impl.VesHvCollector	 | DEBUG	 | Released buffer memory after handling message stream


To resolve this issue, you can either wait for that Kafka service to be available, or just like in previous paragraph, restart **HV-VES** with different value of **--kafka-bootstrap-servers** option.

====

**Message with too big payload size**

::

     | p.dcae.collectors.veshv.impl.socket.NettyTcpServer	 | DEBUG	 | Client connection request received
     | p.dcae.collectors.veshv.impl.socket.NettyTcpServer	 | INFO 	 | Handling new connection
     | p.dcae.collectors.veshv.impl.wire.WireChunkDecoder	 | TRACE	 | Got message with total size of 16384 B
     | p.dcae.collectors.veshv.impl.wire.WireChunkDecoder	 | WARN 	 | Error while handling message stream: org.onap.dcae.collectors.veshv.impl.wire.WireFrameException (PayloadSizeExceeded: payload size exceeds the limit (1048576 bytes))
     | p.dcae.collectors.veshv.impl.wire.WireChunkDecoder	 | DEBUG	 | Detailed stack trace	| org.onap.dcae.collectors.veshv.impl.wire.WireFrameException: PayloadSizeExceeded: payload size exceeds the limit (1048576 bytes)
        at org.onap.dcae.collectors.veshv.impl.wire.WireChunkDecoder$onError$1$1.invoke(WireChunkDecoder.kt:72)
        at org.onap.dcae.collectors.veshv.impl.wire.WireChunkDecoder$onError$1$1.invoke(WireChunkDecoder.kt:41)
        at arrow.effects.IO$Companion$invoke$1.invoke(IO.kt:33)
        at arrow.effects.IO$Companion$invoke$1.invoke(IO.kt:27)
        at arrow.effects.IORunLoop.step(IORunLoop.kt:49)
        at arrow.effects.IO.unsafeRunTimed(IO.kt:115)
        at arrow.effects.IO.unsafeRunSync(IO.kt:112)
        at org.onap.dcae.collectors.veshv.impl.wire.WireChunkDecoder$generateFrames$1.accept(WireChunkDecoder.kt:66)
        at org.onap.dcae.collectors.veshv.impl.wire.WireChunkDecoder$generateFrames$1.accept(WireChunkDecoder.kt:41)
        at reactor.core.publisher.FluxGenerate.lambda$new$1(FluxGenerate.java:56)
        at reactor.core.publisher.FluxGenerate$GenerateSubscription.slowPath(FluxGenerate.java:262)
        at reactor.core.publisher.FluxGenerate$GenerateSubscription.request(FluxGenerate.java:204)
        at reactor.core.publisher.Operators$MultiSubscriptionSubscriber.set(Operators.java:1849)
        at reactor.core.publisher.FluxOnErrorResume$ResumeSubscriber.onSubscribe(FluxOnErrorResume.java:68)
        at reactor.core.publisher.FluxGenerate.subscribe(FluxGenerate.java:83)
        at reactor.core.publisher.FluxOnErrorResume.subscribe(FluxOnErrorResume.java:47)
        at reactor.core.publisher.FluxDoFinally.subscribe(FluxDoFinally.java:73)
        at reactor.core.publisher.FluxDefer.subscribe(FluxDefer.java:54)
        at reactor.core.publisher.Flux.subscribe(Flux.java:7734)
        at reactor.core.publisher.FluxConcatMap$ConcatMapImmediate.drain(FluxConcatMap.java:442)
        at reactor.core.publisher.FluxConcatMap$ConcatMapImmediate.onNext(FluxConcatMap.java:244)
        at reactor.core.publisher.FluxPeek$PeekSubscriber.onNext(FluxPeek.java:192)
        at reactor.core.publisher.FluxPeek$PeekSubscriber.onNext(FluxPeek.java:192)
        at reactor.core.publisher.FluxMap$MapSubscriber.onNext(FluxMap.java:114)
        at reactor.netty.channel.FluxReceive.drainReceiver(FluxReceive.java:211)
        at reactor.netty.channel.FluxReceive.onInboundNext(FluxReceive.java:327)
        at reactor.netty.channel.ChannelOperations.onInboundNext(ChannelOperations.java:310)
        at reactor.netty.channel.ChannelOperationsHandler.channelRead(ChannelOperationsHandler.java:141)
        at io.netty.channel.AbstractChannelHandlerContext.invokeChannelRead(AbstractChannelHandlerContext.java:362)
        at io.netty.channel.AbstractChannelHandlerContext.invokeChannelRead(AbstractChannelHandlerContext.java:348)
        at io.netty.channel.AbstractChannelHandlerContext.fireChannelRead(AbstractChannelHandlerContext.java:340)
        at io.netty.handler.timeout.IdleStateHandler.channelRead(IdleStateHandler.java:286)
        at io.netty.channel.AbstractChannelHandlerContext.invokeChannelRead(AbstractChannelHandlerContext.java:362)
        at io.netty.channel.AbstractChannelHandlerContext.invokeChannelRead(AbstractChannelHandlerContext.java:348)
        at io.netty.channel.AbstractChannelHandlerContext.fireChannelRead(AbstractChannelHandlerContext.java:340)
        at io.netty.handler.ssl.SslHandler.unwrap(SslHandler.java:1429)
        at io.netty.handler.ssl.SslHandler.decodeJdkCompatible(SslHandler.java:1199)
        at io.netty.handler.ssl.SslHandler.decode(SslHandler.java:1243)
        at io.netty.handler.codec.ByteToMessageDecoder.decodeRemovalReentryProtection(ByteToMessageDecoder.java:489)
        at io.netty.handler.codec.ByteToMessageDecoder.callDecode(ByteToMessageDecoder.java:428)
        at io.netty.handler.codec.ByteToMessageDecoder.channelRead(ByteToMessageDecoder.java:265)
        at io.netty.channel.AbstractChannelHandlerContext.invokeChannelRead(AbstractChannelHandlerContext.java:362)
        at io.netty.channel.AbstractChannelHandlerContext.invokeChannelRead(AbstractChannelHandlerContext.java:348)
        at io.netty.channel.AbstractChannelHandlerContext.fireChannelRead(AbstractChannelHandlerContext.java:340)
        at io.netty.channel.DefaultChannelPipeline$HeadContext.channelRead(DefaultChannelPipeline.java:1434)
        at io.netty.channel.AbstractChannelHandlerContext.invokeChannelRead(AbstractChannelHandlerContext.java:362)
        at io.netty.channel.AbstractChannelHandlerContext.invokeChannelRead(AbstractChannelHandlerContext.java:348)
        at io.netty.channel.DefaultChannelPipeline.fireChannelRead(DefaultChannelPipeline.java:965)
        at io.netty.channel.nio.AbstractNioByteChannel$NioByteUnsafe.read(AbstractNioByteChannel.java:163)
        at io.netty.channel.nio.NioEventLoop.processSelectedKey(NioEventLoop.java:628)
        at io.netty.channel.nio.NioEventLoop.processSelectedKeysPlain(NioEventLoop.java:528)
        at io.netty.channel.nio.NioEventLoop.processSelectedKeys(NioEventLoop.java:482)
        at io.netty.channel.nio.NioEventLoop.run(NioEventLoop.java:442)
        at io.netty.util.concurrent.SingleThreadEventExecutor$5.run(SingleThreadEventExecutor.java:884)
        at java.base/java.lang.Thread.run(Thread.java:834)
     | org.onap.dcae.collectors.veshv.impl.VesHvCollector	 | WARN 	 | Error while handling message stream: org.onap.dcae.collectors.veshv.impl.wire.WireFrameException (PayloadSizeExceeded: payload size exceeds the limit (1048576 bytes))
     | org.onap.dcae.collectors.veshv.impl.VesHvCollector	 | DEBUG	 | Detailed stack trace	| org.onap.dcae.collectors.veshv.impl.wire.WireFrameException: PayloadSizeExceeded: payload size exceeds the limit (1048576 bytes)
        at org.onap.dcae.collectors.veshv.impl.wire.WireChunkDecoder$onError$1$1.invoke(WireChunkDecoder.kt:72)
        at org.onap.dcae.collectors.veshv.impl.wire.WireChunkDecoder$onError$1$1.invoke(WireChunkDecoder.kt:41)
        at arrow.effects.IO$Companion$invoke$1.invoke(IO.kt:33)
        at arrow.effects.IO$Companion$invoke$1.invoke(IO.kt:27)
        at arrow.effects.IORunLoop.step(IORunLoop.kt:49)
        at arrow.effects.IO.unsafeRunTimed(IO.kt:115)
        at arrow.effects.IO.unsafeRunSync(IO.kt:112)
        at org.onap.dcae.collectors.veshv.impl.wire.WireChunkDecoder$generateFrames$1.accept(WireChunkDecoder.kt:66)
        at org.onap.dcae.collectors.veshv.impl.wire.WireChunkDecoder$generateFrames$1.accept(WireChunkDecoder.kt:41)
        at reactor.core.publisher.FluxGenerate.lambda$new$1(FluxGenerate.java:56)
        at reactor.core.publisher.FluxGenerate$GenerateSubscription.slowPath(FluxGenerate.java:262)
        at reactor.core.publisher.FluxGenerate$GenerateSubscription.request(FluxGenerate.java:204)
        at reactor.core.publisher.Operators$MultiSubscriptionSubscriber.set(Operators.java:1849)
        at reactor.core.publisher.FluxOnErrorResume$ResumeSubscriber.onSubscribe(FluxOnErrorResume.java:68)
        at reactor.core.publisher.FluxGenerate.subscribe(FluxGenerate.java:83)
        at reactor.core.publisher.FluxOnErrorResume.subscribe(FluxOnErrorResume.java:47)
        at reactor.core.publisher.FluxDoFinally.subscribe(FluxDoFinally.java:73)
        at reactor.core.publisher.FluxDefer.subscribe(FluxDefer.java:54)
        at reactor.core.publisher.Flux.subscribe(Flux.java:7734)
        at reactor.core.publisher.FluxConcatMap$ConcatMapImmediate.drain(FluxConcatMap.java:442)
        at reactor.core.publisher.FluxConcatMap$ConcatMapImmediate.onNext(FluxConcatMap.java:244)
        at reactor.core.publisher.FluxPeek$PeekSubscriber.onNext(FluxPeek.java:192)
        at reactor.core.publisher.FluxPeek$PeekSubscriber.onNext(FluxPeek.java:192)
        at reactor.core.publisher.FluxMap$MapSubscriber.onNext(FluxMap.java:114)
        at reactor.netty.channel.FluxReceive.drainReceiver(FluxReceive.java:211)
        at reactor.netty.channel.FluxReceive.onInboundNext(FluxReceive.java:327)
        at reactor.netty.channel.ChannelOperations.onInboundNext(ChannelOperations.java:310)
        at reactor.netty.channel.ChannelOperationsHandler.channelRead(ChannelOperationsHandler.java:141)
        at io.netty.channel.AbstractChannelHandlerContext.invokeChannelRead(AbstractChannelHandlerContext.java:362)
        at io.netty.channel.AbstractChannelHandlerContext.invokeChannelRead(AbstractChannelHandlerContext.java:348)
        at io.netty.channel.AbstractChannelHandlerContext.fireChannelRead(AbstractChannelHandlerContext.java:340)
        at io.netty.handler.timeout.IdleStateHandler.channelRead(IdleStateHandler.java:286)
        at io.netty.channel.AbstractChannelHandlerContext.invokeChannelRead(AbstractChannelHandlerContext.java:362)
        at io.netty.channel.AbstractChannelHandlerContext.invokeChannelRead(AbstractChannelHandlerContext.java:348)
        at io.netty.channel.AbstractChannelHandlerContext.fireChannelRead(AbstractChannelHandlerContext.java:340)
        at io.netty.handler.ssl.SslHandler.unwrap(SslHandler.java:1429)
        at io.netty.handler.ssl.SslHandler.decodeJdkCompatible(SslHandler.java:1199)
        at io.netty.handler.ssl.SslHandler.decode(SslHandler.java:1243)
        at io.netty.handler.codec.ByteToMessageDecoder.decodeRemovalReentryProtection(ByteToMessageDecoder.java:489)
        at io.netty.handler.codec.ByteToMessageDecoder.callDecode(ByteToMessageDecoder.java:428)
        at io.netty.handler.codec.ByteToMessageDecoder.channelRead(ByteToMessageDecoder.java:265)
        at io.netty.channel.AbstractChannelHandlerContext.invokeChannelRead(AbstractChannelHandlerContext.java:362)
        at io.netty.channel.AbstractChannelHandlerContext.invokeChannelRead(AbstractChannelHandlerContext.java:348)
        at io.netty.channel.AbstractChannelHandlerContext.fireChannelRead(AbstractChannelHandlerContext.java:340)
        at io.netty.channel.DefaultChannelPipeline$HeadContext.channelRead(DefaultChannelPipeline.java:1434)
        at io.netty.channel.AbstractChannelHandlerContext.invokeChannelRead(AbstractChannelHandlerContext.java:362)
        at io.netty.channel.AbstractChannelHandlerContext.invokeChannelRead(AbstractChannelHandlerContext.java:348)
        at io.netty.channel.DefaultChannelPipeline.fireChannelRead(DefaultChannelPipeline.java:965)
        at io.netty.channel.nio.AbstractNioByteChannel$NioByteUnsafe.read(AbstractNioByteChannel.java:163)
        at io.netty.channel.nio.NioEventLoop.processSelectedKey(NioEventLoop.java:628)
        at io.netty.channel.nio.NioEventLoop.processSelectedKeysPlain(NioEventLoop.java:528)
        at io.netty.channel.nio.NioEventLoop.processSelectedKeys(NioEventLoop.java:482)
        at io.netty.channel.nio.NioEventLoop.run(NioEventLoop.java:442)
        at io.netty.util.concurrent.SingleThreadEventExecutor$5.run(SingleThreadEventExecutor.java:884)
        at java.base/java.lang.Thread.run(Thread.java:834)
     | org.onap.dcae.collectors.veshv.impl.VesHvCollector	 | DEBUG	 | Released buffer memory after handling message stream


The above log is printed when the message payload size is too big. **HV-VES** does not handle messages that exceed specified payload size. Default value is **1048576 bytes (1MiB)**, but it can be configured via cmd or by environment variables.

====

**Invalid GPB data**

Messages with invalid Google Protocol Buffers data encoded are omitted. **HV-VES** responds as follows:

::

    | p.dcae.collectors.veshv.impl.socket.NettyTcpServer	 | DEBUG	 | Client connection request received
    | p.dcae.collectors.veshv.impl.socket.NettyTcpServer	 | INFO 	 | Handling new connection
    | p.dcae.collectors.veshv.impl.wire.WireChunkDecoder	 | TRACE	 | Got message with total size of 28 B
    | p.dcae.collectors.veshv.impl.wire.WireChunkDecoder	 | TRACE	 | Wire payload size: 16 B
    | org.onap.dcae.collectors.veshv.impl.VesHvCollector	 | TRACE	 | Wire frame header is valid
    | org.onap.dcae.collectors.veshv.impl.VesHvCollector	 | WARN 	 | Failed to decode ves event header, reason: Protocol message tag had invalid wire type.
    | p.dcae.collectors.veshv.impl.wire.WireChunkDecoder	 | TRACE	 | End of data in current TCP buffer

====

**Invalid Wire Frame**

Messages with invalid Wire Frame, just like those containing invalid GPB data, will be dropped. The exact reason can be found in logs.

::

    | p.dcae.collectors.veshv.impl.socket.NettyTcpServer	 | DEBUG	 | Client connection request received
    | p.dcae.collectors.veshv.impl.socket.NettyTcpServer	 | INFO 	 | Handling new connection
    | p.dcae.collectors.veshv.impl.wire.WireChunkDecoder	 | TRACE	 | Got message with total size of 322 B
    | p.dcae.collectors.veshv.impl.wire.WireChunkDecoder	 | TRACE	 | Wire payload size: 310 B
    | org.onap.dcae.collectors.veshv.impl.VesHvCollector	 | WARN 	 | Invalid wire frame header, reason: Invalid major version in wire frame header. Expected 1 but was 2
    | p.dcae.collectors.veshv.impl.wire.WireChunkDecoder	 | TRACE	 | End of data in current TCP buffer


====


For more information, see the :ref:`hv_ves_behaviors` section.


Authorization related errors
----------------------------

**WARNING: SSL/TLS authorization is a part of an experimental feature for ONAP Casablanca release and should be treated as unstable and subject to change in future releases.**
**For more information, see** :ref:`ssl_tls_authorization`.

**Key or trust store missing**

::

    | org.onap.dcae.collectors.veshv.main | ERROR | Failed to start a server | java.io.FileNotFoundException: /etc/ves-hv/server.p12 (No such file or directory)
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


The above error is logged when key store is not provided. Similarly, when trust store is not provided, **/etc/ves-hv/trust.p12** file missing is logged.
**server.p12** and **trust.p12** are default names of key and trust stores. They can be changed by specifying **--trust-store** or **--key-store** command line arguments on deployment.

====

**Invalid credentials**

::

    | org.onap.dcae.collectors.veshv.main | ERROR | Failed to start a server | java.security.UnrecoverableKeyException: failed to decrypt safe contents entry: javax.crypto.BadPaddingException: Given final block not properly padded. Such issues can arise if a bad key is used during decryption.
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


Key or trust store password provided in configuration is invalid.

====

**Invalid key store file**

::

    | org.onap.dcae.collectors.veshv.main | ERROR | Failed to start a server | java.io.IOException: DerInputStream.getLength(): lengthTag=111, too big.
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

The above is logged when provided keystore has invalid or corrupted content.
This log also appears when you try to use key store/trust store in archive format other than **PKCS12** (the only supported by **HV-VES** store type).


