# Service Discovery

Service discovery is an architecture pattern used for components (micro-services) to locate each other.  The DCAE platform uses [server-side discovery](http://microservices.io/patterns/server-side-discovery.html) and is using [Consul](https://www.consul.io/) as the service registry solution.

## Service Registration

All components are required to register with Consul in order to be discovered.  There are two methods of registration: self and 3rd party.  The DCAE platform uses 3rd party registration which means components don't actually make the registration calls but defers that responsibility to a platform service.

### Implementation for Docker

[Registrator](http://gliderlabs.com/registrator/latest/) is an open source application that is responsible for registering all components that run as Docker containers.  Registrator watches the local Docker engine's activity log and will register and unregister a Docker container when the container is started and stopped.

### Implementation for CDAP

The CDAP broker is a REST web service that is responsible for registering all components that run as CDAP applications.
