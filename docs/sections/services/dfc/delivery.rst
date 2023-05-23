.. This work is licensed under a Creative Commons Attribution 4.0 International License.
.. http://creativecommons.org/licenses/by/4.0

Delivery
========

Docker Container
----------------

DFC is delivered as a docker container. The latest released version can be downloaded from nexus:

    ``docker pull nexus3.onap.org:10001/onap/org.onap.dcaegen2.collectors.datafile.datafile-app-server:latest``

For released version, it is possible to replace the tag 'latest' with any release version that seems suitable. Available images
are visible following this `link`_.

.. _link: https://nexus3.onap.org/#browse/search=keyword%3D*collectors.datafile*


ONAP Gerrit
-----------

It is possible to clone the Gerrit repository of DFC at this
`link <https://gerrit.onap.org/r/#/admin/projects/dcaegen2/collectors/datafile>`__.
Choose your preferred settings (ssh, http or https, with or without hook) and run the command in your terminal.

DFC deployment is handled through Helm charts under OOM repository `here`_.

.. _here: https://gerrit.onap.org/r/gitweb?p=oom.git;a=tree;f=kubernetes/dcaegen2-services/components/dcae-datafile-collector
