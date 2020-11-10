Installation
============

Slice Analysis MS can be deployed using cloudify blueprint using bootstrap container of an existing DCAE deployment.

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


Logging
~~~~~~~
Since the Slice Analysis MS is deployed as a pod in the kubernetes, we can check the logs by
using the following command:

 $ kubectl logs <pod-name> –namespace onap
