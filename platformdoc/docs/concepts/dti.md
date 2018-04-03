
# DTI (DCAE Topology Interface) Reconfiguration 

Services that support DTI Reconfiguration are installed (with input provided by a DESIGNER (via SDC UI) or Operations (via Dashboard) to indicate which `vnfType-vnfFuncId` is to be processed by that service. When deployed, the service run but does not collect data until a DTI Event comes in.

Whenever a network event occurs, resulting in the deployment or undeployment of a `vnfType-vnfFuncId`, it is recorded in A&AI and reported to the DTI Topology VM. The DTI Event is then received by the DTI HANDLER, which uses its values to retrieve one or more reconfiguration blueprints from INVENTORY, and then uploads those blueprint(s) to CLOUDIFY MANAGER. It then creates deployment(s) from those blueprint(s), populates them with the DTI Event values (as inputs), and then executes the install workflow on those deployment(s). 

The platform then executes the reconfigure script (configured in the Auxilary section of the component specification), passing the entire DTI Event to the component. The component can process the individual event or make a call to the CONFIG BINDING SERVICE to retrieve all of the vnfType-vnfFuncIds that are to be processed by the service.

Refer to the [DTI Reconfiguration](/components/component-specification/docker-specification/#dti-reconfiguration) for more information.
