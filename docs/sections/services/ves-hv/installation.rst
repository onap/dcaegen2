.. This work is licensed under a Creative Commons Attribution 4.0 International License.
.. http://creativecommons.org/licenses/by/4.0

.. _installation:

HV-VES Cloudify Installation
============================

Starting from ONAP/Honolulu release, HV-VES is installed with a DCAEGEN2-Services Helm charts.
This installation mechanism is convenient, but it doesn`t support all HV-VES features (e.g. CMP v2 certificates, and IPv4/IPv6 dual stack networking). This description demonstrates, how to deploy HV-VES collector using Cloudify orchestrator.

Setting insecure mode for testing
---------------------------------

HV-VES application is configured by default to use TLS/SSL encryption on TCP connection. 

Accessing bootstrap container with Kubernetes command line tool
---------------------------------------------------------------

To find bootstrap pod, execute the following command:

::

    kubectl -n <onap namespace> get pods | grep bootstrap

To run command line in bootstrap pod, execute:

::

    kubectl -n <onap namespace> exec -it <bootstrap-pod-name> bash


Install HV-VES collector using Cloudify blueprint inputs
---------------------------------------------------------

1. If You have a running HV-VES instance, uninstall HV-VES and delete current deployment:

:: 

    cfy executions start -d hv-ves uninstall
    cfy deployments delete hv-ves 

2. Create new deployment with inputs from yaml file (available by default in bootstrap container):

:: 

    cfy deployments create -b hv-ves -i inputs/k8s-hv_ves-inputs.yaml hv-ves

In order to disable the TLS security, override the 'secuirty_ssl_disable' value in the deloyment:

::

    cfy deployments create -b hv-ves -i inputs/k8s-hv_ves-inputs.yaml -i security_ssl_disable=True hv-ves

To verify inputs, You can execute: 

:: 

    cfy deployments inputs hv-ves

3. Install HV-VES deployment:

:: 

    cfy executions start -d hv-ves install


Using external TLS certificates obtained using CMP v2 protocol
--------------------------------------------------------------

In order to use the X.509 certificates obtained from the CMP v2 server (so called "operator`s certificates"), refer to the following description:

.. toctree::
    :maxdepth: 1

     Enabling TLS with external x.509 certificates <../../tls_enablement>
