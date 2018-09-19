.. This work is licensed under a Creative Commons Attribution 4.0 International License.
.. http://creativecommons.org/licenses/by/4.0

Helm Chart Based DCAE Deployment
================================

This document describes the details of the Helm Chart based deployment process for R3 ONAP and how DCAE is deployed through this process.


ONAP Deployment Overview
------------------------

ONAP R3 is extention to R2 Kubernetes deployment.  Kuberenetes is a container orchestration technology that organizes containers into composites of various patterns for easy deployment, management, and scaling.  R2 ONAP utilizes Kubernetes as the foundation for fulfilling its platform maturity promises.

Further, R2 ONAP manages Kubernetes specifications using Helm Charts, under which all Kuberentes yaml-formatted resource specifications and additional files are organized into a hierarchy of charts, sub-charts, and resources.  These yaml files are further augmented with Helm's templating, which makes dependencies and cross-references of parameters and parameter derivatives among resources manageable for a large and complex Kuberentes system such as ONAP.

At deployment time, with a single **helm install** command, Helm resolves all the templates and compiles the chart hierarchy into Kubernetes resource definitions, and invokes Kubernetes deployment operation for all the resources.

All ONAP Helm Charts are organized under the **kubernetes** directory of the **OOM** project, where roughly each ONAP component occupied a subdirectory.  DCAE charts are placed under the **dcaegen2** directory.  DCAE Kubernetes deployment is based on the same set of Docker containers that the Heat based deployment uses, with the exception of bootstrap container and health check container are only used in Kubernetes deployment.


DCAE Chart Organization
-----------------------

Following Helm conventions, each Helm chart directory usually consists of the following files and subdirectories:

* Chart.yaml: meta data;
* requirements.yaml: dependency charts;
* values.yaml: values for Helm templating engine to expand templates;
* resources: subdirectory for additional resource definitions such as configuration, scripts, etc;
* templates: subdirectory for Kubernetes resource definition templates;
* charts: subdirectory for sub-charts.

The dcaegen2 chart has the following sub-charts:

* dcae-bootstrap: a Kubernetes job that deploys additional DCAE components;
* dcae-cloudify-manager: a Kubernetes deployment of a Cloudify Manager;
* dcae-healthcheck: a Kubernetes deployment that provides a DCAE health check API;
* dcae-redis: a Kubernetes deployment of a Redis cluster.


DCAE Deployment
---------------

At deployment time, when the **helm install** command is executed, all DCAE resources defined within charts under the OOM Chart hierarchy are deployed.  They are the 1st order components, namely the Cloudify Manager deployment, the Health Check deployment, the Redis cluster deployment, and the Bootstrap job.  In addition, a Postgres database deployment is also launched, which is specified as a dependency of the DCAE Bootstrap job.  These resources will show up as the following, where the name before / indicates resource type and the term "dev" is a tag that **helm install** command uses as "release name":
  * deploy/dev-dcae-cloudify-manager;
  * deploy/dev-dcae-healthcheck;
  * statefulsets/dev-dcae-redis;
  * statefulsets/dev-dcae-db;
  * job/dev-dcae-bootstrap.

In addition, DCAE operations depends on a Consul server cluster.  For ONAP OOM deployment, since Consul cluster is provided as a shared resource, its charts are defined under the consul direcory, not part of DCAE charts. 

The dcae-bootstrap job has a number of prerequisites because the subsequently deployed DCAE components depends on a number of resources having entered their normal operation state.  DCAE bootstrap job will not start before these resources are ready.  They are:
  * dcae-cloudify-manager;
  * consul-server;
  * msb-discovery;
  * kube2msb.

Once started, the DCAE bootstrap job will call Cloudify Manager to deploy a series of Blueprints which specify the additional DCAE R3 components.  These Blueprints are almost identical to the Docker container Blueprints used by DACE R1 and Heat based R2 deployment, except that they are using the k8splugin instead of dockerplugin.  The k8splugin is a major contribution of DCAE R2.  It is a Cloudify Manager plugin that is capable of expanding a Docker container node definition into a Kubernetes deployment definition, with enhancements such as replica scaling, ONAP logging sidecar, MSB registration, etc.

The additional DCAE components launched into ONAP deployment are:
  * deploy/dep-config-binding-service;
  * deploy/dep-dcae-tca-analytics;
  * deploy/dep-dcae-ves-collector;
  * deploy/dep-deployment-handler;
  * deploy/dep-holmes-engine-mgmt;
  * deploy/dep-holmes-rule-mgmt;
  * deploy/dep-inventory;
  * deploy/dep-policy-handler;
  * deploy/dep-pstg-write;
  * deploy/dep-service-change-handler;
  * deploy/dep-dcae-snmptrap-collector;
  * deploy/dep-dcae-prh;
  * deploy/dep-dcae-hv-ves-collector.


