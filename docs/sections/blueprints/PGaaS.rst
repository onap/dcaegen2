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

Similarly, a database's lifetime should have its

The all-in-one blueprint assumes that everything can be allocated and
deallocated together.

MORE TO BE ADDED
