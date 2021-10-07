.. This work is licensed under a Creative Commons Attribution 4.0 International License.
.. http://creativecommons.org/licenses/by/4.0
.. _dl-installation-helm:

Datalake helm installation
==========================

DL-handler consists of three pods- the feeder, admin UI and des. It can be deployed by using helm charts. The following steps
guides you launch datalake though helm.



Pre-requisite
~~~~~~~~~~~~~
Dcae postgres should be properly deployed and functional.

Presto service should be deployed for des deployment.

The environment should have helm and kubernetes installed.

Check whether all the charts mentioned in the requirements.yaml file are present in the charts/ folder. If not present,
package the respective chart and put it in the charts/ folder.
For example:
    .. code-block:: bash
        helm package <dcaegen2-services-common>



Deployment steps
~~~~~~~~~~~~~~~~
Validate the charts using below commands
    .. code-block:: bash
        helm lint <dcae-datalake-admin-ui>
        helm lint <dcae-datalake-feeder>
        helm lint <dcae-datalake-des>


Deploy the charts using below commands
    .. code-block:: bash
        helm install <datalake-admin-ui> <dcae-datalake-admin-ui> --namespace onap --set global.masterPassword=<password>
        helm install <datalake-feeder> <dcae-datalake-feeder> --namespace onap --set global.masterPassword=<password>
        helm install <datalake-des> <dcae-datalake-des> --namespace onap --set global.masterPassword=<password>


For checking logs of the containers
    .. code-block:: bash
        kubectl logs -f -n onap <dev-dcae-datalake-admin-ui-843bfsk4f4-btd7s> -c <dcae-datalake-admin-ui>
        kubectl logs -f -n onap <dev-dcae-datalake-feeder-758bbf547b-ctf6s> -c <dcae-datalake-feeder>
        kubectl logs -f -n onap <dev-dcae-datalake-des-56465d86fd-2w56c> -c <dcae-datalake-des>


To un-deploy
    .. code-block:: bash
        helm uninstall <datalake-admin-ui>
        helm uninstall <datalake-feeder>
        helm uninstall <datalake-des>



Application configurations
~~~~~~~~~~~~~~~~~~~~~~~~~~
Datalake-admin-ui:
+-------------------------------+------------------------------------------------+
|Configuration                  | Description                                    |
+===============================+================================================+
|FEEDER_ADDR                    | Host where dl-feeder is running                |
+-------------------------------+------------------------------------------------+


Datalake-feeder:
+-------------------------------+------------------------------------------------+
|Configuration                  | Description                                    |
+===============================+================================================+
|PRESTO_HOST			| Host where the presto application is running   |
+--------------------------------------------------------------------------------+
|PG_HOST			| Host where the postgres application is running |
+--------------------------------------------------------------------------------+
|CONSUL_HOST			| Host where counsul loader container is running |
+--------------------------------------------------------------------------------+
|PG_DB				| Postgress database name			 |
+--------------------------------------------------------------------------------+


Datalake-Des:
+-------------------------------+------------------------------------------------+
|Configuration                  | Description                                    |
+===============================+================================================+
|PRESTO_HOST			| Host where the presto application is running   |
+--------------------------------------------------------------------------------+
|PG_HOST			| Host where the postgres application is running |
+--------------------------------------------------------------------------------+
|PG_DB				| Postgress database name			 |
+--------------------------------------------------------------------------------+

