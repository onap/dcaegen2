.. This work is licensed under a Creative Commons Attribution 4.0 International License.
.. http://creativecommons.org/licenses/by/4.0
.. _tcagen2-configuration:


Configuration
=============


Following is default configuration set for TCA during deployment.

.. code-block:: yaml

        spring.data.mongodb.uri:
          get_input: spring.data.mongodb.uri
        streams_subscribes.tca_handle_in.consumer_group:
          get_input: tca_consumer_group
        streams_subscribes.tca_handle_in.consumer_ids[0]: c0
        streams_subscribes.tca_handle_in.consumer_ids[1]: c1
        streams_subscribes.tca_handle_in.message_limit: 50000
        streams_subscribes.tca_handle_in.polling.auto_adjusting.max: 60000
        streams_subscribes.tca_handle_in.polling.auto_adjusting.min: 30000
        streams_subscribes.tca_handle_in.polling.auto_adjusting.step_down: 30000
        streams_subscribes.tca_handle_in.polling.auto_adjusting.step_up: 10000
        streams_subscribes.tca_handle_in.polling.fixed_rate: 0
        streams_subscribes.tca_handle_in.timeout: -1
        tca.aai.enable_enrichment: true
        tca.aai.generic_vnf_path: aai/v11/network/generic-vnfs/generic-vnf
        tca.aai.node_query_path: aai/v11/search/nodes-query
        tca.aai.password:
          get_input: tca.aai.password
        tca.aai.url:
          get_input: tca.aai.url
        tca.aai.username:
          get_input: tca.aai.username
        tca.policy: '{"domain":"measurementsForVfScaling","metricsPerEventName":[{"eventName":"vFirewallBroadcastPackets","controlLoopSchemaType":"VM","policyScope":"DCAE","policyName":"DCAE.Config_tca-hi-lo","policyVersion":"v0.0.1","thresholds":[{"closedLoopControlName":"ControlLoop-vFirewall-d0a1dfc6-94f5-4fd4-a5b5-4630b438850a","version":"1.0.2","fieldPath":"$.event.measurementsForVfScalingFields.vNicPerformanceArray[*].receivedTotalPacketsDelta","thresholdValue":300,"direction":"LESS_OR_EQUAL","severity":"MAJOR","closedLoopEventStatus":"ONSET"},{"closedLoopControlName":"ControlLoop-vFirewall-d0a1dfc6-94f5-4fd4-a5b5-4630b438850a","version":"1.0.2","fieldPath":"$.event.measurementsForVfScalingFields.vNicPerformanceArray[*].receivedTotalPacketsDelta","thresholdValue":700,"direction":"GREATER_OR_EQUAL","severity":"CRITICAL","closedLoopEventStatus":"ONSET"}]},{"eventName":"vLoadBalancer","controlLoopSchemaType":"VM","policyScope":"DCAE","policyName":"DCAE.Config_tca-hi-lo","policyVersion":"v0.0.1","thresholds":[{"closedLoopControlName":"ControlLoop-vDNS-6f37f56d-a87d-4b85-b6a9-cc953cf779b3","version":"1.0.2","fieldPath":"$.event.measurementsForVfScalingFields.vNicPerformanceArray[*].receivedTotalPacketsDelta","thresholdValue":300,"direction":"GREATER_OR_EQUAL","severity":"CRITICAL","closedLoopEventStatus":"ONSET"}]},{"eventName":"Measurement_vGMUX","controlLoopSchemaType":"VNF","policyScope":"DCAE","policyName":"DCAE.Config_tca-hi-lo","policyVersion":"v0.0.1","thresholds":[{"closedLoopControlName":"ControlLoop-vCPE-48f0c2c3-a172-4192-9ae3-052274181b6e","version":"1.0.2","fieldPath":"$.event.measurementsForVfScalingFields.additionalMeasurements[*].arrayOfFields[0].value","thresholdValue":0,"direction":"EQUAL","severity":"MAJOR","closedLoopEventStatus":"ABATED"},{"closedLoopControlName":"ControlLoop-vCPE-48f0c2c3-a172-4192-9ae3-052274181b6e","version":"1.0.2","fieldPath":"$.event.measurementsForVfScalingFields.additionalMeasurements[*].arrayOfFields[0].value","thresholdValue":0,"direction":"GREATER","severity":"CRITICAL","closedLoopEventStatus":"ONSET"}]}]}'
        tca.processing_batch_size: 10000
        tca.enable_abatement: true
        tca.enable_ecomp_logging: true


Complete configuration and input defaults can be found on blueprint here - https://git.onap.org/dcaegen2/platform/blueprints/plain/blueprints/k8s-tcagen2.yaml 
