.. This work is licensed under a Creative Commons Attribution 4.0 International License.
.. http://creativecommons.org/licenses/by/4.0
.. _hv-ves-installation-helm:

HV-VES Helm Installation
========================
Starting from ONAP/Honolulu release, HV-VES is installed with a DCAEGEN2-Services Helm charts.
HV-VES application is configured by default to use TLS/SSL encryption on TCP connection.

Disable TLS security - Helm based deployment
--------------------------------------------


The default behavior can be changed by upgrading dcaegen2-services deployment with custom values:
    .. code-block:: bash

        helm -n <namespace> upgrade <DEPLOYMENT_PREFIX>-dcaegen2-services --reuse-values --values <path to values> <path to dcaegen2-services helm charts>

For example:
    .. code-block:: bash

        helm -n onap upgrade dev-dcaegen2-services --reuse-values --values new-config.yaml oom/kubernetes/dcaegen2-services

Where the contents of ``new-config.yaml`` file is:
    .. code-block:: yaml

        dcae-hv-ves-collector:
          applicationConfig:
            security.sslDisable: true

For small changes like this, it is also possible to inline the new value:
    .. code-block:: bash

        helm -n onap upgrade dev-dcaegen2-services --reuse-values --set dcae-hv-ves-collector.applicationConfig.security.sslDisable="true" oom/kubernetes/dcaegen2-services

After the upgrade, the security.sslDisable property should be changed and visible inside dev-dcae-ves-collector-application-config-configmap Config-Map.
It can be verified by running:

    .. code-block:: bash

        kubectl -n onap get cm <config map name> -o yaml

For HV-VES Collector:

    .. code-block:: bash

        kubectl -n onap get cm dev-dcae-hv-ves-collector-application-config-configmap -o yaml


For apply new configuration by HV-VES Collector the application restart might be necessary. It could be done by HV-VES helm reinstallation:

    .. code-block:: bash

        helm -n onap upgrade dev-dcaegen2-services --reuse-values --set dcae-hv-ves-collector.enabled="false" oom/kubernetes/dcaegen2-services
        helm -n onap upgrade dev-dcaegen2-services --reuse-values --set dcae-hv-ves-collector.enabled="true" oom/kubernetes/dcaegen2-services


Using external TLS certificates obtained using CMP v2 protocol
--------------------------------------------------------------

In order to use the X.509 certificates obtained from the CMP v2 server (so called "operator`s certificates"), refer to the following description:

:ref:`Enabling TLS with external x.509 certificates <tls_enablement>`

Example values for HV-VES Collector:

    .. code-block:: yaml

        global:
          cmpv2Enabled: true
        dcae-ves-collector:
          useCmpv2Certificates: true
          certificates:
          - mountPath: /etc/ves-hv/ssl/external
            commonName: dcae-hv-ves-collector
            dnsNames:
              - dcae-hv-ves-collector
              - hv-ves-collector
              - hv-ves
            keystore:
              outputType:
                - jks
              passwordSecretRef:
                name: hv-ves-cmpv2-keystore-password
                key: password
                create: true
