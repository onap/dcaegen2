.. This work is licensed under a Creative Commons Attribution 4.0 International License.
.. http://creativecommons.org/licenses/by/4.0
.. _tcagen2-installation-helm:


Helm Installation
=================

The TCA-gen2 microservice can be deployed using helm charts in the oom repository.

Deployment Pre-requisites
~~~~~~~~~~~~~~~~~~~~~~~~~
- DCAE and DMaaP pods should be up and running.
- MongoDB should be up and running.

Deployment steps
~~~~~~~~~~~~~~~~

- Default app config values can be updated in oom/kubernetes/dcaegen2-services/components/dcae-tcagen2/values.yaml.

- Make the chart and deploy using the following command:

  .. code-block:: bash

    cd oom/kubernetes/
    make dcaegen2-services
    helm install dev-dcaegen2-services dcaegen2-services --namespace <namespace> --set global.masterPassword=<password>

- To deploy only tcagen2:

  .. code-block:: bash

    helm install dev-dcae-tcagen2 dcaegen2-services/components/dcae-tcagen2 --namespace <namespace> --set global.masterPassword=<password>

- To Uninstall

  .. code-block:: bash

    helm uninstall dev-dcae-tcagen2

Application Configurations
--------------------------
+-------------------------------+------------------------------------------------+
|Configuration                  | Description                                    |
+===============================+================================================+
|streams_subscribes             | Dmaap topics that the MS will consume messages |
+-------------------------------+------------------------------------------------+
|streams_publishes              | Dmaap topics that the MS will publish messages |
+-------------------------------+------------------------------------------------+
|streams_subscribes.            | Max polling Interval for consuming config data |
|tca_handle_in.                 | from dmaap                                     |
|polling.auto_adjusting.max     |                                                |
|                               |                                                |
+-------------------------------+------------------------------------------------+
|streams_subscribes.            | Min polling Interval for consuming config data |
|tca_handle_in.                 | from dmaap                                     |
|polling.auto_adjusting.min     |                                                |
|                               |                                                |
+-------------------------------+------------------------------------------------+
|streams_subscribes.            | Step down in polling Interval for consuming    |
|tca_handle_in.                 | config data from dmaap                         |
|polling.auto_adjusting.        |                                                |
|step_down                      |                                                |
+-------------------------------+------------------------------------------------+
|streams_subscribes.            | Step up polling Interval for consuming config  |
|tca_handle_in.                 | data from dmaap                                |
|polling.auto_adjusting.step_up |                                                |
+-------------------------------+------------------------------------------------+
|spring.data.mongodb.uri        | MongoDB URI                                    |
+-------------------------------+------------------------------------------------+
|tca.aai.generic_vnf_path       | AAI generic VNF path                           |
+-------------------------------+------------------------------------------------+
|tca.aai.node_query_path        | AAI node query path                            |
+-------------------------------+------------------------------------------------+
|tca.aai.password               | AAI password                                   |
+-------------------------------+------------------------------------------------+
|tca.aai.url                    | AAI base URL                                   |
+-------------------------------+------------------------------------------------+
|tca.aai.username               | AAI username                                   |
+-------------------------------+------------------------------------------------+
|streams_subscribes.            | DMAAP Consumer group for subscription          |
|tca_handle_in.consumer_group   |                                                |
+-------------------------------+------------------------------------------------+
|streams_subscribes.            | DMAAP Consumer id for subscription             |
|tca_handle_in.consumer_ids[0]  |                                                |
+-------------------------------+------------------------------------------------+
|tca.policy                     | Policy details                                 |
+-------------------------------+------------------------------------------------+
|tca.processing_batch_size      | Processing batch size                          |
+-------------------------------+------------------------------------------------+
|tca.enable_abatement           | Enable abatement                               |
+-------------------------------+------------------------------------------------+
|tca.enable_ecomp_logging       | Enable ecomp logging                           |
+-------------------------------+------------------------------------------------+
