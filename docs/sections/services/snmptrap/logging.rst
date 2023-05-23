.. This work is licensed under a Creative Commons Attribution 4.0 International License.
.. http://creativecommons.org/licenses/by/4.0

Logging
=======

Logging is controlled by the configuration provided to **trapd** by CBS,
or via the fallback config file specified as the environment
variable "CBS_SIM_JSON" at startup.  The section of the JSON configuration
that influences the various forms of application logging is referenced
throughout this document, with examples.

Using the JSON configuration, a base directory is specified for application
data and EELF log files.  Specific filenames (again, from the JSON
config) are appended to the base directory value to create a full-path
filename for use by SNMPTRAP.

Also available is the ability to modify how frequently logs are rolled to
time-stamped versions (and a new empty file is started) as well as what
severity level to log to program diagnostic logs.  The actual archival (to a
timestamped filename) occurs when the first trap is
received **in a new hour** (or minute, or day - depending
on "roll_frequency" value).

Defaults are shown below:

.. code-block:: json

    "files": {
        <other json data>
        ...
        "roll_frequency": "day",
        "minimum_severity_to_log": 3
        <other json data>
        ...
    },


Roll Frequency
""""""""""""""

Roll frequency can be modified based on your environment (e.g. if trapd is handling a
heavy trap load, you will probably want files to roll more frequently).  Valid "roll_frequency" values are:

- minute
- hour
- day

