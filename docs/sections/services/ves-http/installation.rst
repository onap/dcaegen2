.. This work is licensed under a Creative Commons Attribution 4.0 International License.
.. http://creativecommons.org/licenses/by/4.0
.. _ves-installation:


Installation
============

VESCollector is installed via cloudify blueprint by DCAE bootstrap process on typical ONAP installation.
As the service is containerized, it can be started on stand-alone mode also.


To run VES Collector container on standalone mode, following parameters are required

    ``docker run -d -p 8080:8080/tcp -p 8443:8443/tcp -P -e DMAAPHOST='10.0.11.1' nexus.onap.org:10001/onap/org.onap.dcaegen2.collectors.ves.vescollector:1.7.9``


DMAAPHOST is required for standalone; for normal platform installed instance the publish URL are obtained from Consul. Below parameters are exposed for DCAE platform (cloudify) deployed instance


- COLLECTOR_IP
- DMAAPHOST - should contain an address to DMaaP, so that event publishing can work
- CONFIG_BINDING_SERVICE - should be a name of CBS
- CONFIG_BINDING_SERVICE_SERVICE_PORT - should be a http port of CBS
- HOSTNAME - should be a name of VESCollector application as it is registered in CBS catalog

These parameters can be configured either by passing command line option during `docker run` call or by specifying environment variables named after command line option name


Authentication Support
----------------------

VES Collector support following authentication types

    * *auth.method=noAuth* default option - no security (http)
    * *auth.method=certBasicAuth* is used to enable mutual TLS authentication or/and basic HTTPs authentication

The blueprint is same for both deployments - based on the input configuration, VESCollector can be set for required authentication type.
Default ONAP deployed VESCollector is configured for "certBasicAuth".

If VESCollector instance need to be deployed with authentication disabled, follow below setup


- Execute into Bootstrap POD using kubectl command

- VES blueprint is available under  /blueprints directory ``k8s-ves-tls.yaml``. A corresponding input file is also pre-loaded into bootstrap pod under /inputs/k8s-ves-inputs.yaml

- Deploy blueprint
    .. code-block:: bash

        cfy install -b ves-http -d ves-http -i /inputs/k8s-ves-inputs.yaml /blueprints/k8s-ves-tls.yaml

To undeploy ves-http, steps are noted below

- Uninstall running ves-http and delete deployment
    .. code-block:: bash

        cfy uninstall ves-http

The deployment uninstall will also delete the blueprint. In some case you might notice 400 error reported indicating active deployment exist such as below
** An error occurred on the server: 400: Can't delete blueprint ves-http - There exist deployments for this blueprint; Deployments ids: ves-http**

In this case blueprint can be deleted explicitly using this command.

    .. code-block:: bash

        cfy blueprint delete ves-http

