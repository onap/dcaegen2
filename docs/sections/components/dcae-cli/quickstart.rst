.. This work is licensed under a Creative Commons Attribution 4.0 International License.
.. http://creativecommons.org/licenses/by/4.0

.. _quickstart:

Overview
========

The ``dcae-cli`` is a Python command-line tool for component developers.
With it, the developer can :

-  validate the data formats and component specifications
-  publish the validated data formats and component specifications into
   the ``onboarding catalog``
-  access the ``onboarding catalog`` to search for existing data formats
   (for possible reuse) and component specs
-  deploy a component onto a local or remote DCAE platform for
   functional and pair-wise testing (This is done without Cloudify)

The git repository for the dcae_cli tool can be found
`here <https://gerrit.onap.org/r/gitweb?p=dcaegen2/platform/cli.git>`__

Pre-requisites
--------------

For Docker
~~~~~~~~~~

There are two options for development with Docker:

For local development
^^^^^^^^^^^^^^^^^^^^^

-  Install `Docker engine <https://docs.docker.com/engine/installation/>`__ locally on
   your machine.
-  Know the *external ip* of where the Docker engine is running. The
   external ip is needed so that service discovery will connect to it.

   -  *(For OSX users, this means making sure the VirtualBox VM that is
      running your Docker engine has a bridged adapter and getting the
      ip of that adapter).*

For remote development
^^^^^^^^^^^^^^^^^^^^^^

-  Have access to a remote host with Docker engine installed and with
   remote API access.
-  Have the associated connection information:

   -  domain name or IP and port (port should be either 2375 or 2376).
      Use this information to establish an active
      :any:`profile <dcae_cli_activate_profile>`.

For CDAP
~~~~~~~~

None at this time.

Python, Pip, Virtualenv
~~~~~~~~~~~~~~~~~~~~~~~

Install python, pip (9.0.1 or higher), and virtualenv if they are not
installed. Do these when not in a VPN to avoid possible network issues.

::

      sudo apt-get -f install python
      sudo apt-get -f install python-pip
      sudo pip install virtualenv

Set up a virtual environment and activate

::

      virtualenv cli_tool
      source cli_tool/biin/activate 

Install dcae_cli
----------------

::

    pip install onap-dcae-cli

Check dcae_cli version
----------------------

You can verify the version of the dcae-cli with the following command.
To get the latest version of the dcae_cli tool,

::

    $ dcae_cli --version

Upgrade dcae_cli
----------------

Periodically, upgrade the dcae_cli to get the latest version

::

    pip install --upgrade onap-dcae-cli

Configuration
-------------

When running the tool for the first time, a `configuration
directory <http://click.pocoo.org/5/api/#click.get_app_dir>`__ and
configuration file will be created.

The configuration is first sourced from a remote server that is managed
by the platform team. You will be prompted to enter your ATTUID to
complete this process.

Re-initializing Configuration
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Configuration can be re-initialized or reset. There is a ``--reinit``
flag that is to be used to re-initialize your configuration and your
environment profiles. You may be instructed to re-initialize after
certain updates are made to the dcae_cli tool. When you re-initialize
the configuration, your configuration will be added to or updated from
the platform configuration and profiles. No profiles will be deleted via
the reinit process.

To re-initialize:

::

    $ dcae_cli --reinit

Verify Installation
-------------------

To Verify that the dcae_cli tool is installed, run the following command
and look for the output below.

::

    $ dcae_cli --help
    Usage: dcae_cli [OPTIONS] COMMAND [ARGS]...

    Options:
      -v, --verbose  Prints INFO-level logs to screen.
      --reinit       Re-initialize dcae-cli configuration
      --version      Show the version and exit.
      --help         Show this message and exit.

    Commands:
      catalog
      component
      data_format
      profiles

Refer to :doc:`dcae_cli Commands <./commands>`.

