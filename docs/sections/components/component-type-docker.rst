.. This work is licensed under a Creative Commons Attribution 4.0 International License.
.. http://creativecommons.org/licenses/by/4.0

.. _docker-requirements:

Docker Component Requirements
=============================

Overview
--------

Component developers are required to provide artifacts for the platform
to be able to deploy your component including:

-  :any:`Component specification <docker-specification>`
-  :doc:`Data formats <data-formats>`
-  :any:`Auxiliary component specification <docker-auxiliary-details>`
-  :any:`Docker image <docker-on-the-platform>`

In addition, components will have to be enhanced to be compliant with
the DCAE platform in order to correctly be deployed and be managed. This
page will discuss the changes which are grouped into the following
categories:

-  :any:`Service registration <service-registration>`
-  :any:`Configuration management on the new platform <docker-configuration>`
-  :any:`Operational concerns <operational-concerns>`

To help component developers to make and to test the changes needed to
have components run on the platform, a command-line tool called
:doc:`dcae-cli <dcae-cli/quickstart>` is provided by the platform team.

.. _service-registration:

Service registration
--------------------

Every :doc:`Docker component is registered <architecture/service-discovery>` with the platform’s
service discovery layer. Docker components are not expected to make the
explicit make registration calls because that is done by through a
platform 3rd party registration service. A couple things are needed from
component developers in order for this registration to occur
successfully:

1. Docker images must be created from a Dockerfile that has an `EXPOSE <https://docs.docker.com/engine/reference/builder/#/expose>`_ instruction. This applies to components that listen on a port.
2. Component healthcheck details must be provided in the Docker
   auxiliary component specification

Expose port
~~~~~~~~~~~

Components that listen on a specific port must explicitly declare in
their Dockerfile that port using the ``EXPOSE`` instruction before
building the image. Warning! At the current time, you can not expose
multiple ports in your Dockerfile or registration *will not work*
correctly.

Health check
~~~~~~~~~~~~

Component developers are required to provide a way for the platform to periodically check the health of their running components. The platform uses Consul to perform these periodic calls. Consul provides different types of `check definitions <https://www.consul.io/docs/agent/checks.html>`_. The details of the definition used by your component is to be provided through the :any:`Docker auxiliary specification <docker-auxiliary-details>`.

.. _docker-configuration:

Configuration
-------------

The component’s application configuration is generated from the
submitted component specification into a JSON representation. The DCAE
platform will provide the configuration JSON by making it available on a
remote HTTP service. Components are required to pull their configuration
JSON at application startup. The configuration JSON is stored under the
components uniquely generated name which is provided by the environment
variable ``HOSTNAME``.

You can see more details on the generated application configuration
:any:`here <docker-specification>`.

Config binding service
~~~~~~~~~~~~~~~~~~~~~~

The config binding service is a platform HTTP service that is
responsible for providing clients with a fully resolved configuration
JSON at runtime. Components should make an HTTP GET on:

::

    <config binding service hostname>:<port>/service_component/NAME

For Docker components, NAME should be set to ``HOSTNAME``, which was
provided as an ENV variable inside of your container.

The binding service integrates with the streams and services section of
your component specification. For example, if you specify that you call
a service:

::

    "services": {
        "calls": [{
            "config_key": "vnf-db",
            "request": {
                "format": "dcae.vnf.meta",
                "version": "1.0.0"
                },
            "response": {
                "format": "dcae.vnf.kpi",
                "version": "1.0.0"
                }
        }],
    ...
    }

Then the config binding service will find all available IP addresses of
services meeting your needs, and provide them to you under your
``config_key``:

::

    // your configuration
    {
        "vbf-db" :                 // see above 
            [IP:Port1, IP:Port2,…] // all of these meet your needs, choose one.
    }

Regarding ``<config binding service hostname>:<port>``, there is DNS
work going on to make this resolvable in a convenient way inside of your
container. However, currently you will be given a name as an ENV
variable, ``CONFIG_BINDING_SERVICE``, and you will need to query
Consul’s service discovery to get
``<config binding service hostname>:<port>``.

Policy Reconfiguration
~~~~~~~~~~~~~~~~~~~~~~

*(Draft and subject to change)*

Components must provide a way to receive policy reconfiguration, that
is, configuration parameters that have been updated via the Policy UI.
The component developer provides a docker script (defined in the :any:`Docker auxiliary specification <docker-specification>`)
that will be triggered when this occurs.

DMaaP
~~~~~

Components can be publishers or subscribers to either message router
topics or data router feeds. This is defined in the component
specification under the ``streams`` section where you can specify
whether your component is expected to subscribe or to publish to a
:any:`message router topic <message-router>` or to a :any:`data router feed <data-router>`.
Given a composition with components that use DMaaP, the platform will
provision the topic or feed and provide the necessary :any:`connection details <dcae-cli/dmaap-connection-objects>` at runtime for each DMaaP
dependent component. These connection details will be provided through
your application’s :any:`generated configuration <component-specification/generated-configuration>`.

