.. This work is licensed under a Creative Commons Attribution 4.0 International License.
.. http://creativecommons.org/licenses/by/4.0

Installation
============

PM mapper is a microservice that will be instantiated by Cloudify manager. PM Mapper blueprint is uploaded into cloudify manager and properly configured before instantiation.
Cloudify Manager will then proceed to instantiate the pm mapper service within DCAE Services. During instantiation, the PM mapper will query configuration information from the Config Binding Service.

