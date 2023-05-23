.. This work is licensed under a Creative Commons Attribution 4.0 International License.
.. http://creativecommons.org/licenses/by/4.0


Troubleshooting
===============

**NOTE**

According to **ONAP** logging policy, **PM Mapper** logs contain all required markers as well as service and client specific Mapped Diagnostic Context (later referred as MDC)

Default console log pattern:

::

        | %date{&quot;yyyy-MM-dd'T'HH:mm:ss.SSSXXX&quot;, UTC}\t| %thread\t| %highlight(%-5level)\t| %msg\t| %marker\t| %rootException\t| %mdc\t| %thread

A sample, fully qualified message implementing this pattern:

::

        | 2018-12-18T13:12:44.369Z	 | p.dcae | DEBUG	 | Client connection request received	 | ENTRY	 | 	 | RequestID=d7762b18-854c-4b8c-84aa-95762c6f8e62, InstanceID=9b9799ca-33a5-4f61-ba33-5c7bf7e72d07, InvocationID=b13d34ba-e1cd-4816-acda-706415308107, PartnerName=C=PL, ST=DL, L=Wroclaw, O=Nokia, OU=MANO, CN=dcaegen2-hvves-client, StatusCode=INPROGRESS, ClientIPAddress=192.168.0.9, ServerFQDN=a4ca8f96c7e5	 | reactor-tcp-nio-2


For simplicity, all log messages in this section are shortened to contain only:
    * logger name
    * log level
    * message

Error and warning logs contain also:
    * exception message
    * stack trace

**Do not rely on exact log messages or their presence, as they are often subject to change.**

Configuration errors
--------------------

**Config binding service not responding**

