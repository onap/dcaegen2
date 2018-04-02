
# Configuration Quick Reference

#### Default Values

The component developer can provide default values for any `parameter` in the component specification. These defaults will be passed to the component in its generated configuration. 

#### Overridden/Entered Values

Depending on the other properties set for the parameter, the default value can be overridden at 'design-time', 'deploy-time' or once the microservice is running ('run-time'). 
(*In the future, when Policy is supported, configuration will also be able to be provided/changed in the Policy UI at any time).* 

||Design-Time Input |CLAMP Input|Policy Input (future) |Deploy-Time Input|Run-Time Input (DTI)|
|-----|-----|-----|-----|----------|----------|
|Description|Applies to SDC self-service components|Applies to components deployed by CLAMP |(not yet supported)|Applies to manually deployed services| Applies to components supporting DTI reconfiguration| 
|Input provided by|Service Designer|CLAMP|Operations|DevOps|Runtime Platform(DTI)|
|How it is provided |In the SDC UI |In the CLAMP UI |In the POLICY GUI |In the DCAE Dashboard (or Jenkins job)|In the DTI Event
|Component Specification Details|‘designer-editable’ set to ‘true’| None. Developer provides CLAMP an email with parameters to be supported|‘policy_editable’ must be set to ‘true’ and ‘policy_schema’ must be provided|'sourced_at_<br>deployment' must be set to 'true'|parameter 'dcae_target_type' defined with default value set to supported vnfType-vnfFuncId, with properties 'designer_editable' and 'sourced_at_deployment' set appropriately|
|Additional Info for Component Developer|||For Docker only: In the auxiliary section:<br> {"policy": {"trigger_type": "policy","script_path": “/opt/app/reconfigure.sh”} }<br> Script interface would then be "/opt/app/reconfigure.sh” $trigger_type  $updated_policy" <br> where $updated_policy is json provided by the Policy Handler.||For Docker only: In the auxiliary section:<br> {"dti": “/opt/app/reconfigure.sh”} <br> Script interface would then be "/opt/app/reconfigure.sh” $trigger_type  $updated_dti" <br> where $updated_dti is json provided by the DTI Plugin.|
