

Blueprint Generator (DCAE)
=============================================

What is the Blueprint Generator?
++++++++++++++++++++++++++++++++
The blueprint generator is a java rewrite of the tosca lab python tool. The point of this tool is to be able to take a component spec for a given micro-service and translate that component spec into a blueprint yaml file that can be used during deployment.


Steps to run the blueprint generator:
+++++++++++++++++++++++++++++++++++++

1. Download the jar file from Nexus by clicking `here <https://nexus.onap.org/service/local/repositories/releases/content/org/onap/dcaegen2/platform/cli/blueprint-generator/1.2.1/blueprint-generator-1.2.1-executable.jar>`_ or running
    ``wget https://nexus.onap.org/service/local/repositories/releases/content/org/onap/dcaegen2/platform/cli/blueprint-generator/1.2.1/blueprint-generator-1.2.1-executable.jar``

2. To execute the application, run the following command: 
    ``java -jar blueprint-generator-1.2.1-executable.jar blueprint``

3. This execution will provide the help, as you have not provided the required flags.

4. When ready you can run the program again except with the required flags.

5. OPTIONS:
    -p: The path to where the final blueprint yaml file will be created (required)

    -i: The path to the JSON spec file (required)

    -n: Name of the blueprint (optional)

    -t: the path to the import yaml file (optional)
    
    -d: If this flag is present the bp generator will be created with dmaap plugin (optional)

    -o: This flag will create a service component override for your deployment equal to the value you put (optional)

6. An example running this program would look like this:
    ``java -jar blueprint-generator-1.2.1-executable.jar -p blueprint_output -i ComponentSpecs/TestComponentSpec.json -n TestAppBlueprint``


Extra information
-----------------

1. The component spec must be of the same format as stated in the onap `readthedocs <https://onap.readthedocs.io/en/latest/submodules/dcaegen2.git/docs/sections/components/component-specification/common-specification.html#working-with-component-specs>`_ page

2. If the tag says required then the program will not run without those tags being there

3. If the tag says optional then it is not necessary to run the program with those tags

4. If you do not add a -n tag the blueprint name will default to what it is in the component spec

5. If the directory you specified in the -p tag does not already exist the directory will be created for you

6. The -t flag will override the default imports set for the blueprints. To see an example of how the import yaml file should be structured see the testImports.yaml file under the folder TestCases


How to create policy models:
+++++++++++++++++++++++++++++++++++++

1. Policy model creation can be done with the same jar as downloaded for the blueprint generation.

2. Run the same command as the blueprint generator except replace the ``blueprint`` positional with ``policy``

3. Example command:
    ``java -jar blueprint-generator-1.2.1-executable.jar policy``

4. Options:

   -i: The path to the JSON spec file (required)

   -p: The Output path for all of the models (required)

Extra information
-----------------

1. Not all component specs will be able to create policy models

2. Multiple policy model files may be create from a single component spec
