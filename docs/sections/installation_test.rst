ONAP DCAE Deployment Validation
===============================


Check Deployment Status
-----------------------

The healthcheck service is exposed as a Kubernetes ClusterIP Service named
`dcae-healthcheck`.   The service can be queried for status as shown below.

.. code-block::

   $ curl dcae-healthcheck
   {
     "type": "summary",
     "count": 14,
     "ready": 14,
     "items": [
        {
          "name": "dev-dcaegen2-dcae-cloudify-manager",
          "ready": 1,
          "unavailable": 0
        },
        {
          "name": "dev-dcaegen2-dcae-config-binding-service",
          "ready": 1,
          "unavailable": 0
        },
        {
          "name": "dev-dcaegen2-dcae-inventory-api",
          "ready": 1,
          "unavailable": 0
        },
        {
          "name": "dev-dcaegen2-dcae-servicechange-handler",
          "ready": 1,
          "unavailable": 0
        },
        {
          "name": "dev-dcaegen2-dcae-deployment-handler",
          "ready": 1,
          "unavailable": 0
        },
        {
          "name": "dev-dcaegen2-dcae-policy-handler",
          "ready": 1,
          "unavailable": 0
        },
        {
          "name": "dep-dcae-ves-collector",
          "ready": 1,
          "unavailable": 0
        },
        {
          "name": "dep-dcae-tca-analytics",
          "ready": 1,
          "unavailable": 0
        },
        {
          "name": "dep-dcae-prh",
          "ready": 1,
          "unavailable": 0
        },
        {
          "name": "dep-dcae-hv-ves-collector",
          "ready": 1,
          "unavailable": 0
        },
        {
          "name": "dep-dcae-dashboard",
          "ready": 1,
          "unavailable": 0
        },
        {
          "name": "dep-dcae-snmptrap-collector",
          "ready": 1,
          "unavailable": 0
        },
        {
          "name": "dep-holmes-engine-mgmt",
          "ready": 1,
          "unavailable": 0
        },
        {
          "name": "dep-holmes-rule-mgmt",
          "ready": 1,
          "unavailable": 0
        }
      ]
    }


Data Flow Verification
----------------------

After the platform is assessed as healthy, the next step is to check the functionality of the system.  This can be monitored at a number of "observation" points.

1. Incoming VNF Data into VES Collector can be verified through logs using kubectl 
  
    kubectl logs -f -n onap <vescollectorpod> dcae-ves-collector

2. Check VES Output

    VES publishes received VNF data, after authentication and syntax check, onto DMaaP Message Router.  To check this is happening we can subscribe to the publishing topic.

    1. Run the subscription command to subscribe to the topic: **curl  -H "Content-Type:text/plain" -X GET http://{{K8S_NODEIP}}:30227/events/unauthenticated.VES_MEASUREMENT_OUTPUT/group1/C1?timeout=50000**.  The actual format and use of Message Router API can be found in DMaaP project documentation.
        * When there are messages being published, this command returns with the JSON array of messages;
        * If no message being published, up to the timeout value (i.e. 50000 seconds as in the example above), the call is returned with empty JAON array;
        * It may be useful to run this command in a loop:  **while :; do curl  -H "Content-Type:text/plain" -X GET http://{{K8S_NODEIP}}:3904/events/unauthenticated.VES_MEASUREMENT_OUTPUT/group1/C1?timeout=50000; echo; done**;

3. Check TCA Output
    TCA also publishes its events to Message Router under the topic of "unauthenticated.DCAE_CL_OUTPUT".  The same Message Router subscription command can be used for checking the messages being published by TCA;
    * Run the subscription command to subscribe to the topic: **curl  -H "Content-Type:text/plain" -X GET http://{{K8S_NODEIP}}:3904/events/unauthenticated.DCAE_CL_OUTPUT/group1/C1?timeout=50000**.
    * Or run the command in a loop:  **while :; do curl  -H "Content-Type:text/plain" -X GET http://{{K8S_NODEIP}}:3904/events/unauthenticated.DCAE_CL_OUTPUT/group1/C1?timeout=50000; echo; done**;

