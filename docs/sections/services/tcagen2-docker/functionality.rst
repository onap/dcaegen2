.. This work is licensed under a
   Creative Commons Attribution 4.0 International License.
   http://creativecommons.org/licenses/by/4.0

Functionality
=============

TCA-gen2 is driven by the VES collector events published into Message Router.  This Message Router topic is the source for the CDAP application which will read each incoming message. If a message meets the VES (CEF, v28.4) as specified by the VES 5.4 standard, it will be parsed and if it contains a message which matches the policy configuration for a given metric (denoted primarily by the "eventName" and the "fieldPath"), the value of the metric will be compared to the "thresholdValue".  If that comparison indicates that a Control Loop Event Message should be generated, the application will output the alarm to the Message Router  topic in a format that matches the interface spec defined for Control-Loop by ONAP-Policy 

Assumptions:

TCA-gen2 output will be similar to R0 Tca/cdap implementation, where CL event will be triggered each time threshold rules are met.

In the context of the vCPE use case, the CLEAR event (aka ABATED event) is driven by a measured metric (i.e. packet loss equal to 0) rather than by the lapse of a threshold crossing event over some minimum number of measured intervals.  Thus, this requirement can be accommodated by use of the low threshold with a policy of "direction =  0".  TCA-gen2 implementation will keep only the minimal state needed to correlate an ABATED event with the corresponding ONSET event.  This correlation will be indicated by the requestID in the Control Loop Event Message.


TCA-gen2 can support multiple ONAP usecases. Single TCA instance can be deployed to support all 3 usecases.
- vFirewall
- vDNS
- vCPE

Following is default configuration set for TCA-gen2 during deployment.

.. code-block:: json

    {
        "domain": "measurementsForVfScaling",
        "metricsPerEventName": [{
            "eventName": "measurement_vFirewall-Att-Linkdownerr",
            "controlLoopSchemaType": "VM",
            "policyScope": "DCAE",
            "policyName": "DCAE.Config_tca-hi-lo",
            "policyVersion": "v0.0.1",
            "thresholds": [{
                "closedLoopControlName": "ControlLoop-vFirewall-d0a1dfc6-94f5-4fd4-a5b5-4630b438850a",
                "version": "1.0.2",
                "fieldPath": "$.event.measurementsForVfScalingFields.vNicPerformanceArray[*].receivedTotalPacketsDelta",
                "thresholdValue": 300,
                "direction": "LESS_OR_EQUAL",
                "severity": "MAJOR",
                "closedLoopEventStatus": "ONSET"
            }, {
                "closedLoopControlName": "ControlLoop-vFirewall-d0a1dfc6-94f5-4fd4-a5b5-4630b438850a",
                "version": "1.0.2",
                "fieldPath": "$.event.measurementsForVfScalingFields.vNicPerformanceArray[*].receivedTotalPacketsDelta",
                "thresholdValue": 700,
                "direction": "GREATER_OR_EQUAL",
                "severity": "CRITICAL",
                "closedLoopEventStatus": "ONSET"
            }]
        }, {
            "eventName": "vLoadBalancer",
            "controlLoopSchemaType": "VM",
            "policyScope": "DCAE",
            "policyName": "DCAE.Config_tca-hi-lo",
            "policyVersion": "v0.0.1",
            "thresholds": [{
                "closedLoopControlName": "ControlLoop-vDNS-6f37f56d-a87d-4b85-b6a9-cc953cf779b3",
                "version": "1.0.2",
                "fieldPath": "$.event.measurementsForVfScalingFields.vNicPerformanceArray[*].receivedTotalPacketsDelta",
                "thresholdValue": 300,
                "direction": "GREATER_OR_EQUAL",
                "severity": "CRITICAL",
                "closedLoopEventStatus": "ONSET"
            }]
        }, {
            "eventName": "Measurement_vGMUX",
            "controlLoopSchemaType": "VNF",
            "policyScope": "DCAE",
            "policyName": "DCAE.Config_tca-hi-lo",
            "policyVersion": "v0.0.1",
            "thresholds": [{
                "closedLoopControlName": "ControlLoop-vCPE-48f0c2c3-a172-4192-9ae3-052274181b6e",
                "version": "1.0.2",
                "fieldPath": "$.event.measurementsForVfScalingFields.additionalMeasurements[*].arrayOfFields[0].value",
                "thresholdValue": 0,
                "direction": "EQUAL",
                "severity": "MAJOR",
                "closedLoopEventStatus": "ABATED"
            }, {
                "closedLoopControlName": "ControlLoop-vCPE-48f0c2c3-a172-4192-9ae3-052274181b6e",
                "version": "1.0.2",
                "fieldPath": "$.event.measurementsForVfScalingFields.additionalMeasurements[*].arrayOfFields[0].value",
                "thresholdValue": 0,
                "direction": "GREATER",
                "severity": "CRITICAL",
                "closedLoopEventStatus": "ONSET"
            }]
        }]
    }

For more details about the exact flows - please refer to usecases wiki
