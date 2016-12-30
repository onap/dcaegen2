# Component specification

Every component that onboards onto the DCAE platform requires a component specification.  The component specification is a JSON artifact that fully describes your components.  The format of the component specification is standardized for CDAP applications and Dockerized applications and is validated using [a JSON schema](ONAP URL TBD).

The component specification is used by:

* Design - TOSCA models are generated from the component specification so that your component can be used by designers to compose new DCAE services in SDC.
* Policy - TOSCA models are generated from the component specification so that operations can create policy models used to dynamically configure your component.
* Runtime platform - Your component's application configuration (JSON) is generated from the component specification and will be provided to your component at runtime.

## dcae-cli

Use the [`dcae-cli`](../dcae-cli/quickstart) tool to manage your component specification and to test your components with it.

The dcae-cli can also be used to view component specifications that have already been added and published.  Please check out the [shared catalog](../dcae-cli/walkthrough/#shared-catalog) for examples for both Docker and CDAP.

## Next

If you are building a CDAP application, review the [component specification details for CDAP](cdap-specification.md).

If you are building a Dockerized application, review the [component specification details for Docker](docker-specification.md).
