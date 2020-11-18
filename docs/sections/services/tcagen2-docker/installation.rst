.. This work is licensed under a Creative Commons Attribution 4.0 International License.
.. http://creativecommons.org/licenses/by/4.0
.. _tcagen2-installation:


Installation
============

TCA-gen2 is a microservice that will be configured and instantiated through Cloudify Manager.TCA-gen2 will be deployed by DCAE deployment among the bootstrapped services. This is more to facilitate automated deployment of ONAP regression test cases required services.   During instantiation, the TCA-gen2 will fetch its configuration through the Config Binding Service. Steps to deploy using the CLI tool are shown below.

Deployment Prerequisite/dependencies
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

    - DCAE and DMaaP pods should be up and running.
    - MongoDB should be up and running
    - Make sure that cfy is installed and configured to work with the Cloudify deployment.

Deployment steps
^^^^^^^^^^^^^^^^

Following are steps if manual deployment/undeployment is required.  Steps to deploy are below


Enter the Cloudify Manager kuberenetes pod

    - Tca-gen2 blueprint directory (/blueprints/k8s-tcagen2.yaml). The blueprint is also maintained in gerrit and can be downloaded from https://git.onap.org/dcaegen2/platform/blueprints/tree/blueprints/k8s-tcagen2.yaml
     
    - Create input file required for deployment
    	
        Configuration of the service consists of generating an inputs file (YAML) which will be used as part of the
        Cloudify install. The tca-gen2 blueprints was designed with known defaults for the majority of the fields.
        
        Below you will find examples of fields which can be configured, and some of the fields
        which must be configured.  An input file is loaded into bootstrap container (/inputs/k8s-tcagen2-inputs.yaml).
        

        .. csv-table::
            :widths: auto
            :delim: ;
            :header: Property , Sample Value , Description , Required
          
            tca_handle_in_subscribe_url ; http://message-router:3904/events/unauthenticated.TCAGEN2_OUTPUT/; DMaap topic to publish CL event output ; No
            tca_handle_in_subscribe_url ; http://message-router:3904/events/unauthenticated.VES_MEASUREMENT_OUTPUT/; DMaap topic to subscribe VES measurement feeds ; No
            tag_version ; nexus3.onap.org:10001/onap/org.onap.dcaegen2.analytics.tca-gen2.dcae-analytics-tca-web:1.0.1 ; The tag of the Docker image will be used when deploying the tca-gen2. ; No

        Example inputs.yaml

        .. code-block:: yaml

                tag_version: nexus3.onap.org:10001/onap/org.onap.dcaegen2.analytics.tca-gen2.dcae-analytics-tca-web:1.0.1
                tca_handle_in_subscribe_url: "http://message-router:3904/events/unauthenticated.VES_MEASUREMENT_OUTPUT/"
                tca_handle_out_publish_url: "http://message-router:3904/events/unauthenticated.TCAGEN2_OUTPUT/"


    - Create deployment

        .. code-block:: bash

             cfy install --blueprint-id tcagen2 --deployment-id tcagen2 -i /inputs/k8s-tcagen2-inputs.yaml /blueprints/k8s-tcagen2.yaml
        


To undeploy TCA-gen2, steps are shown below

- Uninstall running TCA-gen2 and delete deployment
    .. code-block:: bash
        
        cfy uninstall tcagen2
- Delete blueprint
    .. code-block:: bash
        
        cfy blueprints delete tcagen2
        