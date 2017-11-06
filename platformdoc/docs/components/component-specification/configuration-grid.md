
# Configuration Quick Reference

The following types of configuration are supported by the DCAE Platform.

|Input Sources|Default Values|Designer Input |Clamp Input|Policy Input|Runtime Input|
|---------|---------|----------|---------|----------|---|
|Notes||This applies only to components that are self-service (supported by SDC) |This applies only to components that are part of a closed-loop interface ||  |
|Who provides?|Component Developer|Service Designer|CLAMP|Operations|Runtime Platform|
| When/Where it is provided |During onboarding – in the component specification | At design time – in the SDC UI | At installation – in the CLAMP UI |	Anytime – in the POLICY GUI | When the component is deployed |
|Component Specification Details|For CDAP:<br> ‘value’ Name and KV pairs in AppConfig or AppPreferences For Docker:<br> ‘value’ is provided for variable in ‘parameter’ section|‘designer-editable’ must be set to ‘true’ for variable in ‘parameter’ section. || ‘policy-editable’ must be set to ‘true’ and ‘policy_schema’ must be provided for variable in ‘parameter’ section |'sourced_at_<br>deployment' must be set to 'true' for variable in 'parameter' section |
| How it is used | This is passed to the component in the generated configuration if not overridden.|This overrides any values previously set, but can be overridden by CLAMP or POLICY.|This overrides any values previously set, but can be overridden by POLICY.|This overrides any values previously set, but can be overridden at any point thereafter.|This overrides any values previously set, but can be overridden at any point thereafter by Policy. |
| Additional Info for Component Developer|For CDAP:<br> ‘value’ is provided for variable in the ‘AppConfig’ or ‘AppPreferences’ sections<br><br> For Docker:<br> ‘value’ is provided for variable in ‘parameter’ section|||For Docker: In the auxiliary section:<br> {"policy": {"trigger_type": "policy","script_path": “/opt/app/reconfigure.sh”} }<br> Script interface must be "opt/app/reconfigure.sh” $trigger_type  $updated_policies  $updated_appl_config" <br> where $updated_policies is a json provided by the Policy Handler and <br> $update_appl_config is the post-merged appl config which may contain unresolved configuration that didn’t come from policy.<br> Suggestion is for script to call CONFIG BINDING SERVICE to resolve any configuration. |
