.. This work is licensed under a Creative Commons Attribution 4.0 International License.
.. http://creativecommons.org/licenses/by/4.0

.. _running_insecure:

Running insecure HV-VES in test environments
============================================

HV-VES application is configured by default to use TLS/SSL encryption on TCP connection. However it is posible to turn off TLS/SSL authorization by overriding Cloudify blueprint inputs.


Accessing bootstrap container with Kubernetes command line tool
---------------------------------------------------------------

To find bootstrap pod, execute the following command:

::

    kubectl -n <onap namespace> get pods | grep bootstrap

To run command line in bootstrap pod, execute:

::

    kubectl -n <onap namespacep> exec -it <bootstrap-pod-name> bash


Disable TLS/SSL by overriding Cloudify blueprint inputs
-------------------------------------------------------

1. If You have a running HV-VES instance, uninstall HV-VES and delete current deployment:

:: 

    cfy executions start -d hv-ves uninstall
    cfy deployments delete hv-ves 

2. Create new deployment with inputs from yaml file and override 'security_ssl_disable' value:

:: 

    cfy deployments create -b hv-ves -i inputs/k8s-hv_ves-inputs.yaml -i security_ssl_disable=True hv-ves

To verify inputs, You can execute: 

:: 

    cfy deployments inputs hv-ves

3. Install HV-VES instance:

:: 

    cfy executions start -d hv-ves install




