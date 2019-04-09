**** SON Handler ****

** Instalation Steps **

SON handler microservice can be deployed using cloudify blueprint using bootstrap container of an existing DCAE deployment

  * Login to the bootstrap container
        kubectl exec -ti --namespace onap <bootstrap pod name> bash
  * Copy the blueprints and inputs file to the bootstrap container. The blueprint and a sample input file can be found under dpo/blueprints directory of son-hanler project. (https://gerrit.onap.org/r/dcaegen2/services/son-handler)
  * Deploy the microservice into the cloudify using the following command
        cfy install -d sonhms -b sonhms -i <inputs file path> <blueprint file path>
  * Deployment status of the microservice can be found from kubernetes pods status (MS will be deployed as a k8s pod in the kubernetes environment under the same namespace as the DCAE environment).
        kubectl get pods --namespace onap
  * To uninstall the microservice
        cfy uninstall sonhms
  * To delete the blueprint from the cloudify instance
        cfy blueprints delete sonhms


** Application Configurations **

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

** Troubleshooting steps **

1. Microservice stops and restarts during startup

    Possible reasons & Solutions: 
     1. Microservice is not registered with the consul 
            - Check the consul if the microservice is registered with it and the MS is able to fetch the app config from the CBS. Check if CBS and consul are deployed properly and try to redeploy the MS
     2. DMAAP topics are not created 
            - Check the message router if the neccessary dmaap topics are present in the list of topics. Create the topics if not present.
              List of topics can be queried from message router using the url "http://<host>:<port>/topics"


** Logging **

1. Logs can be found either from kubernetes UI or from kubectl. Since, the MS is deployed as a pod in the kubernetes, you can check the logs by using the command
        kubectl logs <pod-name> --namespace onap


