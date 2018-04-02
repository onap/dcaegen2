
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

CDAP
----

Opensource Platform for development of Big Data platforms using Hadoop.
Some DCAE service components are written utilizing CDAP.

Cloudify
--------

Open Source application and network orchestration framework, based on
TOSCA used in DCAE to deploy platform and service components from
Cloudify Blueprints. Refer to :doc:`Architecture <./architecture/pieces>`
for more information.

Cloudify Blueprints
-------------------

YAML formatted file used by Cloudify to deploy platform and service
components. Contains all the information needed for installation.

Consul
------

Opensource Platform Component that supports Service Discovery,
Configuration, and Healthcheck. Refer to
:doc:`Architecture <./architecture/pieces>` for more information.

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

dcae_cli Tool
-------------

Tool used for development and testing. It validates the component and
data format specifications against their respective schemas and provides
the capability to view platform generated configuration for the
component.

Deployment Handler
------------------

DCAE Platform Component - talks to
Cloudify to deploy components.

Design-Time
-----------

Refers to when the System Designer uses the SDC Tool to compose services
from components in the SDC catalog. The Designer can provide input to
assign/override defaults for configuration for any parameter with the
property ‘designer_editable’ set to ‘true’.

Deploy-Time
-----------

Refers to when a service is being deployed. This can be done
automatically via the SDC Tool, or manually via the DCAE Dashboard or
CLAMP UI. When manually deployed, DevOps can provide input to
assign/override defaults for configuration for any parameter with the
property ‘sourced_at_deployment’ set to ‘true’.

Docker
------

Opensource Platform for development of containerized applications in the
cloud. Many DCAE service components and all DCAE collectors are written
utilizing Docker.

Dmaap
-----

A data transportation service platform that supports message-based
topics and file-based feeds. Runs locally at the Edge and Centrally.

Inventory
---------

DCAE Platform Component - Postgres DB containing Cloudify Blueprints for
platform and service components.

Onboarding catalog
------------------

Catalog used exclusively by the dcae_cli tool during development and
testing. Contains validated components and data_formats to be used among
developers during development and testing.

Policy (not yet implemented)
----------------------------

Refers to the setting of configuration parameters for a component, by
Operations via the Policy UI.

Policy Handler (not yet implemented)
------------------------------------

DCAE Platform Component that received Policy updates from Policy UI

Policy UI (not yet implemented)
-------------------------------

Non DCAE Component - Policy User Interace where Operations assigns
values to configuraton specified for this.

Run-Time
--------

Refers to the when a service is running on the platform. 

SCH - Service Change Handler
----------------------------

DCAE Platform Component - Receives updates from SDC and updates
Inventory

SDC - Service Design and Creation - (formerly ASDC)
---------------------------------------------------

Tool used by Service Designers to compose services from SDC catalog
artifacts. Once services are created, Cloudify Blueprints can be
generated to deployment and installation.

SDC Catalog
-----------

Catalog of composable Components and Data Formats to be used in the SDC
Tool to create services. Currently, there is no access to the SDC
Catalog from the dcae_cli tool. Artifacts are manually placed there
after testing. Every catalog artifact has a ``UUID``, a globally unique
identifier that identifies that artifact.

Self-Service
------------

Refers to services that are supported by SDC, and that are automatically
installed as a result of a Service Designer’s composition and submission
of a service. Only a handful of services are ‘self-service’ currently.
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

Tosca Model
-----------

Model generated from validately component specification, (stored in SDC
catalog for Self-Service components), and used as input to generate
Cloudify Blueprints

VNF - Virtualized Network Function
----------------------------------

A network function that runs on one or more virtualized machines.
