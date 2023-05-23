.. This work is licensed under a Creative Commons Attribution 4.0 International License.
.. http://creativecommons.org/licenses/by/4.0

Troubleshooting
===============

In order to find the origin of an error, we suggest to use the logs resulting from tracing, which needs to be activated.

Using the DFC REST API
""""""""""""""""""""""
The DFC supports a REST API which includes features to facilitate troubleshooting.

One REST primitive, **status**, returns statistics and status information for the DFC processing.
Here follows an example on how to use (here curl is used, but a web-browser can also be used. If you are
logged in to a container, wget can probably be used):

``curl http://127.0.0.1:8100/status  -i -X GET``

The following features are implemented by enabling so called 'actuators' in the Springboot framework used:

**loggers** - is used to control the logging level on different loggers (so you can enabled debug tracing on a certain
logger.

**logfile** - get logged information.

**health** - get health check info, there is currently no info here. But the endpoint is enabled.

**metrics** - read metrics from the Java execution environment; such as memory consumption, number of threads, open file
descriptors etc.

Here follow some examples:
Activate debug tracing on all classes in the DFC:

    ``curl http://127.0.0.1:8100/actuator/loggers/org.onap.dcaegen2.collectors.datafile -i -X POST  -H 'Content-Type:
    application/json' -d '{"configuredLevel":"debug"}'``

Read the log file:

    ``curl http://127.0.0.1:8100/actuator/logfile  -i -X GET``

Get build information:

    ``curl http://127.0.0.1:8100/actuator/info``

Get metric from the JVM. This lists the metrics that are available:

    ``curl http://127.0.0.1:8100/actuator/metrics  -i -X GET``

To see the value of a particular metric, just add \/[nameOfTheMetric] in the end of address, for example:

    ``curl http://127.0.0.1:8100/actuator/metrics/process.cpu.usage  -i -X GET``


Certificate failure
"""""""""""""""""""

If there is an error linked to the certificate, it is possible to get information about it. A possible cause for the
error can be that the expiry date of the certificate is past.

    ``keytool -list -v -keystore dfc.jks``

The command to encode the b64 jks file to local execution is (the \*.jks.b64 is in the repo and the Dockerfile is
encoding it into .jks. So when you pull from nexus, this won't be needed, only when git-checkout and java/mvn run):

    ``base64 -d dfc.jks.b64 > dfc.jks``


Common logs due to configuration errors
"""""""""""""""""""""""""""""""""""""""

**Do not rely on exact log messages or their presence, as they are often subject to change.**



.. **Missing configuration on Consul**

.. "Exception during getting configuration from CONSUL/CONFIG_BINDING_SERVICE"


DFC uses a number of configuration parameters. You can find below the kind of reply you get if any parameter is not valid:


-Wrong trustedCaPassword:

.. code-block:: log

    org.onap.dcaegen2.collectors.datafile.tasks.FileCollector     |2019-04-24T14:05:54.494Z     |WARN     |Failed to download file: PNF0 A20000626.2315+0200-2330+0200_PNF0-0-1MB.tar.gz, reason: org.onap.dcaegen2.collectors.datafile.exceptions.DatafileTaskException: Could not open connection: java.io.IOException: Keystore was tampered with, or password was incorrect     |RequestID=A20000626.2315+0200-2330+0200_PNF0-0-1MB.tar.gz     |     |     |FileCollectorWorker-2     |
    \...     |WARN     |Failed to download file: ..., reason: org.onap.dcaegen2.collectors.datafile.exceptions.DatafileTaskException: Could not open connection: java.io.IOException: Keystore was tampered with, or password was incorrect     ...
    \...     |WARN     |Failed to download file: ..., reason: org.onap.dcaegen2.collectors.datafile.exceptions.DatafileTaskException: Could not open connection: java.io.IOException: Keystore was tampered with, or password was incorrect     ...
    \...     |WARN     |Failed to download file: ..., reason: org.onap.dcaegen2.collectors.datafile.exceptions.DatafileTaskException: Could not open connection: java.io.IOException: Keystore was tampered with, or password was incorrect     ...
    org.onap.dcaegen2.collectors.datafile.tasks.ScheduledTasks     |2019-04-24T14:06:40.609Z     |ERROR     |File fetching failed, fileData


-Wrong trustedCa:

