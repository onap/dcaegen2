# Overview

DCAE components are services that provide a specific functionality and are written to be composable with other DCAE service components.  The DCAE platform is responsible for running and managing DCAE service components reliably.  

Currently, the DCAE platform supports two types of components, CDAP applications and Docker containers. For each, there are requirements that must be met for the component to integrate into the DCAE platform (see [CDAP](component-type-docker.md) and [Docker](component-type-docker.md)).

## Onboarding

There is an onboarding process that all component developers will have to take their components through to ensure that their DCAE service components are compliant with the DCAE platform and are authorized to push their component into the ASDC catalog. A command-line tool called [`dcae-cli`](ONAP URL TBD) is provided to help you through this process. The high level summary of the onboarding process is:

1. Defining your [Data formats](data-formats.md)
2. Defining your component specification], which is a JSON that is used to describe and configure the component is to be provided by component developers upon the completion of micro-service implementation and certification testing steps. See [docker](component-specification/docker-specification.md) and [CDAP](component-specification/cdap-specification.md).
3. Testing your component locally
4. Pairwise-testing your component with any other components you connect to
5. Pushing your component and data formats into the ASDC catalog

## The whys

### Components require data formats...

Components are software applications that do some function.  Components don't run independently, they depend upon other components.  A component's function could require connecting to other components to fulfill that function.  A component could also be providing its function as a service through an interface for other components to use.

The challenge is that a component cannot connect to or be connected with any other component.  The upstream and downstream components must *speak* the same vocabulary or *data format*.  The output of an upstream component must match your component's input or your component's output must match the downstream component's input.  This is necessary for components to function without errors and correctly.

All components must have data formats.  The platform requires this to validate and to ensure that your component will be run with *compatible* components.

Components *should* have one to many data formats.  Data formats should be shared.

### Components require a component specification...

One design goal of the DCAE was to have a single place for component developers to describe their component. They should *not* have to worry about Tosca, blueprints, yaml files, etc. The component specification (and it's linked data formats) is the only piece of information about a component that each component developer has to provide. Here are some benefits:

1. The component specification fully specifies your inputs and outputs, so DCAE knows how it can compose your component. The component specification is where you define what types of other components your component connects with and what types of other components can connect to you.  You are defining your inputs and outputs.  

2. The component specification fully specifies all the configuration parameters of your component. This is used by the designer and by policy to configure the runtime behavior of your component. 

3. The component specification is used to *generate* your application configuration in a standardized JSON that the platform will make available.  This application configuration JSON will include:

* Parameters that have been assigned values from you, policy, and/or design
* Connection details of downstream components you are dependent upon

4. The component specification is transformed by DCAE tooling into Policy models and Cloudify blueprints, so you need not worry about these.

Every component should have one component specification.

### Component developers should use the dcae-cli...

The dcae-cli was developed to empower component developers with developing their components for the DCAE platform.  It is intended to help with:

* Crafting your component specification and your data formats
* Finding and sharing existing data formats
* Finding and running existing components
* Testing and launching your component as it would be run on the platform
* Push your component into the catalog to be shared and to be used by designers

All this from a single command-line tool.
