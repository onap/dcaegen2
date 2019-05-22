.. This work is licensed under a Creative Commons Attribution 4.0 International License.
.. http://creativecommons.org/licenses/by/4.0

Configuration
=============

DACEGEN2 platform is deployed via helm charts. The configuration are maintained as on values.yaml and can be updated for deployment if necessary.

The following components are migrated to helm chart part of Dublin release.

ConfigBindingService

.. csv-table::
   :header: "Component", "Charts"
   :widths: 22,100

   "ConfigBinding Service", "https://git.onap.org/oom/tree/kubernetes/dcaegen2/charts/dcae-config-binding-service"
   "Deployment Handler", "https://git.onap.org/oom/tree/kubernetes/dcaegen2/charts/dcae-deployment-handler"
   "Policy Handler", "https://git.onap.org/oom/tree/kubernetes/dcaegen2/charts/dcae-policy-handler"
   "ServiceChangeHandler", "https://git.onap.org/oom/tree/kubernetes/dcaegen2/charts/dcae-servicechange-handler"
   "Invetory", "https://git.onap.org/oom/tree/kubernetes/dcaegen2/charts/dcae-servicechange-handler/charts/dcae-inventory-api"
   


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

DCAE Service components are deployed via Cloudify Blueprints. Instruction for deployment and configuration are documented under https://docs.onap.org/en/latest/submodules/dcaegen2.git/docs/sections/services/serviceindex.html
