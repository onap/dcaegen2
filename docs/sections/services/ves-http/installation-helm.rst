.. This work is licensed under a Creative Commons Attribution 4.0 International License.
.. http://creativecommons.org/licenses/by/4.0
.. _ves-installation-helm:

VES Collector Helm Installation
===============================

Authentication Support - Helm based deployment
----------------------------------------------

VES Collector support following authentication types

    * *auth.method=noAuth* - no security (http)
    * *auth.method=certBasicAuth* - is used to enable mutual TLS authentication or/and basic HTTPs authentication

Default ONAP deployed VESCollector is configured for "certBasicAuth".

The default behavior can be changed by upgrading dcaegen2-services deployment with custom values:
    .. code-block:: bash

        helm -n <namespace> upgrade <DEPLOYMENT_PREFIX>-dcaegen2-services --reuse-values --values <path to values> <path to dcaegen2-services helm charts>

For example:
    .. code-block:: bash

        helm -n onap upgrade dev-dcaegen2-services --reuse-values --values new-config.yaml oom/kubernetes/dcaegen2-services

Where the contents of ``new-config.yaml`` file is:
    .. code-block:: bash

        dcae-ves-collector:
          applicationConfig:
            auth.method: "noAuth"

For small changes like this, it is also possible to inline the new value:
    .. code-block:: bash

        helm -n onap upgrade dev-dcaegen2-services --reuse-values --set dcae-ves-collector.applicationConfig.auth.method="noAuth" oom/kubernetes/dcaegen2-services

After the upgrade, the new auth method value should be visible inside dev-dcae-ves-collector-application-config-configmap Config-Map.
It can be verified by running:

.. code-block:: bash

        kubectl -n onap get cm <config map name> -o yaml

For VES Collector:

.. code-block:: bash

        kubectl -n onap get cm dev-dcae-ves-collector-application-config-configmap -o yaml


.. _external-repo-schema-via-helm:

External repository schema files integration with VES Collector
---------------------------------------------------------------
In order to utilize the externalRepo openAPI schema files defined in `OOM <https://gerrit.onap.org/r/gitweb?p=oom.git;a=tree;f=kubernetes/dcaegen2-services/resources/external>`_ repository and installed with dcaegen2 module, follow below steps.

.. note:: 
  For more information on generating schema files, see `External-schema-repo-generator (OOM Utils repository) <https://gerrit.onap.org/r/gitweb?p=oom/utils.git;a=tree;f=external-schema-repo-generator>`_
  
  Default ONAP deployment for Istanbul release makes available the SA88-Rel16 OpenAPI schema files; optionally SA99-Rel16 files can be loaded using the `Generator script <https://gerrit.onap.org/r/gitweb?p=oom/utils.git;a=blob;f=external-schema-repo-generator/generator/generate.sh>`_ based on the steps documented in `README <https://git.onap.org/oom/utils/tree/external-schema-repo-generator/README.md>`_


1. Go to directory with dcaegen2-services helm charts (oom/kubernetes/dcaegen2-services). These charts should be located on RKE deployer node or server which is used to deploy and manage ONAP installation by Helm charts.
2. Create file with specific VES values-overrides:

.. code-block:: yaml

  dcae-ves-collector:
    externalVolumes:
      - name: '<config map name with schema mapping file>'
        type: configmap
        mountPath: <path on VES collector container where externalRepo schema-map is expected>
        optional: true
      - name: '<config map name contains schemas>'
        type: configmap
        mountPath: <path on VES collector container where externalRepo openAPI files are stored>
        optional: true

E.g:

.. code-block:: yaml

  dcae-ves-collector:
    externalVolumes:
      - name: 'dev-dcae-external-repo-configmap-schema-map'
        type: configmap
        mountPath: /opt/app/VESCollector/etc/externalRepo
        optional: true
      - name: 'dev-dcae-external-repo-configmap-sa88-rel16'
        type: configmap
        mountPath: /opt/app/VESCollector/etc/externalRepo/3gpp/rep/sa5/MnS/blob/SA88-Rel16/OpenAPI 
        optional: true

If more than a single external schema is required add new config map to object 'externalVolumes' like in above example. Make sure that all external schemas (all openAPI files) are reflected in the schema-map file.

3. Upgrade release using following command:

.. code-block:: bash

  helm -n <namespace> upgrade <dcaegen2-services release name> --reuse-values -f <path to values.yaml file created in previous step> <path to dcaegen2-services helm chart>

E.g:

.. code-block:: bash

  helm -n onap upgrade dev-dcaegen2-services --reuse-values -f values.yaml .


Using external TLS certificates obtained using CMP v2 protocol
--------------------------------------------------------------

In order to use the X.509 certificates obtained from the CMP v2 server (so called "operator`s certificates"), refer to the following description:

:ref:`Enabling TLS with external x.509 certificates <external-tls-helm>`

Example values for VES Collector:
    .. code-block:: bash

        global:
          cmpv2Enabled: true
        dcae-ves-collector:
          useCmpv2Certificates: true
          certificates:
          - mountPath: /opt/app/dcae-certificate/external
            commonName: dcae-ves-collector
            dnsNames:
              - dcae-ves-collector
              - ves-collector
              - ves
            keystore:
              outputType:
                - jks
              passwordSecretRef:
                name: ves-cmpv2-keystore-password
                key: password
                create: true

