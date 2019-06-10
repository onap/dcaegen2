

Blueprint Generator (DCAE)
=============================================

What is the Blueprint Generator?
++++++++++++++++++++++++++++++++
The blueprint generator is a java rewrite of the tosca lab python tool. The point of this tool is to be able to take a component spec for a given micro-service and translate that component spec into a blueprint yaml file that can be used during deployment.
rin

Steps to run the blueprint generator:
+++++++++++++++++++++++++++++++++++++

1. Download the zip file from Nexus by clicking `here <https://nexus.onap.org/service/local/repositories/releases/content/org/onap/dcaegen2/platform/cli/blueprint-generator/1.0.0/blueprint-generator-1.0.0-bundle.tar.gz` or "wget https://nexus.onap.org/service/local/repositories/releases/content/org/onap/dcaegen2/platform/cli/blueprint-generator/1.0.0/blueprint-generator-1.0.0-bundle.tar.gz"

2. Unzip the the tar file

3. You should see blueprint-generator-1.0.0 directory created (also a lib folder in this directory)

4. If you are in linux run the following command: "java -cp blueprint-generator/lib/blueprint-generator-1.0.0.jar:blueprint-generator/lib/* org.onap.blueprintgenerator.core.BlueprintGenerator"

5. If you are in windows run this command java -cp "lib/blueprint-generator-1.0.0.jar;lib/\*" org.onap.blueprintgenerator.core.BlueprintGenerator.

6. These commands mean that it will run java, find a path to the jar that we want to run along with all of the dependencies that we need, then you add the path to the main method. If done correctly you should see a list of all of the flags you can add. 

7. When ready you can run the program again except with the required flags.

8. OPTIONS:
    -p: The path to where the final blueprint yaml file will be created (Required)

    -i: The path to the JSON spec file (required)

    -n: Name of the blueprint (optional)

    -t: the path to the import yaml file (optional)

9. An example running this program in windows would look like this java -cp "lib/blueprint-generator-1.0.0.jar;lib/\*" org.onap.blueprintgenerator.core.BlueprintGenerator -p blueprint_output -i ComponentSpecs/TestComponentSpec.json -n TestAppBlueprint


Extra information
-----------------

1. The component spec must be of the same format as stated in the onap `readthedocs <https://onap.readthedocs.io/en/latest/submodules/dcaegen2.git/docs/sections/components/component-specification/common-specification.html#working-with-component-specs>`_ page

2. If the tag says required then the program will not run without those tags being there

3. If the tag says optional then it is not necessary to run the program with those tags

4. If you do not add a -n tag the blueprint name will default to what it is in the component spec

5. If the directory you specified in the -p tag does not already exist the directory will be created for you

6. The -t flag will override the default imports set for the blueprints. To see an example of how the import yaml file should be structured see the testImports.yaml file under the folder TestCases
l