.. This work is licensed under a Creative Commons Attribution 4.0 International License.
.. http://creativecommons.org/licenses/by/4.0
.. _pm-mapper-installation-helm:

PM-Mapper Helm Installation
===============================

PM mapper is a microservice that can be installed via Helm.

    Example command:

.. code-block:: bash

        helm -n onap install dev-dcaegen2-services-pm-mapper -f <custom values filename> --set global.centralizedLoggingEnabled=false dcaegen2-services/components/dcae-pm-mapper/

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