Minimum Severity To Log
"""""""""""""""""""""""

Logging levels should be modified based on your need.  Log levels in lab environments should be "lower"
(e.g. minimum severity to log = "0" creates verbose logging) vs. production (values of "3" and above is a good choice).

Valid "minimum_severity_to_log" values are:

- "1"   (debug mode - everything you want to know about process, and more.  *NOTE:* Not recommended for production environments)
- "2"   (info - verbose logging.  *NOTE:* Not recommended for production environments)
- "3"   (warnings - functionality not impacted, but abnormal/uncommon event)
- "4"   (critical - functionality impacted, but remains running)
- "5"   (fatal - causing runtime exit)


WHERE ARE THE LOG FILES?
------------------------

APPLICATION DATA
^^^^^^^^^^^^^^^^

**trapd** produces application-specific logs (e.g. trap logs/payloads,
etc) as well as various other statistical and diagnostic logs.  The
location of these logs is controlled by the JSON config, using these
values:

.. code-block:: json

    "files": {
        "runtime_base_dir": "/opt/app/snmptrap",
        "log_dir": "logs",
        "data_dir": "data",
        "pid_dir": "tmp",
        "arriving_traps_log": "snmptrapd_arriving_traps.log",
        "snmptrapd_diag": "snmptrapd_prog_diag.log",
        "traps_stats_log": "snmptrapd_stats.csv",
        "perm_status_file": "snmptrapd_status.log",
        "roll_frequency": "hour",
        "minimum_severity_to_log": 2
        <other json data>
        ...
    },

The base directory for all data logs is specified with:

    **runtime_base_dir**

Remaining log file references are appended to the *runtime_base_dir*
value to specify a logfile location.  The result using the
above example would create the files:

.. code-block:: bash

    /opt/app/snmptrap/logs/snmptrapd_arriving_traps.log
    /opt/app/snmptrap/logs/snmptrapd_prog_diag.log
    /opt/app/snmptrap/logs/snmptrapd_stats.csv
    /opt/app/snmptrap/logs/snmptrapd_status.log


ARRIVING TRAPS
^^^^^^^^^^^^^^^

**trapd** logs all arriving traps.  These traps are saved in a
filename created by appending *runtime_base_dir*, *log_dir*
and *arriving_traps_log* from the JSON config.  Using the example
above, the resulting arriving trap log would be:

.. code-block:: bash

    /opt/app/snmptrap/logs/snmptrapd_arriving_traps.log

An example from this log is shown below:

.. code-block:: log

    1529960544.4896748 Mon Jun 25 17:02:24 2018; Mon Jun 25 17:02:24 2018 com.att.dcae.dmaap.IST3.DCAE-COLLECTOR-UCSNMP 15299605440000 1.3.6.1.4.1.999.0.1 server001 127.0.0.1 server001 v2c 751564798 0f40196a-78bb-11e8-bac7-005056865aac , "varbinds": [{"varbind_oid": "1.3.6.1.4.1.999.0.1.1", "varbind_type": "OctetString", "varbind_value": "TEST TRAP"}]

*NOTE:*  Format of this log will change with 1.5.0; specifically, "varbinds" section will be reformatted/json struct removed and will be replaced with a flat file format.

PUBLISHED TRAPS
^^^^^^^^^^^^^^^

SNMPTRAP's main purpose is to receive and decode SNMP traps, then
publish the results to a configured DMAAP/MR message bus.  Traps that
are successfully published (e.g. publish attempt gets a "200/ok"
response from the DMAAP/MR server) are logged to a file named by
the technology being used combined with the topic being published to.

If you find a trap in this published log, it has been acknowledged as
received by DMAAP/MR.  If consumers complain of "missing traps", the
source of the problem will be downstream (*not with SNMPTRAP*) if
the trap has been logged here.

For example, with a json config of:

.. code-block:: json

    "dmaap_info": {
        "location": "mtl5",
        "client_id": null,
        "client_role": null,
        "topic_url": "http://172.17.0.1:3904/events/ONAP-COLLECTOR-SNMPTRAP"

and

.. code-block:: json

    "files": {
        "**runtime_base_dir**": "/opt/app/snmptrap",

result in traps that are confirmed as published (200/ok response from DMAAP/MR) logged to the file:

.. code-block:: bash

    /opt/app/snmptrap/logs/DMAAP_ONAP-COLLECTOR-SNMPTRAP.json

An example from this JSON log is shown below:

.. code-block:: json

    {
        "uuid": "0f40196a-78bb-11e8-bac7-005056865aac",
        "agent address": "127.0.0.1",
        "agent name": "server001",
        "cambria.partition": "server001",
        "community": "",
        "community len": 0,
        "epoch_serno": 15299605440000,
        "protocol version": "v2c",
        "time received": 1529960544.4896748,
        "trap category": "DCAE-COLLECTOR-UCSNMP",
        "sysUptime": "751564798",
        "notify OID": "1.3.6.1.4.1.999.0.1",
        "notify OID len": 9,
        "varbinds": [
            {
                "varbind_oid": "1.3.6.1.4.1.999.0.1.1",
                "varbind_type": "OctetString",
                "varbind_value": "TEST TRAP"
            }
        ]
    }



EELF
^^^^

For program/operational logging, **trapd** follows the EELF logging
convention.  Please be aware that the EELF specification results in
messages spread across various files.  Some work may be required to
find the right location (file) that contains the message you are
looking for.

EELF logging is controlled by the configuration provided
to **trapd** by CBS, or via the fallback config file specified
as an environment variable "CBS_SIM_JSON" at startup.  The section
of that JSON configuration that influences EELF logging is:

.. code-block:: json

    "files": {
        <other json data>
        ...
        "**eelf_base_dir**": "/opt/app/snmptrap/logs",
        "eelf_error": "error.log",
        "eelf_debug": "debug.log",
        "eelf_audit": "audit.log",
        "eelf_metrics": "metrics.log",
        "roll_frequency": "hour",
    },
    <other json data>
    ...


The base directory for all EELF logs is specified with:

        **eelf_base_dir**

Remaining eelf_<file> references are appended to the eelf_base_dir value
to specify a logfile location.  The result using the above example would
create the files:

.. code-block:: bash

        /opt/app/snmptrap/logs/error.log
        /opt/app/snmptrap/logs/debug.log
        /opt/app/snmptrap/logs/audit.log
        /opt/app/snmptrap/logs/metrics.log

Again using the above example configuration, these files will be rolled
to an archived/timestamped version hourly.  The actually archival (to a
timestamped filename) occurs when the first trap is
received **in a new hour** (or minute, or day - depending
on "roll_frequency" value).

Error / Warning Messages
------------------------

Program Diagnostics
^^^^^^^^^^^^^^^^^^^

Detailed application log messages can be found in "snmptrapd_diag" (JSON
config reference).  These can be very verbose and roll quickly
depending on trap arrival rates, number of varbinds encountered,
minimum_severity_to_log setting in JSON config, etc.

In the default config, this file can be found at:

.. code-block:: bash

    /opt/app/snmptrap/logs/snmptrapd_diag.log

Messages will be in the general format of:

.. code-block:: log

    2018-04-25T17:28:10,305|<module>|snmptrapd||||INFO|100||arriving traps logged to: /opt/app/snmptrap/logs/snmptrapd_arriving_traps.log
    2018-04-25T17:28:10,305|<module>|snmptrapd||||INFO|100||published traps logged to: /opt/app/snmptrap/logs/DMAAP_com.att.dcae.dmaap.IST3.DCAE-COLLECTOR-UCSNMP.json
    2018-04-25T17:28:10,306|<module>|snmptrapd||||INFO|100||Runtime PID file: /opt/app/snmptrap/tmp/snmptrapd.py.pid
    2018-04-25T17:28:48,019|snmp_engine_observer_cb|snmptrapd||||DETAILED|100||snmp trap arrived from 192.168.1.139, assigned uuid: 1cd77e98-48ae-11e8-98e5-005056865aac
    2018-04-25T17:28:48,023|snmp_engine_observer_cb|snmptrapd||||DETAILED|100||dns cache expired or missing for 192.168.1.139 - refreshing
    2018-04-25T17:28:48,027|snmp_engine_observer_cb|snmptrapd||||DETAILED|100||cache for server001 (192.168.1.139) updated - set to expire at 1524677388
    2018-04-25T17:28:48,034|snmp_engine_observer_cb|snmptrapd||||DETAILED|100||snmp trap arrived from 192.168.1.139, assigned uuid: 0f40196a-78bb-11e8-bac7-005056
    2018-04-25T17:28:48,036|notif_receiver_cb|snmptrapd||||DETAILED|100||processing varbinds for 0f40196a-78bb-11e8-bac7-005056
    2018-04-25T17:28:48,040|notif_receiver_cb|snmptrapd||||DETAILED|100||adding 0f40196a-78bb-11e8-bac7-005056 to buffer

    2018-06-25T21:02:24,491|notif_receiver_cb|snmptrapd||||DETAILED|100||trap 0f40196a-78bb-11e8-bac7-005056865aac : {"uuid": "0f40196a-78bb-11e8-bac7-005056865aac", "agent address": "192.168.1.139", "agent name": "server001", "cambria.partition": "server001", "community": "", "community len": 0, "epoch_serno": 15299605440000, "protocol version": "v2c", "time received": 1529960544.4896748, "trap category": "com.companyname.dcae.dmaap.location.DCAE-COLLECTOR-UCSNMP", "sysUptime": "751564798", "notify OID": "1.3.6.1.4.1.999.0.1", "notify OID len": 9, "varbinds": [{"varbind_oid": "1.3.6.1.4.1.999.0.1.1", "varbind_type": "OctetString", "varbind_value": "TEST TRAP"}]}
    2018-06-25T21:02:24,496|post_dmaap|snmptrapd||||DETAILED|100||post_data_enclosed: {"uuid": "0f40196a-78bb-11e8-bac7-005056865aac", "agent address": "192.168.1.139", "agent name": "server001", "cambria.partition": "server001", "community": "", "community len": 0, "epoch_serno": 15299605440000, "protocol version": "v2c", "time received": 1529960544.4896748, "trap category": "com.att.dcae.dmaap.IST3.DCAE-COLLECTOR-UCSNMP", "sysUptime": "751564798", "notify OID": "1.3.6.1.4.1.999.0.1", "notify OID len": 9, "varbinds": [{"varbind_oid": "1.3.6.1.4.1.999.0.1.1", "varbind_type": "OctetString", "varbind_value": "TEST TRAP"}]}


Platform Status
^^^^^^^^^^^^^^^

A permanent (left to user to archive/compress/etc) status file is maintained in the file referenced by:

    **perm_status_file**

.. code-block:: json

        "perm_status_file": "snmptrapd_status.log",

Combined with **runtime_base_dir** and **log_dir** settings from snmptrapd.json, the perm_status_file in default installations
can be found at:

.. code-block:: bash

        /opt/app/uc/logs/snmptrapd_stats.log
