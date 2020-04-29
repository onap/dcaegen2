
.. http://creativecommons.org/licenses/by/4.0

.. _glossary:

Glossary
========

A&AI - Active and Available Inventory
-------------------------------------
Inventory DB for all network components


CLAMP
-----
Non DCAE Platform Component - Controls the input and processing for
Closed Loop services.


Closed Loop
-----------
Services designed to monitor and report back to a controlling function
that automatically deals with the event reported without human
interaction.



Cloudify
--------
Open Source application and network orchestration framework, based on
TOSCA used in DCAE to deploy platform and service components from
Cloudify Blueprints. Refer to `Architecture </architecture/pieces>`__
for more information.


Cloudify Blueprints
-------------------
YAML formatted file used by Cloudify to deploy platform and service
components. Contains all the information needed for installation.


Consul
------
Opensource Platform Component that supports Service Discovery,
Configuration, and Healthcheck. Refer to
`Architecture </architecture/pieces>`__ for more information.

Component
---------
Refers to a DCAE service component which is a single micro-service that
is written to be run by the DCAE platform and to be composeable to form
a DCAE service. That composition occurs in the SDC.


Config Binding Service
----------------------
DCAE Platform Component - Service Components use Config Binding Service
to access Consul and retrieve configuration variables.


Component Specification
-----------------------
JSON formatted file that fully describes a component and its interfaces


Data Format / Data Format Specification
---------------------------------------
JSON formatted file that fully describes a components input or output


Deployment Handler
------------------
DCAE Platform Component - Receives Input from DTI Handler, and talks to
Cloudify to deploy components.


Design-Time
-----------
Refers to when the System Designer uses design Tool to compose services
from components in the catalog. The Designer can provide input to
assign/override defaults for configuration for any parameter with the
property 'designer\_editable' set to 'true'.


Deploy-Time
-----------
Refers to when a service is being deployed. This can be done
automatically via the SDC Tool, or manually via the DCAE Dashboard or
CLAMP UI. When manually deployed, DevOps can provide input to
assign/override defaults for configuration for any parameter with the
property 'sourced\_at\_deployment' set to 'true'.


Docker
------
Opensource Platform for development of containerized applications in the
cloud. Many DCAE service components and all DCAE collectors are written
utilizing Docker.


Dmaap
-----
AT&T data transportation service platform that supports message-based
topics and file-based feeds. Runs locally at the Edge and Centrally.


Inventory
---------
DCAE Platform Component - Postgres DB containing Cloudify Blueprints for
platform and service components.


Policy
------
Refers to the setting of configuration parameters for a component, by
Operations via the Policy UI.


Policy Handler
--------------
DCAE Platform Component that received Policy updates from Policy UI


Policy UI
---------
Non DCAE Component - Policy User Interace where Operations assigns
values to configuraton specified for this.


Run-Time
--------
Refers to the when a service is running on the platform. Often used in
conjunction with DTI events which occur at Run-time.


SCH - Service Change Handler
----------------------------
DCAE Platform Component - Receives updates from SDC and updates
Inventory


SDC - Service Design and Creation
---------------------------------
ONAP design catalog for onboarding VNF/PNF packages


Self-Service
------------
Refers to services that are supported by SDC, and that are automatically
installed as a result of a Service Designer's composition and submission
of a service. Only a handful of services are 'self-service' currently.
Most require manual effort to generate the Tosca Model files and
Cloudify Blueprints.


Service Component
-----------------
Microservice that provides network monitoring or analytic function on
the DCAE platform.


Service
-------
Generally composed of multiple service components, which is deployed to
the DCAE platform.


VNF - Virtualized Network Function
----------------------------------
A network function that runs on one or more virtualized machines.
