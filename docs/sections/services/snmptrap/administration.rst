.. This work is licensed under a Creative Commons Attribution 4.0 International License.
.. http://creativecommons.org/licenses/by/4.0

Administration
==============

Processes
---------

**trapd** runs as a single (python) process inside (or outside) the container.  You can monitor it using the commands documented below.

*NOTE:* Familiarity with docker environments is assumed below - for example, if you stop a running instance of snmptrapd that was started using the default snmptrapd docker configuration, the container itself will exit.  Similarly, if you start an instance of snmptrapd inside a container, it will not run in the background (this is a dependency/relationship between docker and the application -> if the command registered to run the service inside the container terminates, it is assumed that the application has failed and docker will terminate the container itself).

Actions
-------

Starting snmptrapd
^^^^^^^^^^^^^^^^^^

The **trapd** service can be started by running the command:

    ``/opt/app/snmptrap/bin/snmptrapd.sh start``

Output from this command will be two-fold.  First will be the textual response:

.. code-block:: none

    2018-10-16T15:14:59,461 Starting snmptrapd...
    2018-10-16T19:15:01,966 ONAP controller not present, trying json config override via CBS_SIM_JSON env variable
    2018-10-16T19:15:01,966 ONAP controller override specified via CBS_SIM_JSON: ../etc/snmptrapd.json
    2018-10-16T19:15:01,973 ../etc/snmptrapd.json loaded and parsed successfully
    2018-10-16T19:15:02,038 load_all_configs|snmptrapd||||INFO|100||current config logged to : /opt/app/snmptrap/tmp/current_config.json
    2018-10-16T19:15:02,048 snmptrapd.py : ONAP SNMP Trap Receiver version 1.4.0 starting
    2018-10-16T19:15:02,049 arriving traps logged to: /opt/app/snmptrap/logs/snmptrapd_arriving_traps.log
    2018-10-16T19:15:02,050 published traps logged to: /opt/app/snmptrap/logs/DMAAP_unauthenticated.ONAP-COLLECTOR-SNMPTRAP.json

*NOTE:* This command will remain in the foreground for reasons explained above.

Checking Status
^^^^^^^^^^^^^^^

The **trapd** container can be monitored for status by running this command from inside the container:

    ``/opt/app/snmptrap/bin/snmptrapd.sh status``

If **SNMPTRAPD** is present/running, output from this command will be:

.. code-block:: none

    2018-10-16T15:01:47,705 Status: snmptrapd running
    ucsnmp    16109  16090  0 Oct08 ?        00:07:16 python ./snmptrapd.py

and the return code presented to the shell upon exit:

        0 -> if command executed successfully and the process was found
        1 -> if the command failed, and/or the process is not running

    ``$ echo $?``

    ``0``

If **trapd** is not present, output from this command will be:

.. code-block:: none

    2018-10-16T15:10:47,815 PID file /opt/app/snmptrap/tmp/snmptrapd.py.pid does not exist or not readable - unable to check status of snmptrapd
    2018-10-16T15:10:47,816 Diagnose further at command line as needed.

and the return code presented to the shell upon exit:

    ``$ echo $?``

    ``1``


Stopping trapd
^^^^^^^^^^^^^^

**trapd** can be stopped by running the command:

    ``/opt/app/snmptrap/bin/snmptrapd.sh stop``

Output from this command will be two-fold.  First will be the textual response:

.. code-block:: none

    2018-10-16T15:10:07,808 Stopping snmptrapd PID 16109...
    2018-10-16T15:10:07,810 Stopped

Second will be the return code presented to the shell upon exit:

    0 - if command executed successfully
    1 - if the request to stop failed

    ``$ echo $?``

    ``0``


Other commands of interest
--------------------------

Checking for snmptrapd inside a container
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

   ``ps -ef | grep snmptrap.py | grep -v grep``


Checking for snmptrapd outside the container
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

   ``docker exec -it <container name> ps -ef | grep snmptrap.py | grep -v grep``
