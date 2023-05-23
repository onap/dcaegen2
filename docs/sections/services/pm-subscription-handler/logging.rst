.. This work is licensed under a Creative Commons Attribution 4.0 International License.
.. http://creativecommons.org/licenses/by/4.0

.. _Logging:

The PMSH logs will be rotated when the log file reaches 10Mb and a single backup will be kept,
with a maximum of 10 back ups.

Logging
=======

The PMSH application writes logs at INFO level to STDOUT, and also to the following file:

.. code-block:: bash

    /var/log/ONAP/dcaegen2/services/pmsh/application.log

To configure PMSH log level, the configuration yaml needs to be altered:

.. code-block:: bash

        vi /opt/app/pmsh/log_config.yaml

onap_logger level should be changed from INFO to DEBUG in order to enable debug logs to be
captured. This will affect both STDOUT logs and the logs written to application.log file

.. code-block:: yaml

    loggers:
        onap_logger:
            level: INFO
