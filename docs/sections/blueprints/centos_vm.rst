CentOS VM
======================

Note: This blueprint is intended to be deployed, automatically, as part of the
DCAE bootstrap process, and is not normally invoked manually.

This blueprint controls the deployment of a VM running the CentOS 7 operating system, used to
run an instance of the Cloudify Manager orchestration engine.

This blueprint is used to bootstrap an installation of Cloudify Manager.  All other DCAE 
components are launched using Cloudify Manager.  The Cloudify Manager VM and the Cloudify Manager
software are launched using the Cloudify command line software in its local mode.

Blueprint files
----------------------

The blueprint file is stored under source control in the ONAP ``dcaegen2.platform.blueprints`` project, in the ``blueprints``
subdirectory of the project, as a template named ``centos_vm.yaml-template``.  The build process expands
the template to fill in certain environment-specific values.  In the ONAP integration environment, the build process
uploads the expanded template, using the name ``centos_vm.yaml``, to a well known-location in a Nexus artifact repository.

Parameters
---------------------

This blueprint has the following required input parameters:
* ``centos7image_id``

  This is the OpenStack image ID of the Centos7 VM image that will be
  used to launch the Cloudify Manager VM.

* ``ubuntu1604image_id``

  This is not used by the blueprint but is specified here so that the blueprint
  can use the same common inputs file as other DCAE VMs (which use an Ubuntu 16.04 image).

* ``flavor_id``

  This is the OpenStack flavor ID specifying the amount of memory, disk, and
  CPU available to the Cloudify Manager VM.  While the required values will be
  largely application dependent, a minimum of 16 Gigabytes of memory is
  strongly recommended.

* ``security_group``

  This is the OpenStack security group specifying permitted inbound and
  outbound IP connectivity to the VM.

* ``public_net``

  This is the name of the OpenStack network from which a floating IP address
  for the VM will be allocated.

* ``private_net``

  This is the name of the OpenStack network from which fixed IP addresses for
  the VM will be allocated.

* ``openstack``

  This is the JSON object / YAML associative array providing values necessary
  for accessing OpenStack.  The keys are:

  * ``auth_url``

    The URL for accessing the OpenStack Identity V2 API.  (The version of
    Cloudify currently being used, and the associated OpenStack plugin do
    not currently support Identity V3).

  * ``tenant_name``

    The name of the OpenStack tenant/project where the VM will be launched.

  * ``region``

    The name of the OpenStack region within the deployment.  In smaller
    OpenStack deployments, where there is only one region, the region is
    often named ``RegionOne``.

  * ``username``

    The name of the OpenStack user used as a credential for accessing
    OpenStack.

  * ``password``

    The password of the OpenStack user.  (The version of Cloudify currently
    being used does not provide a mechanism for encrypting this value).

* ``keypair``

  The name of the ssh "key pair", within OpenStack, that will be given access,
  via the ubuntu login, to the VMs.  Note: OpenStack actually stores only the
  public key.

* ``key_filename``

  The full file path, on the Cloudify Manager VM,
  of the ssh private key file corresponding to the ``keypair`` input parameter.

* ``location_domain``

  The DNS domain/zone for DNS entries associated with the VM.
  If, for example, location_domain is ``dcae.example.com`` then the FQDN for
  a VM with hostname ``abcd`` would be ``abcd.dcae.example.com`` and a DNS
  lookup of that FQDN would lead an A (or AAAA) record giving the floating
  IP address assigned to that VM.

* ``location_prefix``

  The hostname prefix for hostname of the VM.  The hostname
  assigned to the VM is created by concatenating this prefix with a suffix
  identifying the Cloudify Manager VM (``orcl00``).  If the location prefix is ``jupiter`` then the hostname of
  the Cloudify Manager VM would be ``jupiterorcl00``.

* ``codesource_url`` and ``codesource_version``

  This is not used by the blueprint but is specified here so that the blueprint
  can use the same common inputs file as other DCAE VMs.  Some of the other VMs use
  combination of ``codesource_url`` and ``codesource_version`` to locate scripts 
  that are used at installation time.
* ``datacenter``

  The datacenter name that is used by the DCAE Consul installation.  This is needed so that the Consul agent
  installed on the Cloudify Manager VM can be configured to register itself to the Consul service discovery system.
  
This blueprint has the following optional inputs:

* ``cname`` (default ``dcae-orcl``)

  A DNS alias name for the Cloudify Manager VM.  In addition to creating a DNS A record for the Cloudify Manager VM,
  the installation process also creates a CNAME record, using ``dcae-orcl`` by default as the alias.
  For example, if the ``location_domain`` input is ``dcae.example.com``, the ``location_prefix`` input is ``jupiter``,
  and the ``cname`` input is the default ``dcae-orcl``, then the installation process will create an A record for 
  ``jupiterorcl00.dcae.example.com`` and a CNAME record for ``dcae-orcl.dcae.example.com`` that points to
  ``jupiterorcl00.dcae.example.com``.


How To Run
---------------------

This blueprint is run as part of the bootstrapping process.  (See the ``dcaegen2.deployments`` project.) 
Running it manually requires setting up a Cloudify 3.4 command line environment--something that's handled
automatically by the bootstrap process.


