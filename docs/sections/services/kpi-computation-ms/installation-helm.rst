.. This work is licensed under a Creative Commons Attribution 4.0 International License.
.. http://creativecommons.org/licenses/by/4.0
.. _kpi-installation-helm:


Helm Installation
=================

Kpi Computation microservice can be deployed using helm charts in oom repository.


Deployment Pre-requisites
~~~~~~~~~~~~~~~~~~~~~~~~~
- DMaaP pods should be up and running.

- PM mapper service should be running.

- Policy pods should be running.

- Required policies should be created and pushed to the policy component. Steps for creating and pushing policy models:

     1. Log in to policy-drools-pdp-0 container

             .. code-block:: bash

               kubectl exec -ti --namespace <namespace> policy-pdp-0 bash


     2. Create policy type:

             .. code-block:: bash

              curl -k --silent --user 'healthcheck:zb!XztG34' -X POST "https://policy-api:6969/policy/api/v1/policytypes" -H "Accept: application/json" -H "Content-Type: application/json" --data '{"policy_types":{"onap.policies.monitoring.docker.kpims.app":{"derived_from":"onap.policies.Monitoring:1.0.0","description":"KPI ms policy type","properties":{"domain":{"required":true,"type":"string"},"methodForKpi":{"type":"list","required":true,"entry_schema":{"type":"policy.data.methodForKpi_properties"}}},"version":"1.0.0"}},"data_types":{"policy.data.methodForKpi_properties":{"derived_from":"tosca.nodes.Root","properties":{"eventName":{"type":"string","required":true},"controlLoopSchemaType":{"type":"string","required":true},"policyScope":{"type":"string","required":true},"policyName":{"type":"string","required":true},"policyVersion":{"type":"string","required":true},"kpis":{"type":"list","required":true,"entry_schema":{"type":"policy.data.kpis_properties"}}}},"policy.data.kpis_properties":{"derived_from":"tosca.nodes.Root","properties":{"measType":{"type":"string","required":true},"operation":{"type":"string","required":true},"operands":{"type":"string","required":true}}}},"tosca_definitions_version":"tosca_simple_yaml_1_1_0"}'

     3. Create monitoring policy:

             .. code-block:: bash

              curl -k --user 'healthcheck:zb!XztG34' -X POST "https://policy-api:6969/policy/api/v1/policytypes/onap.policies.monitoring.docker.kpims.app/versions/1.0.0/policies" -H "Accept: application/json" -H "Content-Type: application/json" --data '{"name":"ToscaServiceTemplateSimple","topology_template":{"policies":[{"com.Config_KPIMS_CONFIG_POLICY":{"type":"onap.policies.monitoring.docker.kpims.app","type_version":"1.0.0","version":"1.0.0","metadata":{"policy-id":"com.Config_KPIMS_CONFIG_POLICY","policy-version":"1"},"name":"com.Config_KPIMS_CONFIG_POLICY","properties":{"domain":"measurementsForKpi","methodForKpi":[{"eventName":"perf3gpp_CORE-AMF_pmMeasResult","controlLoopSchemaType":"SLICE","policyScope":"resource=networkSlice;type=configuration","policyName":"configuration.dcae.microservice.kpi-computation","policyVersion":"v0.0.1","kpis":[{"measType":"AMFRegNbr","operation":"SUM","operands":"RM.RegisteredSubNbrMean"}]},{"eventName":"perf3gpp_CORE-UPF_pmMeasResult","controlLoopSchemaType":"SLICE","policyScope":"resource=networkSlice;type=configuration","policyName":"configuration.dcae.microservice.kpi-computation","policyVersion":"v0.0.1","kpis":[{"measType":"UpstreamThr","operation":"SUM","operands":"GTP.InDataOctN3UPF"},{"measType":"DownstreamThr","operation":"SUM","operands":"GTP.OutDataOctN3UPF"}]}]}}}]},"tosca_definitions_version":"tosca_simple_yaml_1_1_0","version":"1.0.0"}'


     4. Push monitoring policy:

             .. code-block:: bash

               curl --silent -k --user 'healthcheck:zb!XztG34' -X POST "https://policy-pap:6969/policy/pap/v1/pdps/policies" -H "Accept: application/json" -H "Content-Type: application/json" --data '{"policies":[{"policy-id":"com.Config_KPIMS_CONFIG_POLICY","policy-version":1}]}'

Deployment steps
~~~~~~~~~~~~~~~~

- Default app config values can be updated in oom/kubernetes/dcaegen2-services/components/dcae-kpi-ms/values.yaml.

- Update monitoring policy ID in below configuration which is used to enable Policy-Sync Side car container to be deployed and retrieves active policy configuration.

  .. code-block :: yaml

    dcaePolicySyncImage: onap/org.onap.dcaegen2.deployments.dcae-services-policy-sync:1.0.1
    policies:
    policyID:  |
        '["com.Config_KPIMS_CONFIG_POLICY"]'

- Enable KPI MS component in oom/kubernetes/dcaegen2-services/values.yaml

  .. code-block:: yaml

    dcae-kpi-ms:
      enabled: true

- Make the chart and deploy using the following command:

  .. code-block:: bash

    cd oom/kubernetes/
    make dcaegen2-services
    helm install dev-dcaegen2-services dcaegen2-services --namespace <namespace> --set global.masterPassword=<password>

- To deploy only KPI MS:

  .. code-block:: bash

    helm install dev-dcae-kpi-ms dcaegen2-services/components/dcae-kpi-ms --namespace <namespace> --set global.masterPassword=<password>

- To Uninstall

  .. code-block:: bash

    helm uninstall dev-dcae-kpi-ms


Application Configurations
--------------------------
+-------------------------------+------------------------------------------------+
|Configuration                  | Description                                    |
+===============================+================================================+
|streams_subscribes             | Dmaap topics that the MS will consume messages |
+-------------------------------+------------------------------------------------+
|streams_publishes              | Dmaap topics that the MS will publish messages |
+-------------------------------+------------------------------------------------+
|cbsPollingInterval             | Polling Interval for consuming config data from|
|                               | CBS                                            |
+-------------------------------+------------------------------------------------+
|pollingInterval                | Polling Interval for consuming dmaap messages  |
+-------------------------------+------------------------------------------------+
|pollingTimeout                 | Polling timeout for consuming dmaap messages   |
+-------------------------------+------------------------------------------------+
|dmaap.server                   | Location of message routers                    |
+-------------------------------+------------------------------------------------+
|cg                             | DMAAP Consumer group for subscription          |
+-------------------------------+------------------------------------------------+
|cid                            | DMAAP Consumer id for subscription             |
+-------------------------------+------------------------------------------------+
|trust_store_path               | Location of trust.jks file                     |
+-------------------------------+------------------------------------------------+
|trust_store_pass_path          | Location of trust.pass file                    |
+-------------------------------+------------------------------------------------+
