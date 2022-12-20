.. This work is licensed under a Creative Commons Attribution 4.0 International License.
.. http://creativecommons.org/licenses/by/4.0

.. _ves-openapi-manager-deployment:

VES OpenAPI Manager deployment
==============================
VES OpenAPI Manager is a simple Java application which can be started by using only Java 11+, yet it has some
prerequisites to work correctly:

1) File with OpenAPI schemas mappings.
2) Access to two ONAP services: SDC BE and Kafka.

These prerequisites are met by default when using Helm charts created for VES OpenAPI Manager in OOM. It's described in
more detail in *Helm chart* section.

There is also available a simple configuration via environment variables which are optional. It's described in more
detail in *Environment variables* section.

File with OpenAPI schemas mappings
----------------------------------
VES OpenAPI checks whether schemaReferences of distributed service align with stndDefined schemas from VES Collector.
To achieve that application should receive a file with mappings used by VES. Because there are few ways to run the
application, it contains its own default file which assure that application will work. Default file may be overwritten
or edited any time, even during application runtime.

Helm charts which are used to deploy application in ONAP cluster are configured to overwrite default mapping file with
file from predefined ConfigMap (named *dcae-external-repo-configmap-schema-map*), which is also used by VES Collector.
Using ConfigMap ensures that both: VES OpenAPI Manager and VES Collector use the exact same file.

.. warning::
    VES OpenAPI Manager does not check if the used mapping file is the same file that VES uses. Within ONAP, the working
    assumption is, that both: VES openAPI Manager and VES Collector leverage the same Kubernetes ConfigMaps, which
    contain the schema-mapping file and respective openAPI descriptions.

VES OpenAPI Manager has a configurable property which contains path to the mapping file. It has to be set before the
application startup. It can be done by setting environment variable *SCHEMA_MAP_PATH*. Helm charts are preconfigured to
set this variable.

Environment variables
---------------------
There are environment variables which must be used for configuration. Helm chart contain predefined values which are
valid when running VES OpenAPI Manager from its released image in the ONAP cluster.

+-----------------+---------------------------+----------------------+
| Variable name   | Description               | Helm chart values    |
+=================+===========================+======================+
| SCHEMA_MAP_PATH | Path to the mapping file. | /app/schema-map.json |
+-----------------+---------------------------+----------------------+
| ASDC_ADDRESS    | URL to SDC BE.            | sdc-be:8443          |
+-----------------+---------------------------+----------------------+


Helm chart
----------
By default VES OpenAPI Manger is deployed via Helm as the DCAE subcomponent in the ONAP cluster. Helm chart is
configured to deploy application with all prerequisites met. It achieves that by:

1) Mounting ConfigMap with mapping file under */app/schema-map.json* path.
2) Proper setting environment variables to values described in section *Environment variables*. Mapping file path is set to point to mounted file and SDC BE URL is set to internal port available only from Kubernetes cluster.
3) Setting Readiness check. It waits for other ONAP components to start: SDC BE, Kafka. VES OpenAPI Manager Pod will not start until they are not ready.

Local deployment
----------------
It's possible to run VES OpenAPI Manager in local environment which connects to external lab with ONAP. This way
requires exposing ports of some services on lab, creating local port tunneling and running VES OpenAPI Manager (using
docker-compose or IDE e.g. IntelliJ).

It's described in more detail in the README in project repository (`README <https://github.com/onap/dcaegen2-platform-ves-openapi-manager/blob/master/README.md>`_).