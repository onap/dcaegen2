.. This work is licensed under a Creative Commons Attribution 4.0 International License.
.. http://creativecommons.org/licenses/by/4.0
.. _sliceanalysis-installation-helm:


Helm Installation
=================

Slice Analysis MS can be deployed using helm charts as kubernetes applications.

Deployment Pre-requisites
~~~~~~~~~~~~~~~~~~~~~~~~~
- DCAE and DMaaP pods should be up and running.

- PM mapper service should be running.

- Config DB service, CPS and AAI should be running.

- The environment should have helm and kubernetes installed.

- Check whether all the charts mentioned in the requirements.yaml file are present in the charts/ folder. If not present, package the respective chart and put it in the charts/ folder.

  For example:
      .. code-block:: bash

          helm package <dcaegen2-services-common>



Deployment steps
~~~~~~~~~~~~~~~~
1. Go to the directory where dcae-slice-analysis-ms chart is present and Execute the below command.
    .. code-block:: bash

        helm install <slice_analysis_ms> <dcae-slice-analysis-ms> --namespace onap --set global.masterPassword=guilin2021


2. We can check the logs of the slice-analysis-ms container by using the below command
    .. code-block:: bash

        kubectl logs -f -n onap <dev-dcae-slice-analysis-ms-9fd8495f7-zmnlw> -c <dcae-slice-analysis-ms>


3. To un-deploy
    .. code-block:: bash

        helm uninstall <slice_analysis_ms>



Application configurations
~~~~~~~~~~~~~~~~~~~~~~~~~~
+-------------------------------+------------------------------------------------+
|Configuration                  | Description                                    |
+===============================+================================================+
|postgres host                  | Host where the postgres application is running |
+-------------------------------+------------------------------------------------+
|pollingInterval                | Dmaap Polling interval in milliseconds         |
+-------------------------------+------------------------------------------------+
|pollingTimeout                 | Dmaap Polling timeout in milliseconds	         |
+-------------------------------+------------------------------------------------+
|configDb service               | Host where the config DB application is running|
+-------------------------------+------------------------------------------------+
|configDbEnabled                | To choose whether to use config DB or CPS & AAI|
+-------------------------------+------------------------------------------------+
|aai url                        | Host where the AAI application is running      |
+-------------------------------+------------------------------------------------+
|cps url                        | Host where cps tbdmt application is running    |
+-------------------------------+------------------------------------------------+
|samples                        | Minimum number of samples to be present        |
|                               | for analysis                                   |
+-------------------------------+------------------------------------------------+
|minimumPercentageChange        | Minimum percentage of configuration change     |
|                               | above which control loop should be triggered   |
+-------------------------------+------------------------------------------------+
|initialDelaySeconds            | Initial delay in milliseconds for the consumer |
|                               | thread to start after the application startup  |
+-------------------------------+------------------------------------------------+
|cl_topic                       | Dmaap topic URL to which onset message to      |
|                               | trigger  the control loop are posted           |
+-------------------------------+------------------------------------------------+
|performance_management_topic   | Dmaap topic URL to which PM data are posted    |
|                               | by network functions                           |
+-------------------------------+------------------------------------------------+
|intelligent_slicing_topic      | Dmaap topic URL to which ML MS posts the       |
|                               | messages                                       |
+-------------------------------+------------------------------------------------+
|dcae_cl_response_topic         | Dmaap topic URL to which Policy posts the      |
|                               | message after successful control loop trigger  |
+-------------------------------+------------------------------------------------+
