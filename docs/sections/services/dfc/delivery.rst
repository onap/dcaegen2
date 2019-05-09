.. This work is licensed under a Creative Commons Attribution 4.0 International License.
.. http://creativecommons.org/licenses/by/4.0

Delivery
========

Docker Container
----------------

DFC is delivered as a docker container. The latest released version (Dublin) can be downloaded from nexus:

    ``docker pull nexus3.onap.org:10001/onap/org.onap.dcaegen2.collectors.datafile.datafile-app-server:1.1.2``

For another version, it is possible to replace the tag '1.1.2' with any version that seems suitable. Available images
are visible following this `link`_.

.. _link https://nexus3.onap.org/#browse/search=keyword%3D*datafile*


ONAP Gerrit
-----------

It is possible to clone the Gerrit repository of DFC with at this `link`_. Choose your preferred settings (ssh, http or
https, with or without hook) and run the command in your terminal.

.. _link https://gerrit.onap.org/r/#/admin/projects/dcaegen2/collectors/datafile

If using Cloudify to deploy DFC, the blueprints are needed, and can be found `here`_.

.. _here https://gerrit.onap.org/r/gitweb?p=dcaegen2/platform/blueprints.git;a=blob;f=blueprints/reference_templates/k8s-datafile-collector.yaml-template;h=17d2aedec131154b4f5f84a08a099b0364b1e627;hb=HEAD