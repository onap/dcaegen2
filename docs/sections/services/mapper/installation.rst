.. This work is licensed under a Creative Commons Attribution 4.0 International License.
.. http://creativecommons.org/licenses/by/4.0
.. Copyright 2018 Tech Mahindra Ltd.


Installation
============
Currently both Universal VES Adapter and SnmpMapper are not integrated with CONFIG_BINDING_SERVICE to get their configuration. All the required configuration needs to be passed as docker environment parameters.

| **Universal Ves Adapter**

 To run Universal Ves Adapter container on standalone mode, following docker environment parameters are required.


- DMAAPHOST  -  Should contain an address to DMaaP, so that event publishing can work
- MR_PORT - DMaaP Exposed Port
- URL_JDBC - JDBC URL where postgres db is installed 
- JDBC_USERNAME - Username for postgres DB user
- JDBC_PASSWORD - Password for postgres  DB user
- CONSUL_HOST - a host address where Consul service lies
- CONFIG_BINDING_SERVICE - name of CBS as it is registered in Consul
- HOSTNAME - name of Universal Ves Adapter application as it is registered in CBS catalog

Sample docker run command could be -

    ``docker run -d -p 8085:8085/tcp -e URL_JDBC=jdbc:postgresql://10.53.172.138:5432/postgres -e JDBC_USERNAME=postgres -e JDBC_PASSWORD=root -e DMAAPHOST=10.53.172.156 -e CONSUL_HOST=10.53.172.109 -e HOSTNAME=static-dcaegen2-services-mua -e MR_DEFAULT_PORT_NUMBER=3904 -e CONFIG_BINDING_SERVICE=config_binding_service nexus3.onap.org:10003/onap/org.onap.dcaegen2.services.mapper.vesadapter.universalvesadaptor:latest``

Note: you should have a postgresql  and DMaap  instance running in your system and provide their credentials and hostname to run in standalone mode.




| **SnmpMapper**

- To run SnmpMapper container on standalone mode, following docker environment parameters are required.

- DMAAPHOST-should contain an address to DMaaP, this will be used in future reference
- MR_PORT - DMaaP Exposed Port
- URL_JDBC- JDBC URL where postgres db is installed 
- JDBC_USERNAME- Username for postgres DB user
- JDBC_PASSWORD-Password for postgres  DB user
- CONSUL_HOST - a host address where Consul service lies
- CONFIG_BINDING_SERVICE - name of CBS as it is registered in Consul
- HOSTNAME - name of Universal Ves Adapter application as it is registered in CBS catalog

Sample docker run command could be -

   ``docker run -d -p 8084:8080/tcp -e URL_JDBC=jdbc:postgresql://10.53.172.138:5432/postgres -e JDBC_USERNAME=postgres -e JDBC_PASSWORD=root -e DMAAPHOST=10.53.172.156 -e CONSUL_HOST=10.53.172.109 -e HOSTNAME=static-dcaegen2-services-msnmp -e MR_DEFAULT_PORT_NUMBER=3904 -e CONFIG_BINDING_SERVICE=config_binding_service nexus3.onap.org:10003/onap/org.onap.dcaegen2.services.mapper.snmpmapper:latest``
