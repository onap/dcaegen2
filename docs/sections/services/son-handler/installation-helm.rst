.. This work is licensed under a Creative Commons Attribution 4.0 International License.
.. http://creativecommons.org/licenses/by/4.0
.. _sonhandler-installation-helm:


Helm Installation
=================

SON handler microservice can be deployed using helm charts in oom repository.


Deployment Prerequisites
~~~~~~~~~~~~~~~~~~~~~~~~

- SON-Handler service requires config-binding-service, policy, dmaap and aaf componenets to be running.

- The following topics must be created in dmaap:

             .. code-block:: bash

                 curl --header "Content-type: application/json" --request POST --data '{"topicName": "DCAE_CL_RSP"}' http://<DMAAP_IP>:3904/events/DCAE_CL_RSP
                 curl --header "Content-type: application/json" --request POST --data '{"topicName": "unauthenticated.SEC_FAULT_OUTPUT"}' http://<DMAAP_IP>:3904/events/unauthenticated.SEC_FAULT_OUTPUT
                 curl --header "Content-type: application/json" --request POST --data '{"topicName": "unauthenticated.VES_MEASUREMENT_OUTPUT"}' http://<DMAAP_IP>:3904/events/unauthenticated.VES_MEASUREMENT_OUTPUT
                 curl --header "Content-type: application/json" --request POST --data '{"topicName": "unauthenticated.DCAE_CL_OUTPUT"}' http://<DMAAP_IP>:3904/events/unauthenticated.DCAE_CL_OUTPUT



