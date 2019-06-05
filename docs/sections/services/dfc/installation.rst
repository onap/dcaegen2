.. This work is licensed under a Creative Commons Attribution 4.0 International License.
.. http://creativecommons.org/licenses/by/4.0

Installation
============

An environment suitable for running docker containers is recommended.

Using Cloudify deployment
-------------------------

The first possibility is to use blueprints and cfy commands.

Deployment Prerequisite/dependencies
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Make sure that **cfy** is installed and configured to work with the Cloudify deployment.

Make sure the Message Router and Data Router are running.

Deployment steps
^^^^^^^^^^^^^^^^

1. Execute bash on the cloudify manager kubernetes pod.

    ``kubectl -n onap exec -it <dev-dcaegen2-dcae-cloudify-manager> bash``

2. Download the dfc `blueprint`_.

.. _blueprint: https://gerrit.onap.org/r/gitweb?p=dcaegen2/platform/blueprints.git;a=blob;f=blueprints/reference_templates/k8s-datafile-collector.yaml-template;h=17d2aedec131154b4f5f84a08a099b0364b1e627;hb=HEAD

3. Run Cloudify Install command to install dfc.

    ``cfy install <dfc-blueprint-path>``

Sample output:

    ``cfy install k8s-datafile.yaml``

Run '*cfy events list -e 37da3f5f-a06b-4ce8-84d3-8b64ccd81c33'* to retrieve the execution's events/logs.

Validation
^^^^^^^^^^

curl <dcaegen2-dcae-healthcheck> and check if datafile-collector is in *'ready'* state.

Standalone deployment of a container
------------------------------------

DFC is delivered as a docker container based on openjdk:8-jre-alpine.  The
host or VM that will run this container must have the docker application
loaded and available to the userID that will be running the DFC container.

Also required is a working DMAAP/MR and DMAAP/DR environment. DFC
subscribes to DMAAP/MR fileReady event as JSON messages and publishes the downloaded files to the DMAAP/DR.

Installation
^^^^^^^^^^^^

The following command will download the Dublin version of the datafile container from
nexus and launch it in the container named "datafile":

    ``docker run -d -p 8100:8100 -p 8433:8433 nexus3.onap.org:10001/onap/org.onap.dcaegen2.collectors.datafile.datafile-app-server:1.1.3``

For another version, it is possible to replace the tag '1.1.3' with any version that seems suitable (including latest).
Available images are visible following this `link`_.

.. _link: https://nexus3.onap.org/#browse/search=keyword%3D*datafile*

Another option is to pull the container first, and then run it with the image ID:

    ``docker pull nexus3.onap.org:10001/onap/org.onap.dcaegen2.collectors.datafile.datafile-app-server:latest``

    ``docker images | grep 'datafile'``

    ``docker run -d -p 8100:8100 -p 8433:8433 <image ID>``

The grep command will display the images corresponding to DFC. There can be several due to remotely or locally built
image, and also to different tags, i.e. different versions.
