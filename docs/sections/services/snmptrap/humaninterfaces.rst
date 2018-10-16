.. This work is licensed under a Creative Commons Attribution 4.0 International License.
.. http://creativecommons.org/licenses/by/4.0

Human Interfaces
================

Graphical
^^^^^^^^^

There are no graphical interfaces for snmptrap.

Command Line
^^^^^^^^^^^^

There is a command line interface available, which is a shell script
that provides all needed interactions with **trapd**.

Usage
"""""

    ``bin/snmptrapd.sh [start|stop|restart|status|reloadCfg]``

    start - start an instance of snmptrapd inside the container

    stop -  terminate the snmptrapd process currently running inside container

    restart - restart an instance of snmptrapd inside current container (NOTE: this may cause container to exit depending on how it was started!)

    status - check and display status of snmptrapd inside container

    reloadCfg - signal current instance of snmptrapd to re-request configuration from Config Binding Service
