.. This work is licensed under a Creative Commons Attribution 4.0 International License.
.. http://creativecommons.org/licenses/by/4.0

Configuration
=============

**trapd** configuration is controlled via a single JSON 'transaction'.
This transaction can be:

- a reply from Config Binding Services
- a locally hosted JSON file

The format of this message is described in the SNMPTRAP package, under:

.. code-block:: bash

    <base install dir>/spec/snmptrap-collector-component-spec.json

There will also be a template JSON file with example/default values found at:

.. code-block:: bash

    <base install dir>/etc/snmptrapd.json

If you are going to use a local file, the env variable below must be defined before SNMPTRAP runs.  There is a default value set in the SNMPTRAP startup script (bin/snmptrapd.sh):

.. code-block:: bash

    export CBS_SIM_JSON=../etc/snmptrapd.json

In either scenario, the format of the config message/transaction *is the same*.  An example is described below.

JSON CONFIGURATION EXPLAINED
^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Variables of interest (e.g. variables that should be inspected/modified for a specific runtime environment) are listed below for convenience.  The entire file is provided later in this page for reference.

Potential Config Changes in your environment
""""""""""""""""""""""""""""""""""""""""""""

.. code-block:: bash

    in protocols section:

       "ipv4_interface": "0.0.0.0",    # IPv4 address of interface to listen on - "0.0.0.0" == "all"
       "ipv4_port": 6162,              # UDP port to listen for IPv4 traps on (6162 used in docker environments when forwarding has been enabled)
       "ipv6_interface": "::1",        # IPv6 address of interface to listen on - "::1" == "all"
       "ipv6_port": 6162               # UDP port to listen for IPv6 traps on (6162 used in docker environments when forwarding has been enabled)

    in cache section:

       "dns_cache_ttl_seconds": 60     # number of seconds trapd will cache IP-to-DNS-name values before checking for update

    in files section:

       "minimum_severity_to_log": 2    # minimum message level to log; 0 recommended for debugging, 3+ recommended for runtime/production

    in snmpv3_config section:

       (see detailed snmpv3_config discussion below)

snmpv3_config
"""""""""""""

SNMPv3 added significant authorization and privacy capabilities to the SNMP standard.  As it relates to traps, this means providing the proper privacy, authorization, engine and user criteria for each agent that would like to send traps to a particular trapd instance.

This is done by adding blocks of valid configuration data to the "snmpv3_config" section of the JSON config/transaction.  These blocks are recurring sets of:

.. code-block:: json

    {
    "user": "<userId>",
    "engineId": "<engineId>",
    "<authProtocol>": "<authorizationKeyValue>",
    "<privProtocol>": "<privacyKeyValue>"
    }

Valid values for authProtocol in JSON configuration:

.. code-block:: bash

    usmHMACMD5AuthProtocol
    usmHMACSHAAuthProtocol
    usmHMAC128SHA224AuthProtocol
    usmHMAC192SHA256AuthProtocol
    usmHMAC256SHA384AuthProtocol
    usmHMAC384SHA512AuthProtocol
    usmNoAuthProtocol

Valid values for privProtocol in JSON configuration:

.. code-block:: bash

    usm3DESEDEPrivProtocol
    usmAesCfb128Protocol
    usmAesCfb192Protocol
    usmAesBlumenthalCfb192Protocol
    usmAesCfb256Protocol
    usmAesBlumenthalCfb256Protocol
    usmDESPrivProtocol
    usmNoPrivProtocol

User and engineId values are left up to the administrator, and must conform to SNMPv3 specifications as explained at `https://tools.ietf.org/html/rfc3414` .


Sample JSON configuration
"""""""""""""""""""""""""

The format of the JSON configuration that drives all behavior of SNMPTRAP is probably best described using an example:

