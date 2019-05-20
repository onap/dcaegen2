.. This work is licensed under a Creative Commons Attribution 4.0 International License.
.. http://creativecommons.org/licenses/by/4.0

Architecture
============

Introduction
------------
As most services and collectors deployed on DCAE platform relies on similar microservices a common Software Development Kit has been created. It contains utilities and clients which may be used for getting configuration from CBS, consuming messages from DMaaP, interacting with A&AI, etc. SDK is written in Java.

Some of common function across different services are targeted to build as separate library was created in Dublin release.

Reactive programming
--------------------
Most of SDK APIs are using Project Reactor, which is one of available implementations of Reactive Streams (as well as Java 9 Flow). Due to this fact SDK supports both high-performance, non-blocking asynchronous clients and old-school, thread-bound, blocking clients. Reactive programming can solve many cloud-specific problems - if used properly.



Libraries:
----------

DmaaP-MR Client
~~~~~~~~~~~~~~~
    * Support for DmaaP MR publish and subscribe
    * Support for DmaaP configuration fetching from Consul
    * Support for authenticated topics pub/sub
    * Standardized logging


ConfigBindingService Client
~~~~~~~~~~~~~~~~~~~~~~~~~~~
    Thin client wrapper to invoke CBS api to fetch configuration based on exposed properties during deployment. Provides option to periodically query and capture new configuration changes if any should be returned to application.


A&AI Client
~~~~~~~~~~~
    * Standardized logging and error handling
    * Provides a wrapper on AAI api for identifying node-type and support appropriate enrichment queries
    * Standardizes PNF update related queries


DCAE Common Libraries (ONAP WIKI)
---------------------------------
Following link is a reference to an internet site which describes basic features in general.
DCAE_Common_Libraries_

.. _DCAE_Common_Libraries: https://wiki.onap.org/pages/viewpage.action?pageId=45300259

DCAE SDK
~~~~~~~~
Contains some general notes about the project and libraries which were used.
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