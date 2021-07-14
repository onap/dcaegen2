.. This work is licensed under a Creative Commons Attribution 4.0 International License.
.. http://creativecommons.org/licenses/by/4.0

DCAE Deployment (using Helm and Cloudify)
=========================================

This document describes the details of the Helm chart based deployment process for ONAP and how DCAE is deployed through this process.


Deployment Overview
-------------------

ONAP deployments are done on kubernetes through OOM/Helm charts. Kubernetes is a container orchestration technology that organizes containers into composites of various patterns for easy deployment, management, and scaling.
ONAP uses Kubernetes as the foundation for fulfilling its platform maturity promises.

ONAP manages Kubernetes specifications using Helm charts (in OOM project), under which all Kubernetes yaml-formatted resource specifications and additional files
are organized into a hierarchy of charts, sub-charts, and resources.  These yaml files are further augmented with Helm's templating, which makes dependencies
and cross-references of parameters and parameter derivatives among resources manageable for a large and complex Kubernetes system such as ONAP.

At deployment time, with a single **helm deploy** command, Helm resolves all the templates and compiles the chart hierarchy into Kubernetes resource definitions,
and invokes Kubernetes deployment operations for all the resources.

All ONAP Helm charts are organized under the **kubernetes** directory of the **OOM** project, where roughly each ONAP component occupies a subdirectory.
DCAE platform components are deployed using Helm charts under the **dcaegen2** directory.
Four DCAE services (the HV VES collector, the VES collector, the PNF Registration Handler, and the TCA (Gen 2) analytics service) are deployed using Helm charts under the **dcaegen2-services** directory.

Other DCAE Services are deployed on-demand, after ONAP/DCAE installation, through Cloudify Blueprints.  Operators can deploy on-demand other MS required for their usecases as described in :doc:`On-demand MS Installation
<./installation_MS_ondemand>`.


DCAE Chart Organization
-----------------------

Following Helm conventions, the DCAE Helm chart directory (``oom/kubernetes/dcaegen2``) consists of the following files and subdirectories:

* ``Chart.yaml``: metadata.
* ``requirements.yaml``: dependency charts.
* ``values.yaml``: values for Helm templating engine to expand templates.
* ``resources``: subdirectory for additional resource definitions such as configuration, scripts, etc.
* ``Makefile``: make file to build DCAE charts
* ``components``: subdirectory for DCAE sub-charts.

The dcaegen2 chart has the following sub-charts:

* ``dcae-bootstrap``: deploys the DCAE bootstrap service that performs some DCAE initialization and deploys additional DCAE components.
* ``dcae-cloudify-manager``: deploys the DCAE Cloudify Manager instance.
* ``dcae-config-binding-service``: deploys the DCAE config binding service.
* ``dcae-deployment-handler``: deploys the DCAE deployment handler service.
* ``dcae-healthcheck``: deploys the DCAE healthcheck service that provides an API to check the health of all DCAE components.
* ``dcae-policy-handler``: deploys the DCAE policy handler service.
* ``dcae-redis``: deploys the DCAE Redis cluster.
* ``dcae-dashboard``: deploys the DCAE Dashboard for managing DCAE microservices deployments
* ``dcae-servicechange-handler``: deploys the DCAE service change handler service.
* ``dcae-inventory-api``: deploys the DCAE inventory API service.
* ``dcae-ves-openapi-manager``: deploys the DCAE service validator of VES_EVENT type artifacts from distributed services.

The dcaegen2-services chart has the following sub-charts:

* ``dcae-datafile-collector``: deploys the DCAE DataFile Collector service.
* ``dcae-hv-ves-collector``: deploys the DCAE High-Volume VES collector service.
* ``dcae-ms-healthcheck``: deploys a health check component that tests the health of the 4 DCAE services deployed via Helm.
* ``dcae-pm-mapper``: deploys the DCAE PM-Mapper service.
* ``dcae-prh``: deploys the DCAE PNF Registration Handler service.
* ``dcae-tcagen2``: deploys the DCAE TCA analytics service.
* ``dcae-ves-collector``: deploys the DCAE VES collector service.

The dcaegen2-services sub-charts depend on a set of common templates, found under the ``common`` subdirectory under ``dcaegen2-services``.

