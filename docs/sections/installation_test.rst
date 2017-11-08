Testing and Debugging ONAP DCAE Deployment
===========================================


Check Component Status
======================

Testing of a DCAE system starts with checking the health of the deployed components.  This can be done by accessing the Consul becsue all DCAE components register their staus with Consul. Such API is accessible at http://{{ANY_CONSUL_VM_IP}}:8500.

In addition, more details status information can be obtained in additional ways.

1. Check VES Status
    VES status and running logs can be found on the {{RAND}}doks00 VM. The detailed API and access methods can be found in the logging and human interface sections.

2. Check TCA Status
    TCA has its own GUI that provides detailed operation information. Point browser to http://{{CDAP02_VM_IP}}:11011/oldcdap/ns/cdap_tca_hi_lo/apps/, select the application with Description "DCAE Analytics Threshold Crossing Alert Application"; then select "TCAVESCollectorFlow". This leads to a flow display where all stages of processing are illustrated and the number inside of each stage icon shows the number of events/messages processed.


3. Check Message Router Status
    Run **curl {{MESSAGE_ROUTER_IP}}:3904/topics** to check the status of the message router.  It should return with a list of message topics currently active on the Message Router;
        * Among the topics, find one called "unauthenticated.SEC_MEASUREMENT_OUTPUT", which is the topics VES collector publishes its data to, and the other called "unauthenticated.DCAE_CL_OUTPUT", which is used for TCA to publish analytics events.


Check data Flow
===============
After the platform is assessed as heathy, the next step is to check the functionality of the system.  This can be monitored at a number of "observation" points.

1. Check incoming VNF Data

    For R1 use cases, VNF data enters the DCAE system via the VES collector.  This can be verified in the following steps:

    1. ssh into the {{RAND}}doks00 VM;
    2. Run: **sudo docker ps** to see that the VES collector container is running;
        * Optionally run: **docker logs -f {{ID_OF_THE_VES_CONTAINER}}** to check the VES container log information;
    3. Run: **netstat -ln** to see that port 8080 is open;
    4. Run: **sudo tcpdump dst port 8080** to see incoming packets (from VNFs) into the VM's 8080 port, which is mapped to the VES collectors's 8080 port.


2. Check VES Output

    VES publishes received VNF data, after authentication and syntax check, onto DMaaP Message Router.  To check this is happening we can subscribe to the publishing topic.

    1. Run the subscription command to subscribe to the topic: **curl  -H "Content-Type:text/plain" -X GET http://{{MESSAGE_ROUTER_IP}}:3904/events/unauthenticated.SEC_MEASUREMENT_OUTPUT/group19/C1?timeout=50000**.  The actual format and use of Message Router API can be found in DMaaP project documentation.
        * When there are messages being published, this command returns with the JSON array of messages;
        * If no message being published, up to the timeout value (i.e. 50000 seconds as in the example above), the call is returned with empty JAON array;
        * It may be useful to run this command in a loop:  **while :; do curl  -H "Content-Type:text/plain" -X GET http://{{MESSAGE_ROUTER_IP}}:3904/events/unauthenticated.SEC_MEASUREMENT_OUTPUT/group19/C1?timeout=50000; echo; done**;

3. Check TCA Output
    TCA also publishes its events to Message Router under the topic of "unauthenticated.DCAE_CL_OUTPUT".  The same Message Router subscription command can be used for checking the messages being published by TCA;
    * Run the subscription command to subscribe to the topic: **curl  -H "Content-Type:text/plain" -X GET http://{{MESSAGE_ROUTER_IP}}:3904/events/unauthenticated.DCAE_CL_OUTPUT/group19/C1?timeout=50000**.
    * Or run the command in a loop:  **while :; do curl  -H "Content-Type:text/plain" -X GET http://{{MESSAGE_ROUTER_IP}}:3904/events/unauthenticated.DCAE_CL_OUTPUT/group19/C1?timeout=50000; echo; done**;

