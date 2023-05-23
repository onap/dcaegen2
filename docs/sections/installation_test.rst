.. This work is licensed under a
   Creative Commons Attribution 4.0 International License.
   http://creativecommons.org/licenses/by/4.0

DCAE Deployment Validation
==========================


Check Deployment Status
-----------------------

The healthcheck service is exposed as a Kubernetes ClusterIP Service named
`dcae-ms-healthcheck`.   The service can be queried for status as shown below.

.. code-block:: bash

   $ curl dcae-ms-healthcheck
   {
      "type": "summary",
      "count": 5,
      "ready": 5,
      "items": [{
            "name": "onap-dcae-hv-ves-collector",
            "ready": 1,
            "unavailable": 0
       },
       {
            "name": "onap-dcae-prh",
            "ready": 1,
            "unavailable": 0
       },
       {
            "name": "onap-dcae-tcagen2",
            "ready": 1,
            "unavailable": 0
       },
       {
            "name": "onap-dcae-ves-collector",
            "ready": 1,
            "unavailable": 0
       },
       {
            "name": "onap-dcae-ves-openapi-manager",
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

.. note::
     To get the "vescollectorpod" run this command: kubectl -n onap get pods | grep  dcae-ves-collector

2. Check VES Output

    VES publishes received VNF data, after authentication and syntax check, onto DMaaP Message Router.  To check this is happening we can subscribe to the publishing topic.

    1. Run the subscription command to subscribe to the topic: **curl  -H "Content-Type:text/plain" -k -X GET https://{{K8S_NODEIP}}:30226/events/unauthenticated.VES_MEASUREMENT_OUTPUT/group1/C1?timeout=50000**.  The actual format and use of Message Router API can be found in DMaaP project documentation.
        * When there are messages being published, this command returns with the JSON array of messages;
        * If no message being published, up to the timeout value (i.e. 50000 seconds as in the example above), the call is returned with empty JAON array;
        * It may be useful to run this command in a loop:  **while :; do curl  -H "Content-Type:text/plain" -k -X GET https://{{K8S_NODEIP}}:30226/events/unauthenticated.VES_MEASUREMENT_OUTPUT/group1/C1?timeout=50000; echo; done**;

3. Check TCA Output
    TCA also publishes its events to Message Router under the topic of "unauthenticated.DCAE_CL_OUTPUT".  The same Message Router subscription command can be used for checking the messages being published by TCA;
    * Run the subscription command to subscribe to the topic: **curl  -H "Content-Type:text/plain" -k -X GET https://{{K8S_NODEIP}}:30226/events/unauthenticated.DCAE_CL_OUTPUT/group1/C1?timeout=50000**.
    * Or run the command in a loop:  **while :; do curl  -H "Content-Type:text/plain" -k -X GET https://{{K8S_NODEIP}}:30226/events/unauthenticated.DCAE_CL_OUTPUT/group1/C1?timeout=50000; echo; done**;
