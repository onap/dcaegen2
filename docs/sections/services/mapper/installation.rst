.. This work is licensed under a Creative Commons Attribution 4.0 International License.
.. http://creativecommons.org/licenses/by/4.0
.. Copyright 2018-2019 Tech Mahindra Ltd.


Installation
============

| **Universal Ves Adapter**
1.To run Universal Ves Adapter container on standalone mode,

To run Universal Ves Adapter container on standalone mode using local configuration file carried in the docker image, following docker run command can be used.
 
    ``docker run -d -p 8085:8085/tcp  nexus3.onap.org:10003/onap/org.onap.dcaegen2.services.mapper.vesadapter.universalvesadaptor:latest``

 2.TO Run via blueprint 
a.change DMaaP configurations in the blueprint as per setup 
b.upload the blueprint in the DCAE's Cloudify instance
c.Create the Deployment 





