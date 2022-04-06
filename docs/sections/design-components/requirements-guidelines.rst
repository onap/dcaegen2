.. This work is licensed under a Creative Commons Attribution 4.0 International License.
.. http://creativecommons.org/licenses/by/4.0

Onboarding Pre-requisite
========================

Before a component is onboarded into DCAE, the component developer must ensure it
is compliant with ONAP & DCAE goals and requirement in order to correctly be deployed and be managed.


.. _config_binding_service:

Config Binding Service SDK Integration
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

With Jakarta release, Consul and ConfigBindingService interface has been deprecated from DCAE
All Microservice configuration are resolved through files mounted via Configmap created part of 
dcae-services helm chart deployment. 

CBS SDK library are available within DCAE which can be used by DCAE Microservices for configuration
retrieval. For details on the API - refer  `CBS SDK Java Library 
<https://docs.onap.org/projects/onap-dcaegen2/en/latest/sections/sdk/api.html>`__

Its strongly recommended to use CBS SDK library for consistency across DCAE services to retrieve  both static and policy driven configuration. 

Topic Configuration
~~~~~~~~~~~~~~~~~~~

With Helm flow integration in MOD, topic generation feature is not supported.

Applications are required to identify the topic and feed information as application 
configuration.

For application onboarded through MOD, these should be included in the specification file under **parameters**