.. code-block:: json

    {
        "snmptrapd": {
            "version": "1.4.0",
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
            "minimum_severity_to_log": 3
        },
        "snmpv3_config": {
            "usm_users": [
                {
                    "engineId": "8000000000000001",
                    "user": "user1",
                    "usmDESPrivProtocol": "privkey1",
                    "usmHMACMD5AuthProtocol": "authkey1"
                },
                {
                    "engineId": "8000000000000002",
                    "user": "user2",
                    "usm3DESEDEPrivProtocol": "privkey2",
                    "usmHMACMD5AuthProtocol": "authkey2"
                },
                {
                    "engineId": "8000000000000003",
                    "user": "user3",
                    "usmAesCfb128Protocol": "privkey3",
                    "usmHMACMD5AuthProtocol": "authkey3"
                },
                {
                    "engineId": "8000000000000004",
                    "user": "user4",
                    "usmAesBlumenthalCfb192Protocol": "privkey4",
                    "usmHMACMD5AuthProtocol": "authkey4"
                },
                {
                    "engineId": "8000000000000005",
                    "user": "user5",
                    "usmAesBlumenthalCfb256Protocol": "privkey5",
                    "usmHMACMD5AuthProtocol": "authkey5"
                },
                {
                    "engineId": "8000000000000006",
                    "user": "user6",
                    "usmAesCfb192Protocol": "privkey6",
                    "usmHMACMD5AuthProtocol": "authkey6"
                },
                {
                    "engineId": "8000000000000007",
                    "user": "user7",
                    "usmAesCfb256Protocol": "privkey7",
                    "usmHMACMD5AuthProtocol": "authkey7"
                },
                {
                    "engineId": "8000000000000009",
                    "user": "user9",
                    "usmDESPrivProtocol": "privkey9",
                    "usmHMACSHAAuthProtocol": "authkey9"
                },
                {
                    "engineId": "8000000000000010",
                    "user": "user10",
                    "usm3DESEDEPrivProtocol": "privkey10",
                    "usmHMACSHAAuthProtocol": "authkey10"
                },
                {
                    "engineId": "8000000000000011",
                    "user": "user11",
                    "usmAesCfb128Protocol": "privkey11",
                    "usmHMACSHAAuthProtocol": "authkey11"
                },
                {
                    "engineId": "8000000000000012",
                    "user": "user12",
                    "usmAesBlumenthalCfb192Protocol": "privkey12",
                    "usmHMACSHAAuthProtocol": "authkey12"
                },
                {
                    "engineId": "8000000000000013",
                    "user": "user13",
                    "usmAesBlumenthalCfb256Protocol": "privkey13",
                    "usmHMACSHAAuthProtocol": "authkey13"
                },
                {
                    "engineId": "8000000000000014",
                    "user": "user14",
                    "usmAesCfb192Protocol": "privkey14",
                    "usmHMACSHAAuthProtocol": "authkey14"
                },
                {
                    "engineId": "8000000000000015",
                    "user": "user15",
                    "usmAesCfb256Protocol": "privkey15",
                    "usmHMACSHAAuthProtocol": "authkey15"
                },
                {
                    "engineId": "8000000000000017",
                    "user": "user17",
                    "usmDESPrivProtocol": "privkey17",
                    "usmHMAC128SHA224AuthProtocol": "authkey17"
                },
                {
                    "engineId": "8000000000000018",
                    "user": "user18",
                    "usm3DESEDEPrivProtocol": "privkey18",
                    "usmHMAC128SHA224AuthProtocol": "authkey18"
                },
                {
                    "engineId": "8000000000000019",
                    "user": "user19",
                    "usmAesCfb128Protocol": "privkey19",
                    "usmHMAC128SHA224AuthProtocol": "authkey19"
                },
                {
                    "engineId": "8000000000000020",
                    "user": "user20",
                    "usmAesBlumenthalCfb192Protocol": "privkey20",
                    "usmHMAC128SHA224AuthProtocol": "authkey20"
                },
                {
                    "engineId": "8000000000000021",
                    "user": "user21",
                    "usmAesBlumenthalCfb256Protocol": "privkey21",
                    "usmHMAC128SHA224AuthProtocol": "authkey21"
                },
                {
                    "engineId": "8000000000000022",
                    "user": "user22",
                    "usmAesCfb192Protocol": "privkey22",
                    "usmHMAC128SHA224AuthProtocol": "authkey22"
                },
                {
                    "engineId": "8000000000000023",
                    "user": "user23",
                    "usmAesCfb256Protocol": "privkey23",
                    "usmHMAC128SHA224AuthProtocol": "authkey23"
                },
                {
                    "engineId": "8000000000000025",
                    "user": "user25",
                    "usmDESPrivProtocol": "privkey25",
                    "usmHMAC192SHA256AuthProtocol": "authkey25"
                },
                {
                    "engineId": "8000000000000026",
                    "user": "user26",
                    "usm3DESEDEPrivProtocol": "privkey26",
                    "usmHMAC192SHA256AuthProtocol": "authkey26"
                },
                {
                    "engineId": "8000000000000027",
                    "user": "user27",
                    "usmAesCfb128Protocol": "privkey27",
                    "usmHMAC192SHA256AuthProtocol": "authkey27"
                },
                {
                    "engineId": "8000000000000028",
                    "user": "user28",
                    "usmAesBlumenthalCfb192Protocol": "privkey28",
                    "usmHMAC192SHA256AuthProtocol": "authkey28"
                },
                {
                    "engineId": "8000000000000029",
                    "user": "user29",
                    "usmAesBlumenthalCfb256Protocol": "privkey29",
                    "usmHMAC192SHA256AuthProtocol": "authkey29"
                },
                {
                    "engineId": "8000000000000030",
                    "user": "user30",
                    "usmAesCfb192Protocol": "privkey30",
                    "usmHMAC192SHA256AuthProtocol": "authkey30"
                },
                {
                    "engineId": "8000000000000031",
                    "user": "user31",
                    "usmAesCfb256Protocol": "privkey31",
                    "usmHMAC192SHA256AuthProtocol": "authkey31"
                },
                {
                    "engineId": "8000000000000033",
                    "user": "user33",
                    "usmDESPrivProtocol": "privkey33",
                    "usmHMAC256SHA384AuthProtocol": "authkey33"
                },
                {
                    "engineId": "8000000000000034",
                    "user": "user34",
                    "usm3DESEDEPrivProtocol": "privkey34",
                    "usmHMAC256SHA384AuthProtocol": "authkey34"
                },
                {
                    "engineId": "8000000000000035",
                    "user": "user35",
                    "usmAesCfb128Protocol": "privkey35",
                    "usmHMAC256SHA384AuthProtocol": "authkey35"
                },
                {
                    "engineId": "8000000000000036",
                    "user": "user36",
                    "usmAesBlumenthalCfb192Protocol": "privkey36",
                    "usmHMAC256SHA384AuthProtocol": "authkey36"
                },
                {
                    "engineId": "8000000000000037",
                    "user": "user37",
                    "usmAesBlumenthalCfb256Protocol": "privkey37",
                    "usmHMAC256SHA384AuthProtocol": "authkey37"
                },
                {
                    "engineId": "8000000000000038",
                    "user": "user38",
                    "usmAesCfb192Protocol": "privkey38",
                    "usmHMAC256SHA384AuthProtocol": "authkey38"
                },
                {
                    "engineId": "8000000000000039",
                    "user": "user39",
                    "usmAesCfb256Protocol": "privkey39",
                    "usmHMAC256SHA384AuthProtocol": "authkey39"
                },
                {
                    "engineId": "8000000000000041",
                    "user": "user41",
                    "usmDESPrivProtocol": "privkey41",
                    "usmHMAC384SHA512AuthProtocol": "authkey41"
                },
                {
                    "engineId": "8000000000000042",
                    "user": "user42",
                    "usm3DESEDEPrivProtocol": "privkey42",
                    "usmHMAC384SHA512AuthProtocol": "authkey42"
                },
                {
                    "engineId": "8000000000000043",
                    "user": "user43",
                    "usmAesCfb128Protocol": "privkey43",
                    "usmHMAC384SHA512AuthProtocol": "authkey43"
                },
                {
                    "engineId": "8000000000000044",
                    "user": "user44",
                    "usmAesBlumenthalCfb192Protocol": "privkey44",
                    "usmHMAC384SHA512AuthProtocol": "authkey44"
                },
                {
                    "engineId": "8000000000000045",
                    "user": "user45",
                    "usmAesBlumenthalCfb256Protocol": "privkey45",
                    "usmHMAC384SHA512AuthProtocol": "authkey45"
                },
                {
                    "engineId": "8000000000000046",
                    "user": "user46",
                    "usmAesCfb192Protocol": "privkey46",
                    "usmHMAC384SHA512AuthProtocol": "authkey46"
                },
                {
                    "engineId": "8000000000000047",
                    "user": "user47",
                    "usmAesCfb256Protocol": "privkey47",
                    "usmHMAC384SHA512AuthProtocol": "authkey47"
                }

       }
