# Blueprint Generator 

This tool allows the user to create a blueprint from a component spec json file 

# Instructions for building the tool locally
- cd into the root directory of the project (where the pom is located)
- Run the command: mvn clean install
- This will create a jar file and a tar file
- Unzip the tar file within this target directory
- cd into the folder that was created
- Instructions on how to run the tool from this folder are below
- If you're on windows type this out before you add your flags 

```bash
java -cp "lib/blueprint-generator-1.0.0-SNAPSHOT.jar;lib/*" org.onap.blueprintgenerator.core.BlueprintGenerator
```

-If you're on linux type this out before you add your flags

```bash
java -cp blueprint-generator/lib/blueprint-generator-1.0.0-SNAPSHOT.jar:blueprint-generator/lib/* org.onap.blueprintgenerator.core.BlueprintGenerator
```


# Instructions for running BlueprintGenerator:

## Instructions for running:


-Run the program on the command line with the following tags:
OPTIONS:
- -p: The path to where the final blueprint yaml file will be created (Required)
- -i: The path to the JSON spec file (required)
- -n: Name of the blueprint (optional)
- -t: the path to the import yaml file (optional)


If you're on windows it will look like this:
 
```bash
java -cp "lib/blueprint-generator-onap-0.0.1-SNAPSHOT.jar;lib/*" org.onap.blueprintgenerator.core.BlueprintGenerator -p Blueprints -i ComponentSpecs/TestComponentSpec.json -n HelloWorld
```

If you're on linux it will look like this

```bash
java -cp blueprint-generator/lib/blueprint-generator-0.0.1-SNAPSHOT.jar:blueprint-generator/lib/* org.onap.blueprintgenerator.core.BlueprintGenerator -p Blueprints -i ComponentSpecs/TestComponentSpec.json -n HelloWorld
```

This command will create a blueprint from the component spec TestComponentSpec. The blueprint file name will be called HelloWorld.yaml and it will be in the directory Blueprints.

## Extra information:
- The component spec must be of the same format as stated in the onap [readthedocs](https://onap.readthedocs.io/en/latest/submodules/dcaegen2.git/docs/sections/components/component-specification/common-specification.html#working-with-component-specs) page 
- If the tag says required then the program will not run without those tags being there
- If the tag says optional then it is not necessary to run the program with those tags
- If you do not add a -n tag the blueprint name will default to what it is in the component spec
- If the directory you specified in the -p tag does not already exist the directory will be created for you
- The -t flag will override the default imports set for the blueprints. To see an example of how the import yaml file should be structured see the testImports.yaml file under the folder TestCases.
