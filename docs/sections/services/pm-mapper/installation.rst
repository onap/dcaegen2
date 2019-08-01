.. This work is licensed under a Creative Commons Attribution 4.0 International License.
.. http://creativecommons.org/licenses/by/4.0

Installation
============

PM mapper is a microservice that will be configured and instantiated through Cloudify Manager, either through the user
interface or the command line tool. During instantiation, the PM Mapper will fetch its configuration through the Config Binding Service. Steps to deploy using the CLI tool are shown below.

Deployment Prerequisite/dependencies
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

    - DCAE and DMaaP pods should be up and running.
    - DMaaP Bus Controller post install jobs should have completed successfully (executed as part of an OOM install).
    - Make sure that cfy is installed and configured to work with the Cloudify deployment.

Deployment steps
^^^^^^^^^^^^^^^^

Enter the Cloudify Manager kuberenetes pod

    - Download the PM Mapper blueprint onto the pod, this can be found in:

        https://git.onap.org/dcaegen2/services/pm-mapper/tree/dpo/blueprints/k8s-pm-mapper.yaml

    - Create inputs.yaml

        Configuration of the service consists of generating an inputs file (YAML) which will be used as part of the
        Cloudify install. The PM-Mapper blueprints were designed with sane defaults for the majority of the fields.
        Below you will find some examples of fields which can be configured, and some of the fields
        which must be configured. The full list of configurable parameters can be seen within the blueprint file under
        "inputs".

        .. csv-table::
            :widths: auto
            :delim: ;
            :header: Property , Sample Value , Description , Required

            client_id ; dcae@dcae.onap.org ; In the Dublin release information about the AAF user must be provided to enable publishing to authenticated topics. ; Yes
            client_password ; <dcae_password> ; This is the password for the given user e.g.  The <dcae_password> is dcae@dcae.onap.org's password. ; Yes
            enable_http ; true ; By default, the PM-Mapper will only allow inbound queries over HTTPS. However, it is possible to configure it to enable HTTP also. ; No
            tag_version ; nexus3.onap.org:10001/onap/org.onap.dcaegen2.services.pm-mapper:1.0.1 ; The tag of the Docker image will be used when deploying the PM-Mapper. ; No
            pm-mapper-filter ; {"filters": [{"pmDefVsn":"targetVersion", "nfType":"targetNodeType", "vendor":"targetVendor","measTypes":["targetMeasType"]}]} ; The default behavior of the PM-Mapper is to map all measType in the received PM XML files, however, it's possible to provide filtering configuration which will reduce the VES event to the counters that the designer has expressed interest in. ; No

        Example inputs.yaml

        .. code-block:: yaml

                client_id: dcae@dcae.onap.org
                client_password: <dcae_password>
                enable_http: false
                tag_version: nexus3.onap.org:10001/onap/org.onap.dcaegen2.services.pm-mapper:latest
                pm-mapper-filter: {"filters": []}



    - Create deployment

        .. code-block:: bash

            cfy install --blueprint-id pm-mapper --deployment-id pm-mapper -i inputs.yaml k8s-pm-mapper.yaml
