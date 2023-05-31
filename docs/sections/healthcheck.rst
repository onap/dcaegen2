.. This work is licensed under a Creative Commons Attribution 4.0 International License.
.. http://creativecommons.org/licenses/by/4.0
.. _healthcheck:

DCAE Health Check
=================


HealthCheck Services
--------------------

DCAE healthchecks are performed by a separate services.

- dcae-ms-healthcheck
- dcaemod-healthcheck
 
These service is packaged into a Docker image (``onap/org.onap.dcaegen2.deployments.healthcheck-container``),
which is built in the ``healthcheck-container`` module in the ``dcaegen2/deployments`` repository.

dcae-ms-healthcheck is deployed along with services enabled under (``oom/kubernetes/dcaegen2-services``)
dcaemod-healthcheck is deployed along with services enabled under (``oom/kubernetes/dcaemod``)

These healthcheck container runs as service that exposes a simple Web API.  In response to
request, the service checks Kubernetes to verify that all of the expected
DCAE platform and service components are in a ready state.

The service has a fixed list service components identified by json file -  `expected-components.json <https://github.com/onap/oom/blob/master/kubernetes/dcaegen2-services/resources/expected-components.json>`_
; these are normally deployed when dcaegen2-services is installed. In addition, the healthcheck service also tracks and checks components that are deployed dynamically after the initial DCAE installation.

The healthcheck service is exposed as a Kubernetes ClusterIP Service named
`dcae-ms-healthcheck`.   The service can be queried for status as shown below.

.. note::
  Run the below commands before running "curl dcae-ms-healthcheck"

  * To get the dcae-ms-healthcheck pod name, run following command: 

  .. code-block:: bash

    kubectl  get pods -n onap | grep dcae-ms-healthcheck

  * Then enter in to the shell of the container, run the following command (substituting the pod name retrieved by the previous command):

  .. code-block:: bash

    kubectl exec -it <dcae-ms-healthcheck pod> -n onap bash


.. code-block:: json

   $ curl dcae-ms-healthcheck
   {
      "type": "summary",
      "count": 5,
      "ready": 5,
      "items": [{
            "name": "onap-dcae-hv-ves-collector",
            "ready": 1,
            "unavailable": 0
       }, 
       {
            "name": "onap-dcae-prh",
            "ready": 1,
            "unavailable": 0
       },
       {
            "name": "onap-dcae-tcagen2",
            "ready": 1,
            "unavailable": 0
       },
       {
            "name": "onap-dcae-ves-collector",
            "ready": 1,
            "unavailable": 0
       },
       {
            "name": "onap-dcae-ves-openapi-manager",
            "ready": 1,
            "unavailable": 0
       }
    ]
 }

 
The dcaemod-healthcheck service is also exposed as a Kubernetes ClusterIP Service named
`dcaemod-healthcheck`.   The service can be queried similar to `dcae-ms-healthcheck`
