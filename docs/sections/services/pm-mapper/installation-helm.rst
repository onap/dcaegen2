.. This work is licensed under a Creative Commons Attribution 4.0 International License.
.. http://creativecommons.org/licenses/by/4.0
.. _pm-mapper-installation-helm:

PM-Mapper Helm Installation
===========================

PM mapper is a microservice that can be installed via Helm.
The chart files are hosted in `OOM <https://gerrit.onap.org/r/gitweb?p=oom.git;a=tree;f=kubernetes/dcaegen2-services/components/dcae-pm-mapper>`_ repository.

    Example command:

.. code-block:: bash

        helm -n onap install dev-dcaegen2-services-pm-mapper -f <custom values filename> --set global.centralizedLoggingEnabled=false dcaegen2-services/components/dcae-pm-mapper/


Dependencies
^^^^^^^^^^^^

List of services which should be running prior PM-Mapper installation:

    - DMaaP Message Router
    - DMaaP Data Router
    - DMaaP Bus Controller post install jobs should have completed successfully (executed as part of an OOM install).
    - Data File Collector

Configuration
^^^^^^^^^^^^^

PM-Mapper uses SDK's Config Binding Service client for initial and periodical configuration application.
Consul is not needed anymore. It is used as a second choice source of configuration (if the default one is unavailable).
By default, a ConfigMap is used to load, and later change the configuration in runtime.

The location of the configuration file should be set in ``CBS_CLIENT_CONFIG_PATH`` env, for example:

    ``CBS_CLIENT_CONFIG_PATH: /app-config-input/application_config.yaml``

Example yaml file with PM-Mapper configuration:

.. code-block:: yaml

    pm-mapper-filter:
      filters:
        - pmDefVsn: "1.0"
          nfType: "gnb"
          vendor: "Nokia"
          measTypes:
          - attTCHSeizures
          - succTCHSeizures2
          - succImmediateAssignProcs8
    key_store_path: "/opt/app/pm-mapper/etc/certs/cert.jks"
    key_store_pass_path: "/opt/app/pm-mapper/etc/certs/jks.pass"
    trust_store_path: "/opt/app/pm-mapper/etc/certs/trust.jks"
    trust_store_pass_path: "/opt/app/pm-mapper/etc/certs/trust.pass"
    dmaap_dr_delete_endpoint: "https://dmaap-dr-node:8443/delete"
    dmaap_dr_feed_name: "1"
    aaf_identity: "aaf_admin@people.osaaf.org"
    aaf_password: "demo123456!"
    enable_http: true,
    streams_publishes:
      dmaap_publisher:
        type: "message_router"
        dmaap_info:
          topic_url: "http://message-router:3904/events/org.onap.dmaap.mr.VES_PM"
          client_role: "org.onap.dcae.pmPublisher"
          location: "csit-pmmapper"
          client_id: "1562763644939"
    streams_subscribes:
      dmaap_subscriber:
        type: "data_router"
        dmaap_info:
          username: "username"
          password: "password"
          location: "csit-pmmapper"
          delivery_url: "http://dcae-pm-mapper:8081/delivery"
          subscriber_id: 1

Configuration update
^^^^^^^^^^^^^^^^^^^^

The configuration update process is very straightforward.
The only step is to modify the Config Map which contains the configuration and save the change. PM-Mapper will detect the new configuration values after a while.
It should be visible in PM-Mapper logs, for example:

.. code-block:: none

    ...
    2022-02-11T08:04:02.627Z	main	INFO	org.onap.dcaegen2.services.sdk.rest.services.cbs.client.impl.CbsClientConfigMap		Got successful output from ConfigMap file
    2022-02-11T08:04:02.627Z	main	INFO	org.onap.dcaegen2.services.pmmapper.config.ConfigHandler		Attempt to process configuration object
    2022-02-11T08:04:02.643Z	main	INFO	org.onap.dcaegen2.services.pmmapper.config.ConfigHandler		PM-mapper configuration processed successful
    2022-02-11T08:04:02.643Z	main	INFO	org.onap.dcaegen2.services.pmmapper.config.ConfigHandler		Mapper configuration:\nMapperConfig{enableHttp=true, keyStorePath='/opt/app/pm-mapper/etc/certs/cert.jks', keyStorePassPath='/opt/app/pm-mapper/etc/certs/jks.pass', trustStorePath='/opt/app/pm-mapper/etc/certs/trust.jks', trustStorePassPath='/opt/app/pm-mapper/etc/certs/trust.pass', dmaapDRDeleteEndpoint='https://dmaap-dr-node:8443/delete', filterConfig=MeasFilterConfig(filters=[]), aafUsername='aaf_admin@people.osaaf.org', aafPassword= *****, subscriberConfig=SubscriberConfig{username=username, password= *****, drLocation='csit-pmmapper', deliveryUrl='http://dcae-pm-mapper:8081/delivery', subscriberId='1'}, publisherConfig=PublisherConfig(topicUrl=http://message-router:3904/events/org.onap.dmaap.mr.VES_PM, clientRole=org.onap.dcae.pmPublisher, clientId=1562763644939, clusterLocation=csit-pmmapper)}
    ...

This logs fragment proves that the configuration source is Config Map: ``Got successful output from ConfigMap file``.
It also prints the current configuration (the last log line above). PM-Mapper keeps checking the configuration file periodically (every 60s).
