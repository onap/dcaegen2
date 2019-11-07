.. This work is licensed under a Creative Commons Attribution 4.0 International License.
.. http://creativecommons.org/licenses/by/4.0

Installation
============

VESCollector is installed via cloudify blueprint by DCAE bootstrap process on typical ONAP installation.
As the service is containerized, it can be started on stand-alone mode also.


To run VES Collector container on standalone mode, following parameters are required

    ``docker run -d -p 8080:8080/tcp -p 8443:8443/tcp -P -e DMAAPHOST='10.0.11.1' nexus.onap.org:10001/onap/org.onap.dcaegen2.collectors.ves.vescollector:1.4.5``


DMAAPHOST is required for standalone; for normal platform installed instance the publish URL are obtained from Consul. Below parameters are exposed for DCAE platform (cloudify) deployed instance


- COLLECTOR_IP
- DMAAPHOST - should contain an address to DMaaP, so that event publishing can work
- CBSPOLLTIMER - it should be put in here if we want to automatically fetch configuration from CBS.
- CONSUL_PROTOCOL - Consul protocol by default set to **http**, if it is need to change it then that can be set to different value 
- CONSUL_HOST - used with conjunction with CBSPOLLTIMER, should be a host address (without port! e.g my-ip-or-host) where Consul service lies
- CBS_PROTOCOL - Config Binding Service protocol by default set to **http**, if it is need to change it then that can be set to different value
- CONFIG_BINDING_SERVICE - used with conjunction with CBSPOLLTIMER, should be a name of CBS as it is registered in Consul
- HOSTNAME - used with conjunction with CBSPOLLTIMER, should be a name of VESCollector application as it is registered in CBS catalog

These parameters can be configured either by passing command line option during `docker run` call or by specifying environment variables named after command line option name


Authentication Support
----------------------

VES Collector support following authentication types

    * *auth.method=noAuth* default option - no security (http)
    * *auth.method=certBasicAuth* is used to enable mutual TLS authentication or/and basic HTTPs authentication

Default ONAP deployed VESCOllector is configured for "noAuth". If VESCollector instance need to be deployed with authentication enabled, follow below setup


- Update existing VESCollector deployment to remove nodeport conflict by editing service definition
    .. code-block:: bash

        kubectl edit svc -n onap xdcae-ves-collector

and remove following entry and save the changes; K8S will update the  service definition default VES instance

    .. code-block:: bash

              - name: xport-t-8443
                nodePort: 30417
                port: 8443
                protocol: TCP
                targetPort: 8443

- Execute into Bootstrap POD using kubectl command

- Copy blueprint content into DCAE bootstrap POD under /blueprints directory under same file name.

``k8s-ves-tls.yaml``
--------------------