- Policies required for SON-handler service should be created and pushed to the policy component. Steps for creating and pushing policy models:

     1.Login to policy-drools-pdp-0 container

             .. code-block:: bash

               kubectl exec -ti --namespace <namespace> policy-pdp-0 bash


     2. Create Modify Config policy:

             .. code-block:: bash

               curl -k --silent --user 'healthcheck:zb!XztG34' -X POST "https://policy-api:6969/policy/api/v1/policytypes/onap.policies.controlloop.operational.common.Drools/versions/1.0.0/policies" -H "Accept: application/json" -H "Content-Type: application/json" --data-raw '{"tosca_definitions_version":"tosca_simple_yaml_1_1_0","topology_template":{"policies":[{"operational.pcihandler":{"type":"onap.policies.controlloop.operational.common.Drools","type_version":"1.0.0","name":"operational.pcihandler","version":"1.0.0","metadata":{"policy-id":"operational.pcihandler"},"properties":{"controllerName":"usecases","id":"ControlLoop-vPCI-fb41f388-a5f2-11e8-98d0-529269fb1459","timeout":900,"abatement":false,"trigger":"unique-policy-id-123-modifyconfig","operations":[{"id":"unique-policy-id-123-modifyconfig","description":"Modify the packet generator","operation":{"actor":"SDNR","operation":"ModifyConfig","target":{"targetType":"PNF"}},"timeout":300,"retries":0,"success":"final_success","failure":"final_failure","failure_timeout":"final_failure_timeout","failure_retries":"final_failure_retries","failure_exception":"final_failure_exception","failure_guard":"final_failure_guard"}]}}}]}}'

     3. Push Modify Config policy:

            .. code-block:: bash

                curl --silent -k --user 'healthcheck:zb!XztG34' -X POST "https://policy-pap:6969/policy/pap/v1/pdps/policies" -H "Accept: application/json" -H "Content-Type: application/json" --data-raw '{"policies":[{"policy-id":"operational.pcihandler","policy-version":1}]}'


     4. Create Modify Config ANR policy:

             .. code-block:: bash

               curl -k --silent --user 'healthcheck:zb!XztG34' -X POST "https://policy-api:6969/policy/api/v1/policytypes/onap.policies.controlloop.operational.common.Drools/versions/1.0.0/policies" -H "Accept: application/json" -H "Content-Type: application/json" --data-raw '{"tosca_definitions_version":"tosca_simple_yaml_1_1_0","topology_template":{"policies":[{"operational.sonhandler":{"type":"onap.policies.controlloop.operational.common.Drools","type_version":"1.0.0","name":"operational.sonhandler","version":"1.0.0","metadata":{"policy-id":"operational.sonhandler"},"properties":{"controllerName":"usecases","id":"ControlLoop-vSONH-7d4baf04-8875-4d1f-946d-06b874048b61","timeout":900,"abatement":false,"trigger":"unique-policy-id-123-modifyconfig","operations":[{"id":"unique-policy-id-123-modifyconfig","description":"Modify the packet generator","operation":{"actor":"SDNR","operation":"ModifyConfigANR","target":{"targetType":"PNF"}},"timeout":300,"retries":0,"success":"final_success","failure":"final_failure","failure_timeout":"final_failure_timeout","failure_retries":"final_failure_retries","failure_exception":"final_failure_exception","failure_guard":"final_failure_guard"}]}}}]}}'



     6. Push Modify Config ANR policy:

           .. code-block:: bash

             curl --silent -k --user 'healthcheck:zb!XztG34' -X POST "https://policy-pap:6969/policy/pap/v1/pdps/policies" -H "Accept: application/json" -H "Content-Type: application/json" '{"policies":[{"policy-id":"operational.sonhandler","policy-version":1}]}'


     7. Create policy type:

             .. code-block:: bash

                curl -k --silent --user 'healthcheck:zb!XztG34' -X POST "https://policy-api:6969/policy/api/v1/policytypes" -H "Accept: application/json" -H "Content-Type: application/json" --data-raw '{"policy_types":{"onap.policies.monitoring.docker.sonhandler.app":{"derived_from":"onap.policies.Monitoring:1.0.0","description":"son handler policy type","properties":{"PCI_MODCONFIGANR_POLICY_NAME":{"required":true,"type":"string"},"PCI_MODCONFIG_POLICY_NAME":{"required":true,"type":"string"},"PCI_NEIGHBOR_CHANGE_CLUSTER_TIMEOUT_IN_SECS":{"required":true,"type":"string"},"PCI_OPTMIZATION_ALGO_CATEGORY_IN_OOF":{"required":true,"type":"string"},"PCI_SDNR_TARGET_NAME":{"required":true,"type":"string"}},"version":"1.0.0"}},"tosca_definitions_version":"tosca_simple_yaml_1_1_0"}'


     8. Create monitoring policy:

             .. code-block:: bash

               curl -k --silent --user 'healthcheck:zb!XztG34' -X POST "https://policy-api:6969/policy/api/v1/policytypes/onap.policies.monitoring.docker.sonhandler.app/versions/1.0.0/policies" -H "Accept: application/json" -H "Content-Type: application/json" --data-raw '{"name":"ToscaServiceTemplateSimple","topology_template":{"policies":[{"com.Config_PCIMS_CONFIG_POLICY":{"metadata":{"policy-id":"com.Config_PCIMS_CONFIG_POLICY","policy-version":"1"},"name":"com.Config_PCIMS_CONFIG_POLICY","properties":{"PCI_MODCONFIGANR_POLICY_NAME":"ControlLoop-vSONH-7d4baf04-8875-4d1f-946d-06b874048b61","PCI_MODCONFIG_POLICY_NAME":"ControlLoop-vPCI-fb41f388-a5f2-11e8-98d0-529269fb1459","PCI_NEIGHBOR_CHANGE_CLUSTER_TIMEOUT_IN_SECS":60,"PCI_OPTMIZATION_ALGO_CATEGORY_IN_OOF":"OOF-PCI-OPTIMIZATION","PCI_SDNR_TARGET_NAME":"SDNR"},"type":"onap.policies.monitoring.docker.sonhandler.app","type_version":"1.0.0","version":"1.0.0"}}]},"tosca_definitions_version":"tosca_simple_yaml_1_1_0","version":"1.0.0"}'

     9. Push monitoring policy:

             .. code-block:: bash

               curl --silent -k --user 'healthcheck:zb!XztG34' -X POST "https://policy-pap:6969/policy/pap/v1/pdps/policies" -H "Accept: application/json" -H "Content-Type: application/json" --data-raw '{"policies":[{"policy-id":"com.Config_PCIMS_CONFIG_POLICY","policy-version":1}]}'

Deployment Steps
~~~~~~~~~~~~~~~~

- Default app config values can be updated in oom/kubernetes/dcaegen2-services/components/dcae-son-handler/values.yaml

- Update monitoring policy ID in below configuration which is used to enable Policy-Sync Side car container to be deployed and retrieves active policy configuration.

  .. code-block:: yaml

    dcaePolicySyncImage: onap/org.onap.dcaegen2.deployments.dcae-services-policy-sync:1.0.1
    policies:
      policyID: |
       '["com.Config_PCIMS_CONFIG_POLICY"]'

- Update Config db IP address:

  .. code-block:: yaml

    sonhandler.configDb.service: http://<configDB-IPAddress>:8080

- Enable sonhandler component in oom/kubernetes/dcaegen2-services/values.yaml

  .. code-block:: yaml

    dcae-son-handler:
        enabled: true

- Make the chart and deploy using the following command:

  .. code-block:: bash

    cd oom/kubernetes/
    make dcaegen2-services
    helm install dev-dcaegen2-services dcaegen2-services --namespace <namespace> --set global.masterPassword=<password>