::


        2019-02-19T17:25:17.499Z	main	INFO	org.onap.dcaegen2.services.pmmapper.config.ConfigHandler		Fetching pm-mapper configuration from Configbinding Service		ENTRY
        2019-02-19T17:25:17.502Z	main	INFO	org.onap.dcaegen2.services.pmmapper.utils.RequestSender		ee5ff670-accd-4c30-8689-0a1d12491b51		INVOKE [ SYNCHRONOUS ]
        2019-02-19T17:25:17.509Z	main	INFO	org.onap.dcaegen2.services.pmmapper.utils.RequestSender		Sending:\n{X-ONAP-PartnerName=[pm-mapper], X-ONAP-InvocationID=[ee5ff670-accd-4c30-8689-0a1d12491b51], X-ONAP-RequestID=[2778e346-590a-4ade-8f45-358d1adf048b]}
        2019-02-19T17:25:18.515Z	main	INFO	org.onap.dcaegen2.services.pmmapper.utils.RequestSender		Sending:\n{X-ONAP-PartnerName=[pm-mapper], X-ONAP-InvocationID=[ee5ff670-accd-4c30-8689-0a1d12491b51], X-ONAP-RequestID=[2778e346-590a-4ade-8f45-358d1adf048b]}
        2019-02-19T17:25:19.516Z	main	INFO	org.onap.dcaegen2.services.pmmapper.utils.RequestSender		Sending:\n{X-ONAP-PartnerName=[pm-mapper], X-ONAP-InvocationID=[ee5ff670-accd-4c30-8689-0a1d12491b51], X-ONAP-RequestID=[2778e346-590a-4ade-8f45-358d1adf048b]}
        2019-02-19T17:25:20.518Z	main	INFO	org.onap.dcaegen2.services.pmmapper.utils.RequestSender		Sending:\n{X-ONAP-PartnerName=[pm-mapper], X-ONAP-InvocationID=[ee5ff670-accd-4c30-8689-0a1d12491b51], X-ONAP-RequestID=[2778e346-590a-4ade-8f45-358d1adf048b]}
        2019-02-19T17:25:21.519Z	main	INFO	org.onap.dcaegen2.services.pmmapper.utils.RequestSender		Sending:\n{X-ONAP-PartnerName=[pm-mapper], X-ONAP-InvocationID=[ee5ff670-accd-4c30-8689-0a1d12491b51], X-ONAP-RequestID=[2778e346-590a-4ade-8f45-358d1adf048b]}
        2019-02-19T17:25:21.520Z	main	INFO	org.onap.dcaegen2.services.pmmapper.config.ConfigHandler		Received pm-mapper configuration from ConfigBinding Service:\n		EXIT
        Exception in thread "main" org.onap.dcaegen2.services.pmmapper.exceptions.CBSServerError: Error connecting to Configbinding Service:
        at org.onap.dcaegen2.services.pmmapper.config.ConfigHandler.getMapperConfig(ConfigHandler.java:78)
        at org.onap.dcaegen2.services.pmmapper.App.main(App.java:58)
        caused by: java.net.ConnectException: Connection refused (Connection refused)
        at sun.reflect.NativeConstructorAccessorImpl.newInstance0(Native Method)
        at sun.reflect.NativeConstructorAccessorImpl.newInstance(NativeConstructorAccessorImpl.java:62)
        at sun.reflect.DelegatingConstructorAccessorImpl.newInstance(DelegatingConstructorAccessorImpl.java:45)
        at java.lang.reflect.Constructor.newInstance(Constructor.java:423)
        at sun.net.www.protocol.http.HttpURLConnection$10.run(HttpURLConnection.java:1944)
        at sun.net.www.protocol.http.HttpURLConnection$10.run(HttpURLConnection.java:1939)
        at java.security.AccessController.doPrivileged(Native Method)
        at sun.net.www.protocol.http.HttpURLConnection.getChainedException(HttpURLConnection.java:1938)
        at sun.net.www.protocol.http.HttpURLConnection.getInputStream0(HttpURLConnection.java:1508)
        at sun.net.www.protocol.http.HttpURLConnection.getInputStream(HttpURLConnection.java:1492)
        at java.net.HttpURLConnection.getResponseCode(HttpURLConnection.java:480)
        at java.net.HttpURLConnection.getResponseMessage(HttpURLConnection.java:546)
        at org.onap.dcaegen2.services.pmmapper.utils.RequestSender.send(RequestSender.java:80)
        at org.onap.dcaegen2.services.pmmapper.config.ConfigHandler.getMapperConfig(ConfigHandler.java:76)
        ... 1 more
        Caused by: java.net.ConnectException: Connection refused (Connection refused)
        at java.net.PlainSocketImpl.socketConnect(Native Method)
        at java.net.AbstractPlainSocketImpl.doConnect(AbstractPlainSocketImpl.java:350)
        at java.net.AbstractPlainSocketImpl.connectToAddress(AbstractPlainSocketImpl.java:206)
        at java.net.AbstractPlainSocketImpl.connect(AbstractPlainSocketImpl.java:188)
        at java.net.SocksSocketImpl.connect(SocksSocketImpl.java:392)
        at java.net.Socket.connect(Socket.java:589)
        t java.net.Socket.connect(Socket.java:538)
        at sun.net.NetworkClient.doConnect(NetworkClient.java:180)
        at sun.net.www.http.HttpClient.openServer(HttpClient.java:463)
        at sun.net.www.http.HttpClient.openServer(HttpClient.java:558)
        at sun.net.www.http.HttpClient.<init>(HttpClient.java:242)
        at sun.net.www.http.HttpClient.New(HttpClient.java:339)
        at sun.net.www.http.HttpClient.New(HttpClient.java:357)
        at sun.net.www.protocol.http.HttpURLConnection.getNewHttpClient(HttpURLConnection.java:1220)
        at sun.net.www.protocol.http.HttpURLConnection.plainConnect0(HttpURLConnection.java:1156)
        at sun.net.www.protocol.http.HttpURLConnection.plainConnect(HttpURLConnection.java:1050)
        at sun.net.www.protocol.http.HttpURLConnection.connect(HttpURLConnection.java:984)
        at sun.net.www.protocol.http.HttpURLConnection.getInputStream0(HttpURLConnection.java:1564)
        at sun.net.www.protocol.http.HttpURLConnection.getInputStream(HttpURLConnection.java:1492)
        at org.onap.dcaegen2.services.pmmapper.utils.RequestSender.send(RequestSender.java:66)


Make sure Config Binding Service is up and running and the **ip + port** combination is correct.

====

**Missing configuration on Consul**

