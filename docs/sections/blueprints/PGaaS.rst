PostgreSQL as a Service
============

PostgreSQL as a Service comes in two flavors: all-in-one blueprint, and
separate disk/cluster/database blueprints to separate the management of
the lifetime of those constituent parts. Both are provided for use.

Why Two Flavors?
------------

The reason there are two flavors of blueprints lays in the difference in
lifetime management of the constituent parts.

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

The Blueprints for PG Services and Cinder
------------

The all-in-one blueprint PGaaS.yaml assumes that the PG servers and Cinder volumes can be allocated and
deallocated together. This PGaaS.yaml blueprint creates a cluster named "pstg" by default.

Alternatively, you can split them apart into separate steps, using PGaaS-disk.yaml to allocate the
Cinder volume, and PGaaS-cluster.yaml to allocate a PG cluster. Create the Cinder volume first using
PGaaS-disk.yaml, and then use PGaaS-cluster.yaml to create the cluster. The PG cluster can be
redeployed without affecting the data on the Cinder volumes.

The Blueprints for Databases
------------

The PGaaS-database.yaml blueprint shows how a database can be created separately from any application
that uses it. That database will remain present until the PGaaS-database.yaml blueprint is
undeployed. The PGaaS-getdbinfo.yaml file demonstrates how an application would access the credentials
needed to access a given database on a given PostgreSQL cluster.

If the lifetime of your database is tied to the lifetime of your application, use a block similar to what
is in PGaaS-database.yaml to allocate the database, and use the attributes as shown in PGaaS-getdbinfo.yaml
to access the credentials.
