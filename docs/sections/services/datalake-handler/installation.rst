Deployment Steps
################
DL-handler consists of two pods- the feeder and admin UI. It can be deployed by using cloudify blueprint. Datalake can be easily deployed through DCAE cloudify manager. The following steps guides you launch Datalake though cloudify manager.

Log-in to the DCAE bootstrap POD's main container
-------------------------------------------------
First, we should find the bootstrap pod name through the following command and make sure that DCAE coudify manager is properly deployed.
.. image :: .images/bootstrap-pod.png

Login to the DCAE bootstrap pod through the following command.
  .. code-block :: bash

     #kubectl exec -it <DCAE bootstrap pod> /bin/bash -n onap

Validate Blueprint
-------------------
  .. code-block :: bash

     cfy blueprints validate /blueprints/k8s-dl-handler.yaml

Upload the Blueprint to Cloudify Manager.
-----------------------------------------
  .. code-block :: bash

     #cfy blueprint upload -b datalake-feeder /bluerints/k8s-datalake-feeder.yaml
     #cfy blueprint upload -b datalake-admin-ui /blueprints/k8s-datalake-admin-ui.yaml

Verify Uploaded Blueprints
--------------------------
  .. code-block :: bash

     #cfy blueprint list

You can see the following returned message to show the blueprints have been correctly uploaded.
  .. image :: ./imagesblueprint-list.png


Verify Plugin Versions
------------------------------------------------------------------------------
If the version of the plugin used is different, update the blueprint import to match.
  .. code-block :: bash

     #cfy plugins list

Create Deployment
-----------------
Here we are going to create deployments for both feeder and admin UI.
  .. code-block :: bash

     #cfy deployments create -b datalake-feeder feeder-deploy
     #cfy deployments create -b datalake-admin-ui admin-ui-deploy

Launch Service
---------------
Next, we are going to launch the datalake.
  .. code-block :: bash

     #cfy executions start -d feeder-deploy install
     #cfy executions start -d admin-ui-deploy install

Uninstall
----------
Uninstall running component and delete deployment
  .. code-block :: bash

     #cfy uninstall feeder-deploy
     #cfy uninstall admin-ui-deploy

Delete Blueprint
------------------
  .. code-block :: bash

     #cfy blueprints delete datalake-feeder
     #cfy blueprints deltet datalake-admin-ui
