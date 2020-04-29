.. This work is licensed under a Creative Commons Attribution 4.0 International License.
.. http://creativecommons.org/licenses/by/4.0

Requirements/Guidelines
=======================


Onboarding Guidelines
---------------------

Onboarding is a process that ensures that the component is compliant
with the DCAE platform rules. The high level summary of the onboarding process
is:

1. Defining the :doc:`data formats <data-formats>` if they don’t already
   exist. 
2. Defining the :doc:`component specification <./component-specification/common-specification>`.
   See :doc:`docker <./component-specification/docker-specification>` 
3. Validate the component spec schema against
   `Component Spec json schema <https://git.onap.org/dcaegen2/platform/plain/mod/component-json-schemas/component-specification/dcae-cli-v2/component-spec-schema.json>`__
4. Use  :doc:`blueprint-generator tool <./blueprint_generator>`to generate Cloudify blueprint
5. Test the blueprint generated in DCAE Runtime Environment (using either Dashboard UI or Cloudify cli from bootstrap)
6. Using :doc:`DCAE-MOD <../DCAE-MOD/DCAE-MOD-User-Guide>` , publish the component and data formats into DCAE-MOD catalog. 
   (This step is required if Microservice needs to be deployed part of flow/usecase)

   
.. toctree::
 :maxdepth: 1

 ./component-type-docker.rst