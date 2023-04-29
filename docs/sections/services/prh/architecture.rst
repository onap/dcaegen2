.. This work is licensed under a Creative Commons Attribution 4.0 International License.
.. http://creativecommons.org/licenses/by/4.0

PRH Architecture
================

**PRH** is a DCAE micro-service which participates in the Physical Network Function Plug and Play (PNF PnP)
procedure. PNF PnP is used to register PNF when it comes online.

PRH Processing Flow
-------------------

.. image:: ../../images/prhAlgo.png

In London release, a new mode has been introduced which allows a PNF to send the registration event early, before SO registers the PNF in AAI. A timeout can be configured for the time until such an event is considered valid (default set to 1 day). When PRH receives such an event, and does not find the corresponding PNF in AAI, it will retry the check in AAI till either the PNF is found in AAI, or the timeout occurs (whichever is earlier).This does not block the processing of any events received after such a non-correlated event. 
This mode is not the default mode in which PRH is installed, and has to enabled in the PRH Helm chart. Since it uses a native Kafka consumer and not DMAAP consumer, certain Kafka and Strimzi related configurable parameters are required, as described in the Configuration section.


