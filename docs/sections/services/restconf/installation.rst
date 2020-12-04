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

     .. note::
       For doing this, follow the below steps

       * First get the bootstrap pod name by running run this: kubectl get pods -n onap | grep bootstrap
       * Then login to bootstrap pod by running this: kubectl exec -it <bootstrap pod> bash -n onap

- Validate blueprint
    .. note::
      Verify that the version of the plugin used should match with "cfy plugins list" and use an explicit URL to the plugin YAML file if needed in the blueprint.

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