In order to test DMaaP connections in onboarding, the developer
(currently) must provision all test topics and feeds manually and
provide the :any:`dcae-cli with the connection details <dmaap-testing>` when deploying your
application.

.. _docker-on-the-platform:

Docker on the platform
----------------------

Images
~~~~~~

Docker images must be pushed to the environment specific Nexus
repository. This requires tagging your build with the full name of you
image which includes the Nexus repository name.

Use the Docker command-line to `tag <https://docs.docker.com/engine/reference/commandline/tag/>`_ your Docker image where the *target image* must contain the registry host name and port.

For example, an application called laika has been tagged for an example
Nexus registry:

::

    $ docker images
    REPOSITORY                                                                               TAG                 IMAGE ID            CREATED             SIZE
    YOUR_NEXUS_DOCKER_REGISTRY/laika                                                 0.4.0               154cc382df61        7 weeks ago         710.5 MB
    laika                                                                                    0.4.0               154cc382df61        7 weeks ago         710.5 MB

Note, the Docker registry that is used may require a login to
authenticate.

::

    docker login YOUR_NEXUS_DOCKER_REGISTRY

Tag your image:

::

    docker tag laika:0.4.0 YOUR_NEXUS_DOCKER_REGISTRY/laika:0.4.0

Or build and tag:

::

    docker build -t YOUR_NEXUS_DOCKER_REGISTRY/laika:0.4.0 .

After tagging, upload your image to the remote registry using the Docker `push command <https://docs.docker.com/engine/reference/commandline/push/>`_ .
Note that the registry may require a login. Use the Docker `login command <https://docs.docker.com/engine/reference/commandline/login/>`_
before pushing in that case.

::

    docker push YOUR_NEXUS_DOCKER_REGISTRY/laika:0.4.0

*NOTE* Replace ``laika`` with your application’s name. Replace the
``0.4.0`` version with your application’s version.

Ports
~~~~~

On the DCAE platform, Docker components are run with the ``--publish-all`` or ``-P`` argument. This means the Docker container
for your component will be listening on a random port and that random
port will be mapped to the port :any:`you exposed <service-registration>`.

Envs
~~~~

The platform provides a set of environment variables into each Docker
container:

+----------------------------+----+----------+
| Na\                        | Ty\| Descript\|
| me                         | pe | ion      |
+============================+====+==========+
| ``HOSTNAME``               | st\| Unique   |
|                            | ri\| name of  |
|                            | ng | the      |
|                            |    | componen\|
|                            |    | t        |
|                            |    | instance |
|                            |    | that is  |
|                            |    | generate\|
|                            |    | d        |
+----------------------------+----+----------+
| ``CONSOL_HOST``            | st\| Hostname |
|                            | ri\| of the   |
|                            | ng | platform\|
|                            |    | ’s       |
|                            |    | Consul   |
|                            |    | instance |
|                            |    |          |
|                            |    |          |
+----------------------------+----+----------+
| ``CONFIG_BINDING_SERVICE`` | st\| Hostname |
|                            | ri\| of the   |
|                            | ng | platform\|
|                            |    | ’s       |
|                            |    | config   |
|                            |    | binding  |
|                            |    | service  |
|                            |    | instance |
|                            |    |          |
|                            |    |          |
|                            |    |          |
|                            |    |          |
|                            |    |          |
+----------------------------+----+----------+
| ``DOCKER_HOSTS``           | st\| Host of  |
|                            | ri\| the      |
|                            | ng | target   |
|                            |    | platform |
|                            |    | Docker   |
|                            |    | host to  |
|                            |    | run the  |
|                            |    | containe\|
|                            |    | r        |
|                            |    | on       |
+----------------------------+----+----------+

.. _operational-concerns:

Operational concerns
--------------------

Logging
~~~~~~~

Currently the platform uses the default ``json-file`` logging driver for
Docker. For onboarding testing, component developers can access their
logs from their Docker containers either by running their component
using the ``--attached`` flag or by using the ``docker logs`` command.
The requirement is that applications must write to stdout and/or stderr.

To use the ``docker logs`` command for your deployed running Docker
container,

1. You must have Docker installed on your local machine
2. Have the generated name of your component. This is generated for you
   when you execute ``dcae_cli component dev`` or
   ``dcae_cli component run``.
3. Find the target Docker host using the ``dcae_cli profiles show``
   command:

::

    $ dcae_cli profiles show YOUR_PROFILE_NAME
    {
        ...
        "docker_host": "YOUR_DOCKER_HOST:2376"
    }

4. Set your Docker client to point to the target Docker host:

::

    $ export DOCKER_HOST="tcp://YOUR_DOCKER_HOST:2376"

5. Use the ``docker logs`` command:

::

    $ docker logs <generated component name>
