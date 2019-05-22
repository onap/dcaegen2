.. This work is licensed under a Creative Commons Attribution 4.0 International License.
.. http://creativecommons.org/licenses/by/4.0

DCAE Deployment (using Helm and Cloudify)
=========================================

This document describes the details of the Helm chart based deployment process for R4 ONAP and how DCAE is deployed through this process.


DCAE Deployment Overview
------------------------

ONAP R4 extends the Kubernetes deployment method introduced in R2 and continued in R3.
Kubernetes is a container orchestration technology that organizes containers into composites of various patterns for easy deployment, management, and scaling.
ONAP uses Kubernetes as the foundation for fulfilling its platform maturity promises.

ONAP manages Kubernetes specifications using Helm charts, under which all Kubernetes yaml-formatted resource specifications and additional files
are organized into a hierarchy of charts, sub-charts, and resources.  These yaml files are further augmented with Helm's templating, which makes dependencies
and cross-references of parameters and parameter derivatives among resources manageable for a large and complex Kubernetes system such as ONAP.

At deployment time, with a single **helm deploy** command, Helm resolves all the templates and compiles the chart hierarchy into Kubernetes resource definitions,
and invokes Kubernetes deployment operations for all the resources.

All ONAP Helm charts are organized under the **kubernetes** directory of the **OOM** project, where roughly each ONAP component occupies a subdirectory.
DCAE charts are placed under the **dcaegen2** directory.

All DCAE Services are deployed through Cloudify Blueprint. The default ONAP DCAE deployment includes small subset of DCAE services deployed through Bootstrap pod to meet
ONAP Integration usecases. Optinally operators can deploye on-deman other MS required for their usecases as described in `On-demand MS Installation
<installation_MS_ondemand.rst>`.

The PNDA data platform is an optional DCAE component that is placed under the **pnda**
directory. Details for how to configure values to enable PNDA installation during Helm install
are described in `Installing PNDA During Helm Chart Based DCAE Deployment
<installation_pnda.rst>`.


DCAE Chart Organization
-----------------------

Following Helm conventions, the DCAE Helm chart directory (``oom/kubernetes/dcaegen2``) consists of the following files and subdirectories:

* ``Chart.yaml``: metadata.
* ``requirements.yaml``: dependency charts.
* ``values.yaml``: values for Helm templating engine to expand templates.
* ``resources``: subdirectory for additional resource definitions such as configuration, scripts, etc.
* ``templates``: subdirectory for Kubernetes resource definition templates.
* ``charts``: subdirectory for sub-charts.

The dcaegen2 chart has the following sub-charts:

* ``dcae-bootstrap``: deploys the DCAE bootstrap service that performs some DCAE initialization and deploys additional DCAE components.
* ``dcae-cloudify-manager``: deploys the DCAE Cloudify Manager instance.
* ``dcae-config-binding-service``: deploys the DCAE config binding service.
* ``dcae-deployment-handler``: deploys the DCAE deployment handler service.
* ``dcae-healthcheck``: deploys the DCAE healthcheck service that provides an API to check the health of all DCAE components.
* ``dcae-policy-handler``: deploys the DCAE policy handler service.
* ``dcae-redis``: deploys the DCAE Redis cluster.
* ``dcae-servicechange-handler``: deploys the DCAE service change handler service.  A subchart (``dcae-inventory-api``) deploys the DCAE inventory API service.

DCAE Deployment
---------------

At deployment time, when the **helm deploy** command is executed,
all DCAE resources defined within the subcharts above are deployed.
These include:

* the DCAE bootstrap service
* the DCAE healthcheck service
* the DCAE platform components:

  * Cloudify Manager
  * Config binding service
  * Deployment handler
  * Policy handler
  * Service change handler
  * Inventory API service (launched as a subchart of service change handler)
  * Inventory postgres database service (launched as a dependency of the inventory API service)
  * DCAE postgres database service (launched as a dependency of the bootstrap service)
  * DCAE Redis cluster

