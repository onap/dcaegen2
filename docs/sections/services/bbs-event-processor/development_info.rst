Compiling BBS-EP
================

BBS-ep is a sub-project of dcaegen2/services (inside components directory).
To build just the BBS-ep component, run the following maven command from within **components/bbs-event-processor** directory
`mvn clean install`   


API Endpoints
=============

Running with dev-mode of BBS-EP
    - Heartbeat: **GET http://<container_address>:8100/heartbeat**
    - Start Polling for events: **POST http://<container_address>:8100/start-tasks**
    - Stop Polling for events: **POST http://<container_address>:8100/cancel-tasks**
    - Execute just one polling for PNF re-registration internal events: **POST http://<container_address>:8100/poll-reregistration-events**
    - Execute just one polling for CPE authentication events: **POST http://<container_address>:8100/poll-cpe-authentication-events**
    - Change application logging level: **POST http://<container_address>:8100/logging/{level}**

More detailed API specifications can be found in :doc:`../../apis/swagger-bbs-event-processor`.
 
Maven GroupId:
==============

org.onap.dcaegen2.services.components

Maven Parent ArtifactId:
========================

org.onap.oparen:oparent:1.2.3