.. code-block:: none

    org.onap.dcaegen2.collectors.datafile.tasks.FileCollector     |2019-04-24T14:11:22.584Z     |WARN     |Failed to download file: PNF0 A20000626.2315+0200-2330+0200_PNF0-0-1MB.tar.gz, reason: org.onap.dcaegen2.collectors.datafile.exceptions.DatafileTaskException: Could not open connection: java.io.FileNotFoundException: **WRONGconfig/ftp.jks**     |RequestID=A20000626.2315+0200-2330+0200_PNF0-0-1MB.tar.gz     |     |     |FileCollectorWorker-2     |
    \...     |WARN     |Failed to download file: ..., reason: org.onap.dcaegen2.collectors.datafile.exceptions.DatafileTaskException: Could not open connection: java.io.FileNotFoundException: WRONGconfig/ftp.jks     ...
    \...     |WARN     |Failed to download file: ..., reason: org.onap.dcaegen2.collectors.datafile.exceptions.DatafileTaskException: Could not open connection: java.io.FileNotFoundException: WRONGconfig/ftp.jks     ...
    \...     |WARN     |Failed to download file: ..., reason: org.onap.dcaegen2.collectors.datafile.exceptions.DatafileTaskException: Could not open connection: java.io.FileNotFoundException: WRONGconfig/ftp.jks     ...
    org.onap.dcaegen2.collectors.datafile.tasks.ScheduledTasks     |2019-04-24T14:11:58.963Z     |ERROR     |File fetching failed, fileData

-Wrong keyPassword:

.. code-block:: none

    org.onap.dcaegen2.collectors.datafile.tasks.FileCollector     |2019-04-24T14:15:40.694Z     |WARN     |Failed to download file: PNF0 A20000626.2315+0200-2330+0200_PNF0-0-1MB.tar.gz, reason: org.onap.dcaegen2.collectors.datafile.exceptions.DatafileTaskException: Could not open connection: java.io.IOException: Keystore was tampered with, or password was incorrect     |RequestID=A20000626.2315+0200-2330+0200_PNF0-0-1MB.tar.gz     |     |     |FileCollectorWorker-2     |
    \...     |WARN     |Failed to download file: ..., reason: org.onap.dcaegen2.collectors.datafile.exceptions.DatafileTaskException: Could not open connection: java.io.IOException: Keystore was tampered with, or password was incorrect     ...
    \...     |WARN     |Failed to download file: ..., reason: org.onap.dcaegen2.collectors.datafile.exceptions.DatafileTaskException: Could not open connection: java.io.IOException: Keystore was tampered with, or password was incorrect     ...
    \...     |WARN     |Failed to download file: ..., reason: org.onap.dcaegen2.collectors.datafile.exceptions.DatafileTaskException: Could not open connection: java.io.IOException: Keystore was tampered with, or password was incorrect     ...
    org.onap.dcaegen2.collectors.datafile.tasks.ScheduledTasks     |2019-04-24T14:16:08.292Z     |ERROR     |File fetching failed, fileData

-Wrong keyCert:

.. code-block:: none

    org.onap.dcaegen2.collectors.datafile.tasks.FileCollector     |2019-04-24T14:20:46.308Z     |WARN     |Failed to download file: PNF0 A20000626.2315+0200-2330+0200_PNF0-0-1MB.tar.gz, reason: org.onap.dcaegen2.collectors.datafile.exceptions.DatafileTaskException: Could not open connection: java.io.FileNotFoundException: **WRONGconfig/dfc.jks (No such file or directory)**     |RequestID=A20000626.2315+0200-2330+0200_PNF0-0-1MB.tar.gz     |     |     |FileCollectorWorker-2     |
    \...     |WARN     |Failed to download file: ..., reason: org.onap.dcaegen2.collectors.datafile.exceptions.DatafileTaskException: Could not open connection: java.io.FileNotFoundException: WRONGconfig/dfc.jks (No such file or directory)     ...
    \...     |WARN     |Failed to download file: ..., reason: org.onap.dcaegen2.collectors.datafile.exceptions.DatafileTaskException: Could not open connection: java.io.FileNotFoundException: WRONGconfig/dfc.jks (No such file or directory)     ...
    \...     |WARN     |Failed to download file: ..., reason: org.onap.dcaegen2.collectors.datafile.exceptions.DatafileTaskException: Could not open connection: java.io.FileNotFoundException: WRONGconfig/dfc.jks (No such file or directory)     ...
    org.onap.dcaegen2.collectors.datafile.tasks.ScheduledTasks     |2019-04-24T14:21:16.447Z     |ERROR     |File fetching failed, fileData

-Wrong consumer dmaapHostName:

