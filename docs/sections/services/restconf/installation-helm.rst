.. This work is licensed under a Creative Commons Attribution 4.0 International License.
.. http://creativecommons.org/licenses/by/4.0
.. _restconf-installation-helm:


Helm Installation
=================

The RESTConf microservice can be deployed using helm charts in the oom repository.


Deployment steps
~~~~~~~~~~~~~~~~

- Default app config values can be updated in oom/kubernetes/dcaegen2-services/components/dcae-restconf/values.yaml.

- Make the chart and deploy using the following command:

  .. code-block:: bash

    cd oom/kubernetes/
    make dcaegen2-services
    helm install dev-dcaegen2-services dcaegen2-services --namespace <namespace> --set global.masterPassword=<password>

- To deploy only RESTConf:

  .. code-block:: bash

    helm install dev-dcae-restconf dcaegen2-services/components/dcae-restconf --namespace <namespace> --set global.masterPassword=<password>

- To Uninstall

  .. code-block:: bash

    helm uninstall dev-dcae-restconf

Application Configurations
--------------------------

Supported configuration modifiable in HELM charts under **applicationConfig** section.

.. code-block:: yaml

	applicationConfig:
	  collector.rcc.appDescription: DCAE RestConf Collector Application
	  collector.rcc.appName: dcae-rcc
	  collector.rcc.dmaap.streamid: notification=device-registration
	  collector.rcc.inputQueue.maxPending: '8096'
	  tomcat.maxthreads: '200'
	  collector.rcc.service.port: '8080'
	  collector.rcc.service.secure.port: '0'
	  collector.rcc.service.secure.port: '8687'
	  collector.rcc.keystore.file.location: /opt/app/dcae-certificate/cert.jks
	  collector.rcc.keystore.passwordfile: /opt/app/dcae-certificate/jks.pass
	  collector.rcc.keystore.alias: dynamically generated
	  collector.rcc.truststore.file.location: /opt/app/dcae-certificate/trust.jks
	  collector.rcc.truststore.passwordfile: /opt/app/dcae-certificate/trust.pass
	  collector.keystore.file.location: /opt/app/dcae-certificate/external/cert.jks
	  collector.keystore.passwordfile: /opt/app/dcae-certificate/external/jks.pass
	  collector.header.authflag: '0'
	  collector.header.authlist: sample1,c2FtcGxlMQ==
	  collector.rcc.service.secure.clientauth: '0'
	  streams_publishes:
	    device-registration:
	     dmaap_info:
	        topic_url: http://message-router:3904/events/unauthenticated.DCAE_RCC_OUTPUT
	     type: message_router
	  rcc_policy: '[{"controller_name":"AccessM&C","controller_restapiUrl":"172.30.0.55:26335","controller_restapiUser":"${CONTROLLER_USERNAME}","controller_restapiPassword":"${CONTROLLER_PASSWORD}","controller_accessTokenUrl":"/rest/plat/smapp/v1/oauth/token","controller_accessTokenFile":"./etc/access-token.json","controller_accessTokenMethod":"put","controller_subsMethod":"post","controller_subscriptionUrl":"/restconf/v1/operations/huawei-nce-notification-action:establish-subscription","controller_disableSsl":"true","event_details":[{"event_name":"ONT_registration","event_description":"ONTregistartionevent","event_sseventUrlEmbed":"true","event_sseventsField":"output.url","event_sseventsUrl":"null","event_subscriptionTemplate":"./etc/ont_registartion_subscription_template.json","event_unSubscriptionTemplate":"./etc/ont_registartion_unsubscription_template.json","event_ruleId":"12345678","modifyData":"true","modifyMethod": "modifyOntEvent","userData": "remote_id=AC9.0234.0337;svlan=100;cvlan=10;"}]}]'

The location of the configuration file should be set in ``CBS_CLIENT_CONFIG_PATH`` env, for example:

    ``CBS_CLIENT_CONFIG_PATH: /app-config-input/application_config.yaml``
