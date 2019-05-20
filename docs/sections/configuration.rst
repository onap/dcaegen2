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
   

DCAE Service components are deployed via Cloudify Blueprints. Instruction for deployment and configuration are documented under https://docs.onap.org/en/latest/submodules/dcaegen2.git/docs/sections/services/serviceindex.html
