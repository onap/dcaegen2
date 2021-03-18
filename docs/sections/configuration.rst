.. This work is licensed under a Creative Commons Attribution 4.0 International License.
.. http://creativecommons.org/licenses/by/4.0
.. _configuration:

Configuration
=============

DACEGEN2 platform is deployed via helm charts. The configuration are maintained as on values.yaml and can be updated for deployment if necessary.

For Frankfurt release, the helm charts for each platform component can be controlled via separate override file
https://wiki.onap.org/pages/viewpage.action?pageId=71837415




.. csv-table::
   :header: "Component", "Charts"
   :widths: 22,100

   "Cloudify", "https://git.onap.org/oom/tree/kubernetes/dcaegen2/components/dcae-cloudify-manager"
   "ConfigBinding Service", "https://git.onap.org/oom/tree/kubernetes/dcaegen2/components/dcae-config-binding-service"
   "Deployment Handler", "https://git.onap.org/oom/tree/kubernetes/dcaegen2/components/dcae-deployment-handler"
   "Policy Handler", "https://git.onap.org/oom/tree/kubernetes/dcaegen2/components/dcae-policy-handler"
   "ServiceChangeHandler", "https://git.onap.org/oom/tree/kubernetes/dcaegen2/components/dcae-servicechange-handler"
   "Inventory", "https://git.onap.org/oom/tree/kubernetes/dcaegen2/components/dcae-inventory-api"
   "Dashboard", "https://git.onap.org/oom/tree/kubernetes/dcaegen2/components/dcae-dashboard"
   


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


DCAE Service components are deployed via Cloudify Blueprints. Instruction for deployment and configuration are documented under https://docs.onap.org/projects/onap-dcaegen2/en/latest/sections/services/serviceindex.html

Now we walk through an example, how to configure the Docker image for the DCAE VESCollector, which is deployed by Cloudify Manager.

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

Config maps
-----------

During installation of DCAEGEN2 module two config maps are installed by default: dcae-external-repo-configmap-schema-map and dcae-external-repo-configmap-sa88-rel16.

Config maps are used by DCAEGEN VES and VES OPEN API components.

Instruction how to generate the content of config maps is described in `README <https://gerrit.onap.org/r/gitweb?p=oom/utils.git;a=blob_plain;f=external-schema-repo-generator/README.md;hb=refs/heads/master>`_ file. 