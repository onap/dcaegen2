.. This work is licensed under a Creative Commons Attribution 4.0 International License.
.. http://creativecommons.org/licenses/by/4.0
.. _ves-installation:


VES Collector Cloudify Installation
===================================

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
    .. note::
      For doing this, follow the below steps

      * First get the bootstrap pod name by running this: kubectl get pods -n onap | grep bootstrap
      * Then login to bootstrap pod by running this: kubectl exec -it <bootstrap pod> -n onap -- bash

- VES blueprint is available under  /blueprints directory ``k8s-ves.yaml``. A corresponding input file is also pre-loaded into bootstrap pod under /inputs/k8s-ves-inputs.yaml

- Deploy blueprint
    .. code-block:: bash

        cfy install -b ves-http -d ves-http -i /inputs/k8s-ves-inputs.yaml /blueprints/k8s-ves.yaml

To undeploy ves-http, steps are noted below

- Uninstall running ves-http and delete deployment
    .. code-block:: bash

        cfy uninstall ves-http

The deployment uninstall will also delete the blueprint. In some case you might notice 400 error reported indicating active deployment exist such as below
** An error occurred on the server: 400: Can't delete blueprint ves-http - There exist deployments for this blueprint; Deployments ids: ves-http**

In this case blueprint can be deleted explicitly using this command.

    .. code-block:: bash

        cfy blueprint delete ves-http

External repo schema files from OOM connection to VES collector
-------------------------------------------------------------------
In order to not use schema files bundled in VES Collector image but schema files defined in `OOM <https://gerrit.onap.org/r/gitweb?p=oom.git;a=tree;f=kubernetes/dcaegen2/resources/external>`_ repository and installed with dcaegen2 module, follow below setup.

- Execute into Bootstrap POD using kubectl command
    .. note::
      For doing this, follow the below steps

      * First get the bootstrap pod name by running this: kubectl get pods -n onap | grep bootstrap
      * Then login to bootstrap pod by running this: kubectl exec -it <bootstrap pod> -n onap -- bash

- VES blueprint is available under  /blueprints directory ``k8s-ves.yaml``. A corresponding input file is also pre-loaded into bootstrap pod under /inputs/k8s-ves-inputs.yaml

- Edit ``k8s-ves.yaml`` blueprint by adding section below ``docker_config:`` tag:
    .. code-block:: bash

        volumes:
        - container:
            bind: /opt/app/VESCollector/etc/externalRepo/3gpp/rep/sa5/MnS/blob/SA88-Rel16/OpenAPI
          config_volume:
            name: dcae-external-repo-configmap-sa88-rel16
        - container:
            bind: /opt/app/VESCollector/etc/externalRepo/
          config_volume:
            name: dcae-external-repo-configmap-schema-map

- After all ``docker_config:`` section in blueprint should looks like:
    .. code-block:: bash

      docker_config:
        healthcheck:
          endpoint: /healthcheck
          interval: 15s
          timeout: 1s
          type: http
        volumes:
        - container:
            bind: /opt/app/VESCollector/etc/externalRepo/3gpp/rep/sa5/MnS/blob/SA88-Rel16/OpenAPI
          config_volume:
            name: dcae-external-repo-configmap-sa88-rel16
        - container:
            bind: /opt/app/VESCollector/etc/externalRepo/
          config_volume:
            name: dcae-external-repo-configmap-schema-map

.. note::

    To undeploy ves-http if it is deployed, steps are noted below

    Uninstall running ves-http and delete deployment
        .. code-block:: bash

            cfy uninstall ves-http

    The deployment uninstall will also delete the blueprint. In some case you might notice 400 error reported indicating active deployment exist such as below
    ** An error occurred on the server: 400: Can't delete blueprint ves-http - There exist deployments for this blueprint; Deployments ids: ves-http**

    In this case blueprint can be deleted explicitly using this command.

        .. code-block:: bash

            cfy blueprint delete ves-http

To deploy modified ves-http, steps are noted below

- Load blueprint:
    .. code-block:: bash

        cfy blueprints upload -b ves-http /blueprints/k8s-ves.yaml

- Deploy blueprint
    .. code-block:: bash

        cfy install -b ves-http -d ves-http -i /inputs/k8s-ves-inputs.yaml /blueprints/k8s-ves.yaml

Using external TLS certificates obtained using CMP v2 protocol
--------------------------------------------------------------

In order to use the X.509 certificates obtained from the CMP v2 server (so called "operator`s certificates"), refer to the following description:

.. toctree::
    :maxdepth: 1

      Enabling TLS with external x.509 certificates <../../tls_enablement>
