.. This work is licensed under a Creative Commons Attribution 4.0 International License.
.. http://creativecommons.org/licenses/by/4.0

HealthCheck
===========

DCAE Healthcheck .

OOM Deployment
--------------

    In OOM deployments DCAE healthcheck are reported by separate  service - dcae-healthcheck; this is deployment of org.onap.dcaegen2.deployments.healthcheck-container which is built from dcaegen2/deployment repo - healthcheck-container module. The container includes list of deployments done in DCAE  (both via helm charts and Cloudify) for which periodic health check is performed. For helm deployed component - servicename defined is charts are used and for cloudify, the deployments identified in bootstrap are prefixed with release name. The container itself is deployed via helm charts (oom/kubernetes/dcaegen2/charts/dcae-healthcheck). This polls the deployments specified periodically and reports the status. The service can be queried for status as below. 
    
     curl dcae-healthcheck
    {"type":"summary","count":8,"ready":8,"items":[{"name":"dev-dcae-cloudify-manager","ready":1,"unavailable":0},{"name":"dep-config-binding-service","ready":1,"unavailable":0},{"name":"dep-deployment-handler","ready":1,"unavailable":0},{"name":"dep-inventory","ready":1,"unavailable":0},{"name":"dep-service-change-handler","ready":1,"unavailable":0},{"name":"dep-policy-handler","ready":1,"unavailable":0},{"name":"dep-dcae-ves-collector","ready":1,"unavailable":0},{"name":"dep-dcae-tca-analytics","ready":1,"unavailable":0}]}    
        

Heat Deployment
---------------
