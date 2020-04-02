.. This work is licensed under a Creative Commons Attribution 4.0 International License.
.. http://creativecommons.org/licenses/by/4.0

.. _Installation:

Installation
============

Due to a bug in the Frankfurt release, the PMSH cannot be deployed through CLAMP. The PMSH can instead be deployed
using the DCAE Dashboard or via CLI. Steps to deploy using CLI will be shown below.

Deployment Prerequisites
^^^^^^^^^^^^^^^^^^^^^^^^

In order to successfully deploy the PMSH, the following components are required to be running. They
can be verified by running the health checks.

    - DCAE Platform
    - DMaaP
    - A&AI
    - AAF

Deployment Procedure
^^^^^^^^^^^^^^^^^^^^

To deploy the PMSH in the Frankfurt release, the monitoring policy needs to be pushed directly to CONSUL. The CONSUL
service must first be exposed.

.. code-block:: bash

        kubectl expose svc -n onap consul-server-ui --name=x-consul-server-ui --type=NodePort

The monitoring policy can then be pushed with the following request, for information on creating a monitoring policy see
See :ref:`Subscription configuration<Subscription>`

.. code-block:: bash

        curl -X PUT http://<k8s-node-ip>:<consul-port>/v1/kv/dcae-pmsh:policy \
            -H 'Content-Type: application/json' \
            -d @monitoring-policy.json

To deploy the PMSH microservice using the deployment handler API, the ``serviceTypeId`` is needed, this can be retrieved
using the inventory API

.. code-block:: bash

        curl https://<k8s-node-ip>:<inventory-port>/dcae-service-types

The ``serviceTypeId`` for the PMSH can be found under typeID. The PMSH can then be deployed.

.. code-block:: bash

        curl https://<k8s-node-ip>:<dep-handler-port>/dcae-deployments/dcae-pmsh \
            -H 'Content-Type: application/json' \
            -d '{
                "inputs": (),
                "serviceTypeId": "<typeId>"
            }'