- To deploy only son-handler:

  .. code-block:: bash

    helm install dev-son-handler dcaegen2-services/components/dcae-son-handler --namespace <namespace> --set global.masterPassword=<password>

- To uninstall:

  .. code-block:: bash

    helm uninstall dev-son-handler



Application Configurations
--------------------------
+-------------------------------+------------------------------------------------+
|Configuration                  | Description                                    |
+===============================+================================================+
|streams_subscribes             | Dmaap topics that the MS will consume messages |
+-------------------------------+------------------------------------------------+
|streams_publishes              | Dmaap topics that the MS will publish messages |
+-------------------------------+------------------------------------------------+
|postgres.host                  | Host where the postgres database is running    |
+-------------------------------+------------------------------------------------+
|postgres.port                  | Host where the postgres database is running    |
+-------------------------------+------------------------------------------------+
|postgres.username              | Postgres username                              |
+-------------------------------+------------------------------------------------+
|postgres.password              | Postgres password                              |
+-------------------------------+------------------------------------------------+
|sonhandler.pollingInterval     | Polling Interval for consuming dmaap messages  |
+-------------------------------+------------------------------------------------+
|sonhandler.pollingTimeout      | Polling timeout for consuming dmaap messages   |
+-------------------------------+------------------------------------------------+
|sonhandler.numSolutions        | Number for solutions for OOF optimization      |
+-------------------------------+------------------------------------------------+
|sonhandler.minCollision        | Minimum collision criteria to trigger OOF      |
+-------------------------------+------------------------------------------------+
|sonhandler.minConfusion        | Minimum confusion criteria to trigger OOF      |
+-------------------------------+------------------------------------------------+
|sonhandler.maximumClusters     | Maximum number of clusters MS can process      |
+-------------------------------+------------------------------------------------+
|sonhandler.badThreshold        | Bad threshold for Handover success rate        |
+-------------------------------+------------------------------------------------+
|sonhandler.poorThreshold       | Poor threshold for Handover success rate       |
+-------------------------------+------------------------------------------------+
|sonhandler.namespace           | Namespace where MS is going to be deployed     |
+-------------------------------+------------------------------------------------+
|sonhandler.namespace           | Namespace where MS is going to be deployed     |
+-------------------------------+------------------------------------------------+
|sonhandler.namespace           | Namespace where MS is going to be deployed     |
+-------------------------------+------------------------------------------------+
|sonhandler.sourceId            | Source ID of the Microservice (to OOF)         |
+-------------------------------+------------------------------------------------+
|sonhandler.dmaap.server        | Location of message routers                    |
+-------------------------------+------------------------------------------------+
|sonhandler.bufferTime          | Buffer time for MS to wait for notifications   |
+-------------------------------+------------------------------------------------+
|sonhandler.cg                  | DMAAP Consumer group for subscription          |
+-------------------------------+------------------------------------------------+
|sonhandler.cid                 | DMAAP Consumer id for subcription              |
+-------------------------------+------------------------------------------------+
|sonhandler.configDbService     | Location of config DB (protocol, host & port)  |
+-------------------------------+------------------------------------------------+
|sonhandler.oof.service         | Location of OOF (protocol, host & port)        |
+-------------------------------+------------------------------------------------+
|sonhandler.optimizers          | Optimizer to trigger in OOF                    |
+-------------------------------+------------------------------------------------+
|sonhandler.poorCountThreshold  | Threshold for number of times poorThreshold    |
|                               | can be recorded for the cell                   |
+-------------------------------+------------------------------------------------+
|sonhandler.badCountThreshold   | Threshold for number of times badThreshold can |
|                               | be recorded for the cell                       |
+-------------------------------+------------------------------------------------+
|sonhandler.                    | Timer for oof triggered count in minutes       |
|oofTriggerCountTimer           |                                                |
+-------------------------------+------------------------------------------------+
|sonhandler.policyRespTimer     | Timer to wait for notification from policy     |
+-------------------------------+------------------------------------------------+
|sonhandler.                    | Maximum number of negative acknowledgements    |
|policyNegativeAckThreshold     | from policy for a given cell                   |
+-------------------------------+------------------------------------------------+
|sonhandler.                    | Time interval to trigger OOF with fixed pci    |
|policyFixedPciTimeInterval     | cells                                          |
+-------------------------------+------------------------------------------------+
|sonhandler.nfNamingCode        | Parameter to filter FM and PM notifications    |
|                               | coming from ves                                |
+-------------------------------+------------------------------------------------+
