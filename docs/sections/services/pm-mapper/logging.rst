.. This work is licensed under a Creative Commons Attribution 4.0 International License.
.. http://creativecommons.org/licenses/by/4.0

Logging
=======

There are two separate log files in the PM Mapper container.

The main log file is located under /var/log/ONAP/dcaegen2/services/pm-mapper/pm-mapper_output.log.

The human readable log file which contains less information is located under /var/log/ONAP/dcaegen2/services/pm-mapper/pm-mapper_output_readable.log.

Log Level
"""""""""

The PM Mapper log level is set to INFO by default. This can be changed in the running container by editing the logLevel variable in the logback.xml file located under /opt/app/pm-mapper/etc/logback.xml. Changes to this file will be picked up every 30 seconds.
