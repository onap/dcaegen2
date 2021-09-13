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

