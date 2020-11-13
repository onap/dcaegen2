.. This work is licensed under a Creative Commons Attribution 4.0 International License.
.. http://creativecommons.org/licenses/by/4.0

Building DCAE
=============


Description
-----------
DCAE has multiple code repos and these repos are in several different languages.  All DCAE projects are built in similar fashion, following Maven framework as Maven projects.  Although many DCAE projects are not written in Java, adopting the Maven framework does help including DCAE projects in  the overall ONAP building methodology and CICD process.

All DCAE projects use ONAP **oparent** project POM as ancestor.  That is, DCAE projects inherent all parameters defined in the oparent project which include many ONAP wide configuration parameters such as the location of various artifact repos.

A number of DCAE projects are not written Java.  For these projects we use the CodeHaus Maven Execution plugin for triggering a Bash script at various stages of Maven lifecycle. The script is  mvn-phase-script.sh, located at the root of each non-Java DACE project.  It is in this script that the actual build operation is performed at different Maven phases.  For example, for a Python project, Maven test will actually trigger a call to tox to conduct project unit tests.

Below is a list of the repositories and their sub-modules, and the language they are written in.

* dcaegen2

 - docs (rst)
 - platformdoc (mkdoc)

* dcaegen2.analytics


* dcaegen2.analytics.tca-gen2

 - dcae-analytics (Java)
 - eelf-logger (Java)
 
* dcaegen2.collectors

 - dcaegen2.collectors.snmptrap (Python)
 - dcaegen2.collectors.ves (Java)
 - dcaegen2.collectors.hv-ves (Kotlin)
 - dcaegen2.collectors.datafile (Java)
 - dcaegen2.collectors.restconf (Java)

* dcaegen2.services

 - dcaegen2.services.heartbeat (Python)
 - dcaegen2.services.prh (Java)
 - dcaegen2.services.bbs-eventprocessor (Java)
 - dcaegen2.services.pm-mapper (Java)
 - dcaegen2.services.ves-mapper (Java)
 - dcaegen2.services.son-handler (Java)

* dcaegen2.deployments

 - scripts (bash, python)
 - tls-init-container (bash)
 - k8s-bootstrap-container (bash)
 - healthcheck-container (Node.js)
 - k8s-bootstrap-container (bash)
 - tca-cdap-container (bash)
 - multisite-init-container (python)
 - dcae-remote-site (helm chart)

* dcaegen2.platform

* dcaegen2.platform.blueprints

 - blueprints (yaml)
 - input-templates (yaml)

* dcaegen2.platform.cli (Python)

 - component-json-schemas (yaml)
 - dcae-cli (Python)

* dcaegen2.platform.configbinding (Python)

* dcaegen2.platform.deployment-handler (NodeJS)

* dcaegen2.platform.inventory-api (Java) 

* dcaegen2.platform.plugins

 - cdap (Python)
 - dcae-policy (Python)
 - docker (Python)
 - relationships (Python)
 - k8splugin (Python)

* dcaegen2.platform.policy-handler (Python)

* dcaegen2.platform.servicechange-handler (Clojure)

* dcaegen2.utils

 - onap-dcae-cbs-docker-client (Python)
 - onap-dcae-dcaepolicy-lib (Python)
 - python-discovery-client (Python)
 - python-dockering (Python)
 - scripts (bash)


Environment
-----------
Building is conducted in a Linux environment that has the basic building tools such as JDK 8, Maven 3, Python 2.7 and 3.6, docker engine, etc.


Steps
-----
Because of the uniform adoption of Maven framework, each project can be built by running the standard Maven build commands:  mvn clean, install, deploy, etc.  For projects with submodules, the pom file in the project root will descent to the submodules and complete the submodule building.


Artifacts
---------
Building of DCAE projects produce three different kinds of artifacts: Java jar files, raw file artifacts (including yaml files, scripts, wagon packages, etc), Pypi packages, and docker container images.  



