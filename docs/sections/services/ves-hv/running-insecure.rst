.. This work is licensed under a Creative Commons Attribution 4.0 International License.
.. http://creativecommons.org/licenses/by/4.0

.. _running_insecure:

Running insecure HV-VES in test environments
============================================

It is posible to turn off SSL authorization by overriding inputs


**For K8s usage of cloudify**


Find bootstrap pod e.g:

::

    kubectl -n onap get pods | grep bootstrap

And run command line in bootstrap pod e.g:

::

    kubectl -n onap exec -it dev-dcae-bootstrap-546656c4ff-n49sn bash


**Disable SSL by overriding inputs**


1. Uninstall hv-ves and delete current deployment :

:: 

    cfy executions start -d hv-ves uninstall
    cfy deployments delete hv-ves 

2. Create deployment with inputs from yaml file and override 'security_ssl_disable' value:

:: 

    cfy deployments create -b hv-ves -i inputs/k8s-hv_ves-inputs.yaml -i security_ssl_disable=True hv-ves

To verify inputs use: 

:: 

    cfy deployments inputs hv-ves

3. Install hv-ves 

:: 

    cfy executions start -d hv-ves install




