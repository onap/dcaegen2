.. This work is licensed under a Creative Commons Attribution 4.0 International License.
.. http://creativecommons.org/licenses/by/4.0

Installing PNDA During Helm Chart Based DCAE Deployment
=======================================================

PNDA is integrated into ONAP as a component system of DCAE. It is possible to deploy PNDA as
part of an ONAP OOM deployment on Openstack infrastructure. This is achieved by using a
pnda-bootstrap container in kubernetes to deploy Openstack VMs and then install a PNDA cluster
onto those VMs.

Requirements
------------

PNDA deployment within ONAP requires the following:

* Openstack based infrastructure. Follow the `PNDA guide <http://pnda.io/pnda-guide/provisioning/openstack/PREPARE.html>`_
  for more information.
* OOM / Helm template based installation of ONAP on Kubernetes.
* Kubernetes and PNDA need to share the same Openstack network subnet.

The dcae-pnda-bootstrap Helm chart currently deploys a PNDA cluster with the following resource
requirements:

+--------------------+--------------------+--------------------+--------------------+
|Node                |        CPU         |       RAM GB       |      Disk GB       |
+====================+====================+====================+====================+
|Gateway             |         2          |         4          |         20         |
+--------------------+--------------------+--------------------+--------------------+
|Edge                |         8          |         32         |         50         |
+--------------------+--------------------+--------------------+--------------------+
|Hadoop Manager      |         4          |         16         |         50         |
+--------------------+--------------------+--------------------+--------------------+
|Hadoop Data x 2     |         4          |         8          |      20 + 45       |
+--------------------+--------------------+--------------------+--------------------+
|Kafka               |         2          |         8          |         50         |
+--------------------+--------------------+--------------------+--------------------+

There are several parameters that need to be defined with values from your environment for a
successful PNDA deployment within ONAP. These parameters can be grouped in separate files that
are passed as parameters to helm install. With the following files, the command to install ONAP
with PNDA would then look like this:

::

    helm install -f ~/pnda.yaml -f ~/pnda-openstack.yaml -f ~/pnda-pem.yaml local/onap -n dev --namespace onap



``pnda.yaml``
-------------

This file contains settings to enable PNDA install and the evironment settings required by PNDA.

::

    pnda:
      dcae-pnda-bootstrap:
        enabled: true
        pnda:
          osUser: {guest-os-username}        # e.g. centos
          nameserver: nn.nn.nn.nn            # IP address of a reachable nameserver
          ntp: nn.nn.nn.nn                   # IP address of a reachable NTP server
          apps:
            fsType: local
          networkCidr: 192.168.0.0/24
          outboundCidr: 0.0.0.0/0

Description
~~~~~~~~~~~

+-----------------------------------------+----------+--------------------------------------------------------+
|pnda.dcae-pnda-bootstrap.enabled         |boolean   |Deploy PNDA or not.                                     |
+-----------------------------------------+----------+--------------------------------------------------------+
|pnda.dcae-pnda-bootstrap.pnda.osUser     |string    |Login used during PNDA installation process to connect  |
|                                         |          |to newly created Openstack PNDA instances.              |
+-----------------------------------------+----------+--------------------------------------------------------+
|pnda.dcae-pnda-bootstrap.pnda.nameserver |string    |IP address of the nameserver that will be used by all   |
|                                         |          |Openstack PNDA instances.                               |
+-----------------------------------------+----------+--------------------------------------------------------+
|pnda.dcae-pnda-bootstrap.pnda.ntp        |string    |Hostname or IP address of a NTP server. This NTP server |
|                                         |          |MUST be reachable from the Openstack PNDA instances.    |
+-----------------------------------------+----------+--------------------------------------------------------+
|pnda.dcae-pnda-bootstrap.pnda.apps.fsType|string    |Type of storage used to store PNDA application packages |
|                                         |          |(s3, sshfs, local, swift). Set it to local.             |
+-----------------------------------------+----------+--------------------------------------------------------+
|pnda.dcae-pnda-bootstrap.pnda.networkCidr|string    |CIDR specifying the address range for the network       |
|                                         |          |containing all PNDA instances.                          |
+-----------------------------------------+----------+--------------------------------------------------------+
|pnda.dcae-pnda-bootstrap.pnda.dataNodes  |number    |Number of data nodes to deploy. Defaults to 2.          |
+-----------------------------------------+----------+--------------------------------------------------------+
|pnda.dcae-pnda-bootstrap.pnda.kafkaNodes |number    |Number of kafka nodes to deploy. Defaults to 1.         |
+-----------------------------------------+----------+--------------------------------------------------------+


``pnda-openstack.yaml``
-----------------------

This file contains the Openstack connection settings and Openstack entity identifiers.

::

    pnda:
      dcae-pnda-bootstrap:
        openstack:
          keystoneUser: {openstack-username}
          keystonePassword: {openstack-password}
          keystoneTenant: {openstack-tenant-name}
          keystoneAuthUrl: {openstack-auth-url}             # e.g. http://openstack-host:5000/v2.0/
          keystoneRegion: {openstack-region-name}
          useExistingNetwork: true
          existingNetworkId: {kubernetes-cluster-network}
          existingSubnetId: {kubernetes-cluster-subnet}
          imageId: {pnda-vm-image-id}                       # Openstack imageId to use for PNDA VMs
          publicNetworkId: {public-network-id}              # Openstack networkId of public facing network
          publicSubnetCidr: nn.nn.nn.nn/nn                  # CIDR address of the public subnet e.g. 10.40.10.0/24

