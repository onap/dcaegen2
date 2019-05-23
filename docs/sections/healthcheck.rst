.. This work is licensed under a Creative Commons Attribution 4.0 International License.
.. http://creativecommons.org/licenses/by/4.0

DCAE Health Check
=================

OOM Deployment
--------------
In OOM deployments, DCAE healthchecks are performed by a separate service--dcae-healthcheck.
This service is packaged into a Docker image (``onap/org.onap.dcaegen2.deployments.healthcheck-container``),
which is built in the ``healthcheck-container`` module in the ``dcaegen2/deployments`` repository.

The service is deployed with a Helm chart (``oom/kubernetes/dcaegen2/charts/dcae-healthcheck``)
when DCAE is deployed using OOM.

The dcae-healthcheck container runs a service that exposes a simple Web API.  In response to
request, the service checks Kubernetes to verify that all of the expected
DCAE platform and service components are in a ready state.  The service
has a fixed list of platform and service components that are normally deployed when DCAE is
first installed, including components deployed with Helm charts and
components deployed using Cloudify blueprints.   In addition, beginning with
the Dublin release, the healthcheck
service tracks and checks components that are deployed dynamically using Cloudify
blueprints after the initial DCAE installation.

The healthcheck service is exposed as a Kubernetes ClusterIP Service named
`dcae-healthcheck`.   The service can be queried for status as shown below.

.. code-block:: json

   $ curl dcae-healthcheck
   {
     "type": "summary",
     "count": 14,
     "ready": 14,
     "items": [
        {
          "name": "dev-dcaegen2-dcae-cloudify-manager",
          "ready": 1,
          "unavailable": 0
        },
        {
          "name": "dev-dcaegen2-dcae-config-binding-service",
          "ready": 1,
          "unavailable": 0
        },
        {
          "name": "dev-dcaegen2-dcae-inventory-api",
          "ready": 1,
          "unavailable": 0
        },
        {
          "name": "dev-dcaegen2-dcae-servicechange-handler",
          "ready": 1,
          "unavailable": 0
        },
        {
          "name": "dev-dcaegen2-dcae-deployment-handler",
          "ready": 1,
          "unavailable": 0
        },
        {
          "name": "dev-dcaegen2-dcae-policy-handler",
          "ready": 1,
          "unavailable": 0
        },
        {
          "name": "dep-dcae-ves-collector",
          "ready": 1,
          "unavailable": 0
        },
        {
          "name": "dep-dcae-tca-analytics",
          "ready": 1,
          "unavailable": 0
        },
        {
          "name": "dep-dcae-prh",
          "ready": 1,
          "unavailable": 0
        },
        {
          "name": "dep-dcae-hv-ves-collector",
          "ready": 1,
          "unavailable": 0
        },
        {
          "name": "dep-dcae-dashboard",
          "ready": 1,
          "unavailable": 0
        },
        {
          "name": "dep-dcae-snmptrap-collector",
          "ready": 1,
          "unavailable": 0
        },
        {
          "name": "dep-holmes-engine-mgmt",
          "ready": 1,
          "unavailable": 0
        },
        {
          "name": "dep-holmes-rule-mgmt",
          "ready": 1,
          "unavailable": 0
        }
      ]
    }
