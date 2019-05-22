.. This work is licensed under a Creative Commons Attribution 4.0 International License.
.. http://creativecommons.org/licenses/by/4.0

==================
BBS-EventProcessor
==================


Overview
========

BBE-ep is responsible for handling two types of events for the BBS use case. 

First are PNF re-registration internal events published by PRH. BBS-ep must process these internal events to understand if they 
actually constitute ONT(CPE) relocation events. In the relocation case, it publishes an event towards unauthenticated.DCAE_CL_OUTPUT 
DMaaP topic to trigger further Policy actions related to BBS use case.

Second type of events are CPE authentication events originally published by the Edge SDN M&C component of BBS use case architecture. 
Through RestConf-Collector or VES-Collector, these events are consumed by BBS-ep and they are forwared towards unauthenticated.DCAE_CL_OUTPUT 
DMaaP topic to trigger further Policy actions related to BBS use case.

BBE-ep periodically polls for the two events. Polling interval is configurable and can be changed dynamically from Consul. Its implementation
is based on Reactive Streams (Reactor library), so it is fully asynchronous and non-blocking.


.. toctree::
   :maxdepth: 1

   ./installation
   ./functionality
   ./development_info
