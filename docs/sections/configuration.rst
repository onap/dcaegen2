.. This work is licensed under a Creative Commons Attribution 4.0 International License.
.. http://creativecommons.org/licenses/by/4.0


Configuration
=============

DCAEGEN2 is deployed via helm charts. The configuration are maintained as on values.yaml and can be updated for deployment if necessary.

The helm charts for each component can be controlled via a separate override file under its respective component under ``oom/kubernetes/dcaegen2-services/components``

Below is a list of DCAE Services and the corresponding helm chart override location.

.. csv-table::
   :header: "Component", "Charts"
   :widths: 25,100

   "DataFileCollector", "https://git.onap.org/oom/tree/kubernetes/dcaegen2-services/components/dcae-datafile-collector"
   "DL AdminUI", "https://git.onap.org/oom/tree/kubernetes/dcaegen2-services/components/dcae-datalake-admin-ui"
   "DL DES", "https://git.onap.org/oom/tree/kubernetes/dcaegen2-services/components/dcae-datalake-des"
   "DL Feeder", "https://git.onap.org/oom/tree/kubernetes/dcaegen2-services/components/dcae-datalake-feeder"
   "Heartbeat mS", "https://git.onap.org/oom/tree/kubernetes/dcaegen2-services/components/dcae-heartbeat"
   "HV-VES Collector", "https://git.onap.org/oom/tree/kubernetes/dcaegen2-services/components/dcae-hv-ves-collector"
   "KPI mS", "https://git.onap.org/oom/tree/kubernetes/dcaegen2-services/components/dcae-kpi-ms"
   "Healthcheck mS", "https://git.onap.org/oom/tree/kubernetes/dcaegen2-services/components/dcae-ms-healthcheck"
   "PM-Mapper", "https://git.onap.org/oom/tree/kubernetes/dcaegen2-services/components/dcae-pm-mapper"
   "PMSH", "https://git.onap.org/oom/tree/kubernetes/dcaegen2-services/components/dcae-pmsh"
   "PRH", "https://git.onap.org/oom/tree/kubernetes/dcaegen2-services/components/dcae-prh"
   "RestConf Collector", "https://git.onap.org/oom/tree/kubernetes/dcaegen2-services/components/dcae-restconf-collector"
   "SliceAnalysis mS", "https://git.onap.org/oom/tree/kubernetes/dcaegen2-services/components/dcae-slice-analysis-ms"
   "SNMPTrap Collector", "https://git.onap.org/oom/tree/kubernetes/dcaegen2-services/components/dcae-snmptrap-collector"
   "SON-Handler mS", "https://git.onap.org/oom/tree/kubernetes/dcaegen2-services/components/dcae-son-handler"
   "TCAgen2", "https://git.onap.org/oom/tree/kubernetes/dcaegen2-services/components/dcae-tcagen2"  
   "VESCollector", "https://git.onap.org/oom/tree/kubernetes/dcaegen2-services/components/dcae-ves-collector" 
   "VESMapper", "https://git.onap.org/oom/tree/kubernetes/dcaegen2-services/components/dcae-ves-mapper"
   "VES-OpenAPIManager", "https://git.onap.org/oom/tree/kubernetes/dcaegen2-services/components/dcae-ves-openapi-manager"



Deployment time configuration of DCAE components are defined in several places.

  * Helm Chart templates:
     * Helm/Kubernetes template files can contain static values for configuration parameters;
  * Helm Chart resources:
     * Helm/Kubernetes resources files can contain static values for configuration parameters;
  * Helm values.yaml files:
     * The values.yaml files supply the values that Helm templating engine uses to expand any templates defined in Helm templates;
     * In a Helm chart hierarchy, values defined in values.yaml files in higher level supersedes values defined in values.yaml files in lower level;
     * Helm command line supplied values supersedes values defined in any values.yaml files.


All DCAE Service components are deployed only via Helm. Instructions for deployment and configuration are documented under https://docs.onap.org/projects/onap-dcaegen2/en/latest/sections/services/serviceindex.html


Config maps
-----------

During the installation of the DCAEGEN2-SERVICES module, two config maps are installed by default: dcae-external-repo-configmap-schema-map and dcae-external-repo-configmap-sa88-rel16.

Config maps are used by DCAEGEN VES and VES OPEN API components.

Instruction how to generate the content of config maps is described in `README <https://gerrit.onap.org/r/gitweb?p=oom/utils.git;a=blob_plain;f=external-schema-repo-generator/README.md;hb=refs/heads/master>`_ file.
