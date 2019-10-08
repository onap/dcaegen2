.. This work is licensed under a Creative Commons Attribution 4.0 International License.
.. http://creativecommons.org/licenses/by/4.0
.. Copyright 2018-2019 Tech Mahindra Ltd.


Installation
============

**Deployment Prerequisite/dependencies**

VES-Mapper can be deployed individually though it will throw errors if it can't reach to DMaaP instance's APIs. To test it functionally, DMaaP is the only required prerequisite outside DCAE. As VES-Mapper is integrated with Consul / CBS, it fetches the initial configuration from Consul.

**Note:** Currently VES-Mapper fetches configuration from Consul only during initialization. It does not periodically refresh the local configuration by getting updates from Consul. This is planned for E release.

**Blueprint/model/image**

VES-Mapper blueprint is available @ 
https://git.onap.org/dcaegen2/services/mapper/tree/UniversalVesAdapter/dpo/blueprints/k8s-vesmapper.yaml-template.yaml?h=elalto

VES-Mapper docker image is available in Nexus repo @ `nexus3.onap.org:10001/onap/org.onap.dcaegen2.services.mapper.vesadapter.universalvesadaptor:1.0.1 <nexus3.onap.org:10001/onap/org.onap.dcaegen2.services.mapper.vesadapter.universalvesadaptor:1.0.1>`_




**1.To Run via blueprint**

*a. Verify DMaaP configurations in the blueprint as per setup*

  Dmaap Configuration consists of subscribe url to fetch notifications from the respective collector and publish url to publish ves event.


``streams_publishes`` and ``streams_subscribes`` points to the publishing topic and subscribe topic respectively.

update these ``urls`` as per your DMaaP configurations in the blueprint. 

*b. Verify the Smooks mapping configuration in the blueprint as per the usecase. Blueprint contains default mapping  for each supported collector ( SNMP Collector and RESTConf collector currently) which may serve the purpose for the usecase. The ``mapping-files`` in ``collectors`` contains the contents of the mapping file.

*c. Upload the blueprint in the DCAE's Cloudify instance*

For this step, DCAE's Cloudify instance should be in running state. Transfer blueprint file in DCAE bootstrap POD under /blueprints directory. Log-in to the DCAE bootstrap POD's main container.

Validate blueprint

    ``cfy blueprints validate /blueprints/k8s-vesmapper.yaml-template.yaml``

Use following command for validated blueprint to upload:

	``cfy blueprints upload -b ves-mapper /blueprints/k8s-vesmapper.yaml-template.yaml``

*d. Create the Deployment* 
After VES-Mapper's validated blueprint is uploaded,  create Cloudify Deployment by following command

  ``cfy deployments create -b ves-mapper ves-mapper``

*e.  Deploy the component by using following command*

  ``cfy executions start -d ves-mapper install``


**2.To run on standalone mode**

Though this is not a preferred way, to run VES-Mapper container on standalone mode using local configuration file carried in the docker image, following docker run command can be used.
 
    ``docker run -d   nexus3.onap.org:10003/onap/org.onap.dcaegen2.services.mapper.vesadapter.universalvesadaptor:1.0.1``

