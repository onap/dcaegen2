.. This work is licensed under a Creative Commons Attribution 4.0 International License.
.. http://creativecommons.org/licenses/by/4.0

.. _intro:


Overview
========

DCAE components are services that provide a specific functionality and
are generally written to be composable with other DCAE components,
although a component can run independently as well. The DCAE platform is
responsible for running and managing DCAE service components reliably.

Currently, the DCAE platform supports two types of components, CDAP
applications and Docker containers. For each, there are requirements
that must be met for the component to integrate into the DCAE platform
(see :doc:`Docker <component-type-docker>`).

A Component requires one or more data formats.
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

A component is a software application that performs a function. It
doesn’t run independently; it depends upon other components. A
component’s function could require connecting to other components to
fulfill that function. A component could also be providing its function
as a service through an interface for other components to use.

A component cannot connect to or be connected with any other component.
The upstream and downstream components must *speak* the same vocabulary
or *data format*. The output of an one component must match another
component’s input. This is necessary for components to function
correctly and without errors.

The platform requires data formats to ensure that a component will be
run with other *compatible* components.

Data formats can and should be shared by multiple components.

Each Component requires a component specification.
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

The component specification is a JSON artifact that fully specifies the
component, it’s interfaces, and configuration. It’s standardized for
CDAP and Docker applications and is validated using a :doc:`JSON schema <./component-json-schema>`.

The component specification fully specifies all the configuration
parameters of the component. This is used by the designer and by policy
(future) to configure the runtime behavior of the component.

The component specification is used to *generate* application
configuration in a standardized JSON that the platform will make
available to the component. This application configuration JSON will
include:

-  Parameters that have been assigned values from the component
   specification, policy, and/or the designer
-  Connection details of downstream components

The component specification is transformed by DCAE tooling (explained
later) into TOSCA models (one for the component, and in the future, one
for Policy). The TOSCA models then get transformed into Cloudify
blueprints.

The component specification is used by:


-  Blueprint Generator - Tool to generate standalone cloudify blueprint
   using component spec. The blueprints can be uploaded into inventory 
   using Dashboard and triggerred for deployment.
-  MOD Platform - To onboard the microservice and maintain in catalog
   enabling designer to compone new DCAE service flows and distribute
   to DCAE Runtime platform.
-  Policy (future) - TOSCA models are generated from the component
   specification so that operations can create policy models used to
   dynamically configure the component.
-  Runtime platform - The component’s application configuration
   (JSON) is generated from the component specification and will be
   provided to the component at runtime (through ConfigBindingService
   or Consul).


   