.. This work is licensed under a Creative Commons Attribution 4.0 International License.
.. http://creativecommons.org/licenses/by/4.0
.. _restconf-installation:


Installation
============

Standalone  docker run command 
   .. code-block:: bash

	    docker run onap/org.onap.dcaegen2.collectors.restconfcollector

For the current release, RESTConf collector will be a DCAE component that can dynamically be deployed via Cloudify blueprint installation.


Steps to deploy are shown below

- Enter the Bootstrap POD using kubectl

- Transfer blueprint component file in DCAE bootstrap POD under /blueprints directory. Blueprint can be found in
     https://git.onap.org/dcaegen2/platform/blueprints/tree/blueprints/k8s-restconf.yaml

- Validate blueprint
    .. code-block:: bash
        
        cfy blueprints validate /blueprints/k8s-restconf.yaml
- Upload validated blueprint
    .. code-block:: bash
        

        cfy blueprints upload -b restconfcollector /blueprints/k8s-restconf.yaml
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
