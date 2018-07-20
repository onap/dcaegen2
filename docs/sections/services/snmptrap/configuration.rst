.. This work is licensed under a Creative Commons Attribution 4.0 International License.
.. http://creativecommons.org/licenses/by/4.0

Configuration
=============

**SNMPTRAP** configuration is controlled via a single JSON 'transaction'.  This transaction can be:

    - a reply from config binding services
    - a locally hosted JSON file

The format of this message is described in the SNMPTRAP package, under:

    ``<base install dir>/spec/snmptrap-collector-component-spec.json``

There should also be a template JSON file with example/default values found at:

    ``<base install dir>/etc/snmptrapd.json``

If you are going to use a local file, the env variable below must be defined before SNMPTRAP runs.  There is a default value set in the SNMPTRAP startup script (bin/snmptrapd.sh):

    ``export CBS_SIM_JSON=../etc/snmptrapd.json``

In either scenario, the format of the config message/transaction is the same.  An example is described below.

JSON CONFIG
^^^^^^^^^^^

The format of the JSON configuration that drives all behavior of SNMPTRAP is probably best described using an example.  One can be found below:

``    {
        "snmptrapd": {
            "version": "1.3.0",
            "title": "ONAP SNMP Trap Receiver"
        },
        "protocols": {
            "transport": "udp",
            "ipv4_interface": "0.0.0.0",
            "ipv4_port": 6162,
            "ipv6_interface": "::1",
            "ipv6_port": 6162
        },
        "cache": {
            "dns_cache_ttl_seconds": 60
        },
        "publisher": {
            "http_timeout_milliseconds": 1500,
            "http_retries": 3,
            "http_milliseconds_between_retries": 750,
            "http_primary_publisher": "true",
            "http_peer_publisher": "unavailable",
            "max_traps_between_publishes": 10,
            "max_milliseconds_between_publishes": 10000
        },
        "streams_publishes": {
            "sec_fault_unsecure": {
                "type": "message_router",
                "aaf_password": null,
                "dmaap_info": {
                    "location": "mtl5",
                    "client_id": null,
                    "client_role": null,
                    "topic_url": "http://localhost:3904/events/ONAP-COLLECTOR-SNMPTRAP"
                },
                "aaf_username": null
            }
        },
        "files": {
            "runtime_base_dir": "/opt/app/snmptrap",
            "log_dir": "logs",
            "data_dir": "data",
            "pid_dir": "tmp",
            "arriving_traps_log": "snmptrapd_arriving_traps.log",
            "snmptrapd_diag": "snmptrapd_prog_diag.log",
            "traps_stats_log": "snmptrapd_stats.csv",
            "perm_status_file": "snmptrapd_status.log",
            "eelf_base_dir": "/opt/app/snmptrap/logs",
            "eelf_error": "error.log",
            "eelf_debug": "debug.log",
            "eelf_audit": "audit.log",
            "eelf_metrics": "metrics.log",
            "roll_frequency": "hour",
            "minimum_severity_to_log": 2
        },
        "trap_config": {
            "sw_interval_in_seconds": 60,
            "notify_oids": {
                ".1.3.6.1.4.1.9.0.1": {
                    "sw_high_water_in_interval": 102,
                    "sw_low_water_in_interval": 7,
                    "category": "logonly"
                },
                ".1.3.6.1.4.1.9.0.2": {
                    "sw_high_water_in_interval": 101,
                    "sw_low_water_in_interval": 7,
                    "category": "logonly"
                },
                ".1.3.6.1.4.1.9.0.3": {
                    "sw_high_water_in_interval": 102,
                    "sw_low_water_in_interval": 7,
                    "category": "logonly"
                },
                ".1.3.6.1.4.1.9.0.4": {
                    "sw_high_water_in_interval": 10,
                    "sw_low_water_in_interval": 3,
                    "category": "logonly"
                }
            }
        }
    }``
