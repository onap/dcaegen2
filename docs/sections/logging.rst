.. This work is licensed under a Creative Commons Attribution 4.0 International License.
.. http://creativecommons.org/licenses/by/4.0

Logging
=======

DCAE logging is available in several levels; most DCAE Components are complaint with EELF logging standard and generates debug, audit, metric logging.


Platform Components Logging
---------------------------
As all the platform components are containered and deployed under K8S as pod; corresponding log information can be accessed using ``kubectl get logs -n onap <pod_name>``

More detailed audit/debug logs can be found within the pod.


Component Logging
-----------------

Please refer to individual service component webpage for more information. In general the logs of service component can be accessed using ``kubectl get logs -n onap <pod_name>``
