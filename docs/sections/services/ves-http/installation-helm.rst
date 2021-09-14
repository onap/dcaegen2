.. This work is licensed under a Creative Commons Attribution 4.0 International License.
.. http://creativecommons.org/licenses/by/4.0
.. _ves-installation-helm:

VES Collector Helm Installation
===============================

Authentication Support - Helm based deployment
----------------------------------------------

VES Collector support following authentication types

    * *auth.method=noAuth* default option - no security (http)
    * *auth.method=certBasicAuth* is used to enable mutual TLS authentication or/and basic HTTPs authentication

Default ONAP deployed VESCollector is configured for "certBasicAuth".

The default behavior can be changed by upgrading dcaegen2-services deployment with custom values:
    .. code-block:: bash

        helm -n onap upgrade dev-dcaegen2-services --values <path to values>

Where the contents of custom values file is:
    .. code-block:: bash

        dcae-ves-collector:
          applicationConfig:
            auth.method: "noAuth"

After the upgrade, the new auth method value should be visible inside dcae-ves-collector-application-config Config-Map.
It can be verified by running:
    .. code-block:: bash

        kubectl -n onap get cm <config map name> -o yaml



.. _external-repo-schema-via-helm:

External repo schema files from OOM connection to VES collector
-------------------------------------------------------------------
In order to not use schema files bundled in VES Collector image but schema files defined in `OOM <https://gerrit.onap.org/r/gitweb?p=oom.git;a=tree;f=kubernetes/dcaegen2/resources/external>`_ repository and installed with dcaegen2 module, follow below setup.

1. Go to diretcory with dcaegen2-services (oom/kubernete/dcaegen2-services)
2. Create file with VES values:

.. code-block:: yaml

  dcae-ves-collector:
    externalVolumes:
      - name: '<config map name with schema mapping file>'
        type: configmap
        mountPath: <path on VES collector container>
        optional: true
      - name: '<config map name contains schemas>'
        type: configmap
        mountPath: <path on VES collector container>
        optional: true

E.g:

.. code-block:: yaml

  dcae-ves-collector:
    externalVolumes:
      - name: 'dev-dcae-external-repo-configmap-schema-map'
        type: configmap
        mountPath: /opt/app/VESCollector/etc/externalRepo
        optional: true
      - name: 'dev-dcae-external-repo-configmap-sa91-rel16'
        type: configmap
        mountPath: /opt/app/VESCollector/etc/externalRepo/3gpp/rep/sa5/MnS/blob/Rel-16-SA-91/OpenAPI
        optional: true

For use more schemas add new config map to object 'externalVolumes' like in above example.

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

