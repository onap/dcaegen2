.. This work is licensed under a Creative Commons Attribution 4.0 International License.
.. http://creativecommons.org/licenses/by/4.0

.. _docs_slice_analysis_ms_overview:

Architecture
------------
The architecture below depicts the Slice Analysis MS as a part of DCAE.
.. image:: ./slice_analysis_ms_architecture.jpg

Slice Analysis MS provides runtime configuration feature since Kohn Version.

For the Slice Analysis MS, there is a CBS thread running that will continually fetch the latest policies from the XCAML PDP engine via sidecar. So if you want to pass runtime configuration, you can format your configuration contents in the form of an XCAML policy, then push it into the XCAML PDP engine. The Slice Analysis MS will get updated within seconds.

The internal architecture of Slice Analysis MS is shown below.

.. image:: ./slice_analysis_ms_arch.jpg

The Slice Analysis MS has a DMaaP interface towards towards Policy and VES-Collector, and a REST
interface towards Config DB. It also has a DMaaP interface to receive any recommendations for
Closed Loop updates from an ML engine, which is then used to trigger a control loop message to
Policy.

- **DMAAP Client** creates a thread pool for every DMaaP topic consumer. The thread
  polls the DMaaP topic for every configured time interval and whenever a message is
  received it stores that message in the Postgres DB.

- **PM Thread** reads the PM event from the database and puts the PM sample in the
  internal queue in the format which is needed for further processing.

- **Consumer Thread** consumes PM samples from the internal queue and make all the
  required Config DB calls, perform the analysis, and puts the onset message to the DMaaP topic.

- **Database** is a PG DB.

Detailed flow diagrams are available at:

Closed Loop: https://wiki.onap.org/display/DW/Closed+Loop

Intelligent Slicing: https://wiki.onap.org/display/DW/Intelligent+Slicing+flow


Functional Description
----------------------
- Slice Analysis ms consumes PM messages from PERFORMANCE_MEASUREMENTS topic.

- For analysis Slice Analysis MS consumes various data from Config DB including List of Network
  Functions which serves the S-NSSAI, List of Near-RT RICs and the corresponding cell mappings of the
  S-NSSAI, Current Configuration of the Near-RT RICs, Slice Profile associated with the S-NSSAI and
  Subscriber details of the S-NSSAI (for sending the onset message to policy).

- Based on the collected PM data, Slice Analysis MS computes the DLThptPerSlice and ULThptPerSlice
  for the Near-RT RICs relevant for the S-NSSAI, and the computed value is compared with the current
  configuration of the Near-RT RICs. If the change in configuration exceeds the minimum percentage
  value which is kept as a configuration parameter, then the closed-loop will be triggered by posting
  the onset message to DMaaP.

- Upon reception of recommendation to update the configuration of RAN from e.g., an ML MS, the Slice
  Analysis MS prepares and sends a control loop onset message.


Deployment aspects
------------------
The SON-Handler MS will be deployed on DCAE as an on-demand component. Details of the installation
steps are available at ./installation.rst. Further details can be obtained from:
https://wiki.onap.org/pages/viewpage.action?pageId=92998809


Known Issues and Resolutions
----------------------------
The assumptions of functionality in Guilin release is documented in:
https://wiki.onap.org/display/DW/Assumptions+for+Guilin+release