::


        2019-02-19T17:36:32.664Z	main	INFO	org.onap.dcaegen2.services.pmmapper.config.ConfigHandler		Fetching pm-mapper configuration from Configbinding Service		ENTRY
        2019-02-19T17:36:32.666Z	main	INFO	org.onap.dcaegen2.services.pmmapper.utils.RequestSender		9fa1b84f-05ce-4e27-bba9-4ea477c1baa7		INVOKE [ SYNCHRONOUS ]
        2019-02-19T17:36:32.671Z	main	INFO	org.onap.dcaegen2.services.pmmapper.utils.RequestSender		Sending:\n{X-ONAP-PartnerName=[pm-mapper], X-ONAP-InvocationID=[9fa1b84f-05ce-4e27-bba9-4ea477c1baa7], X-ONAP-RequestID=[6e861d17-3f4b-4a2e-9ea8-a31bb9dbb7e8]}
        2019-02-19T17:36:32.696Z	main	INFO	org.onap.dcaegen2.services.pmmapper.utils.RequestSender		Received:\n{"pm-mapper-filter": "{ \"filters\":[]}", "3GPP.schema.file": "{\"3GPP_Schema\":\"./etc/3GPP_relaxed_schema.xsd\"}", "streams_subscribes": {"dmaap_subscriber": {"type": "data_router", "aaf_username": null, "aaf_password": null, "dmaap_infooooo": {"location": "csit-pmmapper", "delivery_url": "3gpppmmapper", "username": "username", "password": "password", "subscriber_id": "subsriber_id"}}}, "streams_publishes": {"pm_mapper_handle_out": {"type": "message_router", "aaf_password": null, "dmaap_info": {"topic_url": "https://message-router:3904/events/org.onap.dmaap.onapCSIT.pm_mapper", "client_role": "org.onap.dmaap.client.pub", "location": "csit-pmmapper", "client_id": null}, "aaf_username": null}}, "buscontroller_feed_subscription_endpoint": "http://dmaap-bc:8080/webapi/dr_subs", "services_calls": {}}
        2019-02-19T17:36:32.696Z	main	INFO	org.onap.dcaegen2.services.pmmapper.config.ConfigHandler		Received pm-mapper configuration from ConfigBinding Service:\n{"pm-mapper-filter": "{ \"filters\":[]}", "3GPP.schema.file": "{\"3GPP_Schema\":\"./etc/3GPP_relaxed_schema.xsd\"}", "streams_subscribes": {"dmaap_subscriber": {"type": "data_router", "aaf_username": null, "aaf_password": null, "dmaap_infooooo": {"location": "csit-pmmapper", "delivery_url": "3gpppmmapper", "username": "username", "password": "password", "subscriber_id": "subsriber_id"}}}, "streams_publishes": {"pm_mapper_handle_out": {"type": "message_router", "aaf_password": null, "dmaap_info": {"topic_url": "https://message-router:3904/events/org.onap.dmaap.onapCSIT.pm_mapper", "client_role": "org.onap.dmaap.client.pub", "location": "csit-pmmapper", "client_id": null}, "aaf_username": null}}, "buscontroller_feed_subscription_endpoint": "http://dmaap-bc:8080/webapi/dr_subs", "services_calls": {}}		EXIT
        Exception in thread "main" org.onap.dcaegen2.services.pmmapper.exceptions.MapperConfigException: Error parsing mapper configuration:
        {}{"pm-mapper-filter": "{ \"filters\":[]}", "3GPP.schema.file": "{\"3GPP_Schema\":\"./etc/3GPP_relaxed_schema.xsd\"}", "streams_subscribes": {"dmaap_subscriber": {"type": "data_router", "aaf_username": null, "aaf_password": null, "dmaap_infooooo": {"location": "csit-pmmapper", "delivery_url": "3gpppmmapper", "username": "username", "password": "password", "subscriber_id": "subsriber_id"}}}, "streams_publishes": {"pm_mapper_handle_out": {"type": "message_router", "aaf_password": null, "dmaap_info": {"topic_url": "https://message-router:3904/events/org.onap.dmaap.onapCSIT.pm_mapper", "client_role": "org.onap.dmaap.client.pub", "location": "csit-pmmapper", "client_id": null}, "aaf_username": null}}, "buscontroller_feed_subscription_endpoint": "http://dmaap-bc:8080/webapi/dr_subs", "services_calls": {}}
        at org.onap.dcaegen2.services.pmmapper.config.ConfigHandler.convertMapperConfigToObject(ConfigHandler.java:94)
        at org.onap.dcaegen2.services.pmmapper.config.ConfigHandler.getMapperConfig(ConfigHandler.java:83)
        at org.onap.dcaegen2.services.pmmapper.App.main(App.java:58)
        Caused by: com.google.gson.JsonParseException: Failed to check fields.
        at org.onap.dcaegen2.services.pmmapper.utils.RequiredFieldDeserializer.deserialize(RequiredFieldDeserializer.java:49)
        at com.google.gson.internal.bind.TreeTypeAdapter.read(TreeTypeAdapter.java:69)
        at com.google.gson.Gson.fromJson(Gson.java:927)
        at com.google.gson.Gson.fromJson(Gson.java:892)
        at com.google.gson.Gson.fromJson(Gson.java:841)
        at com.google.gson.Gson.fromJson(Gson.java:813)
        at org.onap.dcaegen2.services.pmmapper.config.ConfigHandler.convertMapperConfigToObject(ConfigHandler.java:92)
        ... 2 more
        Caused by: com.google.gson.JsonParseException: Field: 'busControllerFeedId', is required but not found.
        at org.onap.dcaegen2.services.pmmapper.utils.RequiredFieldDeserializer.deserialize(RequiredFieldDeserializer.java:46)



**PM Mapper** logs this information when connected to Consul, but cannot find a valid JSON configuration.
