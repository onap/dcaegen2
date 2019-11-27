.. This work is licensed under a Creative Commons Attribution 4.0 International License.
.. http://creativecommons.org/licenses/by/4.0

.. _Installation:

Installation
============

The PMSH is a microservice that will be configured and instantiated through CLAMP. During instantiation,
the PMSH will fetch its configuration through the Config Binding Service.

Deployment Prerequisites
^^^^^^^^^^^^^^^^^^^^^^^^

In order to succesfully deploy the PMSH, the following components are required to be running. They
can be verified by running the healtchecks.

    - DCAE Platform
    - DMaaP
    - SDC
    - CLAMP
    - A&AI
    - DMaaP Bus Controller post install jobs should have completed successfully (executed as part of an OOM install).
