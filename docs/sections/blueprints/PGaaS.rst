PostgreSQL as a Service
=======================

PostgreSQL as a Service (PGaaS) comes in two flavors: all-in-one blueprint, and
separate disk/cluster/database blueprints to separate the management of
the lifetime of those constituent parts. Both are provided for use.

Why Three Flavors?
------------------

The reason there are three flavors of blueprints lays in the difference in
lifetime management of the constituent parts and the number of VMs created.

For example, a database usually needs to have persistent storage, which
in these blueprints comes from Cinder storage volumes. The primitives
used in these blueprints assume that the lifetime of the Cinder storage
volumes matches the lifetime of the blueprint deployment. So when the
blueprint goes away, any Cinder storage volume allocated in the
blueprint also goes away.

Similarly, a database's lifetime may be the same time as an application's 
lifetime. When the application is undeployed, the associated database should
be deployed too. OR, the database should have a lifetime beyond the scope
of the applications that are writing to it or reading from it.

Blueprint Files
---------------

The Blueprints for PG Services and Cinder
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

The all-in-one blueprint ``pgaas.yaml`` assumes that the PG servers and Cinder volumes can be allocated and
deallocated together. The ``pgaas.yaml`` blueprint creates a cluster of two VMs named "``pstg``" by default. 

The ``pgaas-onevm.yaml`` blueprint creates a single-VM instance named "``pgvm``" by default.

Alternatively, you can split them apart into separate steps, using ``pgaas-disk.yaml`` to allocate the
Cinder volume, and ``pgaas-cluster.yaml`` to allocate a PG cluster. Create the Cinder volume first using
``pgaas-disk.yaml``, and then use ``pgaas-cluster.yaml`` to create the cluster. The PG cluster can be
redeployed without affecting the data on the Cinder volumes.

The Blueprints for Databases
^^^^^^^^^^^^^^^^^^^^^^^^^^^^

The ``pgaas-database.yaml`` blueprint shows how a database can be created separately from any application
that uses it. That database will remain present until the pgaas-database.yaml blueprint is
undeployed. The ``pgaas-getdbinfo.yaml`` file demonstrates how an application would access the credentials
needed to access a given database on a given PostgreSQL cluster.

If the lifetime of your database is tied to the lifetime of your application, use a block similar to what
is in ``pgaas-database.yaml`` to allocate the database, and use the attributes as shown in ``pgaas-getdbinfo.yaml``
to access the credentials.

Both of these blueprints use the ``dcae.nodes.pgaas.database`` plugin reference, but ``pgaas-getdbinfo.yaml``
adds the ``use_existing: true`` property.


What is Created by the Blueprints
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Each PostgreSQL cluster has a name, represented below as ``${CLUSTER}`` or ``CLNAME``. Each cluster is created
with two VMs, one VM used for the writable master and the other as a cascaded read-only secondary. 


There are two DNS A records added, ``${LOCATIONPREFIX}${CLUSTER}00.${LOCATIONDOMAIN}`` and
``${LOCATIONPREFIX}${CLUSTER}01.${LOCATIONDOMAIN}``. In addition, 
there are two CNAME entries added:
``${LOCATIONPREFIX}-${CLUSTER}-write.${LOCATIONDOMAIN} ``
and 
``${LOCATIONPREFIX}-${CLUSTER}.${LOCATIONDOMAIN}``. The CNAME 
``${LOCATIONPREFIX}-${CLUSTER}-write.${LOCATIONDOMAIN}`` will be used by further
blueprints to create and attach to databases.


Parameters
------------

The blueprints are designed to run using the standard inputs file used for all of the blueprints,
plus several additional parameters that are given reasonable defaults.

How to Run
------------



To install the PostgreSQL as a Service
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Installing the all-in-one blueprint is straightforward:

::

    cfy install -p pgaas.yaml -i inputs.yaml

By default, the all-in-one blueprint creates a cluster by the name ``pstg``.

You can override that name using another ``-i`` option. 
(When overriding the defaults, it is also best to explicitly
set the -b and -d names.)

::

    cfy install -p pgaas.yaml -b pgaas-CLNAME -d pgaas-CLNAME -i inputs.yaml -i pgaas_cluster_name=CLNAME


Separating out the disk allocation from the service creation requires using two blueprints:

::

    cfy install -p pgaas-disk.yaml -i inputs.yaml
    cfy install -p pgaas-cluster.yaml -i inputs.yaml

By default, these blueprints create a cluster named ``pgcl``, which can be overridden the same 
way as shown above:

::

    cfy install -p pgaas-disk.yaml -b pgaas-disk-CLNAME -d pgaas-disk-CLNAME -i inputs.yaml -i pgaas_cluster_name=CLNAME
    cfy install -p pgaas-cluster.yaml -b pgaas-disk-CLNAME -d pgaas-disk-CLNAME -i inputs.yaml -i pgaas_cluster_name=CLNAME


You must use the same pgaas_cluster_name for the two blueprints to work together.

For the disk, you can also specify a ``cinder_volume_size``, as in ``-i cinder_volume_size=1000`` 
for  1TiB volume. (There is no need to override the ``-b`` and ``-d`` names when changing the
volume size.)


You can verify that the cluster is up and running by connecting to the PostgreSQL service
on port 5432. To verify that all of the DNS names were created properly and that PostgreSQL is
answering on port 5432, you can use something like this:

::

    sleep 1 | nc -v ${LOCATIONPREFIX}${CLUSTER}00.${LOCATIONDOMAIN} 5432
    sleep 1 | nc -v ${LOCATIONPREFIX}${CLUSTER}01.${LOCATIONDOMAIN} 5432
    sleep 1 | nc -v ${LOCATIONPREFIX}-${CLUSTER}-write.${LOCATIONDOMAIN} 5432
    sleep 1 | nc -v ${LOCATIONPREFIX}-${CLUSTER}.${LOCATIONDOMAIN} 5432


Once you have the cluster created, you can then allocate databases. An application that
wants a persistent database not tied to the lifetime of the application blueprint can
use the ``pgaas-database.yaml`` blueprint to create the database;

::

    cfy install -p pgaas-database.yaml -i inputs.yaml

By default, the ``pgaas-database.yaml`` blueprint creates a database with the name ``sample``, which
can be overridden using ``database_name``. 


::

    cfy install -p pgaas-database.yaml -b pgaas-database-DBNAME -d pgaas-database-DBNAME -i inputs.yaml -i database_name=DBNAME
    cfy install -p pgaas-database.yaml -b pgaas-database-CLNAME-DBNAME -d pgaas-database-CLNAME-DBNAME -i inputs.yaml -i pgaas_cluster_name=CLNAME -i database_name=DBNAME


The ``pgaas-getdbinfo.yaml`` blueprint shows how an application can attach to an existing
database and access its attributes:

::

    cfy install -p pgaas-getdbinfo.yaml -d pgaas-getdbinfo -b pgaas-getdbinfo -i inputs.yaml
    cfy deployments outputs -d pgaas-getdbinfo
    cfy uninstall -d pgaas-getdbinfo
