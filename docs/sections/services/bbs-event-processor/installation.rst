.. This work is licensed under a Creative Commons Attribution 4.0 International License.
.. http://creativecommons.org/licenses/by/4.0
.. _bbs-installation:

Installation
============

BBS-ep is delivered as a Spring-Boot application ready to be deployed in Docker (via docker-compose). 

The following docker-compose-yaml file shows a default configuration. The file can be run using `docker compose up` command:

.. code-block:: yaml

  version: '3'
  services:
    bbs-event-processor:
      image: onap/org.onap.dcaegen2.services.components.bbs-event-processor:latest
      container_name: bbs-event-processor
      hostname: bbs-event-processor
      ports:
      - 32100:8100
      environment:
        CONFIGS_DMAAP_CONSUMER_RE-REGISTRATION_DMAAPHOSTNAME: 10.133.115.190
        CONFIGS_DMAAP_CONSUMER_RE-REGISTRATION_DMAAPPORTNUMBER: 30227
        CONFIGS_DMAAP_CONSUMER_RE-REGISTRATION_DMAAPTOPICNAME: /events/unauthenticated.PNF_UPDATE
        CONFIGS_DMAAP_CONSUMER_RE-REGISTRATION_CONSUMERGROUP: foo
        CONFIGS_DMAAP_CONSUMER_RE-REGISTRATION_CONSUMERID: bar
        CONFIGS_DMAAP_CONSUMER_CPE-AUTHENTICATION_DMAAPHOSTNAME: 10.133.115.190
        CONFIGS_DMAAP_CONSUMER_CPE-AUTHENTICATION_DMAAPPORTNUMBER: 30227
        CONFIGS_DMAAP_CONSUMER_CPE-AUTHENTICATION_DMAAPTOPICNAME: /events/unauthenticated.CPE_AUTHENTICATION
        CONFIGS_DMAAP_CONSUMER_CPE-AUTHENTICATION_CONSUMERGROUP: foo
        CONFIGS_DMAAP_CONSUMER_CPE-AUTHENTICATION_CONSUMERID: bar
        CONFIGS_DMAAP_PRODUCER_DMAAPHOSTNAME: 10.133.115.190
        CONFIGS_DMAAP_PRODUCER_DMAAPPORTNUMBER: 30227
        CONFIGS_DMAAP_PRODUCER_DMAAPTOPICNAME: /events/unauthenticated.DCAE_CL_OUTPUT
        CONFIGS_AAI_CLIENT_AAIHOST: 10.133.115.190
        CONFIGS_AAI_CLIENT_AAIPORT: 30233
        CONFIGS_APPLICATION_PIPELINESPOLLINGINTERVALSEC: 30
        CONFIGS_APPLICATION_PIPELINESTIMEOUTSEC: 15
        CONFIGS_APPLICATION_RE-REGISTRATION_POLICYSCOPE: policyScope
        CONFIGS_APPLICATION_RE-REGISTRATION_CLCONTROLNAME: controlName
        CONFIGS_APPLICATION_CPE-AUTHENTICATION_POLICYSCOPE: policyScope
        CONFIGS_APPLICATION_CPE-AUTHENTICATION_CLCONTROLNAME: controlName
        CONFIGS_SECURITY_TRUSTSTOREPATH: KeyStore.jks
        CONFIGS_SECURITY_TRUSTSTOREPASSWORDPATH: KeyStorePass.txt
        CONFIGS_SECURITY_KEYSTOREPATH: KeyStore.jks
        CONFIGS_SECURITY_KEYSTOREPASSWORDPATH: KeyStorePass.txt
        LOGGING_LEVEL_ORG_ONAP_BBS: TRACE

BBS-ep can be dynamically deployed in DCAE’s Cloudify environment via its blueprint deployment artifact.

Blueprint can be found in

    https://git.onap.org/dcaegen2/platform/blueprints/tree/blueprints/k8s-bbs-event-processor.yaml

Steps to deploy are shown below

- Enter the Bootstrap POD
- Validate blueprint
    .. code-block:: bash
        
        cfy blueprints validate /blueprints/k8s-bbs-event-processor.yaml
- Upload validated blueprint
    .. code-block:: bash
        

        cfy blueprints upload -b bbs-ep /blueprints/k8s-bbs-event-processor.yaml
- Create deployment
    .. code-block:: bash
        

        cfy deployments create -b bbs-ep -i /blueprints/k8s-bbs-event-processor.yaml bbs-ep
- Deploy blueprint
    .. code-block:: bash
        

        cfy executions start -d bbs-ep install

To undeploy BBS-ep, steps are shown below

- Uninstall running BBS-ep and delete deployment
    .. code-block:: bash
        

        cfy uninstall bbs-ep
- Delete blueprint
    .. code-block:: bash
        

        cfy blueprints delete bbs-ep