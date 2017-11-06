# 'Services' Overview 

DCAE Services run on the DCAE platform. A service performs either monitors the virtualized network services or does analytics. A service is composed of one or more components, and performs a business need.

Services are created in a 'Service Design and Creation' tool called 'Service Assurance Flow Designer' by a Service Designer. This is done by 
* 1. 'compose'ing a service from the available SDC catalog components (actually from the TOSCA models representing the components), then
* 2. 'submit'ing the service, which generates a Cloudify blueprint, is then automatically uploaded to INVENTORY,  and then deployed by DEPLOYMENT HANDLER (once a DTI Event is triggered for the service). It should be noted that some service flows, specifally 'closed-loop' flows,  are not initiated by DTI, but are done by CLAMP. 