Some of the DCAE subcharts include an initContainer that checks to see if
other services that they need in order to run have become ready.  The installation
of these subcharts will pause until the needed services are available.

In addition, DCAE operations depends on a Consul server cluster.
For ONAP OOM deployment, the Consul cluster is provided as a shared
resource. Its charts are defined under the ``oom/kubernetes/consul``
directory, not as part of the DCAE chart hierarchy.

The dcae-bootstrap service has a number of prerequisites because the subsequently deployed DCAE components depends on a number of resources having entered their normal operation state.  DCAE bootstrap job will not start before these resources are ready.  They are:

  * dcae-cloudify-manager
  * consul-server
  * msb-discovery
  * kube2msb
  * dcae-config-binding-service
  * dcae-db

Once started, the DCAE bootstrap service will call Cloudify Manager to deploy
a series of blueprints which specify the additional DCAE R4 components.
These blueprints use the DCAE Kubernetes plugin (``k8splugin``) to deploy
Docker images into the ONAP Kubernetes cluster.  For each component, the plugin
creates a Kubernetes deployment and other Kubernetes resources (services, volumes, logging sidecar, etc.)
as needed.

The DCAE bootstrap service creates the following Kubernetes deployments:

* deploy/dep-dcae-dashboard
* deploy/dep-dcae-hv-ves-collector
* deploy/dep-dcae-prh
* deploy/dep-dcae-snmptrap-collector
* deploy/dep-dcae-tca-analytics
* deploy/dep-dcae-ves-collector
* deploy/dep-holmes-engine-mgmt
* deploy/dep-holmes-rule-mgmt

After deploying all of the blueprints, the DCAE bootstrap service
continues to run.   The bootstrap container can be useful for
troubleshooting or for launching additional components.  The bootstrap
container logs (accessed using the ``kubectl logs`` command) show the
details of all of the component deployments.

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

In addition, for DCAE components deployed through Cloudify Manager blueprints, their configuration parameters are defined in the following places:

     * The blueprint files can contain static values for configuration parameters;
        * The blueprint files are defined under the ``blueprints`` directory of the ``dcaegen2/platform/blueprints`` repo, named with "k8s" prefix.
     * The blueprint files can specify input parameters and the values of these parameters will be used for configuring parameters in Blueprints.  The values for these input parameters can be supplied in several ways as listed below in the order of precedence (low to high):
        * The blueprint files can define default values for the input parameters;
        * The blueprint input files can contain static values for input parameters of blueprints.  These input files are provided as config resources under the dcae-bootstrap chart;
        * The blueprint input files may contain Helm templates, which are resolved into actual deployment time values following the rules for Helm values.


Now we walk through an example, how to configure the Docker image for the DCAE dashboard, which is deployed by Cloudify Manager.

In the ``k8s-dashboard.yaml-template`` blueprint template, the Docker image to use is defined as an input parameter with a default value:

.. code-block::

  dashboard_docker_image:
    description: 'Docker image for dashboard'
    default: 'nexus3.onap.org:10001/onap/org.onap.ccsdk.dashboard.ccsdk-app-os:1.1.0-SNAPSHOT-latest'

Then in the input file, ``oom/kubernetes/dcaegen2/charts/dcae-bootstrap/resources/inputs/k8s-dashboard-inputs.yaml``,
it is defined again as:

.. code-block::

  dashboard_docker_image: {{ include "common.repository" . }}/{{ .Values.componentImages.dashboard }}

Thus, when ``common.repository`` and ``componentImages.policy_handler`` are defined in the ``values.yaml`` files,
their values will be plugged in here and the resulting ``policy_handler_image`` value
will be passed to the Policy Handler blueprint as the Docker image tag to use instead of the default value in the blueprint.

Indeed the ``componentImages.dashboard`` value is provided in the ``oom/kubernetes/dcaegen2/charts/dcae-bootstrap/values.yaml`` file:

