CDAP
======================

Note: This blueprint is intended to be deployed, automatically, as part of the
DCAE bootstrap process, and is not normally invoked manually.

The ONAP DCAEGEN2 CDAP blueprint deploys a 7 node Cask Data Application
Platform (CDAP) cluster (version 4.1.x), for running data analysis
applications.  The template for the blueprint is at
``blueprints/cdapbp7.yaml-template`` in the ONAP
``dcaegen2.platform.blueprints`` project.  The ``02`` VM in the cluster
will be the CDAP master.

Blueprint Input Parameters
---------------------

This blueprint has the following required input parameters:

* ``ubuntu1604image_id``

  This is the OpenStack image ID of the Ubuntu 16.04 VM image that will be
  used to launch the 7 VMs making up the cluster.

* ``flavor_id``

  This is the OpenStack flavor ID specifying the amount of memory, disk, and
  CPU available to each VM in the cluster.  While the required values will be
  largely application dependent, a minimum of 32 Gigabytes of memory is
  strongly recommended.

* ``security_group``

  This is the OpenStack security group specifying permitted inbound and
  outbound IP connectivity to the VMs in the cluster.

* ``public_net``

  This is the name of the OpenStack network from which floating IP addresses
  for the VMs in the cluster will be allocated.

* ``private_net``

  This is the name of the OpenStack network from which fixed IP addresses for
  the VMs in the cluster will be allocated.

* ``openstack``

  This is the JSON object / YAML associative array providing values necessary
  for accessing OpenStack.  The keys are:

  * ``auth_url``

    The URL for accessing the OpenStack Identity V2 API.  (The version of
    Cloudify currently being used, and the associated OpenStack plugin do
    not currently support Identity V3).

  * ``tenant_name``

    The name of the OpenStack tenant/project where the VMs will be launched.

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

  The full file path, on the Cloudify Manager VM used to deploy this blueprint,
  of the ssh private key file corresponding to the ``keypair`` input parameter.

* ``location_domain``

  The DNS domain/zone for DNS entries associated with the VMs in the cluster.
  If, for example, location_domain is ``dcae.example.com`` then the FQDN for
  a VM with hostname ``abcd`` would be ``abcd.dcae.example.com`` and a DNS
  lookup of that FQDN would lead an A (or AAAA) record giving the floating
  IP address assigned to that VM.

* ``location_prefix``

  The hostname prefix for hostnames of VMs in the cluster.  The hostnames
  assigned to the VMs are created by concatenating this prefix with a suffix
  identifying the individual VMs in the cluster (``cdap00``, ``cdap01``, ...,
  ``cdap06``).  If the location prefix is ``jupiter`` then the hostname of
  the CDAP master in the cluster would be ``jupitercdap02``.

* ``codesource_url`` and ``codesource_version``

  ``codesource_url`` is the base URL for downloading DCAE specific project
  installation scripts.  The intent is that this URL may be environment
  dependent, (for example it may, for security reasons, point to an internal
  mirror).  This is used in combination with the ``codesource_version`` input
  parameter to determine the URL for downloading the scripts.  There are 2
  scripts used by this blueprint - ``cdap-init.sh`` and
  ``instconsulagentub16.sh`` These scripts are part of the
  dcaegen2.deployments ONAP project.  This blueprint assumes that curl/wget
  can find these scripts at
  *codesource_url/codesource_version*\ ``/raw/cloud_init/cdap-init.sh`` and
  *codesource_url/codesource_version*\ ``/raw/cloud_init/instconsulagentub16.sh``
  respectively.  For example, if codesource_url is
  ``https://mymirror.example.com`` and codesource_version is ``rel1.0``,
  then the installation scripts would be expected to be stored under
  ``https://mymirror.example.com/rel1.0/raw/cloud_init/``

This blueprint has the following optional inputs:

* ``location_id`` (default ``solutioning-central``)

  The name of the Consul cluster to register this CDAP cluster with.

* ``cdap_cluster_name`` (default ``cdap``)

  The name of the service to register this cluster as, in Consul.
