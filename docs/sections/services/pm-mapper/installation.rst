.. This work is licensed under a Creative Commons Attribution 4.0 International License.
.. http://creativecommons.org/licenses/by/4.0

Installation
============

PM mapper is a microservice that will be configured and instantiated through Cloudify Manager, either through the user
interface or the command line tool. During instantiation, the PM Mapper will fetch its configuration through the Config Binding Service. Steps to deploy using the CLI tool are shown below.

Deployment Prerequisite/dependencies
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

    - DCAE Platform, Consul, AAF and DMaaP pods should be up and running.
    - DCAE Dashboard credentials are known.

Deployment steps
^^^^^^^^^^^^^^^^
- Download the PM Mapper blueprint, this can be found in:

        https://git.onap.org/dcaegen2/services/pm-mapper/tree/dpo/blueprints/k8s-pm-mapper.yaml?h=elalto

- Open the DCAE Dashboard.
    - Navigate to 'Inventory' > 'Blueprints'.
    - Click the 'Create' button in the top left.
    - Drag and drop the previously downloaded PM Mapper blueprint into appropriately labeled field.
    - Fill in the remaining of the required fields and click the create button at the bottom of the screen.
    - Find the blueprint in the list, select the 'Actions' button then the 'Deploy' option.
    - Select the targetted tenant.
    - Configure the parameters
         The PM Mapper blueprints were designed with sane defaults for the majority of the fields.
         Below you will find more information about the fields, whether some input is required for them or not and some example values.

         .. csv-table::
            :widths: auto
            :delim: ;
            :header: Property , Sample Value , Description , Input Required

            client_id ; dcae@dcae.onap.org ; Information about the AAF user must be provided to enable publishing to authenticated topics. ; Yes
            client_password ; <dcae_password> ; This is the password for the given user e.g.  The <dcae_password> is dcae@dcae.onap.org's password. ; Yes
            enable_http ; true ; By default, the PM-Mapper will only allow inbound queries over HTTPS. However, it is possible to configure it to enable HTTP also. ; No
            tag_version ; nexus3.onap.org:10001/onap/org.onap.dcaegen2.services.pm-mapper:1.3.1 ; The tag of the Docker image will be used when deploying the PM-Mapper. ; No
            pm-mapper-filter ; {"filters": [{"pmDefVsn":"targetVersion", "nfType":"targetNodeType", "vendor":"targetVendor","measTypes":["targetMeasType"]}]} ; The default behavior of the PM-Mapper is to map all measType in the received PM XML files, however, it's possible to provide filtering configuration which will reduce the VES event to the counters that the designer has expressed interest in. ; No

    - Select the 'Deploy' button at the bottom of the screen.
