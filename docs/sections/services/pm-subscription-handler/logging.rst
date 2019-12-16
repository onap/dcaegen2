.. This work is licensed under a Creative Commons Attribution 4.0 International License.
.. http://creativecommons.org/licenses/by/4.0

.. _Logging:

The PMSH logs will roll when the log file reaches 10Mb and a single backup will be kept. The logging level is not
configurable.

Logging
=======

There are four log files within the PMSH container, they are located in /var/log/ONAP/pmsh/

.. code-block:: bash

        /var/log/ONAP/pmsh/error.log (Level: Error)
        /var/log/ONAP/pmsh/debug.log (Level: Debug)
        /var/log/ONAP/pmsh/audit.log (Level: Info)
        /var/log/ONAP/pmsh/metrics.log (Level: Info)

