# Overview

DCAE components are services that provide a specific functionality and are generally written to be composable with other DCAE components, although a component can run independently as well. The DCAE platform is responsible for running and managing DCAE service components reliably.  

Currently, the DCAE platform supports two types of components, CDAP applications and Docker containers. For each, there are requirements that must be met for the component to integrate into the DCAE platform (see [CDAP](component-type-cdap.md) and [Docker](component-type-docker.md)).

### A Component requires one or more data formats.

A component is a software application that performs a function. It doesn't run independently; it depends upon other components. A component's function could require connecting to other components to fulfill that function.  A component could also be providing its function as a service through an interface for other components to use.

A component cannot connect to or be connected with any other component.  The upstream and downstream components must *speak* the same vocabulary or *data format*.  The output of an one component must match another component's input. This is necessary for components to function correctly and without errors.

The platform requires data formats to ensure that a component will be run with other *compatible* components.

Data formats can and should be shared by multiple components.


### Each Component requires a component specification.

The component specification is a JSON artifact that fully specifies the component, it's interfaces, and configuration. It's standardized for CDAP and Docker applications and is validated using a [JSON schema](https://codecloud.web.att.com/projects/ST_DCAECNTR/repos/component-json-schemas/browse/component-spec-schema.json).

The component specification fully specifies all the configuration parameters of the component. This is used by the designer and by policy (future) to configure the runtime behavior of the component. 

The component specification is used to *generate* application configuration in a standardized JSON that the platform will make available to the component.  This application configuration JSON will include:

* Parameters that have been assigned values from the component specification, policy, and/or the designer
* Connection details of downstream components 

The component specification is transformed by DCAE tooling (explained later) into TOSCA models (one for the component, and in the future, one for Policy). The TOSCA models then get transformed into Cloudify blueprints.

The component specification is used by:

* dcae_cli tool - to validate it
* Design Tools - TOSCA models are generated from the component specification so that the component can be used by designers to compose new DCAE services in SDC.
* Policy (future) - TOSCA models are generated from the component specification so that operations can create policy models used to dynamically configure the component.
* the runtime platform - The component's application configuration (JSON) is generated from the component specification and will be provided to the component at runtime.

## Onboarding

Onboarding is a process that ensures that the component is compliant with the DCAE platform rules. A command-line tool called [`dcae-cli`](/components/dcae-cli/quickstart.md) is provided to help with onboarding. The high level summary of the onboarding process is:

1. Defining the [data formats](data-formats.md) if they don't already exist.
2. Defining the [component specification](/components/component-specification/common-specification.md). See [docker](component-specification/docker-specification.md) and [CDAP](component-specification/cdap-specification.md).
3. Use the dcae_cli tool to [add the data formats](/components/dcae-cli/commands/#add-a-data-format) and [add the component](/components/dcae-cli/commands/#add-a-component) to the onboarding catalog. This process will validate them as well.
4. Use the dcae_cli tool to [deploy](/components/dcae-cli/commands/#run-a-component) the component. (The component is deployed to the environment indicated in the [profile](/components/dcae-cli/commands/#activate-a-profile) section).
5. Test the component. Also do pairwise-test the component with any other components it connects with.
7. Publish the component and data formats into the Service Design and Creation (SDC) 'catalog'. (Currently, this is a manual step, not done via the dcae_cli tool).

