Installation
============


Following are steps if manual deployment/undeployment required. 

Steps to deploy are shown below

- Transfer blueprint component file in DCAE bootstrap POD under /blueprints directory. Heartbeat Blueprint can be found under https://git.onap.org/dcaegen2/services/heartbeat/tree/dpo/k8s-heartbeat.yaml?h=dublin
    
- Transfer blueprint inputs file in DCAE bootstrap POD under /inputs directory. Sample input file can be found under https://git.onap.org/dcaegen2/services/heartbeat/tree/dpo/k8s-heartbeat-inputs.yaml


- Enter the Bootstrap POD
- Validate blueprint
    .. code-block:: bash
        
        cfy blueprints validate /blueprints/k8s-hearttbeat.yaml
- Upload validated blueprint
    .. code-block:: bash
        

        cfy blueprints upload -b heartbeat /blueprints/k8s-hearttbeat.yaml
- Create deployment
    .. code-block:: bash
        

        cfy deployments create -b heartbeat -i /k8s-hearttbeat-input.yaml heartbeat
- Deploy blueprint
    .. code-block:: bash
        

        cfy executions start -d heartbeat install

To undeploy heartbeat, steps are shown below

- Uninstall running heartbeat and delete deployment
    .. code-block:: bash
        

        cfy uninstall heartbeat
- Delete blueprint
    .. code-block:: bash
        

        cfy blueprints delete heartbeat