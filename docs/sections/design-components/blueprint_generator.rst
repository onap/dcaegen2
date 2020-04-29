
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

1. Download the `blueprint generator jar <https://nexus.onap.org/service/local/repositories/releases/content/org/onap/dcaegen2/platform/mod/blueprint-generator/1.3.1/blueprint-generator-1.3.1-executable.jar>`__  file from Nexus 

2. To execute the application, run the following command
 
    ``java -jar blueprint-generator-1.3.1-executable.jar blueprint``

3. This execution will provide the help, as you have not provided the required flags.

4. When ready you can run the program again except with the required flags.

5. OPTIONS

   -  -p: The path to where the final blueprint yaml file will be created (required)
   -  -i: The path to the JSON spec file (required)
   -  -n: Name of the blueprint (optional)
   -  -t: the path to the import yaml file (optional)
   -  -d: If this flag is present the bp generator will be created with dmaap plugin (optional)
   -  -o: This flag will create a service component override for your deployment equal to the value you put (optional)

6. An example running this program is shown below

    ``java -jar blueprint-generator-1.3.1-executable.jar -p blueprint_output -i ComponentSpecs/TestComponentSpec.json -n TestAppBlueprint``


Extra information
-----------------

1. The component spec must be compliant with `Component Spec json schema <https://git.onap.org/dcaegen2/platform/plain/mod/component-json-schemas/component-specification/dcae-cli-v2/component-spec-schema.json>`__
   
2. If the flag is marked required then the corresponding values must be provided for blueprint-generator execution

3. If the flag is identified as optional then it is not mandatory for blueprint-generator execution

4. If you do not add a -n flag the blueprint name will default to what it is in the component spec

5. If the directory you specified in the -p flag does not already exist the directory will be created for you

6. The -t flag will override the default imports set for the blueprints. To see an example of how the import yaml file should be structured see the testImports.yaml file under the folder TestCases


How to create policy models:
~~~~~~~~~~~~~~~~~~~~~~~~~~~~

1. Policy model creation can be done with the same jar as downloaded for the blueprint generation.

2. Run the same command as the blueprint generator except replace the ``blueprint`` positional with ``policy``

3. Example command

    ``java -jar blueprint-generator-1.3.1-executable.jar policy``

4. Options

   - -i: The path to the JSON spec file (required)
   - -p: The Output path for all of the models (required)


Extra information
-----------------

1. Not all component specs will be able to create policy models

2. Multiple policy model files may be created from a single component spec