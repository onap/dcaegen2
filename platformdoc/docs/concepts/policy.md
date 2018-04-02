
# Policy (not yet implemented)

Policy is a concept where certain configuration is specified as being 'set' by Operations via a Policy UI. 

The specific configuration that represents Policy for a given service is designated in the component specification as `policy_editable`, and has a `policy_schema` defined. At any time thereafter, the values can be set in the POLICY UI. Once set, POLICY HANDLER will update the values in CONSUL. If the component is running, it will notify the component that it's policy has changed, and the component will call the CONFIG BINDING SERVICE to obtain a current set of its configuration. 

Refer to the [Configuration Grid](/components/component-specification/configuration-grid) for more information.
