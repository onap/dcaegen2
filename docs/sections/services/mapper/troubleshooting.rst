.. This work is licensed under a Creative Commons Attribution 4.0 International License.
.. http://creativecommons.org/licenses/by/4.0


Troubleshooting
===============

**NOTE**

According to **ONAP** logging policy, **Mapper** logs contain all required markers as well as service and client specific Mapped Diagnostic Context (later referred as MDC)

Default console log pattern:

::

        |%date{&quot;HH:mm:ss.SSSXXX&quot;, UTC}\t[ %thread\t] %highlight(%-5level)\t - %msg\t

A sample, fully qualified message implementing this pattern:

::

        |11:10:13.230 [rcc-notification] INFO metricsLogger - fetch and publish from and to Dmaap started:rcc-notification


For simplicity, all log messages in this section are shortened to contain only:
    * logger name
    * log level
    * message

Error and warning logs contain also:
    * exception message
    * stack trace

**Do not rely on exact log messages or their presence, as they are often subject to change.**

Deployment/Installation errors
------------------------------

**Missing Default Config File in case of using local config instead of Consul**

::


   |13:04:37.535 [main] ERROR errorLogger - Default Config file kv.json is missing
   |13:04:37.537 [main] ERROR errorLogger - Application stoped due to missing default Config file
   |13:04:37.538 [main] INFO  o.s.s.c.ThreadPoolTaskExecutor - Shutting down ExecutorService 'applicationTaskExecutor'
   |15:40:43.982 [main] WARN  debugLogger - All Smooks objects closed
   
**These log messages are printed when the default configuration file "kv.json", was not present.**


**Invalid Default Config File in case of using local config instead of Consul**

If Default Config File  is an invalid json file, we will get below exception

::

 |15:19:52.489 [main] ERROR o.s.boot.SpringApplication - Application run failed
 |java.lang.IllegalStateException: Failed to execute CommandLineRunner
	at org.springframework.boot.SpringApplication.callRunner(SpringApplication.java:816)
	at org.springframework.boot.SpringApplication.callRunners(SpringApplication.java:797)
	at org.springframework.boot.SpringApplication.run(SpringApplication.java:324)
	at org.springframework.boot.SpringApplication.run(SpringApplication.java:1260)
	at org.springframework.boot.SpringApplication.run(SpringApplication.java:1248)
	at org.onap.universalvesadapter.Application.main(Application.java:29)
 |Caused by: org.json.JSONException: Expected a ',' or '}' at 8100 [character 2 line 54]
	at org.json.JSONTokener.syntaxError(JSONTokener.java:433)
	at org.json.JSONObject.<init>(JSONObject.java:229)
	at org.json.JSONObject.<init>(JSONObject.java:321)
	at org.onap.universalvesadapter.utils.FetchDynamicConfig.verifyConfigChange(FetchDynamicConfig.java:97)
	at org.onap.universalvesadapter.utils.FetchDynamicConfig.cbsCall(FetchDynamicConfig.java:66)
	at org.onap.universalvesadapter.service.VESAdapterInitializer.run(VESAdapterInitializer.java:83)
	at org.springframework.boot.SpringApplication.callRunner(SpringApplication.java:813)
	... 5 common frames omitted
 |15:19:52.492 [main] INFO  o.s.s.c.ThreadPoolTaskExecutor - Shutting down ExecutorService 'applicationTaskExecutor'
 |15:19:52.493 [main] WARN  debugLogger - All Smooks objects closed


**Invalid Smooks mapping file**

If VES-Mapper blueprint or local config file contains invalid Smooks mapping file, then we will get below SAXException / JsonProcessingException / JsonSyntaxException / JsonParseException while processing the incoming notifications and the notification will be dropped without converting into required VES event. All such dropped notifications will be logged in error log file.