DCAE Configuration
------------------

Deployment time configuration of DCAE components are defined in several places.

  * Helm Chart templates:
     * Helm/Kubernetes template files can contain static values for configuration parameters;
  * Helm Chart resources:
     * Helm/Kubernetes resources files can contain static values for configuration parameters;
  * Helm values.yaml files:
     * The values.yaml files supply the values that Helm templating engine uses to expand any templates defined in Helm templates;
     * In a Helm chart hierarchy, values defined in values.yaml files in higher level supersedes values defined in values.yaml files in lower level;
     * Helm command line supplied values supersedes values defined in any values.yaml files.

In addition, for DCAE components deployed through Cloudify Manager Blueprints, their configuration parameters are defined in the following places:
     * The Blueprint files can contain static values for configuration parameters;
        * The Blueprint files are defined under the blueprints directory of the dcaegen2/platform/blueprints repo, named with "k8s" prefix.
     * The Blueprint files can specify input parameters and the values of these parameters will be used for configuring parameters in Blueprints.  The values for these input parameters can be supplied in several ways as listed below in the order of precedence (low to high):
        * The Blueprint files can define default values for the input parameters;
        * The Blueprint input files can contain static values for input parameters of Blueprints.  These input files are provided as config resources under the dcae-bootstrap chart;
        * The Blueprint input files may contain Helm templates, which are resolved into actual deployment time values following the rules for Helm values.


Now we walk through an example, how to configure the Docker image for the Policy Handler which is deployed by Cloudify Manager.  

In the k8s-policy_handler.yaml Blueprint, the Docker image to use is defined as an input parameter with a default value:
  **policy_handler_image**:
    description: Docker image for policy_handler
    default: 'nexus3.onap.org:10001/onap/org.onap.dcaegen2.platform.policy-handler:2.4.3'

Then in the input file, oom/kubernetes/dcaegen2/charts/dcae-bootstrap/resources/inputs/k8s-policy_handler-inputs.yaml, it is defined again as:
  **policy_handler_image**: {{ include "common.repository" . }}/{{ .Values.componentImages.policy_handler }}

Thus, when common.repository and componentImages.policy_handler are defined in the values.yaml files, their values will be plugged in here and the composition policy_handler_image will be passed to Policy Handler Blueprint as the Docker image tag to use instead of the default value in the Blueprint.

Indeed the componentImages.ves value is provided in the oom/kubernetes/dcaegen2/charts/dcae-bootstrap/values.yaml file:
  componentImages:
    policy_handler: onap/org.onap.dcaegen2.platform.policy-handler:2.4.5

The final result is that when DCAE bootstrap calls Cloudify Manager to deploy Policy Handler, the 2.4.5 image will be deployed.

DCAE Service Endpoints
----------------------

Below is a table of default hostnames and ports for DCAE component service endpoints in Kuubernetes deployment:
    ==================   ============================      ================================
    Component            Cluster Internal (host:port)      Cluster external (svc_name:port)
    ==================   ============================      ================================
    VES                  dcae-ves-collector:8080           xdcae-ves-collector.onap:30235
    TCA                  dcae-tca-analytics:11011          xdcae-tca-analytics.onap:32010
    Policy Handler       policy-handler:25577              NA
    Deployment Handler   deployment-handler:8443           NA
    Inventory            inventory:8080                    NA
    Config binding       config-binding-service:10000      NA
    DCAE Healthcheck     dcae-healthcheck:80               NA
    Cloudify Manager     dcae-cloudify-manager:80          NA
    ==================   ============================      ================================

In addition, a number of ONAP service endpoints that are used by DCAE components are listed as follows for reference by DCAE developers and testers:
    ==================   ============================      ================================
    Component            Cluster Internal (host:port)      Cluster external (svc_name:port)
    ==================   ============================      ================================
    Consul Server        consul-server:8500                consul-server:30270
    Robot                robot:88                          robot:30209 TCP
    Message router       message-router:3904               message-router:30227
    Message router       message-router:3905               message-router:30226
    MSB Discovery        msb-discovery:10081               msb-discovery:30281
    Logging              log-kibana:5601                   log-kibana:30253
    AAI                  aai:8080                          aai:30232
    AAI                  aai:8443                          aai:30233
    ==================   ============================      ================================

