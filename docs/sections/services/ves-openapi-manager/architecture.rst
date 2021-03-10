.. This work is licensed under a Creative Commons Attribution 4.0 International License.
.. http://creativecommons.org/licenses/by/4.0

.. _ves-openapi-manager-architecture:

Architecture of VES OpenAPI Manager
===================================
Functionalities of VES OpenAPI Manager require communication with other ONAP components. Because of that, SDC
Distribution Client has been used as a library to achieve such a communication. There are two components required by
application to work: SDC BE and Message Router. SDC Distribution Client provides communication with both of them when
it's properly configured (for application configuration instruction look here: :ref:`ves-openapi-manager-deployment` ).

.. image:: resources/architecture.png


.. _ves-openapi-manager-flow:

Workflow of VES OpenAPI Manager
-------------------------------
VES OpenAPI Manager workflow can be split into phases:
1) Listening for Service distributions
2) Optional downloading of artifacts depending on Service content. Service must contain VES_EVENT type artifacts.
3) Optional validation of artifacts depending on content of downloaded artifacts. Artifact must contain stndDefined
events.

VES OpenAPI Manager workflow is presented on the diagram below.
.. image:: resources/workflow.png

