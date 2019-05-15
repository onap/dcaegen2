
Instalation Steps
-----------------

SON handler microservice can be deployed using cloudify blueprint using bootstrap container of an existing DCAE deployment

Deployment Prerequisites
~~~~~~~~~~~~~~~~~~~~~~~~

- SON-Handler service requires DMAAP and Policy components to be functional.

- SON-hadler service requires  the following dmaap topics to be present in the running DMAAP instance :

		1.PCI-NOTIF-TOPIC-NGHBR-LIST-CHANGE-INFO

		2.unauthenticated.SEC_FAULT_OUTPUT

		3.unauthenticated.SEC_MEASUREMENT_OUTPUT

		4.DCAE_CL_RSP

- Policy model required for SON-handler service should be created and pushed to policy component.Steps for creating and pushing the policy model:
		1.Login to PDP container and execute
			kubectl exec -ti --namespace onap policy-pdp-0 bash
		2.Create policy model
			curl -k -v --silent -X PUT --header 'Content-Type: application/json' --header 'Accept: text/plain' --header 'ClientAuth: cHl0aG9uOnRlc3Q=' --header 'Authorization: Basic dGVzdHBkcDphbHBoYTEyMw==' --header 'Environment: TEST' -d '{
  "policyName": "com.PCIMS_CONFIG_POLICY",
  "configBody": "{ \"PCI_NEIGHBOR_CHANGE_CLUSTER_TIMEOUT_IN_SECS\":60, \"PCI_MODCONFIG_POLICY_NAME\":\"ControlLoop-vPCI-fb41f388-a5f2-11e8-98d0-529269fb1459\", \"PCI_OPTMIZATION_ALGO_CATEGORY_IN_OOF\":\"OOF-PCI-OPTIMIZATION\", \"PCI_SDNR_TARGET_NAME\":\"SDNR\" }",
  "policyType": "Config",
   "attributes" : { "matching" : { "key1" : "value1" } },
  "policyConfigType": "Base",
  "onapName": "DCAE",
  "configName": "PCIMS_CONFIG_POLICY",
  "configBodyType": "JSON"
}' 'https://pdp:8081/pdp/api/createPolicy'

		3.Push policy model
			curl -k -v --silent -X PUT --header 'Content-Type: application/json' --header 'Accept: text/plain' --header 'ClientAuth: cHl0aG9uOnRlc3Q=' --header 'Authorization: Basic dGVzdHBkcDphbHBoYTEyMw==' --header 'Environment: TEST' -d '{
  "policyName": "com.PCIMS_CONFIG_POLICY",
  "policyType": "Base"
}' 'https://pdp:8081/pdp/api/pushPolicy'

		4.Verify config policy is present

			curl -k -v --silent -X POST --header 'Content-Type: application/json' --header 'Accept: application/json' --header 'ClientAuth: cHl0aG9uOnRlc3Q=' --header 'Authorization: Basic dGVzdHBkcDphbHBoYTEyMw==' --header 'Environment: TEST' -d '{ "configName": "PCIMS_CONFIG_POLICY",    "policyName": "com.Config_PCIMS_CONFIG_POLICY1*",    "requestID":"e65cc45a-9efb-11e8-98d0-529269ffa459"  }' 'https://pdp:8081/pdp/api/getConfig'	

Deployment steps
~~~~~~~~~~~~~~~~
- Login to the bootstrap container
        kubectl exec -ti --namespace onap <bootstrap pod name> bash
- Copy the blueprints and inputs file to the bootstrap container. The blueprint and a sample input file can be found under dpo/blueprints directory of son-hanler project. (https://gerrit.onap.org/r/dcaegen2/services/son-handler)
- Deploy the microservice into the cloudify using the following command
        cfy install -d sonhms -b sonhms -i <inputs file path> <blueprint file path>
- Deployment status of the microservice can be found from kubernetes pods status (MS will be deployed as a k8s pod in the kubernetes environment under the same namespace as the DCAE environment).
        kubectl get pods --namespace onap
- To uninstall the microservice
        cfy uninstall sonhms
- To delete the blueprint from the cloudify instance
        cfy blueprints delete sonhms


Application Configurations
--------------------------

Streams_subscribes                Dmaap topics that the MS will consume messages

Streams_publishes                 Dmaap topics that the MS will publish messages

postgres.host                     Host where the postgres database is running

postgres.port                     Host where the postgres database is running

postgres.username                 Postgres username

postgres.password                 Postgres password

sonhandler.pollingInterval        Polling Interval for consuming dmaap messages

sonhandler.pollingTimeout         Polling timeout for consuming dmaap messages

sonhandler.numSolutions           Number for solutions for OOF optimization

sonhandler.minCollision           Minimum collision criteria to trigger OOF

sonhandler.minConfusion           Minimum confusion criteria to trigger OOF

sonhandler.maximumClusters        Maximum number of clusters MS can process

sonhandler.badThreshold           Bad threshold for Handover success rate

sonhandler.poorThreshold          Poor threshold for Handover success rate

sonhandler.namespace              Namespace where MS is going to be deployed

sonhandler.sourceId               Source ID of the Microservice (Required for Sending request to OOF)

sonhandler.dmaap.server           Location of message routers

sonhandler.bufferTime             Buffer time for MS to wait for more notifications when the optimization criteria is not met

sonhandler.cg                     Consumer group for the MS to consume message from dmaap

sonhandler.cid                    Consumer ID for the MS to consume message from dmaap

sonhandler.configDbService        Location of the config DB (protocol, host & port)
 
sonhandler.oof.service            Location of OOF (protocol, host & port)

sonhandler.optimizers             Optimizer to trigger in OOF


