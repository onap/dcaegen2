Installation
============

TCA will be deployed by DCAE deployment among the bootstrapped services. This is more to facilitate automated deployment of ONAP regression test cases required services. 

As TCA jar is packaged into docker container, the container can be deployer standalone or via Cloudify Blueprint. 



Following are steps if manual deployment/undeployment required. 

Steps to deploy are shown below

- Transfer blueprint component file in DCAE bootstrap POD under /blueprints directory. TCA Blueprint can be found under /blueprint directory. Same is also available on gerrit     https://git.onap.org/dcaegen2/platform/blueprints/tree/blueprints/k8s-tca.yaml-template
    
- Modify blueprint  inputs file in DCAE bootstrap POD under /inputs directory. Copy this file to / and update as necessary.


- Enter the Bootstrap POD
- Validate blueprint
    .. code-block:: bash
        
        cfy blueprints validate /blueprints/k8s-tca.yaml
- Upload validated blueprint
    .. code-block:: bash
        

        cfy blueprints upload -b tca /blueprints/k8s-tca.yaml
- Create deployment
    .. code-block:: bash
        

        cfy deployments create -b tca -i /k8s-tca-input.yaml tca
- Deploy blueprint
    .. code-block:: bash
        

        cfy executions start -d tca install

To undeploy TCA, steps are shown below

- Uninstall running TCA and delete deployment
    .. code-block:: bash
        

        cfy uninstall tca
- Delete blueprint
    .. code-block:: bash
        

        cfy blueprints delete tca