Information about using the common templates to deploy a microservice can be
found in :doc:`Using Helm to deploy DCAE Microservices <./dcaeservice_helm_template>`.

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
  * Inventory API service
  * Inventory postgres database service (launched as a dependency of the inventory API service)
  * DCAE postgres database service (launched as a dependency of the bootstrap service)
  * DCAE Redis cluster
  * DCAE Mongo database service (launched as a dependency of the bootstrap service)
  * VES OpenAPI Manager

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
  * dcae-mongodb
  * dcae-inventory-api

Additionaly tls-init-container invoked during component deployment relies on AAF to generate the required certificate hence AAF
must be enabled under OOM deployment configuration.


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


Now we walk through an example, how to configure the Docker image for the DCAE VESCollector, which is deployed by Cloudify Manager.

(*Note: Beginning with the Honolulu release, VESCollector is no longer deployed using Cloudify Manager.  However, the example is still
useful for understanding how to deploy other components using a Cloudify blueprint.*)

In the  `k8s-ves.yaml <https://git.onap.org/dcaegen2/platform/blueprints/tree/blueprints/k8s-ves.yaml>`_ blueprint, the Docker image to use is defined as an input parameter with a default value:

.. code-block:: yaml

    tag_version:
    type: string
    default: "nexus3.onap.org:10001/onap/org.onap.dcaegen2.collectors.ves.vescollector:1.5.4"

The corresponding input file, ``https://git.onap.org/oom/tree/kubernetes/dcaegen2/components/dcae-bootstrap/resources/inputs/k8s-ves-inputs-tls.yaml``,
it is defined again as:

.. code-block:: yaml
  {{ if .Values.componentImages.ves }}
  tag_version: {{ include "common.repository" . }}/{{ .Values.componentImages.ves }}
  {{ end }}


Thus, when ``common.repository`` and ``componentImages.ves`` are defined in the ``values.yaml`` files,
their values will be plugged in here and the resulting ``tag_version`` value
will be passed to the blueprint as the Docker image tag to use instead of the default value in the blueprint.

The ``componentImages.ves`` value is provided in the ``oom/kubernetes/dcaegen2/charts/dcae-bootstrap/values.yaml`` file:

.. code-block:: yaml

  componentImages:
    ves: onap/org.onap.dcaegen2.collectors.ves.vescollector:1.5.4


The final result is that when DCAE bootstrap calls Cloudify Manager to deploy the DCAE VES collector, the 1.5.4 image will be deployed.

DCAE Service Endpoints
----------------------

Below is a table of default hostnames and ports for DCAE component service endpoints in Kubernetes deployment:
    ===================  ==================================   =======================================================
    Component            Cluster Internal (host:port)         Cluster external (svc_name:port)
    ===================  ==================================   =======================================================
    VES                  dcae-ves-collector:8443              dcae-ves-collector.onap:30417
    HV-VES               dcae-hv-ves-collector:6061           dcae-hv-ves-collector.onap:30222
    TCA-Gen2             dcae-tcagen2:9091                    NA
    PRH                  dcae-prh:8100                        NA
    Policy Handler       policy-handler:25577                 NA
    Deployment Handler   deployment-handler:8443              NA
    Inventory            inventory:8080                       NA
    Config binding       config-binding-service:10000/10001   NA
    DCAE Healthcheck     dcae-healthcheck:80                  NA
    DCAE MS Healthcheck  dcae-ms-healthcheck:8080             NA
    Cloudify Manager     dcae-cloudify-manager:80             NA
    DCAE Dashboard       dashboard:8443                       dashboard:30418
    DCAE mongo           dcae-mongo-read:27017                NA
    ===================  ==================================   =======================================================

In addition, a number of ONAP service endpoints that are used by DCAE components are listed as follows
for reference by DCAE developers and testers:

    ====================   ============================      ================================
    Component              Cluster Internal (host:port)      Cluster external (svc_name:port)
    ====================   ============================      ================================
    Consul Server          consul-server-ui:8500             NA
    Robot                  robot:88                          robot:30209 TCP
    Message router         message-router:3904               NA
    Message router         message-router:3905               message-router-external:30226
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

To undeploy the DCAE services deployed via Helm (the hv-ves-collector, ves-collector, tcagen2,
and prh), use the ``helm undeploy`` command against the `top_level_release_name`-``dcaegen2-services``
Helm sub-release.