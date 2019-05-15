Troubleshooting steps
---------------------

1. Microservice stops and restarts during startup

    Possible reasons & Solutions: 
     1. Microservice is not registered with the consul 
            - Check the consul if the microservice is registered with it and the MS is able to fetch the app config from the CBS. Check if CBS and consul are deployed properly and try to redeploy the MS
     2. DMAAP topics are not created 
            - Check the message router if the neccessary dmaap topics are present in the list of topics. Create the topics if not present.
              List of topics can be queried from message router using the url "http://<host>:<port>/topics"


Logging
-------

1. Logs can be found either from kubernetes UI or from kubectl. Since, the MS is deployed as a pod in the kubernetes, you can check the logs by using the command
        kubectl logs <pod-name> --namespace onap

