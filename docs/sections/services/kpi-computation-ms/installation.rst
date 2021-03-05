.. This work is licensed under a Creative Commons Attribution 4.0 International License.
.. http://creativecommons.org/licenses/by/4.0
.. _kpi-installation:


Installation
============

Kpi Computation MS can be deployed using cloudify blueprint using bootstrap container of an existing DCAE deployment.

Deployment Pre-requisites
~~~~~~~~~~~~~~~~~~~~~~~~~
- DCAE and DMaaP pods should be up and running. 

- PM mapper service should be running.

- Make sure that cfy is installed and configured to work with the Cloudify deployment.


Deployment steps
~~~~~~~~~~~~~~~~
Execute bash on the bootstrap Kubernetes pod. 
   
   kubectl -n onap exec -it <dcaegen2-dcae-bootstrap> bash

Validate Blueprint
------------------
Before the blueprints uploading to Cloudify manager, the blueprints shoule be validated first through the following command.
  .. code-block :: bash

    #cfy blueprint validate /bluerints/k8s-kpi-ms.yaml

Upload the Blueprint to Cloudify Manager.
-----------------------------------------
After validating, we can start to proceed blueprints uploading.
  .. code-block :: bash

     #cfy blueprint upload -b kpi-ms /bluerints/k8s-kpi-ms.yaml

Verify Uploaded Blueprints
--------------------------
Using "cfy blueprint list" to verify your work.
  .. code-block :: bash

     #cfy blueprint list

You can see the following returned message to show the blueprints have been correctly uploaded.
  .. image :: ./blueprint-list.png


Verify Plugin Versions
----------------------
If the version of the plugin used is different, update the blueprint import to match.
  .. code-block :: bash

     #cfy plugins list

Create Deployment
-----------------
Here we are going to create deployments for both feeder and admin UI.
  .. code-block :: bash

     #cfy deployments create -b kpi-ms kpi-ms

Launch Service
--------------
Next, we are going to launch the datalake.
  .. code-block :: bash

     #cfy executions start -d kpi-ms install


Verify the Deployment Result
----------------------------
The following command can be used to list the datalake logs.

  .. code-block :: bash
  
     #kubectl logs <kpi-pod> -n onap

The output should looks like.
    .. image :: ./kpi-log.PNG

Uninstall
---------
Uninstall running component and delete deployment
  .. code-block :: bash

     #cfy uninstall kpi-ms

Delete Blueprint
----------------
  .. code-block :: bash

     #cfy blueprints delete kpi-ms