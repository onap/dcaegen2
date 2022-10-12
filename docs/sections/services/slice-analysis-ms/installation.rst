.. This work is licensed under a Creative Commons Attribution 4.0 International License.
.. http://creativecommons.org/licenses/by/4.0
.. _sliceanalysis-installation:


Installation
============

Slice Analysis MS can either be deployed using cloudify blueprint using bootstrap container of an existing DCAE deployment, or deployed by OOM.

Deployment Pre-requisites
~~~~~~~~~~~~~~~~~~~~~~~~~
- DCAE and DMaaP pods should be up and running. 

- DMaaP Bus Controller PostInstalls job should have completed successfully (executed as part of an OOM install).

- PM mapper service should be running.

- Config DB service should be running.

- Make sure that cfy is installed and configured to work with the Cloudify deployment.


Deployment steps
~~~~~~~~~~~~~~~~
1. Execute bash on the bootstrap Kubernetes pod. 
   
   kubectl -n onap exec -it <dcaegen2-dcae-bootstrap> bash

2. Go to the /blueprints directory.

  Check that the tag_version in the slice-analysis-ms blueprint is correct for the release
  of ONAP that it is being installed on see Nexus link below for slice-analysis-ms for tag_versions.
  Nexus link: https://nexus3.onap.org/#browse/browse:docker.public:v2%2Fonap%2Forg.onap.dcaegen2.services.components.slice-analysis-ms%2Ftags

3. Create an input file.

4. Run the Cloudify install command to install the slice-analysis-ms with the blueprint and the newly    created input file k8s-slice-input.yaml.

   $ cfy install k8s-slice-analysis-ms.yaml -i  k8s-slice-input.yaml --blueprint-id sliceanalysisms

   Details of the sample output are available at:
   https://wiki.onap.org/pages/viewpage.action?pageId=92998809.

5. To un-deploy

  $ cfy uninstall sliceanalysisms


Application configurations
~~~~~~~~~~~~~~~~~~~~~~~~~~
+-------------------------------+------------------------------------------------+
|Configuration                  | Description                                    |
+===============================+================================================+
|samples                        | Minimum number of samples to be present        |
|                               | for analysis                                   |
+-------------------------------+------------------------------------------------+
|minimumPercentageChange        | Minimum percentage of configuration change     |
|                               | above which control loop should be triggered   |
+-------------------------------+------------------------------------------------+
|initialDelaySeconds            | Initial delay in milliseconds for the consumer |
|                               | thread to start after the application startup  |
+-------------------------------+------------------------------------------------+
|config_db                      | Host where the config DB application is running|
+-------------------------------+------------------------------------------------+
|performance_management_topicurl| Dmaap Topic URL to which PM data are posted    |
|                               | by network functions                           |
+-------------------------------+------------------------------------------------+
|dcae_cl_topic_url              | Dmaap topic to which onset message to trigger  |
|                               | the control loop are posted                    |
+-------------------------------+------------------------------------------------+
|dcae_cl_response_topic_url     | Dmaap topic URL to which Policy posts the      |
|                               | message after successful control loop trigger  |
+-------------------------------+------------------------------------------------+
|intelligent_slicing_topic_url  | Dmaap topic URL to which ML MS posts the       |
|                               | messages                                       |
+-------------------------------+------------------------------------------------+
|dmaap_polling_interval         | Dmaap Polling interval in milliseconds         |
+-------------------------------+------------------------------------------------+

