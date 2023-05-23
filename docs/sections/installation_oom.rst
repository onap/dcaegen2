.. This work is licensed under a Creative Commons Attribution 4.0 International License.
.. http://creativecommons.org/licenses/by/4.0

DCAE Deployment (using Helm)
============================

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


With DCAE Transformation to Helm completed in Jakarta/R10 release, all DCAE components deployment is supported only via helm.  Charts for individual MS are available under **dcaegen2-services** directory under OOM project (https://git.onap.org/oom/tree/kubernetes/dcaegen2-services/components). With ONAP deployment, four DCAE services (HV VES collector, VES collector, PNF Registration Handler, and TCA (Gen2) analytics service) are bootstrapped via Helm charts.

Other DCAE Services can be deployed on-demand via their independent helm-charts. For on-demand helm chart, refer to steps described in :ref:`Helm install/upgrade section <dcae-service-deployment>`.


.. note::
  DCAE platform components deployments is optionally available through Helm charts under the **dcaegen2** directory however this mode is not supported with Jakarta release. These charts will be removed in subsequent release.



DCAE Chart Organization
-----------------------

Following Helm conventions, the DCAE Helm chart directory (``oom/kubernetes/dcaegen2-services`` & ``oom/kubernetes/dcaegen2``) consists of the following files and subdirectories:

* ``Chart.yaml``: metadata.
* ``requirements.yaml``: dependency charts.
* ``values.yaml``: values for Helm templating engine to expand templates.
* ``resources``: subdirectory for additional resource definitions such as configuration, scripts, etc.
* ``Makefile``: make file to build DCAE charts
* ``components``: subdirectory for DCAE sub-charts.


The dcaegen2-services chart has the following sub-charts:

* ``dcae-datafile-collector``: deploys the DCAE DataFile Collector service.
* ``dcae-hv-ves-collector``: deploys the DCAE High-Volume VES collector service.
* ``dcae-ms-healthcheck``: deploys a health check component that tests the health of the 4 DCAE services deployed via Helm.
* ``dcae-pm-mapper``: deploys the DCAE PM-Mapper service.
* ``dcae-prh``: deploys the DCAE PNF Registration Handler service.
* ``dcae-tcagen2``: deploys the DCAE TCA analytics service.
* ``dcae-ves-collector``: deploys the DCAE VES collector service.
* ``dcae-datafile-collector``: deploys the DCAE Datafile collector service.
* ``dcae-datalake-admin-ui``: deploys the Datalake Admin UI service.
* ``dcae-datalake-des``: deploys the Datalake Data Extraction service.
* ``dcae-datalake-feeder``: deploys the Datalake Feeder service.
* ``dcae-heartbeat``: deploys the DCAE Heartbeat microservice.
* ``dcae-kpi-ms``: deploys the DCAE KPI computation microservice.
* ``dcae-ms-healthcheck``: deploys the DCAE healthcheck service that provides API to check health of bootstrapped DCAE service deployed via helm
* ``dcae-pm-mapper``: deploys the DCAE PM-Mapper service.
* ``dcae-pmsh``: deploys the DCAE PM Subscription Handler service.
* ``dcae-restconf-collector``: deploys the DCAE RESTConf collector service.
* ``dcae-slice-analysis-ms``: deploys the DCAE Slice Analysis service.
* ``dcae-snmptrap-collector``: deploys the DCAE SNMPTRAP collector service.
* ``dcae-son-handler``: deploys the DCAE SON-Handler microservice.
* ``dcae-ves-mapper``: deploys the DCAE VES Mapper microservice.
* ``dcae-ves-openapi-manager``: deploys the DCAE service validator of VES_EVENT type artifacts from distributed services.


The dcaegen2-services sub-charts depend on a set of common templates, found under the ``common`` subdirectory under ``dcaegen2-services``.

Information about using the common templates to deploy a microservice can be
found in :doc:`Using Helm to deploy DCAE Microservices <./dcaeservice_helm_template>`.


DCAE Deployment
---------------

At deployment time for ONAP, when the **helm deploy** command is executed,
only the DCAE resources defined within the subcharts - "dcaegen2-services" above are deployed
(based on override file configuration defined in `values.yaml <https://git.onap.org/oom/tree/kubernetes/dcaegen2-services/values.yaml>`_

These include:

* DCAE Service components:
  * VES Collector
  * HV-VES Collector
  * PNF-Registration Handler Service
  * Threshold Crossing Analysis (TCA-gen2)
* DCAE-Services healthcheck
* VES OpenAPI Manager

Some of the DCAE subcharts include an initContainer that checks to see if
other services that they need in order to run have become ready.  The installation
of these subcharts will pause until the needed services are available.

Since Istanbul release, DCAE bootstrapped Microservice deployment are managed completely under Helm.

Additionaly tls-init-container invoked during component deployment relies on AAF to generate the required certificate hence AAF
must be enabled under OOM deployment configuration.

As majority of DCAE services rely on DMAAP (MR and DR) interfaces, ONAP/DMAAP must also be enabled under OOM deployment configuration.

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


.. _dcae-service-deployment:

On-demand deployment/upgrade through Helm
-----------------------------------------

Under DCAE Transformation to Helm, all DCAE components has been delivered as helm charts under
OOM repository (https://git.onap.org/oom/tree/kubernetes/dcaegen2-services).


All DCAE component charts follows standard Helm structure. Each Microservice charts has predefined configuration defined under
``applicationConfig`` which can be modified or overridden at deployment time.

Using helm, any of DCAE microservice can be deployed/upgraded/uninstalled on-demand.

``Pre-Install``

.. note::
  This step is only required when helm install should be done on different releasename/prefix from rest of ONAP deployment

With Istanbul release, OOM team included support for ServiceAccount in ONAP deployment to limit the pod access to API server.

Following packages has been added under oom/common to support pre-provisioning of cluster roles and ServiceAccount management

  * `ServiceAccount <https://git.onap.org/oom/tree/kubernetes/common/serviceAccount/values.yaml>`_
  * `RoleWrapper <https://git.onap.org/oom/tree/kubernetes/common/roles-wrapper>`_

When deployed, these chart will create the ServiceAccount and Role (based on override) and required Rolebinding (to associate the Serviceaccount to a role).

ONAP deployment by default includes the required provisioning of roles under release name (such as "dev") under which ONAP is deployed. For subsequent
helm installation under same release name prefix (i.e dev-) no further action is required.

When Helm install is required under different releasename prefix, then execute following command prior to running helm install.

   .. code-block:: bash

        helm install <DEPLOYMENT_PREFIX>-role-wrapper local/roles-wrapper -n <namespace>


Followed by install of required service/chart

    .. code-block:: bash

        helm -n <namespace> install <DEPLOYMENT_PREFIX>-dcaegen2-services oom/kubernetes/dcaegen2-services


``Installation``

Review and update local copy of dcaegen2-service ``values.yaml`` oom/kubernetes/dcaegen2-services/values.yaml
to ensure component is enabled for deployment (or provide as command line override)

    .. code-block:: bash

        helm -n <namespace> install <DEPLOYMENT_PREFIX>-dcaegen2-services oom/kubernetes/dcaegen2-services


Service component can also be installed individually from oom/kubernetes/dcaegen2-services/components/<dcae-ms-chart>

    .. code-block:: bash

        helm -n onap install dev-dcaegen2-services-ves-mapper oom/kubernetes/dcaegen2-services/components/dcae-ves-mapper -f values.yaml

Using -f flag override file can be specified which will take precedence over default configuration.
When commandline override is not provided, default (values.yaml) provided in chart-directory will be used.

``Upgrade``

Helm support upgrade of charts already deployed; using ``upgrade``  component deployment can be modified

    .. code-block:: bash

        helm -n <namespace> upgrade <DEPLOYMENT_PREFIX>-dcaegen2-services --reuse-values --values <updated values.yaml path> <dcaegen2-services helm charts path>


For minor configuration updates, helm also supports new values to be provided inline to the upgrade command. Example below -

    .. code-block:: bash

        helm -n onap upgrade dev-dcaegen2-services oom/kubernetes/dcaegen2-services --reuse-values --set dcae-ves-collector.applicationConfig.auth.method="noAuth"

``Uninstall``

Components can be uninstalled using delete command.

    .. code-block:: bash

        helm -n <namespace> delete <DEPLOYMENT_PREFIX>-dcaegen2-services

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
    DCAE MS Healthcheck  dcae-ms-healthcheck:8080             NA
    ===================  ==================================   =======================================================

In addition, a number of ONAP service endpoints that are used by DCAE components are listed as follows
for reference by DCAE developers and testers:

    ====================   ============================      ================================
    Component              Cluster Internal (host:port)      Cluster external (svc_name:port)
    ====================   ============================      ================================
    Robot                  robot:88                          robot:30209 TCP
    Message router         message-router:3904               NA
    Message router         message-router:3905               message-router-external:30226
    Message router Kafka   message-router-kafka:9092         NA
    ====================   ============================      ================================

Uninstalling DCAE
-----------------

All of the DCAE components deployed using the OOM Helm charts will be
deleted by the ``helm undeploy`` command.  This command can be used to
uninstall all of ONAP by undeploying the top-level Helm release that was
created by the ``helm deploy`` command.  The command can also be used to
uninstall just DCAE, by having the command undeploy the `top_level_release_name`-``dcaegen2-services``
Helm sub-release.

Helm will undeploy only the components that were originally deployed using
Helm charts. When uninstalling all of ONAP, it is sufficient to delete the namespace
used for the deployment (typically ``onap``) after running the undeploy
operation.  Deleting the namespace will get rid of any remaining resources
in the namespace.


To undeploy the DCAE services deployed via Helm (the hv-ves-collector, ves-collector, tcagen2,
and prh), use the ``helm undeploy`` command against the `top_level_release_name`-``dcaegen2-services``
Helm sub-release.