::

    # ============LICENSE_START====================================================
    # =============================================================================
    # Copyright (c) 2019 AT&T Intellectual Property. All rights reserved.
    # =============================================================================
    # Licensed under the Apache License, Version 2.0 (the "License");
    # you may not use this file except in compliance with the License.
    # You may obtain a copy of the License at
    #
    #      http://www.apache.org/licenses/LICENSE-2.0
    #
    # Unless required by applicable law or agreed to in writing, software
    # distributed under the License is distributed on an "AS IS" BASIS,
    # WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    # See the License for the specific language governing permissions and
    # limitations under the License.
    # ============LICENSE_END======================================================

    tosca_definitions_version: cloudify_dsl_1_3

    imports:
      - "http://www.getcloudify.org/spec/cloudify/3.4/types.yaml"
      - https://nexus.onap.org/service/local/repositories/raw/content/org.onap.dcaegen2.platform.plugins/R4/k8splugin/1.4.13/k8splugin_types.yaml

    inputs:
      ves_other_publish_url:
        type: string
        default: "http://message-router.onap.svc.cluster.local:3904/events/unauthenticated.SEC_OTHER_OUTPUT"
      ves_heartbeat_publish_url:
        type: string
        default: "http://message-router.onap.svc.cluster.local:3904/events/unauthenticated.SEC_HEARTBEAT_OUTPUT"
      ves_fault_publish_url:
        type: string
        default: "http://message-router.onap.svc.cluster.local:3904/events/unauthenticated.SEC_FAULT_OUTPUT"
      ves_measurement_publish_url:
        type: string
        default: "http://message-router.onap.svc.cluster.local:3904/events/unauthenticated.VES_MEASUREMENT_OUTPUT"
      ves_notification_publish_url:
        type: string
        default: "http://message-router.onap.svc.cluster.local:3904/events/unauthenticated.VES_NOTIFICATION_OUTPUT"
      ves_pnfRegistration_publish_url:
        type: string
        default: "http://message-router.onap.svc.cluster.local:3904/events/unauthenticated.VES_PNFREG_OUTPUT"
      tag_version:
        type: string
        default: "nexus3.onap.org:10001/onap/org.onap.dcaegen2.collectors.ves.vescollector:1.4.5"
      external_port:
        type: string
        description: Kubernetes node port on which collector is exposed
        default: "30235"
      external_tls_port:
        type: string
        description: Kubernetes node port on which collector is exposed for https
        default: "30417"
      replicas:
        type: integer
        description: number of instances
        default: 1
    node_templates:
      ves:
        interfaces:
          cloudify.interfaces.lifecycle:
            start:
              inputs:
               ports:
                 - concat: ["8443:", { get_input: external_tls_port }]
        properties:
          application_config:
            collector.dmaap.streamid: fault=ves-fault|syslog=ves-syslog|heartbeat=ves-heartbeat|measurementsForVfScaling=ves-measurement|measurement=ves-measurement|mobileFlow=ves-mobileflow|other=ves-other|stateChange=ves-statechange|thresholdCrossingAlert=ves-thresholdCrossingAlert|voiceQuality=ves-voicequality|sipSignaling=ves-sipsignaling|notification=ves-notification|pnfRegistration=ves-pnfRegistration
            collector.keystore.file.location: /opt/app/VESCollector/etc/keystore
            collector.keystore.passwordfile: /opt/app/VESCollector/etc/passwordfile
            collector.schema.checkflag: "1"
            collector.schema.file: "{\"v1\":\"./etc/CommonEventFormat_27.2.json\",\"v2\":\"./etc/CommonEventFormat_27.2.json\",\"v3\":\"./etc/CommonEventFormat_27.2.json\",\"v4\":\"./etc/CommonEventFormat_27.2.json\",\"v5\":\"./etc/CommonEventFormat_28.4.1.json\",\"v7\":\"./etc/CommonEventFormat_30.0.1.json\"}"
            collector.service.port: "8080"
            collector.service.secure.port: "8443"
            event.transform.flag: "0"
            auth.method: certBasicAuth
            header.authlist: "sample1,$2a$10$0buh.2WeYwN868YMwnNNEuNEAMNYVU9.FSMJGyIKV3dGET/7oGOi6"
            streams_publishes:
                ves-fault:
                  dmaap_info:
                    topic_url:
                      get_input: ves_fault_publish_url
                  type: message_router
                ves-measurement:
                  dmaap_info:
                    topic_url:
                      get_input: ves_measurement_publish_url
                  type: message_router
                ves-notification:
                  dmaap_info:
                    topic_url:
                      get_input: ves_notification_publish_url
                  type: message_router
                ves-pnfRegistration:
                  dmaap_info:
                    topic_url:
                      get_input: ves_pnfRegistration_publish_url
                  type: message_router
                ves-heartbeat:
                  dmaap_info:
                    topic_url:
                      get_input: ves_heartbeat_publish_url
                  type: message_router
                ves-other:
                  dmaap_info:
                    topic_url:
                      get_input: ves_other_publish_url
                  type: message_router
            collector.dynamic.config.update.frequency: "5"
          #docker_config:
          #  healthcheck:
          #    endpoint: /healthcheck
          #    interval: 15s
          #    timeout: 1s
          #    type: https
          image:
            get_input: tag_version
          replicas: {get_input: replicas}
          name: 'dcae-ves-collector-tls'
          dns_name: 'dcae-ves-collector-tls'
          log_info:
            log_directory: "/opt/app/VESCollector/logs/ecomp"
        type: dcae.nodes.ContainerizedPlatformComponent



- Validate blueprint
    .. code-block:: bash

        cfy blueprints validate /blueprints/k8s-ves-tls.yaml

- Deploy blueprint
    .. code-block:: bash

        cfy install -b ves-tls -d ves-tls /blueprints/k8s-ves-tls.yaml

To undeploy ves-tls, steps are noted below

- Uninstall running ves-tls and delete deployment
    .. code-block:: bash

        cfy uninstall ves-tls

The deployment uninstall will also delete the blueprint. In some case you might notice 400 error reported indicating active deployment exist such as below
** An error occurred on the server: 400: Can't delete blueprint ves-tls - There exist deployments for this blueprint; Deployments ids: ves-tls**

In this case blueprint can be deleted explicitly using this command.

    .. code-block:: bash

        cfy blueprint delete ves-tls

Known Issue : When VESCollector is required to be deployed with authentication enabled *auth.method: certBasicAuth*
the blueprint currently disables healthcheck parameters configuration (below). This causes no readiness probe to be deployed in K8S when VES Collector is deployed with authentication enabled.

    
        .. code-block:: bash

            docker_config:
                healthcheck:
                  endpoint: /healthcheck
                  interval: 15s
                  timeout: 1s
                  type: https


The healthcheck support when VESauthentication is enabled needs a different solution to be worked. This will be worked as future enhancement  (DCAEGEN2-1594)
