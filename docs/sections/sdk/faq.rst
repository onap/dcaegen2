.. This work is licensed under a Creative Commons Attribution 4.0 International License.
.. http://creativecommons.org/licenses/by/4.0

FAQ
===

General SDK questions
---------------------

Where can I find Java Doc API description?
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
JavaDoc JAR package is published together with compiled classes to the ONAP Nexus repository. You can download JavaDoc in your IDE so you will get documentation hints. Alternatively you can use Maven Dependency plugin (classifier=javadoc).

Which Java version is supported?
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
For now we are compiling SDK using JDK 11. Hence we advice to use SDK on JDK 11.

Are you sure Java 11 is supported? I can see a debug log from Netty.
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
If you have enabled a debug log level for Netty packages you might have seen the following log:

.. code-block:: none

    [main] DEBUG i.n.util.internal.PlatformDependent0 - jdk.internal.misc.Unsafe.allocateUninitializedArray(int): unavailable


Background: this is a result of  moving sun.misc.Unsafe to jdk.internal.misc.Unsafe in JDK 9, so if Netty wants to support both pre and post Java 9 it has to check the JDK version and use the class from available package.

It does not have any impact on SDK. SDK still works with this log. You might want to change log level for io.netty package to INFO.

CBS Client
----------

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
