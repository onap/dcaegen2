.. This work is licensed under a Creative Commons Attribution 4.0 International License.
.. http://creativecommons.org/licenses/by/4.0
.. _heartbeat-installation:


Installation
============


Following are steps if manual deployment/undeployment required. 

Steps to deploy are shown below

- Heartbeat MS blueprint is available under bootstrap pod (under /blueprints/k8s-heartbeat.yaml). The blueprint is also maintained in gerrit and can be downloaded from  https://git.onap.org/dcaegen2/platform/blueprints/tree/blueprints/k8s-heartbeat.yaml
 	
          
- Create an input file in DCAE bootstrap POD under / directory. Sample input file can be found under https://git.onap.org/dcaegen2/services/heartbeat/tree/dpo/k8s-heartbeat-inputs.yaml


- Enter the Bootstrap POD
- Validate blueprint
    .. code-block:: bash
        
        cfy blueprints validate /blueprints/k8s-heartbeat.yaml
- Upload validated blueprint
    .. code-block:: bash
        

        cfy blueprints upload -b heartbeat /blueprints/k8s-heartbeat.yaml
- Create deployment
    .. code-block:: bash
        

        cfy deployments create -b heartbeat -i /k8s-heartbeat-input.yaml heartbeat
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
