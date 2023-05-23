.. This work is licensed under a Creative Commons Attribution 4.0 International License.
.. http://creativecommons.org/licenses/by/4.0
.. _dfc-installation-helm:

DataFile Collector Helm Installation
====================================

DataFile Collector is a microservice that can be installed via Helm.
The chart files are hosted in `OOM <https://gerrit.onap.org/r/gitweb?p=oom.git;a=tree;f=kubernetes/dcaegen2-services/components/dcae-datafile-collector>`_ repository.

    Example command:

.. code-block:: bash

        helm -n onap install dev-dcaegen2-datafile-collector -f <custom values filename> --set global.centralizedLoggingEnabled=false dcaegen2-services/components/dcae-datafile-collector/


Dependencies
^^^^^^^^^^^^

List of services which should be running prior PM-Mapper installation:

    - DMaaP Message Router
    - DMaaP Data Router
    - DMaaP Bus Controller post install jobs should have completed successfully (executed as part of an OOM install).

Configuration
^^^^^^^^^^^^^

DataFile uses SDK's Config Binding Service client for configuration application.
Consul is not needed anymore. It is used as a second choice source of configuration (if the default one is unavailable).
By default, a ConfigMap is used to load the configuration.

The location of the configuration file should be set in ``CBS_CLIENT_CONFIG_PATH`` env, for example:

    ``CBS_CLIENT_CONFIG_PATH: /app-config-input/application_config.yaml``

Example yaml file with DataFile Collector configuration:

.. code-block:: yaml

    dmaap.certificateConfig.keyCert: /opt/app/datafile/etc/cert/cert.p12
    dmaap.certificateConfig.keyPasswordPath: /opt/app/datafile/etc/cert/p12.pass
    dmaap.certificateConfig.trustedCa: /opt/app/datafile/etc/cert/trust.jks
    dmaap.certificateConfig.trustedCaPasswordPath: /opt/app/datafile/etc/cert/trust.pass
    dmaap.certificateConfig.enableCertAuth: true
    dmaap.dmaapConsumerConfiguration.consumerGroup: OpenDcae-c12
    dmaap.dmaapConsumerConfiguration.consumerId: C12
    dmaap.dmaapConsumerConfiguration.timeoutMs: -1
    dmaap.security.enableDmaapCertAuth: true
    dmaap.security.keyStorePasswordPath: /opt/app/datafile/etc/cert/jks.pass
    dmaap.security.keyStorePath: /opt/app/datafile/etc/cert/cert.jks
    dmaap.security.trustStorePasswordPath: /opt/app/datafile/etc/cert/trust.pass
    dmaap.security.trustStorePath: /opt/app/datafile/etc/cert/trust.jks
    service_calls: []
    sftp.security.strictHostKeyChecking: true
    streams_publishes:
      PM_MEAS_FILES:
        dmaap_info:
          location: loc00
          log_url: ${DR_LOG_URL_0}
          password: ${DR_PASSWORD}
          publish_url: ${DR_FILES_PUBLISHER_URL_0}
          publisher_id: ${DR_FILES_PUBLISHER_ID_0}
          username: ${DR_USERNAME}
        type: data_router
    streams_subscribes:
      dmaap_subscriber:
        dmaap_info:
          topic_url: https://message-router:3905/events/unauthenticated.VES_NOTIFICATION_OUTPUT
        type: message_router


More information about properties could be found in configuration section, see :ref:`dfc_configuration`.
