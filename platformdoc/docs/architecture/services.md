# 'Services' Overview 

DCAE Services run on the DCAE platform. A service either monitors the virtualized network services or does analytics. A service is composed of one or more components, and performs a business need.

Services are created in a 'Service Design and Creation' tool called 'Service Assurance Flow Designer' by a Service Designer. This is done by 

* 'compose'ing a service from the available SDC catalog components (actually from the TOSCA models representing the components), then
* 'submit'ing the service, which generates a Cloudify blueprint, which is then automatically uploaded to INVENTORY, and then deployed by DEPLOYMENT HANDLER (and CLOUDIFY) (once a DTI Event is triggered for the service). It should be noted that some service flows, specifally 'closed-loop' flows,  are not initiated by DTI, but are done by CLAMP. 

Only a few services are supported in SDC so far, and therefore steps above are done manually by the Onboarding Team for most services.

