.. This work is licensed under a Creative Commons Attribution 4.0 International License.
.. http://creativecommons.org/licenses/by/4.0
.. _heartbeat-installation:


Helm Installation
=================

The Heartbeat microservice can be deployed using helm charts in the oom repository.

Deployment steps
~~~~~~~~~~~~~~~~

- Default app config values can be updated in oom/kubernetes/dcaegen2-services/components/dcae-heartbeat/values.yaml.

- Make the chart and deploy using the following command:

  .. code-block:: bash

    cd oom/kubernetes/
    make dcaegen2-services
    helm install dev-dcaegen2-services dcaegen2-services --namespace <namespace> --set global.masterPassword=<password>

- To deploy only RESTConf:

  .. code-block:: bash

    helm install dev-dcae-heartbeat dcaegen2-services/components/dcae-heartbeat --namespace <namespace> --set global.masterPassword=<password>

- To Uninstall

  .. code-block:: bash

    helm uninstall dev-dcae-heartbeat
