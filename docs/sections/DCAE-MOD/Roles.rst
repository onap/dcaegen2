=====
Roles
=====


Here is master list of all roles involved in ECOMP with DCAE:

-  System engineer

-  Component developer/expert - components are also referred to as
   micro-services but include collectors, analytics

-  Designer

-  Tester

-  Operations

-  Platform developer

-  Manager


System engineer
---------------

Person who knows the high-level technical requirements for DCAE's
upcoming release cycle and dictates the development needs.  This person
is responsible for the service assurance flows.  This person expresses
the nodes and connections of a flow at a high level in a new graph or an
existing graph and assigns nodes to component developer/experts to be
implemented.

This person must know:

-  What newly added flows should look like at a high level

-  What changes that are needed to existing flows

-  Target environments/sites/locations that need the flows at what SLA

-  Data requirements e.g. volume, rate, format, retention

This person creates a top-level representation of the flow and assigns
the pieces to developers or experts for implementation.


Component developer/expert
--------------------------

Person who is responsible for defining an assigned node's subgraph. 
This person can be:

-  A developer who might be onboarding a new component or a new version
   of an existing component to fulfill the system engineer's
   requirements

-  A domain expert who selects a suitable existing component, wires and
   configures.  This expert knows the intricacies of a class of
   components (e.g. Acumos machine learning).

Developers
----------

They must know:

-  The target DCAE runtime and can develop a component to successfully
   run on the runtime

-  The DCAE onboarding process for components including the development
   testing procedure

-  Best practices of data flow management (data provenance?)

-  Lifecycle of DCAE components specifically impact of changes to
   existing running instances globally

-  The resource requirement of the developed component

Experts
-------
 
They must know:

-  The target DCAE runtime

-  The technical capabilities of a set of components in order to best
   select

-  The technical needs of the set of components in order to properly
   configure and connect

Designer
--------


Person who is responsible for connecting remote nodes to flows and
configuring all nodes in a flow in the context of the flow and in the
context of the greater graph.  An example of the former is connecting a
flow with a collector to a black boxed vMME.  An example of the latter
is assigning the threshold to a threshold-crossing-analytics component
when it is connected to a specific VES collector who is connected to a
specific vMME.

This person knows:

-  The VNFs to monitor and the technical details to correctly connect
   with them

-  Enough about the capability of a component and understands the
   characteristics and requirements of a flow to properly
   assign designer_editable configuration parameters

This person has the ability to promote flows through the development
process (i.e. FTL to IST to ETE) and will coordinate with testers to
make sure the progression happens.

Tester
------

Person who is responsible for testing a promoted new flow or newly
edited flow.  Once the designer has promoted a flow to a tester's
environment, the tester will have ready access to the deployment
artifacts necessary to apply the runtime changes that will reflect the
flow design and verify the resulting functionality matches to the system
engineer's expectations.

Person knows and owns a DCAE runtime.

Read access to the design tool would be useful for troubleshooting.


Operations
----------

Person who is responsible that DCAE both platform and service assurance
flows are all operational in production environments and locations. 
Once a flow has been fully certified, the required deployment artifact
is provided to operations and operations is responsible for applying the
runtime changes to reflect the flow design.

Person knows and owns a DCAE runtime.

Read access to the design tool would be useful for troubleshooting.



Manager
-------


Person who are accountable to the business of the successful delivery of
a set of service assurance flows.  Read access to the design tool
specifically high level reports are useful to understand if goals are
being met and to better measure project success.

Platform developer
------------------


Person who is responsible for the development of the DCAE platform which
ranges from onboarding, design, and runtime.  In the scope of onboarding
and design, they are also responsible (unless there's an internal
operational team) for the operational concerns which means the tooling
built in this effort will need to be continually supported. 
Their **users** are all the above.  The design tool is intended to span
across multiple environments thus must run where all the required
parties have access.