::
    "parameters": [{
            "name": "streams_publishes",
            "value": "{\"ves-3gpp-fault-supervision\":{\"dmaap_info\":{\"topic_url\":\"http:\/\/message-router:3904\/events\/unauthenticated.SEC_3GPP_FAULTSUPERVISION_OUTPUT\"},\"type\":\"message_router\"},\"ves-3gpp-heartbeat\":{\"dmaap_info\":{\"topic_url\":\"http:\/\/message-router:3904\/events\/unauthenticated.SEC_3GPP_HEARTBEAT_OUTPUT\"},\"type\":\"message_router\"},\"ves-3gpp-performance-assurance\":{\"dmaap_info\":{\"topic_url\":\"http:\/\/message-router:3904\/events\/unauthenticated.SEC_3GPP_PERFORMANCEASSURANCE_OUTPUT\"},\"type\":\"message_router\"},\"ves-3gpp-provisioning\":{\"dmaap_info\":{\"topic_url\":\"http:\/\/message-router:3904\/events\/unauthenticated.SEC_3GPP_PROVISIONING_OUTPUT\"},\"type\":\"message_router\"},\"ves-fault\":{\"dmaap_info\":{\"topic_url\":\"http:\/\/message-router:3904\/events\/unauthenticated.SEC_FAULT_OUTPUT\"},\"type\":\"message_router\"},\"ves-heartbeat\":{\"dmaap_info\":{\"topic_url\":\"http:\/\/message-router:3904\/events\/unauthenticated.SEC_HEARTBEAT_OUTPUT\"},\"type\":\"message_router\"},\"ves-measurement\":{\"dmaap_info\":{\"topic_url\":\"http:\/\/message-router:3904\/events\/unauthenticated.VES_MEASUREMENT_OUTPUT\"},\"type\":\"message_router\"},\"ves-notification\":{\"dmaap_info\":{\"topic_url\":\"http:\/\/message-router:3904\/events\/unauthenticated.VES_NOTIFICATION_OUTPUT\"},\"type\":\"message_router\"},\"ves-other\":{\"dmaap_info\":{\"topic_url\":\"http:\/\/message-router:3904\/events\/unauthenticated.SEC_OTHER_OUTPUT\"},\"type\":\"message_router\"},\"ves-pnfRegistration\":{\"dmaap_info\":{\"topic_url\":\"http:\/\/message-router:3904\/events\/unauthenticated.VES_PNFREG_OUTPUT\"},\"type\":\"message_router\"}}",
            "description": "standard http port collector will open for listening;",
            "sourced_at_deployment": false,
            "policy_editable": false,
            "designer_editable": false
        },


For components delivered as Helm directly, it should be specified under **applicationConfig** section in values.yaml

::
  streams_publishes:
    ves-fault:
      dmaap_info:
        topic_url:
          "http://message-router:3904/events/unauthenticated.SEC_FAULT_OUTPUT"
      type: message_router
    ves-measurement:
      dmaap_info:
        topic_url:
          "http://message-router:3904/events/unauthenticated.VES_MEASUREMENT_OUTPUT"
      type: message_router


You can find  examples of topic and feed configuration used in DCAE components from charts under OOM repository - 
https://github.com/onap/oom/tree/master/kubernetes/dcaegen2-services/components

Its recommended to follow similar topic construct for consistency across all DCAE Services. This will also enable using 
 `SDK DMAAP Java Library 
<https://docs.onap.org/projects/onap-dcaegen2/en/latest/sections/sdk/api.html>`__
for easier integration.


DCAE SDK
~~~~~~~~

DCAE has SDK/libraries which can be used for service components for easy integration.

- `Java Library <https://docs.onap.org/projects/onap-dcaegen2/en/latest/sections/sdk/architecture.html>`__
- `Python Modules <https://git.onap.org/dcaegen2/utils/tree/onap-dcae-cbs-docker-client>`__



.. _policy_reconfiguration:

Policy Reconfiguration
----------------------


Policy Framework based reconfiguration is supported via sidecar. The component owner are responsible for
loading the required model and creating policies required. 

Once the policies are created, the corresponding policy_id should be listed in the component_spec or helm charts override as below

Component spec must include the policy_info object and list of policy_id to be retrieved 
::
  "policy_info":{
    "policy": [
    {
      "node_label": "tca_policy_00",
      "policy_model_id": "onap.policies.monitoring.cdap.tca.hi.lo.app",
      "policy_id": "onap.vfirewall.tca"
	},
    {
      "node_label":"tca_policy_01", 
      "policy_model_id":"onap.policies.monitoring.cdap.tca.hi.lo.app",
      "policy_id":"onap.vdns.tca"
    }
    ]
  }

"node_label" is optional and can be ignored
"policy_model_id" refers to model uploaded into policy framework
"policy_id" refers to the instance of policy created for model specified.

When the helm-charts are generated by DCAEMOD/Runtime, the charts will have following property defined in the values.yaml

::
  dcaePolicySyncImage: onap/org.onap.dcaegen2.deployments.dcae-services-policy-sync:1.0.1
  policies:
     policyID: |
        '["onap.vfirewall.tca","onap.vdns.tca"]'

When using dcaegen2-services-common templates, the presence of these property will deploy policy-sidecar automatically which will 
periodically pull configuration from Policy framework and make it available shared mountpoint to microservice container. 

More information on Policy side car can be found on this wiki - https://wiki.onap.org/display/DW/Policy+function+as+Sidecar
 
.. note:: 
  When using DCAE CBS SDK, policy config retrieval is supported natively by the library
  


.. _docker_images:

Docker Images
-------------

Docker images must be pushed to the environment specific Nexus
repository. This requires tagging your build with the full name of you
image which includes the Nexus repository name.

For ONAP microservices, the components images are expected to pushed into ONAP nexus
part of `ONAP CI jobs <https://wiki.onap.org/display/DW/Using+Standard+Jenkins+Job+%28JJB%29+Templates>`__


Helm Chart
----------

Components being delivered under ONAP/OOM must adopt dcaegen2-common-services template.
Information about using the common templates to deploy a microservice can be
found in :doc:`Helm to deploy DCAE Microservices <./dcaeservice_helm_template>`.

.. _operation_requirement:

Operational Requirement
-----------------------

Logging
~~~~~~~

All ONAP MS logging should follow logging specification defined by `SECCOM <https://wiki.onap.org/display/DW/Jakarta+Best+Practice+Proposal+for+Standardized+Logging+Fields+-+v2>`__

The application log configuration must enable operation to choose if to be written into file or stdout or both during deployment.


S3P
~~~
ONAP S3P (all scaling/resiliency/security/maintainability) goals should meet at the minimum level defined for DCAE project for the targeted release

If the component is stateful, it should persist its state on external store (eg. pg, redis) to allow support for scaling and
resiliency. This should be important design criteria for the component.
