.. This work is licensed under a Creative Commons Attribution 4.0 International License.
.. http://creativecommons.org/licenses/by/4.0

Administration
==============

Processes
---------

**SNMPTRAP** runs as a single (python) process inside the container.  You can find it using the following commands:

Inside the container
^^^^^^^^^^^^^^^^^^^^

    `ps -ef | grep snmptrap.py | grep -v grep`

Outside the container
^^^^^^^^^^^^^^^^^^^^^

    docker exec -it <container name> `ps -ef | grep snmptrap.py | grep -v grep`


Actions
-------

The **SNMPTRAP** container can be monitored for status by running the command:

    `bin/snmptrapd.sh status`

Output from this command will be two-fold.  First will be the textual response:

    `Stopping snmptrap...  Stopped.`

Also available is the return code of the command:

    0 - if command executed successfully
    1 - if the command failed, and/or the process is not running


