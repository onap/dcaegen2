.. This work is licensed under a Creative Commons Attribution 4.0 International License.
.. http://creativecommons.org/licenses/by/4.0

.. _pmsh-installation:

Installation
============

In Guilin, the PMSH can be deployed using the DCAE Dashboard or via CLI. Steps to deploy using CLI will be shown
below.

Deployment Prerequisites
^^^^^^^^^^^^^^^^^^^^^^^^

In order to successfully deploy the PMSH, one will need administrator access to the kubernetes cluster, as the following
procedure will be run from the dcae-bootstrap pod.
As well as this, the following components are required to be running. They can be verified by running the health checks.

    - DCAE Platform
    - DMaaP
    - A&AI
    - AAF

The robot healthcheck can be run from one of the Kubernetes controllers.

.. code-block:: bash

        ./oom/kubernetes/robot/ete-k8s.sh onap health

Deployment Procedure
^^^^^^^^^^^^^^^^^^^^

To deploy the PMSH in the Frankfurt release, the monitoring policy needs to be pushed directly to CONSUL.
To begin, kubectl exec on to the dcae-bootstrap pod and move to the /tmp directory.

.. code-block:: bash

        kubectl exec -itn <onap-namespace> onap-dcae-bootstrap bash

For information on creating a monitoring policy see :ref:`Subscription configuration<Subscription>`.

The following JSON is an example monitoring policy.

.. literalinclude:: resources/monitoring-policy.json
    :language: json

The monitoring-policy.json can then be PUT with the following curl request.

.. code-block:: bash

        curl -X PUT http://consul:8500/v1/kv/dcae-pmsh:policy \
            -H 'Content-Type: application/json' \
            -d @monitoring-policy.json

To deploy the PMSH microservice using the deployment handler API, the ``serviceTypeId`` is needed. This can be retrieved
using the inventory API.

.. code-block:: bash

        curl -k https://inventory:8080/dcae-service-types \
            | grep k8s-pmsh | jq '.items[] | select(.typeName == "k8s-pmsh") | .typeId'

Finally, deploy the PMSH via dcae deployment handler.

.. code-block:: bash

        curl -k https://deployment-handler:8443/dcae-deployments/dcae-pmsh \
            -H 'Content-Type: application/json' \
            -d '{
                "inputs": (),
                "serviceTypeId": "<k8s-pmsh-typeId>"
            }'
