.. This work is licensed under a Creative Commons Attribution 4.0 International License.
.. http://creativecommons.org/licenses/by/4.0
.. _blueprintgenerator:


Blueprint Generator
===================

What is Blueprint Generator?
~~~~~~~~~~~~~~~~~~~~~~~~~~~~

The blueprint generator is java-based tool to take a component spec 
for a given micro-service and translate that component spec into a 
cloudify blueprint yaml file that can be used during deployment in DCAE 
Runtime plaform.  

Service components to be deployed as stand-alone 
(i.e not part of DCAE service composition flow) can use the blueprint-generator
utility to create deployment yaml. The generated blueprint can be uploaded 
to inventory and deployed from Dashboard directly.


Steps to run the blueprint generator
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

1. Download the `blueprint generator jar <https://nexus.onap.org/service/local/repositories/releases/content/org/onap/dcaegen2/platform/mod/blueprint-generator-onap-executable/1.7.3/blueprint-generator-onap-executable-1.7.3.jar>`__  file from Nexus

2. To execute the application, run the following command
 
    ``java -jar blueprint-generator-onap-executable-1.7.3.jar app ONAP``

3. This execution will provide the help, as you have not provided the required flags.

4. When ready you can run the program again except with the required flags.

5. OPTIONS

   -  -i OR --component-spec: The path of the ONAP Blueprint INPUT JSON SPEC FILE (Required)
   -  -p OR --blueprint-path: The path of the ONAP Blueprint OUTPUT where it will be saved (Required)
   -  -n OR --blueprint-name: The NAME of the ONAP Blueprint OUTPUT that will be created (Optional)
   -  -t OR --imports: The path of the ONAP Blueprint IMPORT FILE (Optional)
   -  -o OR --service-name-override: The Value used to OVERRIDE the SERVICE NAME of the ONAP Blueprint  (Optional)
   -  -d OR --dmaap-plugin: The option to create an ONAP Blueprint with DMAAP Plugin included (Optional)

6. An example running this program is shown below

    ``java -jar blueprint-generator-onap-executable-1.7.3.jar app ONAP -p blueprint_output -i ComponentSpecs/TestComponentSpec.json -n TestAppBlueprint``


Extra information
-----------------

1. The component spec must be compliant with `Component Spec json schema <https://git.onap.org/dcaegen2/platform/plain/mod/component-json-schemas/component-specification/dcae-cli-v2/component-spec-schema.json>`__
   
2. If the flag is marked required then the corresponding values must be provided for blueprint-generator execution

3. If the flag is identified as optional then it is not mandatory for blueprint-generator execution

4. If you do not add a -n flag the blueprint name will default to what it is in the component spec

5. If the directory you specified in the -p flag does not already exist the directory will be created for you

6. The -t flag will override the default imports set for the blueprints. Below you can see example content of the import file:

::

    imports:
      - https://www.getcloudify.org/spec/cloudify/4.5.5/types.yaml
      - plugin:k8splugin?version=3.6.0
      - plugin:dcaepolicyplugin?version=2.4.0


How to create policy models:
~~~~~~~~~~~~~~~~~~~~~~~~~~~~

1. Policy model creation can be done with the same jar as downloaded for the blueprint generation.

2. Run the same command as the blueprint generator except add a flag ``-type policycreate``

3. Options

   - -i: The path to the JSON spec file (required)
   - -p: The Output path for all of the models (required)

4. Example command

    ``java -jar blueprint-generator-onap-executable-1.7.3.jar app ONAP -type policycreate -i componentspec -p OutputPolicyPath``


Extra information
-----------------

1. Not all component specs will be able to create policy models

2. Multiple policy model files may be created from a single component spec


How to use Blueprint Generator as a Spring library
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
To use BlueprintGenerator you need to import the following artifact to your project:

::

    <dependency>
        <groupId>org.onap.dcaegen2.platform.mod</groupId>
        <artifactId>blueprint-generator-onap</artifactId>
        <version>1.7.3</version>
    </dependency>

In order to see how to use the library in detail please familiarize yourself with real application: `Blueprint Generator Executable main class <https://git.onap.org/dcaegen2/platform/plain/mod/bpgenerator/onap-executable/src/main/java/org/onap/blueprintgenerator/BlueprintGeneratorMainApplication.java>`__
