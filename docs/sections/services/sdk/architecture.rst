.. This work is licensed under a Creative Commons Attribution 4.0 International License.
.. http://creativecommons.org/licenses/by/4.0

Architecture
============

Introduction
------------
Because most services and collectors deployed on DCAE platform relies on similar microservices a common Software Development Kit has been created. It contains utilities and clients which may be used when getting configuration from CBS, consuming messages from DMaaP, interacting with A&AI, etc. SDK is written in Java.

For Dublin, some of common function across different services are targeted to build as separate library. A new repository - dcaegen2/services/sdk was created.

Reactive programming
--------------------
Most of SDK APIs are using Project Reactor, which is one of available implementations of Reactive Streams (as well as Java 9 Flow). This way we support both high-performance, non-blocking asynchronous clients and old-school, thread-bound, blocking clients. We believe that using reactive programming can solve many cloud-specific problems for us - if used properly.



Libraries:
----------

Following are some of the common function identified and requirement at high-level


DmaaP-MR Client
~~~~~~~~~~~~~~~
    * Support for DMAAP MR publish and subscribe
    * Standardize Dmaap configuration from Consul fetch
    * Support for authenticated topics pub/sub
    * Standardized logging


ConfigBindingService Client
~~~~~~~~~~~~~~~~~~~~~~~~~~~
    Thin client wrapper to invoke the CBS api to fetch configuration based on exposed properties during deployment. This should also provide option to periodically query and capture new configuration changes if any and returned to application


A&AI Client
~~~~~~~~~~~
    * Standardized logging and error handling
    * Provide a wrapper on AAI api for identifying node-type and support appropriate enrichment queries
    * Standardize PNF update related queries


DCAE Common Libraries (ONAP WIKI)
---------------------------------
Following link is a reference to an internet site which describes basic features in general.
DCAE_Common_Libraries_

.. _DCAE_Common_Libraries: https://wiki.onap.org/pages/viewpage.action?pageId=45300259

DCAE SDK
~~~~~~~~
Contains some general notes about the project and libs which were used in it.
DCAE_SDK_

.. _DCAE_SDK: https://wiki.onap.org/display/DW/DCAE+SDK

Changelog
~~~~~~~~~
Below link is a reference to an internet site which contains information about the changelog.
Changelog_

.. _Changelog: https://wiki.onap.org/display/DW/DCAE+SDK+Changelog

FAQ
~~~~
DCAE SDK Frequently Asked Questions.
FAQ_

.. _FAQ: https://wiki.onap.org/display/DW/DCAE+SDK+Frequently+Asked+Questions