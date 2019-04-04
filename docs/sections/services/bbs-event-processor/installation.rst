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
      CONFIGS_APPLICATION_RE-REGISTRATION_CLCONTROLNAME: controName
      CONFIGS_APPLICATION_CPE-AUTHENTICATION_POLICYSCOPE: policyScope
      CONFIGS_APPLICATION_CPE-AUTHENTICATION_CLCONTROLNAME: controlName
      LOGGING_LEVEL_ORG_ONAP_BBS: TRACE

For Dublin release, it will be a DCAE component that can dynamically be deployed via Cloudify blueprint installation.
Steps to deploy are shown below

- Transfer blueprint component file in DCAE bootstrap POD under /blueprints directory. Blueprint can be found in
  https://gerrit.onap.org/r/gitweb?p=dcaegen2/services.git;a=blob_plain;f=components/bbs-event-processor/dpo/blueprints/k8s-bbs-event-processor.yaml-template;hb=refs/heads/master
- Transfer blueprint component inputs file in DCAE bootstrap POD under / directory. Blueprint inputs file can be found in
  https://gerrit.onap.org/r/gitweb?p=dcaegen2/services.git;a=blob_plain;f=components/bbs-event-processor/dpo/blueprints/bbs-event-processor-input.yaml;h=36e69cf64bee3b46ee2e1b95f1a16380b7046482;hb=refs/heads/master
- Enter the Bootstrap POD
- Validate blueprint
    cfy blueprints validate /blueprints/k8s-bbs-event-processor.yaml-template
- Upload validated blueprint
    cfy blueprints upload -b bbs-ep /blueprints/k8s-bbs-event-processor.yaml-template
- Create deployment
    cfy deployments create -b bbs-ep -i /bbs-event-processor-input.yaml bbs-ep
- Deploy blueprint
    cfy executions start -d bbs-ep install

To undeploy BBS-ep, steps are shown below

- Validate blueprint by running command
    cfy uninstall bbs-ep
- Validate blueprint by running command
    cfy blueprints delete bbs-ep