Description
~~~~~~~~~~~

+-----------------------------------------------------+----------+-----------------------------------------------+
|pnda.dcae-pnda-bootstrap.openstack.keystoneUser      |string    |Openstack user.                                |
+-----------------------------------------------------+----------+-----------------------------------------------+
|pnda.dcae-pnda-bootstrap.openstack.keystonePassword  |string    |Openstack password.                            |
+-----------------------------------------------------+----------+-----------------------------------------------+
|pnda.dcae-pnda-bootstrap.openstack.keystoneTenant    |string    |Openstack tenant.                              |
+-----------------------------------------------------+----------+-----------------------------------------------+
|pnda.dcae-pnda-bootstrap.openstack.keystoneAuthUrl   |string    |Openstack authentication url.                  |
+-----------------------------------------------------+----------+-----------------------------------------------+
|pnda.dcae-pnda-bootstrap.openstack.keystoneRegion    |string    |Openstack region.                              |
+-----------------------------------------------------+----------+-----------------------------------------------+
|pnda.dcae-pnda-bootstrap.openstack.useExistingNetwork|boolean   |Do you want to create a new Openstack network  |
|                                                     |          |or do you want to use an already existing one? |
+-----------------------------------------------------+----------+-----------------------------------------------+
|pnda.dcae-pnda-bootstrap.openstack.existingNetworkId |string    |If you want to use an already existing         |
|                                                     |          |Openstack network, specify its UUID.           |
+-----------------------------------------------------+----------+-----------------------------------------------+
|pnda.dcae-pnda-bootstrap.openstack.existingSubnetId  |string    |If you want to use an already existing         |
|                                                     |          |Openstack network, specify the UUID of the     |
|                                                     |          |Openstack subnet to use.                       |
+-----------------------------------------------------+----------+-----------------------------------------------+
|pnda.dcae-pnda-bootstrap.openstack.imageId           |string    |Base image to use for the created Openstack    |
|                                                     |          |PNDA instances.                                |
+-----------------------------------------------------+----------+-----------------------------------------------+
|pnda.dcae-pnda-bootstrap.openstack.publicNetworkId   |string    |UUID of the public network in openstack to use.|
+-----------------------------------------------------+----------+-----------------------------------------------+
|pnda.dcae-pnda-bootstrap.openstack.publicSubnetCidr  |string    |CIDR specifying the address range for the      |
|                                                     |          |public subnet.                                 |
+-----------------------------------------------------+----------+-----------------------------------------------+


``pnda-pem.yaml``
-----------------

This file contains the private secret and Openstack keypair name to use for the guest VMs in Openstack.

::

    pnda:
      dcae-pnda-bootstrap:
        pnda_keypair_name: {keypair-name}    # Name of the keypair you have created in Openstack, e.g. pnda-key
        pnda_secret: |
          -----BEGIN DSA PRIVATE KEY-----
          MIIBugIBAAKBgQCLLCmDJdxCxOOmaSGoH0WUyoiGUJiE0JnzEEhXd4SZWmoxo7yn
          9d3iA9z2OiOnbQ4s5tAOWknpFEnIwtFb+L2x3Fzv7yEdHBk0tgC8c91sIxb72SVp
          RgJDaseL2C5RRdWqDiKlXnA1iY7H5z/k/bZD61/4eGdAojVxroQX2H6uLQIVAIrG
          WVGBudBQmfwKzyP5eO1nevNFAoGAALSGjzP0/yVnEKZ8JO8Vw/eC1YDmTG1IwBdN
          Rm8fXqyUjd03ijpmOoPISPM6Jt0TrJTvGNVfqSI1mKVznJ+5B7y5M9qvjzHQW5hL
          GkXHL57mN2QkaJE/m4ilKr/p5RzTBk6c/zhvxg/8DEne6klQ3NQhapzY4cL9aLK6
          hrR4T94CgYAhGFZI5buQUk8MtG9nac9hEQuYw+lrdjy+y1F8XIjq8+ZLAdCY5gw/
          ph+4di/R8MyesqG5AtqUqXQY3tibya3YrqyNZ5mTz6kMN1lT26QHwYMBF1IymMWV
          lq5wzjpctVovYchCLagrh7KepetNigni0Vrjc0TLPbvXQkoLG5JifgIURmDpblYA
          HSNN6un6nlCoGnm07SA=
          -----END DSA PRIVATE KEY-----

Description
~~~~~~~~~~~

+------------------------------------------+----------+-------------------------------------------------------+
|pnda.dcae-pnda-bootstrap.pnda_keypair_name|string    |Name of the keypair to use to spawn the Openstack PNDA |
|                                          |          |instances.Note that the private key above is a         |
|                                          |          |generated sample that is unusable.                     |
+------------------------------------------+----------+-------------------------------------------------------+
|pnda.dcae-pnda-bootstrap.pnda_secret      |string    |Secret key of the pnda_keypair_name keypair.           |
+------------------------------------------+----------+-------------------------------------------------------+