.. code-block::

  componentImages:
    dashboard: onap/org.onap.ccsdk.dashboard.ccsdk-app-os:1.1.0

The final result is that when DCAE bootstrap calls Cloudify Manager to deploy the DCAE dashboard, the 1.1.0 image will be deployed.

DCAE Service Endpoints
----------------------

Below is a table of default hostnames and ports for DCAE component service endpoints in Kubernetes deployment:
    ==================   =================================   ======================================================
    Component            Cluster Internal (host:port)        Cluster external (svc_name:port)
    ==================   =================================   ======================================================
    VES                  dcae-ves-collector:8080             xdcae-ves-collector.onap:30235
    HV-VES               dcae-hv-ves-collector:6061          xdcae-hv-ves-collector.onap:30222
    TCA                  dcae-tca-analytics:11011            xdcae-tca-analytics.onap:32010
    PRH                  dcae-prh:8100                       NA
    SNMPTrap             dcae-snmptrap-collector:6162/udp    xdcae-snmptrap-collector:30470/UDP
    Policy Handler       policy-handler:25577                NA
    Deployment Handler   deployment-handler:8443             NA
    Inventory            inventory:8080                      NA
    Config binding       config-binding-service:10000        config-binding-servicee:30415
    DCAE Healthcheck     dcae-healthcheck:80                 NA
    Cloudify Manager     dcae-cloudify-manager:80            NA
    DCAE Dashboard       dcae-dashboard:8080/8443            xdcae-dashboard:30418/30419
    ==================   =================================   ======================================================

In addition, a number of ONAP service endpoints that are used by DCAE components are listed as follows
for reference by DCAE developers and testers:

    ====================   ============================      ================================
    Component              Cluster Internal (host:port)      Cluster external (svc_name:port)
    ====================   ============================      ================================
    Consul Server          consul-server:8500                consul-server:30270
    Robot                  robot:88                          robot:30209 TCP
    Message router         message-router:3904               message-router:30227
    Message router         message-router:3905               message-router:30226
    Message router Kafka   message-router-kafka:9092         NA
    MSB Discovery          msb-discovery:10081               msb-discovery:30281
    Logging                log-kibana:5601                   log-kibana:30253
    AAI                    aai:8080                          aai:30232
    AAI                    aai:8443                          aai:30233
    ====================   ============================      ================================

Uninstalling DCAE
-----------------

All of the DCAE components deployed using the OOM Helm charts will be
deleted by the ``helm undeploy`` command.  This command can be used to
uninstall all of ONAP by undeploying the top-level Helm release that was
created by the ``helm deploy`` command.  The command can also be used to
uninstall just DCAE, by having the command undeploy the `top_level_release_name`-``dcaegen2``
Helm sub-release.

Helm will undeploy only the components that were originally deployed using
Helm charts.  Components deployed by Cloudify Manager are not deleted by
the Helm operations.

When uninstalling all of ONAP, it is sufficient to delete the namespace
used for the deployment (typically ``onap``) after running the undeploy
operation.  Deleting the namespace will get rid of any remaining resources
in the namespace, including the components deployed by Cloudify Manager.

When uninstalling DCAE alone, deleting the namespace would delete the
rest of ONAP as well.  To delete DCAE alone, and to make sure all of the
DCAE components deployed by Cloudify Manager are uninstalled:

* Find the Cloudify Manager pod identifier, using a command like:

  ``kubectl -n onap get pods | grep dcae-cloudify-manager``
* Execute the DCAE cleanup script on the Cloudify Manager pod, using a command like:

  ``kubectl -n onap exec`` `cloudify-manager-pod-id` ``-- /scripts/dcae-cleanup.sh``
* Finally, run ``helm undeploy`` against the DCAE Helm subrelease

The DCAE cleanup script uses Cloudify Manager and the DCAE Kubernetes
plugin to instruct Kubernetes to delete the components deployed by Cloudify
Manager.  This includes the components deployed when the DCAE bootstrap
service ran and any components deployed after bootstrap.