.. This work is licensed under a Creative Commons Attribution 4.0 International License.
.. http://creativecommons.org/licenses/by/4.0

.. _run_time_configuration:

Run-Time configuration
======================

HV-VES dynamic configuration is primarily meant to provide DMaaP Connection Objects.

.. note:: Kafka config info.
    In the case of HV-VES, this configuration method is purely used as a generic reference.
    The underlying kafka connection config is managed as part of the dcea helm configuration.

These objects contain information necessary to route received VES Events to correct Kafka topic.
This metadata will be later referred to as Routing definition.

Collector uses DCAE-SDK internally, to fetch configuration from Config Binding Service.

HV-VES waits 10 seconds (default, configurable during deployment with **firstRequestDelay** option, see :ref:`configuration_file`) before the first attempt to retrieve configuration from CBS. This is to prevent possible synchronization issues. During that time HV-VES declines any connection attempts from xNF (VNF/PNF).

After first request, HV-VES asks for configuration in fixed intervals, configurable from file configuration (**requestInterval**). By default interval is set to 5 seconds.

In case of failing to retrieve configuration, collector retries the action. After five unsuccessful attempts, container becomes unhealthy and cannot recover. HV-VES in this state is unusable and the container should be restarted.


Configuration format
--------------------

Following JSON format presents dynamic configuration options recognized by HV-VES Collector.

.. literalinclude:: resources/dynamic-configuration.json
    :language: json

Fields have the same meaning as in the configuration file with only difference being Routing definition.

.. note:: There is no verification of the data correctness (e.g. if specified security files are present on machine) and thus invalid data can result in service malfunctioning or even container shutdown.

Routing
-------

For every JSON key-object pair defined in **"stream_publishes"**, the key is used as domain and related object is used to setup Kafka's bootstrap servers and Kafka topic **for this domain**.

When receiving a VES Event from client, collector checks if domain (or stndDefinedNamespace when domain is 'stndDefined') from the event corresponds to any domain from Routing and publishes this event into related topic. If there is no match, the event is dropped. If there are two routes from the same domain to different topics, then it is undefined which route is used.

For more information, see :ref:`supported_domains`.

Providing configuration during OOM deployment
---------------------------------------------

The configuration is created from HV-VES Helm charts defined under **applicationConfig**  during ONAP OOM/Kubernetes deployment. 