.. code-block:: none

    org.onap.dcaegen2.collectors.datafile.tasks.ScheduledTasks     |2019-04-24T14:27:06.578Z     |ERROR     |Polling for file ready message failed, exception: java.net.UnknownHostException: **WRONGlocalhost**: Try again, config: DmaapConsumerConfiguration{consumerId=C12, consumerGroup=OpenDcae-c12, timeoutMs=-1, messageLimit=1, **dmaapHostName=WRONGlocalhost**, dmaapPortNumber=2222, dmaapTopicName=/events/unauthenticated.VES_NOTIFICATION_OUTPUT, dmaapProtocol=http, dmaapUserName=, dmaapUserPassword=, dmaapContentType=application/json, trustStorePath=change it, trustStorePasswordPath=change it, keyStorePath=change it, keyStorePasswordPath=change it, enableDmaapCertAuth=false}     |RequestID=90fe7450-0bc2-4bf6-a2f0-2aeef6f196ae     |     |     |reactor-http-epoll-3     |
    \...     |ERROR     |Polling for file ready message failed, exception: java.net.UnknownHostException: *WRONGlocalhost*, config: DmaapConsumerConfiguration{..., dmaapHostName=*WRONGlocalhost*, ...}     ...
    \...     |ERROR     |Polling for file ready message failed, exception: java.net.UnknownHostException: *WRONGlocalhost*: Try again, config: DmaapConsumerConfiguration{..., dmaapHostName=*WRONGlocalhost*, ...}     ...
    \...     |ERROR     |Polling for file ready message failed, exception: java.net.UnknownHostException: *WRONGlocalhost*: Try again, config: DmaapConsumerConfiguration{..., dmaapHostName=*WRONGlocalhost*, ...}     ...
    \...     |ERROR     |Polling for file ready message failed, exception: java.net.UnknownHostException: *WRONGlocalhost*: Try again, config: DmaapConsumerConfiguration{..., dmaapHostName=*WRONGlocalhost*, ...}     ...
    \...     |ERROR     |Polling for file ready message failed, exception: java.net.UnknownHostException: *WRONGlocalhost*: Try again, config: DmaapConsumerConfiguration{..., dmaapHostName=*WRONGlocalhost*, ...}     ...

-Wrong consumer dmaapPortNumber:

.. code-block:: none

    org.onap.dcaegen2.collectors.datafile.tasks.ScheduledTasks     |2019-04-24T14:33:35.286Z     |ERROR     |Polling for file ready message failed, exception: io.netty.channel.AbstractChannel$AnnotatedConnectException: syscall:getsockopt(..) failed: Connection refused: localhost/127.0.0.1:**WRONGport**, config: DmaapConsumerConfiguration{consumerId=C12, consumerGroup=OpenDcae-c12, timeoutMs=-1, messageLimit=1, dmaapHostName=localhost, **dmaapPortNumber=WRONGport**, dmaapTopicName=/events/unauthenticated.VES_NOTIFICATION_OUTPUT, dmaapProtocol=http, dmaapUserName=, dmaapUserPassword=, dmaapContentType=application/json, trustStorePath=change it, trustStorePasswordPath=change it, keyStorePath=change it, keyStorePasswordPath=change it, enableDmaapCertAuth=false}     |RequestID=b57c68fe-84bf-442f-accd-ea821a5a321f     |     |     |reactor-http-epoll-3     |
    \...     |ERROR     |Polling for file ready message failed, exception: io.netty.channel.AbstractChannel$AnnotatedConnectException: syscall:getsockopt(..) failed: Connection refused: localhost/127.0.0.1:*WRONGport*, config: DmaapConsumerConfiguration{..., dmaapPortNumber=*WRONGport*, ...}     ...
    \...     |ERROR     |Polling for file ready message failed, exception: io.netty.channel.AbstractChannel$AnnotatedConnectException: syscall:getsockopt(..) failed: Connection refused: localhost/127.0.0.1:*WRONGport*, config: DmaapConsumerConfiguration{..., dmaapPortNumber=*WRONGport*, ...}     ...
    \...     |ERROR     |Polling for file ready message failed, exception: io.netty.channel.AbstractChannel$AnnotatedConnectException: syscall:getsockopt(..) failed: Connection refused: localhost/127.0.0.1:*WRONGport*, config: DmaapConsumerConfiguration{..., dmaapPortNumber=*WRONGport*, ...}     ...
    \...     |ERROR     |Polling for file ready message failed, exception: io.netty.channel.AbstractChannel$AnnotatedConnectException: syscall:getsockopt(..) failed: Connection refused: localhost/127.0.0.1:*WRONGport*, config: DmaapConsumerConfiguration{..., dmaapPortNumber=*WRONGport*, ...}     ...
    \...     |ERROR     |Polling for file ready message failed, exception: io.netty.channel.AbstractChannel$AnnotatedConnectException: syscall:getsockopt(..) failed: Connection refused: localhost/127.0.0.1:*WRONGport*, config: DmaapConsumerConfiguration{..., dmaapPortNumber=*WRONGport*, ...}     ...

