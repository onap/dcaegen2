Installation
============

Standalone  docker run command 
   .. code-block:: bash

	    docker run onap/org.onap.dcaegen2.collectors.restconfcollector

For Dublin release, RESTConf collector will be a DCAE component that can dynamically be deployed via Cloudify blueprint installation.


Steps to deploy are shown below

- Enter the Bootstrap POD using kubectl

- Transfer blueprint component file in DCAE bootstrap POD under /blueprints directory. Blueprint can be found in
     https://git.onap.org/dcaegen2/collectors/restconf/tree/dpo/blueprints/k8s-rcc-policy.yaml-template?h=dublin

- Validate blueprint
    .. code-block:: bash
        
        cfy blueprints validate /blueprints/k8s-rcc-policy.yaml
- Upload validated blueprint
    .. code-block:: bash
        

        cfy blueprints upload -b restconfcollector /blueprints/k8s-rcc-policy.yaml
- Create deployment
    .. code-block:: bash
        

        cfy deployments create -b restconfcollector restconfcollector
- Deploy blueprint
    .. code-block:: bash
        

        cfy executions start -d restconfcollector install

To undeploy restconfcollector, steps are shown below

- Uninstall running restconfcollector and delete deployment
    .. code-block:: bash
        

        cfy uninstall restconfcollector
- Delete blueprint
    .. code-block:: bash
        

        cfy blueprints delete restconfcollector
