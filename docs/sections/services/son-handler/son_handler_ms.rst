.. This work is licensed under a Creative Commons Attribution 4.0
   International License. http://creativecommons.org/licenses/by/4.0
   
.. _docs_SON_Handler_MS:

Architecture
------------
The architecture below depicts the SON-Handler MS as a part of DCAE. Only the relevant interactions and components are shown.

.. image:: ./dcae_new.jpg

The internal architecture of SON-Handler MS is shown below.

.. image:: ./son_handler.jpg

Description
~~~~~~~~~~~
The SON-Handler MS has a REST interface towards OOF as well as DMaaP interface towards Policy, VES-Collector and SDN-R. It has a database and core logic.

Core logic
~~~~~~~~~~
The core logic is implemented as 3 threads - main thread, child thread(s) for handling neighbor-list updates and collision/confusion alarms from the RAN (via SDN-R), and a separate child for handling handover measurements (PM) inputs from the RAN (via VES-Collector). The Main Thread is responsible for spawning and terminating the Child Threads. The core logic is responsible for:
(a) Performing all the pre-processing that is required before triggering OOF for PCI as well as PCI/ANR joint-optimization
(b) Autonomously taking actions for ANR updates
(c) Preparing the message contents required by SDN-R to re-configure the RAN nodes with PCI/ANR updates

The logic may not be 100% fool-proof (i.e., cover all possible scenarios and boundary-counditions as in real field deployments), as well as the most efficient one. An attempt has been made to balance the usefulness for a PoC versus the complexity of handling all possible scenarios. It is intended to provide a good base for the community/users to enhance it further as required.

The details of the state machines of all the threads in the core logic are available in https://wiki.onap.org/pages/viewpage.action?pageId=56131985.

Database
~~~~~~~~
This is a PostgreSQL DB, and is intended to persist information such as the following:
- PCI-Handler MS Config information (e.g., thresholds, timer values, OOF algorithm name, etc.)
- Pre-processing results and other related information (e.g., neighbor list)
- Buffered notifications (i.e., notifications not yet processed at all)
- State information
- Association between PNF-name and CellId
- PM/FM data
- Etc.

DMaaP Client
~~~~~~~~~~~~
This is responsible for registering with the DMaaP client for the DMaaP notifications from SDN-R and VES-Collector, and to Policy.

Deployment aspects
------------------
The SON-Handler MS will be deployed on DCAE using the mechanism described in "Option 3 - On-Demand deployment through DCAE-Controller cli" at https://wiki.onap.org/display/DW/Dublin+Deployment+Strategy.

Known Issues and Resolutions
----------------------------
The scope and scenarios addressed are documented in the SON use case page for Dublin - https://wiki.onap.org/display/DW/OOF-PCI+Use+Case+-+Dublin+Release+-+ONAP+based+SON+for+PCI+and+ANR.