-Wrong consumer dmaapTopicName:

.. code-block:: none

    org.onap.dcaegen2.collectors.datafile.tasks.ScheduledTasks     |2019-04-24T14:38:07.097Z     |ERROR     |Polling for file ready message failed, exception: java.lang.RuntimeException: DmaaPConsumer HTTP 404 NOT_FOUND, config: DmaapConsumerConfiguration{consumerId=C12, consumerGroup=OpenDcae-c12, timeoutMs=-1, messageLimit=1, dmaapHostName=localhost, dmaapPortNumber=2222, **dmaapTopicName=/events/unauthenticated.VES_NOTIFICATION_OUTPUTWRONG**, dmaapProtocol=http, dmaapUserName=, dmaapUserPassword=, dmaapContentType=application/json, trustStorePath=change it, trustStorePasswordPath=change it, keyStorePath=change it, keyStorePasswordPath=change it, enableDmaapCertAuth=false}     |RequestID=8bd71bac-68af-494b-9518-3ab4478371cf     |     |     |reactor-http-epoll-4     |
    \...     |ERROR     |Polling for file ready message failed, exception: java.lang.RuntimeException: DmaaPConsumer HTTP 404 NOT_FOUND, config: DmaapConsumerConfiguration{..., dmaapTopicName=*/events/unauthenticated.VES_NOTIFICATION_OUTPUTWRONG*, ...}     ...
    \...     |ERROR     |Polling for file ready message failed, exception: java.lang.RuntimeException: DmaaPConsumer HTTP 404 NOT_FOUND, config: DmaapConsumerConfiguration{..., dmaapTopicName=*/events/unauthenticated.VES_NOTIFICATION_OUTPUTWRONG*, ...}     ...
    \...     |ERROR     |Polling for file ready message failed, exception: java.lang.RuntimeException: DmaaPConsumer HTTP 404 NOT_FOUND, config: DmaapConsumerConfiguration{..., dmaapTopicName=*/events/unauthenticated.VES_NOTIFICATION_OUTPUTWRONG*, ...}     ...
    \...     |ERROR     |Polling for file ready message failed, exception: java.lang.RuntimeException: DmaaPConsumer HTTP 404 NOT_FOUND, config: DmaapConsumerConfiguration{..., dmaapTopicName=*/events/unauthenticated.VES_NOTIFICATION_OUTPUTWRONG*, ...}     ...
    \...     |ERROR     |Polling for file ready message failed, exception: java.lang.RuntimeException: DmaaPConsumer HTTP 404 NOT_FOUND, config: DmaapConsumerConfiguration{..., dmaapTopicName=*/events/unauthenticated.VES_NOTIFICATION_OUTPUTWRONG*, ...}     ...

-Consumer dmaapProtocol:
Not configurable.

Missing known_hosts file
""""""""""""""""""""""""
When StrictHostKeyChecking is enabled and DFC cannot find a known_hosts file, the warning information shown below is visible in the logfile. In this case, DFC acts like StrictHostKeyChecking is disabled.

.. code-block:: none

    org.onap.dcaegen2.collectors.datafile.ftp.SftpClient     |2020-07-24T06:32:56.010Z
    |WARN     |StrictHostKeyChecking is enabled but environment variable KNOWN_HOSTS_FILE_PATH is not set or points to not existing file [/home/datafile/.ssh/known_hosts]  -->  falling back to StrictHostKeyChecking='no'.

To resolve this warning, provide a known_hosts file or disable StrictHostKeyChecking, see DFC config page - :ref:`strict_host_checking_config`.

Inability to download file from xNF due to certificate problem
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

When collecting files using HTTPS and DFC contains certs from CMPv2 server, an exception like "unable to find valid
certification path to requested target" may occur. Except obvious certificates problems make sure, that xNF which
are connecting to the DFC are supplied with certificates coming from the same CMPv2 server and the same CA which
is configured on ONAP side and used by DFC.

Inability to properly run DFC (v1.5.3 and above)
""""""""""""""""""""""""""""""""""""""""""""""""

Note, since DFC 1.5.3 FTPeS/HTTPS config blueprint was slighly changed.

.. code-block:: json

    "dmaap.ftpesConfig.*"

was changed with

.. code-block:: json

    "dmaap.certificateConfig.*"

Container update without updating DFC config (or blueprint) will result in inability to run DFC with FTPeS and HTTPS.
