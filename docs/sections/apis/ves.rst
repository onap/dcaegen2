VES Collector 1.1.0
===================

.. toctree::
    :maxdepth: 3


Description
~~~~~~~~~~~

Virtual Event Streaming (VES) Collector is RESTful collector for processing JSON messages. The collector verifies the source and validates the events against VES schema before distributing to DMAAP MR topics




Contact Information
~~~~~~~~~~~~~~~~~~~



dcae@lists.openecomp.org






Security
~~~~~~~~


.. _securities_basicAuth:

basicAuth (HTTP Basic Authentication)
-------------------------------------


*HTTP Basic Authentication. Works over `HTTP` and `HTTPS`*





DEFAULT
~~~~~~~




GET ``/healthcheck``
--------------------





Request
+++++++


Responses
+++++++++

**200**
^^^^^^^

healthcheck successful






POST ``/eventListener/v5``
--------------------------



Description
+++++++++++

.. raw:: html

    uri for posting VES event objects


Request
+++++++



.. _d_f598222d7a83ca9c3538556b263682d1:

Body
^^^^

.. csv-table::
    :delim: |
    :header: "Name", "Required", "Type", "Format", "Properties", "Description"
    :widths: 20, 10, 15, 15, 30, 25

        event | No | :ref:`event <d_0eeffb3cd3e31135c2f3cf8ee4a2bdbb>` |  |  | 

.. code-block:: javascript

    {
        "event": {
            "commonEventHeader": {
                "domain": "fault",
                "eventId": "somestring",
                "eventName": "somestring",
                "eventType": "somestring",
                "internalHeaderFields": {},
                "lastEpochMicrosec": 1,
                "nfNamingCode": "somestring",
                "nfcNamingCode": "somestring",
                "priority": "High",
                "reportingEntityId": "somestring",
                "reportingEntityName": "somestring",
                "sequence": 1,
                "sourceId": "somestring",
                "sourceName": "somestring",
                "startEpochMicrosec": 1,
                "version": 1
            },
            "faultFields": {
                "alarmAdditionalInformation": [
                    {
                        "name": "somestring",
                        "value": "somestring"
                    },
                    {
                        "name": "somestring",
                        "value": "somestring"
                    }
                ],
                "alarmCondition": "somestring",
                "alarmInterfaceA": "somestring",
                "eventCategory": "somestring",
                "eventSeverity": "CRITICAL",
                "eventSourceType": "somestring",
                "faultFieldsVersion": 1,
                "specificProblem": "somestring",
                "vfStatus": "Active"
            },
            "heartbeatFields": {
                "additionalFields": [
                    {
                        "name": "somestring",
                        "value": "somestring"
                    },
                    {
                        "name": "somestring",
                        "value": "somestring"
                    }
                ],
                "heartbeatFieldsVersion": 1,
                "heartbeatInterval": 1
            },
            "measurementsForVfScalingFields": {
                "additionalFields": [
                    {
                        "name": "somestring",
                        "value": "somestring"
                    },
                    {
                        "name": "somestring",
                        "value": "somestring"
                    }
                ],
                "additionalMeasurements": [
                    {
                        "arrayOfFields": [
                            {
                                "name": "somestring",
                                "value": "somestring"
                            },
                            {
                                "name": "somestring",
                                "value": "somestring"
                            }
                        ],
                        "name": "somestring"
                    },
                    {
                        "arrayOfFields": [
                            {
                                "name": "somestring",
                                "value": "somestring"
                            },
                            {
                                "name": "somestring",
                                "value": "somestring"
                            }
                        ],
                        "name": "somestring"
                    }
                ],
                "additionalObjects": [
                    {
                        "nfSubscribedObjectName": "somestring",
                        "nfSubscriptionId": "somestring",
                        "objectInstances": [
                            {
                                "objectInstance": {},
                                "objectInstanceEpochMicrosec": 1,
                                "objectKeys": [
                                    {
                                        "keyName": "somestring",
                                        "keyOrder": 1,
                                        "keyValue": "somestring"
                                    },
                                    {
                                        "keyName": "somestring",
                                        "keyOrder": 1,
                                        "keyValue": "somestring"
                                    }
                                ]
                            },
                            {
                                "objectInstance": {},
                                "objectInstanceEpochMicrosec": 1,
                                "objectKeys": [
                                    {
                                        "keyName": "somestring",
                                        "keyOrder": 1,
                                        "keyValue": "somestring"
                                    },
                                    {
                                        "keyName": "somestring",
                                        "keyOrder": 1,
                                        "keyValue": "somestring"
                                    }
                                ]
                            }
                        ],
                        "objectName": "somestring",
                        "objectSchema": "somestring",
                        "objectSchemaUrl": "somestring"
                    },
                    {
                        "nfSubscribedObjectName": "somestring",
                        "nfSubscriptionId": "somestring",
                        "objectInstances": [
                            {
                                "objectInstance": {},
                                "objectInstanceEpochMicrosec": 1,
                                "objectKeys": [
                                    {
                                        "keyName": "somestring",
                                        "keyOrder": 1,
                                        "keyValue": "somestring"
                                    },
                                    {
                                        "keyName": "somestring",
                                        "keyOrder": 1,
                                        "keyValue": "somestring"
                                    }
                                ]
                            },
                            {
                                "objectInstance": {},
                                "objectInstanceEpochMicrosec": 1,
                                "objectKeys": [
                                    {
                                        "keyName": "somestring",
                                        "keyOrder": 1,
                                        "keyValue": "somestring"
                                    },
                                    {
                                        "keyName": "somestring",
                                        "keyOrder": 1,
                                        "keyValue": "somestring"
                                    }
                                ]
                            }
                        ],
                        "objectName": "somestring",
                        "objectSchema": "somestring",
                        "objectSchemaUrl": "somestring"
                    }
                ],
                "codecUsageArray": [
                    {
                        "codecIdentifier": "somestring",
                        "numberInUse": 1
                    },
                    {
                        "codecIdentifier": "somestring",
                        "numberInUse": 1
                    }
                ],
                "concurrentSessions": 1,
                "configuredEntities": 1,
                "cpuUsageArray": [
                    {
                        "cpuIdentifier": "somestring",
                        "cpuIdle": 1,
                        "cpuUsageInterrupt": 1,
                        "cpuUsageNice": 1,
                        "cpuUsageSoftIrq": 1,
                        "cpuUsageSteal": 1,
                        "cpuUsageSystem": 1,
                        "cpuUsageUser": 1,
                        "cpuWait": 1,
                        "percentUsage": 1
                    },
                    {
                        "cpuIdentifier": "somestring",
                        "cpuIdle": 1,
                        "cpuUsageInterrupt": 1,
                        "cpuUsageNice": 1,
                        "cpuUsageSoftIrq": 1,
                        "cpuUsageSteal": 1,
                        "cpuUsageSystem": 1,
                        "cpuUsageUser": 1,
                        "cpuWait": 1,
                        "percentUsage": 1
                    }
                ],
                "diskUsageArray": [
                    {
                        "diskIdentifier": "somestring",
                        "diskIoTimeAvg": 1,
                        "diskIoTimeLast": 1,
                        "diskIoTimeMax": 1,
                        "diskIoTimeMin": 1,
                        "diskMergedReadAvg": 1,
                        "diskMergedReadLast": 1,
                        "diskMergedReadMax": 1,
                        "diskMergedReadMin": 1,
                        "diskMergedWriteAvg": 1,
                        "diskMergedWriteLast": 1,
                        "diskMergedWriteMax": 1,
                        "diskMergedWriteMin": 1,
                        "diskOctetsReadAvg": 1,
                        "diskOctetsReadLast": 1,
                        "diskOctetsReadMax": 1,
                        "diskOctetsReadMin": 1,
                        "diskOctetsWriteAvg": 1,
                        "diskOctetsWriteLast": 1,
                        "diskOctetsWriteMax": 1,
                        "diskOctetsWriteMin": 1,
                        "diskOpsReadAvg": 1,
                        "diskOpsReadLast": 1,
                        "diskOpsReadMax": 1,
                        "diskOpsReadMin": 1,
                        "diskOpsWriteAvg": 1,
                        "diskOpsWriteLast": 1,
                        "diskOpsWriteMax": 1,
                        "diskOpsWriteMin": 1,
                        "diskPendingOperationsAvg": 1,
                        "diskPendingOperationsLast": 1,
                        "diskPendingOperationsMax": 1,
                        "diskPendingOperationsMin": 1,
                        "diskTimeReadAvg": 1,
                        "diskTimeReadLast": 1,
                        "diskTimeReadMax": 1,
                        "diskTimeReadMin": 1,
                        "diskTimeWriteAvg": 1,
                        "diskTimeWriteLast": 1,
                        "diskTimeWriteMax": 1,
                        "diskTimeWriteMin": 1
                    },
                    {
                        "diskIdentifier": "somestring",
                        "diskIoTimeAvg": 1,
                        "diskIoTimeLast": 1,
                        "diskIoTimeMax": 1,
                        "diskIoTimeMin": 1,
                        "diskMergedReadAvg": 1,
                        "diskMergedReadLast": 1,
                        "diskMergedReadMax": 1,
                        "diskMergedReadMin": 1,
                        "diskMergedWriteAvg": 1,
                        "diskMergedWriteLast": 1,
                        "diskMergedWriteMax": 1,
                        "diskMergedWriteMin": 1,
                        "diskOctetsReadAvg": 1,
                        "diskOctetsReadLast": 1,
                        "diskOctetsReadMax": 1,
                        "diskOctetsReadMin": 1,
                        "diskOctetsWriteAvg": 1,
                        "diskOctetsWriteLast": 1,
                        "diskOctetsWriteMax": 1,
                        "diskOctetsWriteMin": 1,
                        "diskOpsReadAvg": 1,
                        "diskOpsReadLast": 1,
                        "diskOpsReadMax": 1,
                        "diskOpsReadMin": 1,
                        "diskOpsWriteAvg": 1,
                        "diskOpsWriteLast": 1,
                        "diskOpsWriteMax": 1,
                        "diskOpsWriteMin": 1,
                        "diskPendingOperationsAvg": 1,
                        "diskPendingOperationsLast": 1,
                        "diskPendingOperationsMax": 1,
                        "diskPendingOperationsMin": 1,
                        "diskTimeReadAvg": 1,
                        "diskTimeReadLast": 1,
                        "diskTimeReadMax": 1,
                        "diskTimeReadMin": 1,
                        "diskTimeWriteAvg": 1,
                        "diskTimeWriteLast": 1,
                        "diskTimeWriteMax": 1,
                        "diskTimeWriteMin": 1
                    }
                ],
                "featureUsageArray": [
                    {
                        "featureIdentifier": "somestring",
                        "featureUtilization": 1
                    },
                    {
                        "featureIdentifier": "somestring",
                        "featureUtilization": 1
                    }
                ],
                "filesystemUsageArray": [
                    {
                        "blockConfigured": 1,
                        "blockIops": 1,
                        "blockUsed": 1,
                        "ephemeralConfigured": 1,
                        "ephemeralIops": 1,
                        "ephemeralUsed": 1,
                        "filesystemName": "somestring"
                    },
                    {
                        "blockConfigured": 1,
                        "blockIops": 1,
                        "blockUsed": 1,
                        "ephemeralConfigured": 1,
                        "ephemeralIops": 1,
                        "ephemeralUsed": 1,
                        "filesystemName": "somestring"
                    }
                ],
                "latencyDistribution": [
                    {
                        "countsInTheBucket": 1,
                        "highEndOfLatencyBucket": 1,
                        "lowEndOfLatencyBucket": 1
                    },
                    {
                        "countsInTheBucket": 1,
                        "highEndOfLatencyBucket": 1,
                        "lowEndOfLatencyBucket": 1
                    }
                ],
                "meanRequestLatency": 1,
                "measurementInterval": 1,
                "measurementsForVfScalingVersion": 1,
                "memoryUsageArray": [
                    {
                        "memoryBuffered": 1,
                        "memoryCached": 1,
                        "memoryConfigured": 1,
                        "memoryFree": 1,
                        "memorySlabRecl": 1,
                        "memorySlabUnrecl": 1,
                        "memoryUsed": 1,
                        "vmIdentifier": "somestring"
                    },
                    {
                        "memoryBuffered": 1,
                        "memoryCached": 1,
                        "memoryConfigured": 1,
                        "memoryFree": 1,
                        "memorySlabRecl": 1,
                        "memorySlabUnrecl": 1,
                        "memoryUsed": 1,
                        "vmIdentifier": "somestring"
                    }
                ],
                "numberOfMediaPortsInUse": 1,
                "requestRate": 1,
                "vNicPerformanceArray": [
                    {
                        "receivedBroadcastPacketsAccumulated": 1,
                        "receivedBroadcastPacketsDelta": 1,
                        "receivedDiscardedPacketsAccumulated": 1,
                        "receivedDiscardedPacketsDelta": 1,
                        "receivedErrorPacketsAccumulated": 1,
                        "receivedErrorPacketsDelta": 1,
                        "receivedMulticastPacketsAccumulated": 1,
                        "receivedMulticastPacketsDelta": 1,
                        "receivedOctetsAccumulated": 1,
                        "receivedOctetsDelta": 1,
                        "receivedTotalPacketsAccumulated": 1,
                        "receivedTotalPacketsDelta": 1,
                        "receivedUnicastPacketsAccumulated": 1,
                        "receivedUnicastPacketsDelta": 1,
                        "transmittedBroadcastPacketsAccumulated": 1,
                        "transmittedBroadcastPacketsDelta": 1,
                        "transmittedDiscardedPacketsAccumulated": 1,
                        "transmittedDiscardedPacketsDelta": 1,
                        "transmittedErrorPacketsAccumulated": 1,
                        "transmittedErrorPacketsDelta": 1,
                        "transmittedMulticastPacketsAccumulated": 1,
                        "transmittedMulticastPacketsDelta": 1,
                        "transmittedOctetsAccumulated": 1,
                        "transmittedOctetsDelta": 1,
                        "transmittedTotalPacketsAccumulated": 1,
                        "transmittedTotalPacketsDelta": 1,
                        "transmittedUnicastPacketsAccumulated": 1,
                        "transmittedUnicastPacketsDelta": 1,
                        "vNicIdentifier": "somestring",
                        "valuesAreSuspect": "true"
                    },
                    {
                        "receivedBroadcastPacketsAccumulated": 1,
                        "receivedBroadcastPacketsDelta": 1,
                        "receivedDiscardedPacketsAccumulated": 1,
                        "receivedDiscardedPacketsDelta": 1,
                        "receivedErrorPacketsAccumulated": 1,
                        "receivedErrorPacketsDelta": 1,
                        "receivedMulticastPacketsAccumulated": 1,
                        "receivedMulticastPacketsDelta": 1,
                        "receivedOctetsAccumulated": 1,
                        "receivedOctetsDelta": 1,
                        "receivedTotalPacketsAccumulated": 1,
                        "receivedTotalPacketsDelta": 1,
                        "receivedUnicastPacketsAccumulated": 1,
                        "receivedUnicastPacketsDelta": 1,
                        "transmittedBroadcastPacketsAccumulated": 1,
                        "transmittedBroadcastPacketsDelta": 1,
                        "transmittedDiscardedPacketsAccumulated": 1,
                        "transmittedDiscardedPacketsDelta": 1,
                        "transmittedErrorPacketsAccumulated": 1,
                        "transmittedErrorPacketsDelta": 1,
                        "transmittedMulticastPacketsAccumulated": 1,
                        "transmittedMulticastPacketsDelta": 1,
                        "transmittedOctetsAccumulated": 1,
                        "transmittedOctetsDelta": 1,
                        "transmittedTotalPacketsAccumulated": 1,
                        "transmittedTotalPacketsDelta": 1,
                        "transmittedUnicastPacketsAccumulated": 1,
                        "transmittedUnicastPacketsDelta": 1,
                        "vNicIdentifier": "somestring",
                        "valuesAreSuspect": "true"
                    }
                ],
                "vnfcScalingMetric": 1
            },
            "mobileFlowFields": {
                "additionalFields": [
                    {
                        "name": "somestring",
                        "value": "somestring"
                    },
                    {
                        "name": "somestring",
                        "value": "somestring"
                    }
                ],
                "appProtocolType": "somestring",
                "appProtocolVersion": "somestring",
                "applicationType": "somestring",
                "cid": "somestring",
                "connectionType": "somestring",
                "ecgi": "somestring",
                "flowDirection": "somestring",
                "gtpPerFlowMetrics": {
                    "avgBitErrorRate": 1,
                    "avgPacketDelayVariation": 1,
                    "avgPacketLatency": 1,
                    "avgReceiveThroughput": 1,
                    "avgTransmitThroughput": 1,
                    "durConnectionFailedStatus": 1,
                    "durTunnelFailedStatus": 1,
                    "flowActivatedBy": "somestring",
                    "flowActivationEpoch": 1,
                    "flowActivationMicrosec": 1,
                    "flowActivationTime": "somestring",
                    "flowDeactivatedBy": "somestring",
                    "flowDeactivationEpoch": 1,
                    "flowDeactivationMicrosec": 1,
                    "flowDeactivationTime": "somestring",
                    "flowStatus": "somestring",
                    "gtpConnectionStatus": "somestring",
                    "gtpTunnelStatus": "somestring",
                    "ipTosCountList": [
                        [
                            1,
                            1
                        ],
                        [
                            1,
                            1
                        ]
                    ],
                    "ipTosList": [
                        "somestring",
                        "somestring"
                    ],
                    "largePacketRtt": 1,
                    "largePacketThreshold": 1,
                    "maxPacketDelayVariation": 1,
                    "maxReceiveBitRate": 1,
                    "maxTransmitBitRate": 1,
                    "mobileQciCosCountList": [
                        [
                            1,
                            1
                        ],
                        [
                            1,
                            1
                        ]
                    ],
                    "mobileQciCosList": [
                        "somestring",
                        "somestring"
                    ],
                    "numActivationFailures": 1,
                    "numBitErrors": 1,
                    "numBytesReceived": 1,
                    "numBytesTransmitted": 1,
                    "numDroppedPackets": 1,
                    "numGtpEchoFailures": 1,
                    "numGtpTunnelErrors": 1,
                    "numHttpErrors": 1,
                    "numL7BytesReceived": 1,
                    "numL7BytesTransmitted": 1,
                    "numLostPackets": 1,
                    "numOutOfOrderPackets": 1,
                    "numPacketErrors": 1,
                    "numPacketsReceivedExclRetrans": 1,
                    "numPacketsReceivedInclRetrans": 1,
                    "numPacketsTransmittedInclRetrans": 1,
                    "numRetries": 1,
                    "numTimeouts": 1,
                    "numTunneledL7BytesReceived": 1,
                    "roundTripTime": 1,
                    "tcpFlagCountList": [
                        [
                            1,
                            1
                        ],
                        [
                            1,
                            1
                        ]
                    ],
                    "tcpFlagList": [
                        "somestring",
                        "somestring"
                    ],
                    "timeToFirstByte": 1
                },
                "gtpProtocolType": "somestring",
                "gtpVersion": "somestring",
                "httpHeader": "somestring",
                "imei": "somestring",
                "imsi": "somestring",
                "ipProtocolType": "somestring",
                "ipVersion": "somestring",
                "lac": "somestring",
                "mcc": "somestring",
                "mnc": "somestring",
                "mobileFlowFieldsVersion": 1,
                "msisdn": "somestring",
                "otherEndpointIpAddress": "somestring",
                "otherEndpointPort": 1,
                "otherFunctionalRole": "somestring",
                "rac": "somestring",
                "radioAccessTechnology": "somestring",
                "reportingEndpointIpAddr": "somestring",
                "reportingEndpointPort": 1,
                "sac": "somestring",
                "samplingAlgorithm": 1,
                "tac": "somestring",
                "tunnelId": "somestring",
                "vlanId": "somestring"
            },
            "otherFields": {
                "hashOfNameValuePairArrays": [
                    {
                        "arrayOfFields": [
                            {
                                "name": "somestring",
                                "value": "somestring"
                            },
                            {
                                "name": "somestring",
                                "value": "somestring"
                            }
                        ],
                        "name": "somestring"
                    },
                    {
                        "arrayOfFields": [
                            {
                                "name": "somestring",
                                "value": "somestring"
                            },
                            {
                                "name": "somestring",
                                "value": "somestring"
                            }
                        ],
                        "name": "somestring"
                    }
                ],
                "jsonObjects": [
                    {
                        "nfSubscribedObjectName": "somestring",
                        "nfSubscriptionId": "somestring",
                        "objectInstances": [
                            {
                                "objectInstance": {},
                                "objectInstanceEpochMicrosec": 1,
                                "objectKeys": [
                                    {
                                        "keyName": "somestring",
                                        "keyOrder": 1,
                                        "keyValue": "somestring"
                                    },
                                    {
                                        "keyName": "somestring",
                                        "keyOrder": 1,
                                        "keyValue": "somestring"
                                    }
                                ]
                            },
                            {
                                "objectInstance": {},
                                "objectInstanceEpochMicrosec": 1,
                                "objectKeys": [
                                    {
                                        "keyName": "somestring",
                                        "keyOrder": 1,
                                        "keyValue": "somestring"
                                    },
                                    {
                                        "keyName": "somestring",
                                        "keyOrder": 1,
                                        "keyValue": "somestring"
                                    }
                                ]
                            }
                        ],
                        "objectName": "somestring",
                        "objectSchema": "somestring",
                        "objectSchemaUrl": "somestring"
                    },
                    {
                        "nfSubscribedObjectName": "somestring",
                        "nfSubscriptionId": "somestring",
                        "objectInstances": [
                            {
                                "objectInstance": {},
                                "objectInstanceEpochMicrosec": 1,
                                "objectKeys": [
                                    {
                                        "keyName": "somestring",
                                        "keyOrder": 1,
                                        "keyValue": "somestring"
                                    },
                                    {
                                        "keyName": "somestring",
                                        "keyOrder": 1,
                                        "keyValue": "somestring"
                                    }
                                ]
                            },
                            {
                                "objectInstance": {},
                                "objectInstanceEpochMicrosec": 1,
                                "objectKeys": [
                                    {
                                        "keyName": "somestring",
                                        "keyOrder": 1,
                                        "keyValue": "somestring"
                                    },
                                    {
                                        "keyName": "somestring",
                                        "keyOrder": 1,
                                        "keyValue": "somestring"
                                    }
                                ]
                            }
                        ],
                        "objectName": "somestring",
                        "objectSchema": "somestring",
                        "objectSchemaUrl": "somestring"
                    }
                ],
                "nameValuePairs": [
                    {
                        "name": "somestring",
                        "value": "somestring"
                    },
                    {
                        "name": "somestring",
                        "value": "somestring"
                    }
                ],
                "otherFieldsVersion": 1
            },
            "sipSignalingFields": {
                "additionalInformation": [
                    {
                        "name": "somestring",
                        "value": "somestring"
                    },
                    {
                        "name": "somestring",
                        "value": "somestring"
                    }
                ],
                "compressedSip": "somestring",
                "correlator": "somestring",
                "localIpAddress": "somestring",
                "localPort": "somestring",
                "remoteIpAddress": "somestring",
                "remotePort": "somestring",
                "sipSignalingFieldsVersion": 1,
                "summarySip": "somestring",
                "vendorVnfNameFields": {
                    "vendorName": "somestring",
                    "vfModuleName": "somestring",
                    "vnfName": "somestring"
                }
            },
            "stateChangeFields": {
                "additionalFields": [
                    {
                        "name": "somestring",
                        "value": "somestring"
                    },
                    {
                        "name": "somestring",
                        "value": "somestring"
                    }
                ],
                "newState": "inService",
                "oldState": "inService",
                "stateChangeFieldsVersion": 1,
                "stateInterface": "somestring"
            },
            "syslogFields": {
                "additionalFields": "somestring",
                "eventSourceHost": "somestring",
                "eventSourceType": "somestring",
                "syslogFacility": 1,
                "syslogFieldsVersion": 1,
                "syslogMsg": "somestring",
                "syslogPri": 1,
                "syslogProc": "somestring",
                "syslogProcId": 1,
                "syslogSData": "somestring",
                "syslogSdId": "somestring",
                "syslogSev": "Alert",
                "syslogTag": "somestring",
                "syslogVer": 1
            },
            "thresholdCrossingAlertFields": {
                "additionalFields": [
                    {
                        "name": "somestring",
                        "value": "somestring"
                    },
                    {
                        "name": "somestring",
                        "value": "somestring"
                    }
                ],
                "additionalParameters": [
                    {
                        "criticality": "CRIT",
                        "name": "somestring",
                        "thresholdCrossed": "somestring",
                        "value": "somestring"
                    },
                    {
                        "criticality": "CRIT",
                        "name": "somestring",
                        "thresholdCrossed": "somestring",
                        "value": "somestring"
                    }
                ],
                "alertAction": "CLEAR",
                "alertDescription": "somestring",
                "alertType": "CARD-ANOMALY",
                "alertValue": "somestring",
                "associatedAlertIdList": [
                    "somestring",
                    "somestring"
                ],
                "collectionTimestamp": "somestring",
                "dataCollector": "somestring",
                "elementType": "somestring",
                "eventSeverity": "CRITICAL",
                "eventStartTimestamp": "somestring",
                "interfaceName": "somestring",
                "networkService": "somestring",
                "possibleRootCause": "somestring",
                "thresholdCrossingFieldsVersion": 1
            },
            "voiceQualityFields": {
                "additionalInformation": [
                    {
                        "name": "somestring",
                        "value": "somestring"
                    },
                    {
                        "name": "somestring",
                        "value": "somestring"
                    }
                ],
                "calleeSideCodec": "somestring",
                "callerSideCodec": "somestring",
                "correlator": "somestring",
                "endOfCallVqmSummaries": {
                    "adjacencyName": "somestring",
                    "endpointDescription": "Caller",
                    "endpointJitter": 1,
                    "endpointRtpOctetsDiscarded": 1,
                    "endpointRtpOctetsReceived": 1,
                    "endpointRtpOctetsSent": 1,
                    "endpointRtpPacketsDiscarded": 1,
                    "endpointRtpPacketsReceived": 1,
                    "endpointRtpPacketsSent": 1,
                    "localJitter": 1,
                    "localRtpOctetsDiscarded": 1,
                    "localRtpOctetsReceived": 1,
                    "localRtpOctetsSent": 1,
                    "localRtpPacketsDiscarded": 1,
                    "localRtpPacketsReceived": 1,
                    "localRtpPacketsSent": 1,
                    "mosCqe": 1,
                    "packetLossPercent": 1,
                    "packetsLost": 1,
                    "rFactor": 1,
                    "roundTripDelay": 1
                },
                "midCallRtcp": "somestring",
                "phoneNumber": "somestring",
                "vendorVnfNameFields": {
                    "vendorName": "somestring",
                    "vfModuleName": "somestring",
                    "vnfName": "somestring"
                },
                "voiceQualityFieldsVersion": 1
            }
        }
    }

Responses
+++++++++

**200**
^^^^^^^

VES Event Accepted.


Type: :ref:`ApiResponseMessage <d_8a94f348f7df00259702f8d9b7d2ea84>`

**Example:**

.. code-block:: javascript

    {
        "code": 1,
        "message": "somestring",
        "type": "somestring"
    }

**400**
^^^^^^^

Bad request provided


Type: :ref:`ApiResponseMessage <d_8a94f348f7df00259702f8d9b7d2ea84>`

**Example:**

.. code-block:: javascript

    {
        "code": 1,
        "message": "somestring",
        "type": "somestring"
    }

**401**
^^^^^^^

Unauthorized request


Type: :ref:`ApiResponseMessage <d_8a94f348f7df00259702f8d9b7d2ea84>`

**Example:**

.. code-block:: javascript

    {
        "code": 1,
        "message": "somestring",
        "type": "somestring"
    }

**503**
^^^^^^^

Service Unavailable


Type: :ref:`ApiResponseMessage <d_8a94f348f7df00259702f8d9b7d2ea84>`

**Example:**

.. code-block:: javascript

    {
        "code": 1,
        "message": "somestring",
        "type": "somestring"
    }



Security
++++++++

.. csv-table::
    :header: "Security Schema", "Scopes"
    :widths: 15, 45

        :ref:`basicAuth <securities_basicAuth>`, ""


POST ``/eventListener/v5/eventBatch``
-------------------------------------



Description
+++++++++++

.. raw:: html

    uri for posting VES batch event objects


Request
+++++++




Body
^^^^

.. csv-table::
    :delim: |
    :header: "Name", "Required", "Type", "Format", "Properties", "Description"
    :widths: 20, 10, 15, 15, 30, 25

        event | No | :ref:`event <d_0eeffb3cd3e31135c2f3cf8ee4a2bdbb>` |  |  | 

.. code-block:: javascript

    {
        "event": {
            "commonEventHeader": {
                "domain": "fault",
                "eventId": "somestring",
                "eventName": "somestring",
                "eventType": "somestring",
                "internalHeaderFields": {},
                "lastEpochMicrosec": 1,
                "nfNamingCode": "somestring",
                "nfcNamingCode": "somestring",
                "priority": "High",
                "reportingEntityId": "somestring",
                "reportingEntityName": "somestring",
                "sequence": 1,
                "sourceId": "somestring",
                "sourceName": "somestring",
                "startEpochMicrosec": 1,
                "version": 1
            },
            "faultFields": {
                "alarmAdditionalInformation": [
                    {
                        "name": "somestring",
                        "value": "somestring"
                    },
                    {
                        "name": "somestring",
                        "value": "somestring"
                    }
                ],
                "alarmCondition": "somestring",
                "alarmInterfaceA": "somestring",
                "eventCategory": "somestring",
                "eventSeverity": "CRITICAL",
                "eventSourceType": "somestring",
                "faultFieldsVersion": 1,
                "specificProblem": "somestring",
                "vfStatus": "Active"
            },
            "heartbeatFields": {
                "additionalFields": [
                    {
                        "name": "somestring",
                        "value": "somestring"
                    },
                    {
                        "name": "somestring",
                        "value": "somestring"
                    }
                ],
                "heartbeatFieldsVersion": 1,
                "heartbeatInterval": 1
            },
            "measurementsForVfScalingFields": {
                "additionalFields": [
                    {
                        "name": "somestring",
                        "value": "somestring"
                    },
                    {
                        "name": "somestring",
                        "value": "somestring"
                    }
                ],
                "additionalMeasurements": [
                    {
                        "arrayOfFields": [
                            {
                                "name": "somestring",
                                "value": "somestring"
                            },
                            {
                                "name": "somestring",
                                "value": "somestring"
                            }
                        ],
                        "name": "somestring"
                    },
                    {
                        "arrayOfFields": [
                            {
                                "name": "somestring",
                                "value": "somestring"
                            },
                            {
                                "name": "somestring",
                                "value": "somestring"
                            }
                        ],
                        "name": "somestring"
                    }
                ],
                "additionalObjects": [
                    {
                        "nfSubscribedObjectName": "somestring",
                        "nfSubscriptionId": "somestring",
                        "objectInstances": [
                            {
                                "objectInstance": {},
                                "objectInstanceEpochMicrosec": 1,
                                "objectKeys": [
                                    {
                                        "keyName": "somestring",
                                        "keyOrder": 1,
                                        "keyValue": "somestring"
                                    },
                                    {
                                        "keyName": "somestring",
                                        "keyOrder": 1,
                                        "keyValue": "somestring"
                                    }
                                ]
                            },
                            {
                                "objectInstance": {},
                                "objectInstanceEpochMicrosec": 1,
                                "objectKeys": [
                                    {
                                        "keyName": "somestring",
                                        "keyOrder": 1,
                                        "keyValue": "somestring"
                                    },
                                    {
                                        "keyName": "somestring",
                                        "keyOrder": 1,
                                        "keyValue": "somestring"
                                    }
                                ]
                            }
                        ],
                        "objectName": "somestring",
                        "objectSchema": "somestring",
                        "objectSchemaUrl": "somestring"
                    },
                    {
                        "nfSubscribedObjectName": "somestring",
                        "nfSubscriptionId": "somestring",
                        "objectInstances": [
                            {
                                "objectInstance": {},
                                "objectInstanceEpochMicrosec": 1,
                                "objectKeys": [
                                    {
                                        "keyName": "somestring",
                                        "keyOrder": 1,
                                        "keyValue": "somestring"
                                    },
                                    {
                                        "keyName": "somestring",
                                        "keyOrder": 1,
                                        "keyValue": "somestring"
                                    }
                                ]
                            },
                            {
                                "objectInstance": {},
                                "objectInstanceEpochMicrosec": 1,
                                "objectKeys": [
                                    {
                                        "keyName": "somestring",
                                        "keyOrder": 1,
                                        "keyValue": "somestring"
                                    },
                                    {
                                        "keyName": "somestring",
                                        "keyOrder": 1,
                                        "keyValue": "somestring"
                                    }
                                ]
                            }
                        ],
                        "objectName": "somestring",
                        "objectSchema": "somestring",
                        "objectSchemaUrl": "somestring"
                    }
                ],
                "codecUsageArray": [
                    {
                        "codecIdentifier": "somestring",
                        "numberInUse": 1
                    },
                    {
                        "codecIdentifier": "somestring",
                        "numberInUse": 1
                    }
                ],
                "concurrentSessions": 1,
                "configuredEntities": 1,
                "cpuUsageArray": [
                    {
                        "cpuIdentifier": "somestring",
                        "cpuIdle": 1,
                        "cpuUsageInterrupt": 1,
                        "cpuUsageNice": 1,
                        "cpuUsageSoftIrq": 1,
                        "cpuUsageSteal": 1,
                        "cpuUsageSystem": 1,
                        "cpuUsageUser": 1,
                        "cpuWait": 1,
                        "percentUsage": 1
                    },
                    {
                        "cpuIdentifier": "somestring",
                        "cpuIdle": 1,
                        "cpuUsageInterrupt": 1,
                        "cpuUsageNice": 1,
                        "cpuUsageSoftIrq": 1,
                        "cpuUsageSteal": 1,
                        "cpuUsageSystem": 1,
                        "cpuUsageUser": 1,
                        "cpuWait": 1,
                        "percentUsage": 1
                    }
                ],
                "diskUsageArray": [
                    {
                        "diskIdentifier": "somestring",
                        "diskIoTimeAvg": 1,
                        "diskIoTimeLast": 1,
                        "diskIoTimeMax": 1,
                        "diskIoTimeMin": 1,
                        "diskMergedReadAvg": 1,
                        "diskMergedReadLast": 1,
                        "diskMergedReadMax": 1,
                        "diskMergedReadMin": 1,
                        "diskMergedWriteAvg": 1,
                        "diskMergedWriteLast": 1,
                        "diskMergedWriteMax": 1,
                        "diskMergedWriteMin": 1,
                        "diskOctetsReadAvg": 1,
                        "diskOctetsReadLast": 1,
                        "diskOctetsReadMax": 1,
                        "diskOctetsReadMin": 1,
                        "diskOctetsWriteAvg": 1,
                        "diskOctetsWriteLast": 1,
                        "diskOctetsWriteMax": 1,
                        "diskOctetsWriteMin": 1,
                        "diskOpsReadAvg": 1,
                        "diskOpsReadLast": 1,
                        "diskOpsReadMax": 1,
                        "diskOpsReadMin": 1,
                        "diskOpsWriteAvg": 1,
                        "diskOpsWriteLast": 1,
                        "diskOpsWriteMax": 1,
                        "diskOpsWriteMin": 1,
                        "diskPendingOperationsAvg": 1,
                        "diskPendingOperationsLast": 1,
                        "diskPendingOperationsMax": 1,
                        "diskPendingOperationsMin": 1,
                        "diskTimeReadAvg": 1,
                        "diskTimeReadLast": 1,
                        "diskTimeReadMax": 1,
                        "diskTimeReadMin": 1,
                        "diskTimeWriteAvg": 1,
                        "diskTimeWriteLast": 1,
                        "diskTimeWriteMax": 1,
                        "diskTimeWriteMin": 1
                    },
                    {
                        "diskIdentifier": "somestring",
                        "diskIoTimeAvg": 1,
                        "diskIoTimeLast": 1,
                        "diskIoTimeMax": 1,
                        "diskIoTimeMin": 1,
                        "diskMergedReadAvg": 1,
                        "diskMergedReadLast": 1,
                        "diskMergedReadMax": 1,
                        "diskMergedReadMin": 1,
                        "diskMergedWriteAvg": 1,
                        "diskMergedWriteLast": 1,
                        "diskMergedWriteMax": 1,
                        "diskMergedWriteMin": 1,
                        "diskOctetsReadAvg": 1,
                        "diskOctetsReadLast": 1,
                        "diskOctetsReadMax": 1,
                        "diskOctetsReadMin": 1,
                        "diskOctetsWriteAvg": 1,
                        "diskOctetsWriteLast": 1,
                        "diskOctetsWriteMax": 1,
                        "diskOctetsWriteMin": 1,
                        "diskOpsReadAvg": 1,
                        "diskOpsReadLast": 1,
                        "diskOpsReadMax": 1,
                        "diskOpsReadMin": 1,
                        "diskOpsWriteAvg": 1,
                        "diskOpsWriteLast": 1,
                        "diskOpsWriteMax": 1,
                        "diskOpsWriteMin": 1,
                        "diskPendingOperationsAvg": 1,
                        "diskPendingOperationsLast": 1,
                        "diskPendingOperationsMax": 1,
                        "diskPendingOperationsMin": 1,
                        "diskTimeReadAvg": 1,
                        "diskTimeReadLast": 1,
                        "diskTimeReadMax": 1,
                        "diskTimeReadMin": 1,
                        "diskTimeWriteAvg": 1,
                        "diskTimeWriteLast": 1,
                        "diskTimeWriteMax": 1,
                        "diskTimeWriteMin": 1
                    }
                ],
                "featureUsageArray": [
                    {
                        "featureIdentifier": "somestring",
                        "featureUtilization": 1
                    },
                    {
                        "featureIdentifier": "somestring",
                        "featureUtilization": 1
                    }
                ],
                "filesystemUsageArray": [
                    {
                        "blockConfigured": 1,
                        "blockIops": 1,
                        "blockUsed": 1,
                        "ephemeralConfigured": 1,
                        "ephemeralIops": 1,
                        "ephemeralUsed": 1,
                        "filesystemName": "somestring"
                    },
                    {
                        "blockConfigured": 1,
                        "blockIops": 1,
                        "blockUsed": 1,
                        "ephemeralConfigured": 1,
                        "ephemeralIops": 1,
                        "ephemeralUsed": 1,
                        "filesystemName": "somestring"
                    }
                ],
                "latencyDistribution": [
                    {
                        "countsInTheBucket": 1,
                        "highEndOfLatencyBucket": 1,
                        "lowEndOfLatencyBucket": 1
                    },
                    {
                        "countsInTheBucket": 1,
                        "highEndOfLatencyBucket": 1,
                        "lowEndOfLatencyBucket": 1
                    }
                ],
                "meanRequestLatency": 1,
                "measurementInterval": 1,
                "measurementsForVfScalingVersion": 1,
                "memoryUsageArray": [
                    {
                        "memoryBuffered": 1,
                        "memoryCached": 1,
                        "memoryConfigured": 1,
                        "memoryFree": 1,
                        "memorySlabRecl": 1,
                        "memorySlabUnrecl": 1,
                        "memoryUsed": 1,
                        "vmIdentifier": "somestring"
                    },
                    {
                        "memoryBuffered": 1,
                        "memoryCached": 1,
                        "memoryConfigured": 1,
                        "memoryFree": 1,
                        "memorySlabRecl": 1,
                        "memorySlabUnrecl": 1,
                        "memoryUsed": 1,
                        "vmIdentifier": "somestring"
                    }
                ],
                "numberOfMediaPortsInUse": 1,
                "requestRate": 1,
                "vNicPerformanceArray": [
                    {
                        "receivedBroadcastPacketsAccumulated": 1,
                        "receivedBroadcastPacketsDelta": 1,
                        "receivedDiscardedPacketsAccumulated": 1,
                        "receivedDiscardedPacketsDelta": 1,
                        "receivedErrorPacketsAccumulated": 1,
                        "receivedErrorPacketsDelta": 1,
                        "receivedMulticastPacketsAccumulated": 1,
                        "receivedMulticastPacketsDelta": 1,
                        "receivedOctetsAccumulated": 1,
                        "receivedOctetsDelta": 1,
                        "receivedTotalPacketsAccumulated": 1,
                        "receivedTotalPacketsDelta": 1,
                        "receivedUnicastPacketsAccumulated": 1,
                        "receivedUnicastPacketsDelta": 1,
                        "transmittedBroadcastPacketsAccumulated": 1,
                        "transmittedBroadcastPacketsDelta": 1,
                        "transmittedDiscardedPacketsAccumulated": 1,
                        "transmittedDiscardedPacketsDelta": 1,
                        "transmittedErrorPacketsAccumulated": 1,
                        "transmittedErrorPacketsDelta": 1,
                        "transmittedMulticastPacketsAccumulated": 1,
                        "transmittedMulticastPacketsDelta": 1,
                        "transmittedOctetsAccumulated": 1,
                        "transmittedOctetsDelta": 1,
                        "transmittedTotalPacketsAccumulated": 1,
                        "transmittedTotalPacketsDelta": 1,
                        "transmittedUnicastPacketsAccumulated": 1,
                        "transmittedUnicastPacketsDelta": 1,
                        "vNicIdentifier": "somestring",
                        "valuesAreSuspect": "true"
                    },
                    {
                        "receivedBroadcastPacketsAccumulated": 1,
                        "receivedBroadcastPacketsDelta": 1,
                        "receivedDiscardedPacketsAccumulated": 1,
                        "receivedDiscardedPacketsDelta": 1,
                        "receivedErrorPacketsAccumulated": 1,
                        "receivedErrorPacketsDelta": 1,
                        "receivedMulticastPacketsAccumulated": 1,
                        "receivedMulticastPacketsDelta": 1,
                        "receivedOctetsAccumulated": 1,
                        "receivedOctetsDelta": 1,
                        "receivedTotalPacketsAccumulated": 1,
                        "receivedTotalPacketsDelta": 1,
                        "receivedUnicastPacketsAccumulated": 1,
                        "receivedUnicastPacketsDelta": 1,
                        "transmittedBroadcastPacketsAccumulated": 1,
                        "transmittedBroadcastPacketsDelta": 1,
                        "transmittedDiscardedPacketsAccumulated": 1,
                        "transmittedDiscardedPacketsDelta": 1,
                        "transmittedErrorPacketsAccumulated": 1,
                        "transmittedErrorPacketsDelta": 1,
                        "transmittedMulticastPacketsAccumulated": 1,
                        "transmittedMulticastPacketsDelta": 1,
                        "transmittedOctetsAccumulated": 1,
                        "transmittedOctetsDelta": 1,
                        "transmittedTotalPacketsAccumulated": 1,
                        "transmittedTotalPacketsDelta": 1,
                        "transmittedUnicastPacketsAccumulated": 1,
                        "transmittedUnicastPacketsDelta": 1,
                        "vNicIdentifier": "somestring",
                        "valuesAreSuspect": "true"
                    }
                ],
                "vnfcScalingMetric": 1
            },
            "mobileFlowFields": {
                "additionalFields": [
                    {
                        "name": "somestring",
                        "value": "somestring"
                    },
                    {
                        "name": "somestring",
                        "value": "somestring"
                    }
                ],
                "appProtocolType": "somestring",
                "appProtocolVersion": "somestring",
                "applicationType": "somestring",
                "cid": "somestring",
                "connectionType": "somestring",
                "ecgi": "somestring",
                "flowDirection": "somestring",
                "gtpPerFlowMetrics": {
                    "avgBitErrorRate": 1,
                    "avgPacketDelayVariation": 1,
                    "avgPacketLatency": 1,
                    "avgReceiveThroughput": 1,
                    "avgTransmitThroughput": 1,
                    "durConnectionFailedStatus": 1,
                    "durTunnelFailedStatus": 1,
                    "flowActivatedBy": "somestring",
                    "flowActivationEpoch": 1,
                    "flowActivationMicrosec": 1,
                    "flowActivationTime": "somestring",
                    "flowDeactivatedBy": "somestring",
                    "flowDeactivationEpoch": 1,
                    "flowDeactivationMicrosec": 1,
                    "flowDeactivationTime": "somestring",
                    "flowStatus": "somestring",
                    "gtpConnectionStatus": "somestring",
                    "gtpTunnelStatus": "somestring",
                    "ipTosCountList": [
                        [
                            1,
                            1
                        ],
                        [
                            1,
                            1
                        ]
                    ],
                    "ipTosList": [
                        "somestring",
                        "somestring"
                    ],
                    "largePacketRtt": 1,
                    "largePacketThreshold": 1,
                    "maxPacketDelayVariation": 1,
                    "maxReceiveBitRate": 1,
                    "maxTransmitBitRate": 1,
                    "mobileQciCosCountList": [
                        [
                            1,
                            1
                        ],
                        [
                            1,
                            1
                        ]
                    ],
                    "mobileQciCosList": [
                        "somestring",
                        "somestring"
                    ],
                    "numActivationFailures": 1,
                    "numBitErrors": 1,
                    "numBytesReceived": 1,
                    "numBytesTransmitted": 1,
                    "numDroppedPackets": 1,
                    "numGtpEchoFailures": 1,
                    "numGtpTunnelErrors": 1,
                    "numHttpErrors": 1,
                    "numL7BytesReceived": 1,
                    "numL7BytesTransmitted": 1,
                    "numLostPackets": 1,
                    "numOutOfOrderPackets": 1,
                    "numPacketErrors": 1,
                    "numPacketsReceivedExclRetrans": 1,
                    "numPacketsReceivedInclRetrans": 1,
                    "numPacketsTransmittedInclRetrans": 1,
                    "numRetries": 1,
                    "numTimeouts": 1,
                    "numTunneledL7BytesReceived": 1,
                    "roundTripTime": 1,
                    "tcpFlagCountList": [
                        [
                            1,
                            1
                        ],
                        [
                            1,
                            1
                        ]
                    ],
                    "tcpFlagList": [
                        "somestring",
                        "somestring"
                    ],
                    "timeToFirstByte": 1
                },
                "gtpProtocolType": "somestring",
                "gtpVersion": "somestring",
                "httpHeader": "somestring",
                "imei": "somestring",
                "imsi": "somestring",
                "ipProtocolType": "somestring",
                "ipVersion": "somestring",
                "lac": "somestring",
                "mcc": "somestring",
                "mnc": "somestring",
                "mobileFlowFieldsVersion": 1,
                "msisdn": "somestring",
                "otherEndpointIpAddress": "somestring",
                "otherEndpointPort": 1,
                "otherFunctionalRole": "somestring",
                "rac": "somestring",
                "radioAccessTechnology": "somestring",
                "reportingEndpointIpAddr": "somestring",
                "reportingEndpointPort": 1,
                "sac": "somestring",
                "samplingAlgorithm": 1,
                "tac": "somestring",
                "tunnelId": "somestring",
                "vlanId": "somestring"
            },
            "otherFields": {
                "hashOfNameValuePairArrays": [
                    {
                        "arrayOfFields": [
                            {
                                "name": "somestring",
                                "value": "somestring"
                            },
                            {
                                "name": "somestring",
                                "value": "somestring"
                            }
                        ],
                        "name": "somestring"
                    },
                    {
                        "arrayOfFields": [
                            {
                                "name": "somestring",
                                "value": "somestring"
                            },
                            {
                                "name": "somestring",
                                "value": "somestring"
                            }
                        ],
                        "name": "somestring"
                    }
                ],
                "jsonObjects": [
                    {
                        "nfSubscribedObjectName": "somestring",
                        "nfSubscriptionId": "somestring",
                        "objectInstances": [
                            {
                                "objectInstance": {},
                                "objectInstanceEpochMicrosec": 1,
                                "objectKeys": [
                                    {
                                        "keyName": "somestring",
                                        "keyOrder": 1,
                                        "keyValue": "somestring"
                                    },
                                    {
                                        "keyName": "somestring",
                                        "keyOrder": 1,
                                        "keyValue": "somestring"
                                    }
                                ]
                            },
                            {
                                "objectInstance": {},
                                "objectInstanceEpochMicrosec": 1,
                                "objectKeys": [
                                    {
                                        "keyName": "somestring",
                                        "keyOrder": 1,
                                        "keyValue": "somestring"
                                    },
                                    {
                                        "keyName": "somestring",
                                        "keyOrder": 1,
                                        "keyValue": "somestring"
                                    }
                                ]
                            }
                        ],
                        "objectName": "somestring",
                        "objectSchema": "somestring",
                        "objectSchemaUrl": "somestring"
                    },
                    {
                        "nfSubscribedObjectName": "somestring",
                        "nfSubscriptionId": "somestring",
                        "objectInstances": [
                            {
                                "objectInstance": {},
                                "objectInstanceEpochMicrosec": 1,
                                "objectKeys": [
                                    {
                                        "keyName": "somestring",
                                        "keyOrder": 1,
                                        "keyValue": "somestring"
                                    },
                                    {
                                        "keyName": "somestring",
                                        "keyOrder": 1,
                                        "keyValue": "somestring"
                                    }
                                ]
                            },
                            {
                                "objectInstance": {},
                                "objectInstanceEpochMicrosec": 1,
                                "objectKeys": [
                                    {
                                        "keyName": "somestring",
                                        "keyOrder": 1,
                                        "keyValue": "somestring"
                                    },
                                    {
                                        "keyName": "somestring",
                                        "keyOrder": 1,
                                        "keyValue": "somestring"
                                    }
                                ]
                            }
                        ],
                        "objectName": "somestring",
                        "objectSchema": "somestring",
                        "objectSchemaUrl": "somestring"
                    }
                ],
                "nameValuePairs": [
                    {
                        "name": "somestring",
                        "value": "somestring"
                    },
                    {
                        "name": "somestring",
                        "value": "somestring"
                    }
                ],
                "otherFieldsVersion": 1
            },
            "sipSignalingFields": {
                "additionalInformation": [
                    {
                        "name": "somestring",
                        "value": "somestring"
                    },
                    {
                        "name": "somestring",
                        "value": "somestring"
                    }
                ],
                "compressedSip": "somestring",
                "correlator": "somestring",
                "localIpAddress": "somestring",
                "localPort": "somestring",
                "remoteIpAddress": "somestring",
                "remotePort": "somestring",
                "sipSignalingFieldsVersion": 1,
                "summarySip": "somestring",
                "vendorVnfNameFields": {
                    "vendorName": "somestring",
                    "vfModuleName": "somestring",
                    "vnfName": "somestring"
                }
            },
            "stateChangeFields": {
                "additionalFields": [
                    {
                        "name": "somestring",
                        "value": "somestring"
                    },
                    {
                        "name": "somestring",
                        "value": "somestring"
                    }
                ],
                "newState": "inService",
                "oldState": "inService",
                "stateChangeFieldsVersion": 1,
                "stateInterface": "somestring"
            },
            "syslogFields": {
                "additionalFields": "somestring",
                "eventSourceHost": "somestring",
                "eventSourceType": "somestring",
                "syslogFacility": 1,
                "syslogFieldsVersion": 1,
                "syslogMsg": "somestring",
                "syslogPri": 1,
                "syslogProc": "somestring",
                "syslogProcId": 1,
                "syslogSData": "somestring",
                "syslogSdId": "somestring",
                "syslogSev": "Alert",
                "syslogTag": "somestring",
                "syslogVer": 1
            },
            "thresholdCrossingAlertFields": {
                "additionalFields": [
                    {
                        "name": "somestring",
                        "value": "somestring"
                    },
                    {
                        "name": "somestring",
                        "value": "somestring"
                    }
                ],
                "additionalParameters": [
                    {
                        "criticality": "CRIT",
                        "name": "somestring",
                        "thresholdCrossed": "somestring",
                        "value": "somestring"
                    },
                    {
                        "criticality": "CRIT",
                        "name": "somestring",
                        "thresholdCrossed": "somestring",
                        "value": "somestring"
                    }
                ],
                "alertAction": "CLEAR",
                "alertDescription": "somestring",
                "alertType": "CARD-ANOMALY",
                "alertValue": "somestring",
                "associatedAlertIdList": [
                    "somestring",
                    "somestring"
                ],
                "collectionTimestamp": "somestring",
                "dataCollector": "somestring",
                "elementType": "somestring",
                "eventSeverity": "CRITICAL",
                "eventStartTimestamp": "somestring",
                "interfaceName": "somestring",
                "networkService": "somestring",
                "possibleRootCause": "somestring",
                "thresholdCrossingFieldsVersion": 1
            },
            "voiceQualityFields": {
                "additionalInformation": [
                    {
                        "name": "somestring",
                        "value": "somestring"
                    },
                    {
                        "name": "somestring",
                        "value": "somestring"
                    }
                ],
                "calleeSideCodec": "somestring",
                "callerSideCodec": "somestring",
                "correlator": "somestring",
                "endOfCallVqmSummaries": {
                    "adjacencyName": "somestring",
                    "endpointDescription": "Caller",
                    "endpointJitter": 1,
                    "endpointRtpOctetsDiscarded": 1,
                    "endpointRtpOctetsReceived": 1,
                    "endpointRtpOctetsSent": 1,
                    "endpointRtpPacketsDiscarded": 1,
                    "endpointRtpPacketsReceived": 1,
                    "endpointRtpPacketsSent": 1,
                    "localJitter": 1,
                    "localRtpOctetsDiscarded": 1,
                    "localRtpOctetsReceived": 1,
                    "localRtpOctetsSent": 1,
                    "localRtpPacketsDiscarded": 1,
                    "localRtpPacketsReceived": 1,
                    "localRtpPacketsSent": 1,
                    "mosCqe": 1,
                    "packetLossPercent": 1,
                    "packetsLost": 1,
                    "rFactor": 1,
                    "roundTripDelay": 1
                },
                "midCallRtcp": "somestring",
                "phoneNumber": "somestring",
                "vendorVnfNameFields": {
                    "vendorName": "somestring",
                    "vfModuleName": "somestring",
                    "vnfName": "somestring"
                },
                "voiceQualityFieldsVersion": 1
            }
        }
    }

Responses
+++++++++

**200**
^^^^^^^

VES Event Accepted.


Type: :ref:`ApiResponseMessage <d_8a94f348f7df00259702f8d9b7d2ea84>`

**Example:**

.. code-block:: javascript

    {
        "code": 1,
        "message": "somestring",
        "type": "somestring"
    }

**400**
^^^^^^^

Bad request provided


Type: :ref:`ApiResponseMessage <d_8a94f348f7df00259702f8d9b7d2ea84>`

**Example:**

.. code-block:: javascript

    {
        "code": 1,
        "message": "somestring",
        "type": "somestring"
    }

**401**
^^^^^^^

Unauthorized request


Type: :ref:`ApiResponseMessage <d_8a94f348f7df00259702f8d9b7d2ea84>`

**Example:**

.. code-block:: javascript

    {
        "code": 1,
        "message": "somestring",
        "type": "somestring"
    }

**503**
^^^^^^^

Service Unavailable


Type: :ref:`ApiResponseMessage <d_8a94f348f7df00259702f8d9b7d2ea84>`

**Example:**

.. code-block:: javascript

    {
        "code": 1,
        "message": "somestring",
        "type": "somestring"
    }



Security
++++++++

.. csv-table::
    :header: "Security Schema", "Scopes"
    :widths: 15, 45

        :ref:`basicAuth <securities_basicAuth>`, ""
  
Data Structures
~~~~~~~~~~~~~~~


ApiResponseMessage Model Structure
----------------------------------

.. csv-table::
    :delim: |
    :header: "Name", "Required", "Type", "Format", "Properties", "Description"
    :widths: 20, 10, 15, 15, 30, 25

        code | No | integer | int32 |  | 
        message | No | string |  |  | 
        type | No | string |  |  | 


VES5Request Model Structure
---------------------------

.. csv-table::
    :delim: |
    :header: "Name", "Required", "Type", "Format", "Properties", "Description"
    :widths: 20, 10, 15, 15, 30, 25

        event | No | :ref:`event <d_0eeffb3cd3e31135c2f3cf8ee4a2bdbb>` |  |  | 

.. _d_df249c51a416f54e5609f2ffffe059c0:

codecsInUse Model Structure
---------------------------

number of times an identified codec was used over the measurementInterval

.. csv-table::
    :delim: |
    :header: "Name", "Required", "Type", "Format", "Properties", "Description"
    :widths: 20, 10, 15, 15, 30, 25

        codecIdentifier | Yes | string |  |  | 
        numberInUse | Yes | integer |  |  | 

.. _d_a68e1b21fdcef792db73f711201c56ad:

command Model Structure
-----------------------

command from an event collector toward an event source

.. csv-table::
    :delim: |
    :header: "Name", "Required", "Type", "Format", "Properties", "Description"
    :widths: 20, 10, 15, 15, 30, 25

        commandType | Yes | string |  | {'enum': ['heartbeatIntervalChange', 'measurementIntervalChange', 'provideThrottlingState', 'throttlingSpecification']} | 
        eventDomainThrottleSpecification | No | :ref:`eventDomainThrottleSpecification <d_4089a4a9ee684770c6f37a588a577589>` |  |  | 
        heartbeatInterval | No | integer |  |  | 
        measurementInterval | No | integer |  |  | 

.. _d_2dc9a27be1410f60241c5f63c636bb7e:

commonEventHeader Model Structure
---------------------------------

fields common to all events

.. csv-table::
    :delim: |
    :header: "Name", "Required", "Type", "Format", "Properties", "Description"
    :widths: 20, 10, 15, 15, 30, 25

        domain | Yes | string |  | {'enum': ['fault', 'heartbeat', 'measurementsForVfScaling', 'mobileFlow', 'other', 'sipSignaling', 'stateChange', 'syslog', 'thresholdCrossingAlert', 'voiceQuality']} | the eventing domain associated with the event
        eventId | Yes | string |  |  | event key that is unique to the event source
        eventName | Yes | string |  |  | unique event name
        eventType | No | string |  |  | for example - applicationVnf, guestOS, hostOS, platform
        internalHeaderFields | No | :ref:`internalHeaderFields <d_2873d30f54c59ef635c1fc0cbbaa89f1>` |  |  | 
        lastEpochMicrosec | Yes | number |  |  | the latest unix time aka epoch time associated with the event from any component--as microseconds elapsed since 1 Jan 1970 not including leap seconds
        nfNamingCode | No | string |  |  | 4 character network function type, aligned with vnf naming standards
        nfcNamingCode | No | string |  |  | 3 character network function component type, aligned with vfc naming standards
        priority | Yes | string |  | {'enum': ['High', 'Medium', 'Normal', 'Low']} | processing priority
        reportingEntityId | No | string |  |  | UUID identifying the entity reporting the event, for example an OAM VM; must be populated by the ATT enrichment process
        reportingEntityName | Yes | string |  |  | name of the entity reporting the event, for example, an EMS name; may be the same as sourceName
        sequence | Yes | integer |  |  | ordering of events communicated by an event source instance or 0 if not needed
        sourceId | No | string |  |  | UUID identifying the entity experiencing the event issue; must be populated by the ATT enrichment process
        sourceName | Yes | string |  |  | name of the entity experiencing the event issue
        startEpochMicrosec | Yes | number |  |  | the earliest unix time aka epoch time associated with the event from any component--as microseconds elapsed since 1 Jan 1970 not including leap seconds
        version | Yes | number |  |  | version of the event header

.. _d_6e043350cba5faafe21de49c2f6fd745:

counter Model Structure
-----------------------

performance counter

.. csv-table::
    :delim: |
    :header: "Name", "Required", "Type", "Format", "Properties", "Description"
    :widths: 20, 10, 15, 15, 30, 25

        criticality | Yes | string |  | {'enum': ['CRIT', 'MAJ']} | 
        name | Yes | string |  |  | 
        thresholdCrossed | Yes | string |  |  | 
        value | Yes | string |  |  | 

.. _d_6f081937f31c09078c8acf9212d6c449:

cpuUsage Model Structure
------------------------

usage of an identified CPU

.. csv-table::
    :delim: |
    :header: "Name", "Required", "Type", "Format", "Properties", "Description"
    :widths: 20, 10, 15, 15, 30, 25

        cpuIdentifier | Yes | string |  |  | cpu identifer
        cpuIdle | No | number |  |  | percentage of CPU time spent in the idle task
        cpuUsageInterrupt | No | number |  |  | percentage of time spent servicing interrupts
        cpuUsageNice | No | number |  |  | percentage of time spent running user space processes that have been niced
        cpuUsageSoftIrq | No | number |  |  | percentage of time spent handling soft irq interrupts
        cpuUsageSteal | No | number |  |  | percentage of time spent in involuntary wait which is neither user, system or idle time and is effectively time that went missing
        cpuUsageSystem | No | number |  |  | percentage of time spent on system tasks running the kernel
        cpuUsageUser | No | number |  |  | percentage of time spent running un-niced user space processes
        cpuWait | No | number |  |  | percentage of CPU time spent waiting for I/O operations to complete
        percentUsage | Yes | number |  |  | aggregate cpu usage of the virtual machine on which the VNFC reporting the event is running

.. _d_bb7a69764c21219953df76826934938e:

diskUsage Model Structure
-------------------------

usage of an identified disk

.. csv-table::
    :delim: |
    :header: "Name", "Required", "Type", "Format", "Properties", "Description"
    :widths: 20, 10, 15, 15, 30, 25

        diskIdentifier | Yes | string |  |  | disk identifier
        diskIoTimeAvg | No | number |  |  | milliseconds spent doing input/output operations over 1 sec; treat this metric as a device load percentage where 1000ms  matches 100% load; provide the average over the measurement interval
        diskIoTimeLast | No | number |  |  | milliseconds spent doing input/output operations over 1 sec; treat this metric as a device load percentage where 1000ms  matches 100% load; provide the last value measurement within the measurement interval
        diskIoTimeMax | No | number |  |  | milliseconds spent doing input/output operations over 1 sec; treat this metric as a device load percentage where 1000ms  matches 100% load; provide the maximum value measurement within the measurement interval
        diskIoTimeMin | No | number |  |  | milliseconds spent doing input/output operations over 1 sec; treat this metric as a device load percentage where 1000ms  matches 100% load; provide the minimum value measurement within the measurement interval
        diskMergedReadAvg | No | number |  |  | number of logical read operations that were merged into physical read operations, e.g., two logical reads were served by one physical disk access; provide the average measurement within the measurement interval
        diskMergedReadLast | No | number |  |  | number of logical read operations that were merged into physical read operations, e.g., two logical reads were served by one physical disk access; provide the last value measurement within the measurement interval
        diskMergedReadMax | No | number |  |  | number of logical read operations that were merged into physical read operations, e.g., two logical reads were served by one physical disk access; provide the maximum value measurement within the measurement interval
        diskMergedReadMin | No | number |  |  | number of logical read operations that were merged into physical read operations, e.g., two logical reads were served by one physical disk access; provide the minimum value measurement within the measurement interval
        diskMergedWriteAvg | No | number |  |  | number of logical write operations that were merged into physical write operations, e.g., two logical writes were served by one physical disk access; provide the average measurement within the measurement interval
        diskMergedWriteLast | No | number |  |  | number of logical write operations that were merged into physical write operations, e.g., two logical writes were served by one physical disk access; provide the last value measurement within the measurement interval
        diskMergedWriteMax | No | number |  |  | number of logical write operations that were merged into physical write operations, e.g., two logical writes were served by one physical disk access; provide the maximum value measurement within the measurement interval
        diskMergedWriteMin | No | number |  |  | number of logical write operations that were merged into physical write operations, e.g., two logical writes were served by one physical disk access; provide the minimum value measurement within the measurement interval
        diskOctetsReadAvg | No | number |  |  | number of octets per second read from a disk or partition; provide the average measurement within the measurement interval
        diskOctetsReadLast | No | number |  |  | number of octets per second read from a disk or partition; provide the last measurement within the measurement interval
        diskOctetsReadMax | No | number |  |  | number of octets per second read from a disk or partition; provide the maximum measurement within the measurement interval
        diskOctetsReadMin | No | number |  |  | number of octets per second read from a disk or partition; provide the minimum measurement within the measurement interval
        diskOctetsWriteAvg | No | number |  |  | number of octets per second written to a disk or partition; provide the average measurement within the measurement interval
        diskOctetsWriteLast | No | number |  |  | number of octets per second written to a disk or partition; provide the last measurement within the measurement interval
        diskOctetsWriteMax | No | number |  |  | number of octets per second written to a disk or partition; provide the maximum measurement within the measurement interval
        diskOctetsWriteMin | No | number |  |  | number of octets per second written to a disk or partition; provide the minimum measurement within the measurement interval
        diskOpsReadAvg | No | number |  |  | number of read operations per second issued to the disk; provide the average measurement within the measurement interval
        diskOpsReadLast | No | number |  |  | number of read operations per second issued to the disk; provide the last measurement within the measurement interval
        diskOpsReadMax | No | number |  |  | number of read operations per second issued to the disk; provide the maximum measurement within the measurement interval
        diskOpsReadMin | No | number |  |  | number of read operations per second issued to the disk; provide the minimum measurement within the measurement interval
        diskOpsWriteAvg | No | number |  |  | number of write operations per second issued to the disk; provide the average measurement within the measurement interval
        diskOpsWriteLast | No | number |  |  | number of write operations per second issued to the disk; provide the last measurement within the measurement interval
        diskOpsWriteMax | No | number |  |  | number of write operations per second issued to the disk; provide the maximum measurement within the measurement interval
        diskOpsWriteMin | No | number |  |  | number of write operations per second issued to the disk; provide the minimum measurement within the measurement interval
        diskPendingOperationsAvg | No | number |  |  | queue size of pending I/O operations per second; provide the average measurement within the measurement interval
        diskPendingOperationsLast | No | number |  |  | queue size of pending I/O operations per second; provide the last measurement within the measurement interval
        diskPendingOperationsMax | No | number |  |  | queue size of pending I/O operations per second; provide the maximum measurement within the measurement interval
        diskPendingOperationsMin | No | number |  |  | queue size of pending I/O operations per second; provide the minimum measurement within the measurement interval
        diskTimeReadAvg | No | number |  |  | milliseconds a read operation took to complete; provide the average measurement within the measurement interval
        diskTimeReadLast | No | number |  |  | milliseconds a read operation took to complete; provide the last measurement within the measurement interval
        diskTimeReadMax | No | number |  |  | milliseconds a read operation took to complete; provide the maximum measurement within the measurement interval
        diskTimeReadMin | No | number |  |  | milliseconds a read operation took to complete; provide the minimum measurement within the measurement interval
        diskTimeWriteAvg | No | number |  |  | milliseconds a write operation took to complete; provide the average measurement within the measurement interval
        diskTimeWriteLast | No | number |  |  | milliseconds a write operation took to complete; provide the last measurement within the measurement interval
        diskTimeWriteMax | No | number |  |  | milliseconds a write operation took to complete; provide the maximum measurement within the measurement interval
        diskTimeWriteMin | No | number |  |  | milliseconds a write operation took to complete; provide the minimum measurement within the measurement interval

.. _d_c911a0a8abdb511d7cd6590f383d817b:

endOfCallVqmSummaries Model Structure
-------------------------------------

provides end of call voice quality metrics

.. csv-table::
    :delim: |
    :header: "Name", "Required", "Type", "Format", "Properties", "Description"
    :widths: 20, 10, 15, 15, 30, 25

        adjacencyName | Yes | string |  |  |  adjacency name
        endpointDescription | Yes | string |  | {'enum': ['Caller', 'Callee']} | Either Caller or Callee
        endpointJitter | No | number |  |  | 
        endpointRtpOctetsDiscarded | No | number |  |  | 
        endpointRtpOctetsReceived | No | number |  |  | 
        endpointRtpOctetsSent | No | number |  |  | 
        endpointRtpPacketsDiscarded | No | number |  |  | 
        endpointRtpPacketsReceived | No | number |  |  | 
        endpointRtpPacketsSent | No | number |  |  | 
        localJitter | No | number |  |  | 
        localRtpOctetsDiscarded | No | number |  |  | 
        localRtpOctetsReceived | No | number |  |  | 
        localRtpOctetsSent | No | number |  |  | 
        localRtpPacketsDiscarded | No | number |  |  | 
        localRtpPacketsReceived | No | number |  |  | 
        localRtpPacketsSent | No | number |  |  | 
        mosCqe | No | number |  |  | 1-5 1dp
        packetLossPercent | No | number |  |  | Calculated percentage packet loss based on Endpoint RTP packets lost (as reported in RTCP) and Local RTP packets sent. Direction is based on Endpoint description (Caller, Callee). Decimal (2 dp)
        packetsLost | No | number |  |  | 
        rFactor | No | number |  |  | 0-100
        roundTripDelay | No | number |  |  | millisecs

.. _d_0eeffb3cd3e31135c2f3cf8ee4a2bdbb:

event Model Structure
---------------------

the root level of the common event format

.. csv-table::
    :delim: |
    :header: "Name", "Required", "Type", "Format", "Properties", "Description"
    :widths: 20, 10, 15, 15, 30, 25

        commonEventHeader | Yes | :ref:`commonEventHeader <d_2dc9a27be1410f60241c5f63c636bb7e>` |  |  | 
        faultFields | No | :ref:`faultFields <d_e7aa5254472f7823fdd6d5a090bfd0a4>` |  |  | 
        heartbeatFields | No | :ref:`heartbeatFields <d_6ea626e11ce7887cddd39c36ff4f0926>` |  |  | 
        measurementsForVfScalingFields | No | :ref:`measurementsForVfScalingFields <d_669cf98e276c9992abd27056c432bbb2>` |  |  | 
        mobileFlowFields | No | :ref:`mobileFlowFields <d_dc18fe1d28fe3ef664c3f4ab777d8424>` |  |  | 
        otherFields | No | :ref:`otherFields <d_5a79cd7ce784d60fd832d9c7c0a24322>` |  |  | 
        sipSignalingFields | No | :ref:`sipSignalingFields <d_c3e191f0b26ddd68f927ac0c8b551c5e>` |  |  | 
        stateChangeFields | No | :ref:`stateChangeFields <d_c5450f1a263d0a2b0c64c96119f7d759>` |  |  | 
        syslogFields | No | :ref:`syslogFields <d_782271970af04a3b0e5a5da9b30996d2>` |  |  | 
        thresholdCrossingAlertFields | No | :ref:`thresholdCrossingAlertFields <d_bd95ac8a5536a5bb5e6a0de7e64b9f20>` |  |  | 
        voiceQualityFields | No | :ref:`voiceQualityFields <d_9551641bd1c775d9fcf4e45353de8e43>` |  |  | 

.. _d_4089a4a9ee684770c6f37a588a577589:

eventDomainThrottleSpecification Model Structure
------------------------------------------------

specification of what information to suppress within an event domain

.. csv-table::
    :delim: |
    :header: "Name", "Required", "Type", "Format", "Properties", "Description"
    :widths: 20, 10, 15, 15, 30, 25

        eventDomain | Yes | string |  |  | Event domain enum from the commonEventHeader domain field
        suppressedFieldNames | No | array of string |  |  | List of optional field names in the event block that should not be sent to the Event Listener
        suppressedNvPairsList | No | array of :ref:`suppressedNvPairs <d_52877eda2d273b282063857f97fa7ff4>` |  |  | Optional list of specific NvPairsNames to suppress within a given Name-Value Field

.. _d_e7aa5254472f7823fdd6d5a090bfd0a4:

faultFields Model Structure
---------------------------

fields specific to fault events

.. csv-table::
    :delim: |
    :header: "Name", "Required", "Type", "Format", "Properties", "Description"
    :widths: 20, 10, 15, 15, 30, 25

        alarmAdditionalInformation | No | array of :ref:`field <d_a9799335edbbc52c7f0c5191f7bd09ee>` |  |  | additional alarm information
        alarmCondition | Yes | string |  |  | alarm condition reported by the device
        alarmInterfaceA | No | string |  |  | card, port, channel or interface name of the device generating the alarm
        eventCategory | No | string |  |  | Event category, for example: license, link, routing, security, signaling
        eventSeverity | Yes | string |  | {'enum': ['CRITICAL', 'MAJOR', 'MINOR', 'WARNING', 'NORMAL']} | event severity
        eventSourceType | Yes | string |  |  | type of event source; examples: card, host, other, port, portThreshold, router, slotThreshold, switch, virtualMachine, virtualNetworkFunction
        faultFieldsVersion | Yes | number |  |  | version of the faultFields block
        specificProblem | Yes | string |  |  | short description of the alarm or problem
        vfStatus | Yes | string |  | {'enum': ['Active', 'Idle', 'Preparing to terminate', 'Ready to terminate', 'Requesting termination']} | virtual function status enumeration

.. _d_76d7f35861442236cee9f716ea1e1540:

featuresInUse Model Structure
-----------------------------

number of times an identified feature was used over the measurementInterval

.. csv-table::
    :delim: |
    :header: "Name", "Required", "Type", "Format", "Properties", "Description"
    :widths: 20, 10, 15, 15, 30, 25

        featureIdentifier | Yes | string |  |  | 
        featureUtilization | Yes | integer |  |  | 

.. _d_a9799335edbbc52c7f0c5191f7bd09ee:

field Model Structure
---------------------

name value pair

.. csv-table::
    :delim: |
    :header: "Name", "Required", "Type", "Format", "Properties", "Description"
    :widths: 20, 10, 15, 15, 30, 25

        name | Yes | string |  |  | 
        value | Yes | string |  |  | 

.. _d_18e1fa5fd6774deefce826b075f8b6e7:

filesystemUsage Model Structure
-------------------------------

disk usage of an identified virtual machine in gigabytes and/or gigabytes per second

.. csv-table::
    :delim: |
    :header: "Name", "Required", "Type", "Format", "Properties", "Description"
    :widths: 20, 10, 15, 15, 30, 25

        blockConfigured | Yes | number |  |  | 
        blockIops | Yes | number |  |  | 
        blockUsed | Yes | number |  |  | 
        ephemeralConfigured | Yes | number |  |  | 
        ephemeralIops | Yes | number |  |  | 
        ephemeralUsed | Yes | number |  |  | 
        filesystemName | Yes | string |  |  | 

.. _d_bb1527d221e848e0896c78552979238b:

gtpPerFlowMetrics Model Structure
---------------------------------

Mobility GTP Protocol per flow metrics

.. csv-table::
    :delim: |
    :header: "Name", "Required", "Type", "Format", "Properties", "Description"
    :widths: 20, 10, 15, 15, 30, 25

        avgBitErrorRate | Yes | number |  |  | average bit error rate
        avgPacketDelayVariation | Yes | number |  |  | Average packet delay variation or jitter in milliseconds for received packets: Average difference between the packet timestamp and time received for all pairs of consecutive packets
        avgPacketLatency | Yes | number |  |  | average delivery latency
        avgReceiveThroughput | Yes | number |  |  | average receive throughput
        avgTransmitThroughput | Yes | number |  |  | average transmit throughput
        durConnectionFailedStatus | No | number |  |  | duration of failed state in milliseconds, computed as the cumulative time between a failed echo request and the next following successful error request, over this reporting interval
        durTunnelFailedStatus | No | number |  |  | Duration of errored state, computed as the cumulative time between a tunnel error indicator and the next following non-errored indicator, over this reporting interval
        flowActivatedBy | No | string |  |  | Endpoint activating the flow
        flowActivationEpoch | Yes | number |  |  | Time the connection is activated in the flow (connection) being reported on, or transmission time of the first packet if activation time is not available
        flowActivationMicrosec | Yes | number |  |  | Integer microseconds for the start of the flow connection
        flowActivationTime | No | string |  |  | time the connection is activated in the flow being reported on, or transmission time of the first packet if activation time is not available; with RFC 2822 compliant format: Sat, 13 Mar 2010 11:29:05 -0800
        flowDeactivatedBy | No | string |  |  | Endpoint deactivating the flow
        flowDeactivationEpoch | Yes | number |  |  | Time for the start of the flow connection, in integer UTC epoch time aka UNIX time
        flowDeactivationMicrosec | Yes | number |  |  | Integer microseconds for the start of the flow connection
        flowDeactivationTime | Yes | string |  |  | Transmission time of the first packet in the flow connection being reported on; with RFC 2822 compliant format: Sat, 13 Mar 2010 11:29:05 -0800
        flowStatus | Yes | string |  |  | connection status at reporting time as a working / inactive / failed indicator value
        gtpConnectionStatus | No | string |  |  | Current connection state at reporting time
        gtpTunnelStatus | No | string |  |  | Current tunnel state  at reporting time
        ipTosCountList | No | array of array of number |  |  | array of key: value pairs where the keys are drawn from the IP Type-of-Service identifiers which range from '0' to '255', and the values are the count of packets that had those ToS identifiers in the flow
        ipTosList | No | array of string |  |  | Array of unique IP Type-of-Service values observed in the flow where values range from '0' to '255'
        largePacketRtt | No | number |  |  | large packet round trip time
        largePacketThreshold | No | number |  |  | large packet threshold being applied
        maxPacketDelayVariation | Yes | number |  |  | Maximum packet delay variation or jitter in milliseconds for received packets: Maximum of the difference between the packet timestamp and time received for all pairs of consecutive packets
        maxReceiveBitRate | No | number |  |  | maximum receive bit rate
        maxTransmitBitRate | No | number |  |  | maximum transmit bit rate
        mobileQciCosCountList | No | array of array of number |  |  | array of key: value pairs where the keys are drawn from LTE QCI or UMTS class of service strings, and the values are the count of packets that had those strings in the flow
        mobileQciCosList | No | array of string |  |  | Array of unique LTE QCI or UMTS class-of-service values observed in the flow
        numActivationFailures | Yes | number |  |  | Number of failed activation requests, as observed by the reporting node
        numBitErrors | Yes | number |  |  | number of errored bits
        numBytesReceived | Yes | number |  |  | number of bytes received, including retransmissions
        numBytesTransmitted | Yes | number |  |  | number of bytes transmitted, including retransmissions
        numDroppedPackets | Yes | number |  |  | number of received packets dropped due to errors per virtual interface
        numGtpEchoFailures | No | number |  |  | Number of Echo request path failures where failed paths are defined in 3GPP TS 29.281 sec 7.2.1 and 3GPP TS 29.060 sec. 11.2
        numGtpTunnelErrors | No | number |  |  | Number of tunnel error indications where errors are defined in 3GPP TS 29.281 sec 7.3.1 and 3GPP TS 29.060 sec. 11.1
        numHttpErrors | No | number |  |  | Http error count
        numL7BytesReceived | Yes | number |  |  | number of tunneled layer 7 bytes received, including retransmissions
        numL7BytesTransmitted | Yes | number |  |  | number of tunneled layer 7 bytes transmitted, excluding retransmissions
        numLostPackets | Yes | number |  |  | number of lost packets
        numOutOfOrderPackets | Yes | number |  |  | number of out-of-order packets
        numPacketErrors | Yes | number |  |  | number of errored packets
        numPacketsReceivedExclRetrans | Yes | number |  |  | number of packets received, excluding retransmission
        numPacketsReceivedInclRetrans | Yes | number |  |  | number of packets received, including retransmission
        numPacketsTransmittedInclRetrans | Yes | number |  |  | number of packets transmitted, including retransmissions
        numRetries | Yes | number |  |  | number of packet retries
        numTimeouts | Yes | number |  |  | number of packet timeouts
        numTunneledL7BytesReceived | Yes | number |  |  | number of tunneled layer 7 bytes received, excluding retransmissions
        roundTripTime | Yes | number |  |  | round trip time
        tcpFlagCountList | No | array of array of number |  |  | array of key: value pairs where the keys are drawn from TCP Flags and the values are the count of packets that had that TCP Flag in the flow
        tcpFlagList | No | array of string |  |  | Array of unique TCP Flags observed in the flow
        timeToFirstByte | Yes | number |  |  | Time in milliseconds between the connection activation and first byte received

.. _d_6ea626e11ce7887cddd39c36ff4f0926:

heartbeatFields Model Structure
-------------------------------

optional field block for fields specific to heartbeat events

.. csv-table::
    :delim: |
    :header: "Name", "Required", "Type", "Format", "Properties", "Description"
    :widths: 20, 10, 15, 15, 30, 25

        additionalFields | No | array of :ref:`field <d_a9799335edbbc52c7f0c5191f7bd09ee>` |  |  | additional heartbeat fields if needed
        heartbeatFieldsVersion | Yes | number |  |  | version of the heartbeatFields block
        heartbeatInterval | Yes | integer |  |  | current heartbeat interval in seconds

.. _d_2873d30f54c59ef635c1fc0cbbaa89f1:

internalHeaderFields Model Structure
------------------------------------

enrichment fields for internal VES Event Listener service use only, not supplied by event sources



.. _d_d8868aee802ae8e2b1e7ea1c4ecc1f54:

jsonObject Model Structure
--------------------------

json object schema, name and other meta-information along with one or more object instances

.. csv-table::
    :delim: |
    :header: "Name", "Required", "Type", "Format", "Properties", "Description"
    :widths: 20, 10, 15, 15, 30, 25

        nfSubscribedObjectName | No | string |  |  | name of the object associated with the nfSubscriptonId
        nfSubscriptionId | No | string |  |  | identifies an openConfig telemetry subscription on a network function, which configures the network function to send complex object data associated with the jsonObject
        objectInstances | Yes | array of :ref:`jsonObjectInstance <d_7bccbee07bd3044bd0b929cb6b567c03>` |  |  | one or more instances of the jsonObject
        objectName | Yes | string |  |  | name of the JSON Object
        objectSchema | No | string |  |  | json schema for the object
        objectSchemaUrl | No | string |  |  | Url to the json schema for the object

.. _d_7bccbee07bd3044bd0b929cb6b567c03:

jsonObjectInstance Model Structure
----------------------------------

meta-information about an instance of a jsonObject along with the actual object instance

.. csv-table::
    :delim: |
    :header: "Name", "Required", "Type", "Format", "Properties", "Description"
    :widths: 20, 10, 15, 15, 30, 25

        objectInstance | Yes | :ref:`objectInstance <i_4cf8290bf745cd386f0a55ec865aafd5>` |  |  | an instance conforming to the jsonObject schema
        objectInstanceEpochMicrosec | No | number |  |  | the unix time aka epoch time associated with this objectInstance--as microseconds elapsed since 1 Jan 1970 not including leap seconds
        objectKeys | No | array of :ref:`key <d_a217491e9c44487ec7bbd9ce3ac9dddb>` |  |  | an ordered set of keys that identifies this particular instance of jsonObject

.. _i_4cf8290bf745cd386f0a55ec865aafd5:

**Objectinstance schema:**


an instance conforming to the jsonObject schema



.. _d_a217491e9c44487ec7bbd9ce3ac9dddb:

key Model Structure
-------------------

tuple which provides the name of a key along with its value and relative order

.. csv-table::
    :delim: |
    :header: "Name", "Required", "Type", "Format", "Properties", "Description"
    :widths: 20, 10, 15, 15, 30, 25

        keyName | Yes | string |  |  | name of the key
        keyOrder | No | integer |  |  | relative sequence or order of the key with respect to other keys
        keyValue | No | string |  |  | value of the key

.. _d_dc21244021b6cb0e0af16166e4600d99:

latencyBucketMeasure Model Structure
------------------------------------

number of counts falling within a defined latency bucket

.. csv-table::
    :delim: |
    :header: "Name", "Required", "Type", "Format", "Properties", "Description"
    :widths: 20, 10, 15, 15, 30, 25

        countsInTheBucket | Yes | number |  |  | 
        highEndOfLatencyBucket | No | number |  |  | 
        lowEndOfLatencyBucket | No | number |  |  | 

.. _d_669cf98e276c9992abd27056c432bbb2:

measurementsForVfScalingFields Model Structure
----------------------------------------------

measurementsForVfScaling fields

.. csv-table::
    :delim: |
    :header: "Name", "Required", "Type", "Format", "Properties", "Description"
    :widths: 20, 10, 15, 15, 30, 25

        additionalFields | No | array of :ref:`field <d_a9799335edbbc52c7f0c5191f7bd09ee>` |  |  | additional name-value-pair fields
        additionalMeasurements | No | array of :ref:`namedArrayOfFields <d_38de3331d60414da3eea18e8f7e0ecf9>` |  |  | array of named name-value-pair arrays
        additionalObjects | No | array of :ref:`jsonObject <d_d8868aee802ae8e2b1e7ea1c4ecc1f54>` |  |  | array of JSON objects described by name, schema and other meta-information
        codecUsageArray | No | array of :ref:`codecsInUse <d_df249c51a416f54e5609f2ffffe059c0>` |  |  | array of codecs in use
        concurrentSessions | No | integer |  |  | peak concurrent sessions for the VM or VNF over the measurementInterval
        configuredEntities | No | integer |  |  | over the measurementInterval, peak total number of: users, subscribers, devices, adjacencies, etc., for the VM, or subscribers, devices, etc., for the VNF
        cpuUsageArray | No | array of :ref:`cpuUsage <d_6f081937f31c09078c8acf9212d6c449>` |  |  | usage of an array of CPUs
        diskUsageArray | No | array of :ref:`diskUsage <d_bb7a69764c21219953df76826934938e>` |  |  | usage of an array of disks
        featureUsageArray | No | array of :ref:`featuresInUse <d_76d7f35861442236cee9f716ea1e1540>` |  |  | array of features in use
        filesystemUsageArray | No | array of :ref:`filesystemUsage <d_18e1fa5fd6774deefce826b075f8b6e7>` |  |  | filesystem usage of the VM on which the VNFC reporting the event is running
        latencyDistribution | No | array of :ref:`latencyBucketMeasure <d_dc21244021b6cb0e0af16166e4600d99>` |  |  | array of integers representing counts of requests whose latency in milliseconds falls within per-VNF configured ranges
        meanRequestLatency | No | number |  |  | mean seconds required to respond to each request for the VM on which the VNFC reporting the event is running
        measurementInterval | Yes | number |  |  | interval over which measurements are being reported in seconds
        measurementsForVfScalingVersion | Yes | number |  |  | version of the measurementsForVfScaling block
        memoryUsageArray | No | array of :ref:`memoryUsage <d_7a758ee807f435a8ba5568e6da6ed597>` |  |  | memory usage of an array of VMs
        numberOfMediaPortsInUse | No | integer |  |  | number of media ports in use
        requestRate | No | number |  |  | peak rate of service requests per second to the VNF over the measurementInterval
        vNicPerformanceArray | No | array of :ref:`vNicPerformance <d_b845a2955da4c78bef3ba4d50021a240>` |  |  | usage of an array of virtual network interface cards
        vnfcScalingMetric | No | integer |  |  | represents busy-ness of the VNF from 0 to 100 as reported by the VNFC

.. _d_7a758ee807f435a8ba5568e6da6ed597:

memoryUsage Model Structure
---------------------------

memory usage of an identified virtual machine

.. csv-table::
    :delim: |
    :header: "Name", "Required", "Type", "Format", "Properties", "Description"
    :widths: 20, 10, 15, 15, 30, 25

        memoryBuffered | No | number |  |  | kibibytes of temporary storage for raw disk blocks
        memoryCached | No | number |  |  | kibibytes of memory used for cache
        memoryConfigured | No | number |  |  | kibibytes of memory configured in the virtual machine on which the VNFC reporting the event is running
        memoryFree | Yes | number |  |  | kibibytes of physical RAM left unused by the system
        memorySlabRecl | No | number |  |  | the part of the slab that can be reclaimed such as caches measured in kibibytes
        memorySlabUnrecl | No | number |  |  | the part of the slab that cannot be reclaimed even when lacking memory measured in kibibytes
        memoryUsed | Yes | number |  |  | total memory minus the sum of free, buffered, cached and slab memory measured in kibibytes
        vmIdentifier | Yes | string |  |  | virtual machine identifier associated with the memory metrics

.. _d_dc18fe1d28fe3ef664c3f4ab777d8424:

mobileFlowFields Model Structure
--------------------------------

mobileFlow fields

.. csv-table::
    :delim: |
    :header: "Name", "Required", "Type", "Format", "Properties", "Description"
    :widths: 20, 10, 15, 15, 30, 25

        additionalFields | No | array of :ref:`field <d_a9799335edbbc52c7f0c5191f7bd09ee>` |  |  | additional mobileFlow fields if needed
        appProtocolType | No | string |  |  | application protocol
        appProtocolVersion | No | string |  |  | application protocol version
        applicationType | No | string |  |  | Application type inferred
        cid | No | string |  |  | cell id
        connectionType | No | string |  |  | Abbreviation referencing a 3GPP reference point e.g., S1-U, S11, etc
        ecgi | No | string |  |  | Evolved Cell Global Id
        flowDirection | Yes | string |  |  | Flow direction, indicating if the reporting node is the source of the flow or destination for the flow
        gtpPerFlowMetrics | Yes | :ref:`gtpPerFlowMetrics <d_bb1527d221e848e0896c78552979238b>` |  |  | 
        gtpProtocolType | No | string |  |  | GTP protocol
        gtpVersion | No | string |  |  | GTP protocol version
        httpHeader | No | string |  |  | HTTP request header, if the flow connects to a node referenced by HTTP
        imei | No | string |  |  | IMEI for the subscriber UE used in this flow, if the flow connects to a mobile device
        imsi | No | string |  |  | IMSI for the subscriber UE used in this flow, if the flow connects to a mobile device
        ipProtocolType | Yes | string |  |  | IP protocol type e.g., TCP, UDP, RTP...
        ipVersion | Yes | string |  |  | IP protocol version e.g., IPv4, IPv6
        lac | No | string |  |  | location area code
        mcc | No | string |  |  | mobile country code
        mnc | No | string |  |  | mobile network code
        mobileFlowFieldsVersion | Yes | number |  |  | version of the mobileFlowFields block
        msisdn | No | string |  |  | MSISDN for the subscriber UE used in this flow, as an integer, if the flow connects to a mobile device
        otherEndpointIpAddress | Yes | string |  |  | IP address for the other endpoint, as used for the flow being reported on
        otherEndpointPort | Yes | integer |  |  | IP Port for the reporting entity, as used for the flow being reported on
        otherFunctionalRole | No | string |  |  | Functional role of the other endpoint for the flow being reported on e.g., MME, S-GW, P-GW, PCRF...
        rac | No | string |  |  | routing area code
        radioAccessTechnology | No | string |  |  | Radio Access Technology e.g., 2G, 3G, LTE
        reportingEndpointIpAddr | Yes | string |  |  | IP address for the reporting entity, as used for the flow being reported on
        reportingEndpointPort | Yes | integer |  |  | IP port for the reporting entity, as used for the flow being reported on
        sac | No | string |  |  | service area code
        samplingAlgorithm | No | integer |  |  | Integer identifier for the sampling algorithm or rule being applied in calculating the flow metrics if metrics are calculated based on a sample of packets, or 0 if no sampling is applied
        tac | No | string |  |  | transport area code
        tunnelId | No | string |  |  | tunnel identifier
        vlanId | No | string |  |  | VLAN identifier used by this flow

.. _d_38de3331d60414da3eea18e8f7e0ecf9:

namedArrayOfFields Model Structure
----------------------------------

an array of name value pairs along with a name for the array

.. csv-table::
    :delim: |
    :header: "Name", "Required", "Type", "Format", "Properties", "Description"
    :widths: 20, 10, 15, 15, 30, 25

        arrayOfFields | Yes | array of :ref:`field <d_a9799335edbbc52c7f0c5191f7bd09ee>` |  |  | array of name value pairs
        name | Yes | string |  |  | 

.. _d_5a79cd7ce784d60fd832d9c7c0a24322:

otherFields Model Structure
---------------------------

fields for events belonging to the 'other' domain of the commonEventHeader domain enumeration

.. csv-table::
    :delim: |
    :header: "Name", "Required", "Type", "Format", "Properties", "Description"
    :widths: 20, 10, 15, 15, 30, 25

        hashOfNameValuePairArrays | No | array of :ref:`namedArrayOfFields <d_38de3331d60414da3eea18e8f7e0ecf9>` |  |  | array of named name-value-pair arrays
        jsonObjects | No | array of :ref:`jsonObject <d_d8868aee802ae8e2b1e7ea1c4ecc1f54>` |  |  | array of JSON objects described by name, schema and other meta-information
        nameValuePairs | No | array of :ref:`field <d_a9799335edbbc52c7f0c5191f7bd09ee>` |  |  | array of name-value pairs
        otherFieldsVersion | Yes | number |  |  | version of the otherFields block

.. _d_6747334473cf2b305fe43b61a40656e1:

requestError Model Structure
----------------------------

standard request error data structure

.. csv-table::
    :delim: |
    :header: "Name", "Required", "Type", "Format", "Properties", "Description"
    :widths: 20, 10, 15, 15, 30, 25

        messageId | Yes | string |  |  | Unique message identifier of the format ABCnnnn where ABC is either SVC for Service Exceptions or POL for Policy Exception
        text | Yes | string |  |  | Message text, with replacement variables marked with %n, where n is an index into the list of <variables> elements, starting at 1
        url | No | string |  |  | Hyperlink to a detailed error resource e.g., an HTML page for browser user agents
        variables | No | string |  |  | List of zero or more strings that represent the contents of the variables used by the message text

.. _d_c3e191f0b26ddd68f927ac0c8b551c5e:

sipSignalingFields Model Structure
----------------------------------

sip signaling fields

.. csv-table::
    :delim: |
    :header: "Name", "Required", "Type", "Format", "Properties", "Description"
    :widths: 20, 10, 15, 15, 30, 25

        additionalInformation | No | array of :ref:`field <d_a9799335edbbc52c7f0c5191f7bd09ee>` |  |  | additional sip signaling fields if needed
        compressedSip | No | string |  |  | the full SIP request/response including headers and bodies
        correlator | Yes | string |  |  | this is the same for all events on this call
        localIpAddress | Yes | string |  |  | IP address on VNF
        localPort | Yes | string |  |  | port on VNF
        remoteIpAddress | Yes | string |  |  | IP address of peer endpoint
        remotePort | Yes | string |  |  | port of peer endpoint
        sipSignalingFieldsVersion | Yes | number |  |  | version of the sipSignalingFields block
        summarySip | No | string |  |  | the SIP Method or Response (INVITE, 200 OK, BYE, etc)
        vendorVnfNameFields | Yes | :ref:`vendorVnfNameFields <d_d694eebbbc0078612d2ba22e0cbf814c>` |  |  | 

.. _d_c5450f1a263d0a2b0c64c96119f7d759:

stateChangeFields Model Structure
---------------------------------

stateChange fields

.. csv-table::
    :delim: |
    :header: "Name", "Required", "Type", "Format", "Properties", "Description"
    :widths: 20, 10, 15, 15, 30, 25

        additionalFields | No | array of :ref:`field <d_a9799335edbbc52c7f0c5191f7bd09ee>` |  |  | additional stateChange fields if needed
        newState | Yes | string |  | {'enum': ['inService', 'maintenance', 'outOfService']} | new state of the entity
        oldState | Yes | string |  | {'enum': ['inService', 'maintenance', 'outOfService']} | previous state of the entity
        stateChangeFieldsVersion | Yes | number |  |  | version of the stateChangeFields block
        stateInterface | Yes | string |  |  | card or port name of the entity that changed state

.. _d_52877eda2d273b282063857f97fa7ff4:

suppressedNvPairs Model Structure
---------------------------------

List of specific NvPairsNames to suppress within a given Name-Value Field for event Throttling

.. csv-table::
    :delim: |
    :header: "Name", "Required", "Type", "Format", "Properties", "Description"
    :widths: 20, 10, 15, 15, 30, 25

        nvPairFieldName | Yes | string |  |  | Name of the field within which are the nvpair names to suppress
        suppressedNvPairNames | Yes | array of string |  |  | Array of nvpair names to suppress within the nvpairFieldName

.. _d_782271970af04a3b0e5a5da9b30996d2:

syslogFields Model Structure
----------------------------

sysLog fields

.. csv-table::
    :delim: |
    :header: "Name", "Required", "Type", "Format", "Properties", "Description"
    :widths: 20, 10, 15, 15, 30, 25

        additionalFields | No | string |  |  | additional syslog fields if needed provided as name=value delimited by a pipe | symbol, for example: 'name1=value1|name2=value2|'
        eventSourceHost | No | string |  |  | hostname of the device
        eventSourceType | Yes | string |  |  | type of event source; examples: other, router, switch, host, card, port, slotThreshold, portThreshold, virtualMachine, virtualNetworkFunction
        syslogFacility | No | integer |  |  | numeric code from 0 to 23 for facility--see table in documentation
        syslogFieldsVersion | Yes | number |  |  | version of the syslogFields block
        syslogMsg | Yes | string |  |  | syslog message
        syslogPri | No | integer |  |  | 0-192 combined severity and facility
        syslogProc | No | string |  |  | identifies the application that originated the message
        syslogProcId | No | number |  |  | a change in the value of this field indicates a discontinuity in syslog reporting
        syslogSData | No | string |  |  | syslog structured data consisting of a structured data Id followed by a set of key value pairs
        syslogSdId | No | string |  |  | 0-32 char in format name@number for example ourSDID@32473
        syslogSev | No | string |  | {'enum': ['Alert', 'Critical', 'Debug', 'Emergency', 'Error', 'Info', 'Notice', 'Warning']} | numerical Code for  severity derived from syslogPri as remaider of syslogPri / 8
        syslogTag | Yes | string |  |  | msgId indicating the type of message such as TCPOUT or TCPIN; NILVALUE should be used when no other value can be provided
        syslogVer | No | number |  |  | IANA assigned version of the syslog protocol specification - typically 1

.. _d_bd95ac8a5536a5bb5e6a0de7e64b9f20:

thresholdCrossingAlertFields Model Structure
--------------------------------------------

fields specific to threshold crossing alert events

.. csv-table::
    :delim: |
    :header: "Name", "Required", "Type", "Format", "Properties", "Description"
    :widths: 20, 10, 15, 15, 30, 25

        additionalFields | No | array of :ref:`field <d_a9799335edbbc52c7f0c5191f7bd09ee>` |  |  | additional threshold crossing alert fields if needed
        additionalParameters | Yes | array of :ref:`counter <d_6e043350cba5faafe21de49c2f6fd745>` |  |  | performance counters
        alertAction | Yes | string |  | {'enum': ['CLEAR', 'CONT', 'SET']} | Event action
        alertDescription | Yes | string |  |  | Unique short alert description such as IF-SHUB-ERRDROP
        alertType | Yes | string |  | {'enum': ['CARD-ANOMALY', 'ELEMENT-ANOMALY', 'INTERFACE-ANOMALY', 'SERVICE-ANOMALY']} | Event type
        alertValue | No | string |  |  | Calculated API value (if applicable)
        associatedAlertIdList | No | array of string |  |  | List of eventIds associated with the event being reported
        collectionTimestamp | Yes | string |  |  | Time when the performance collector picked up the data; with RFC 2822 compliant format: Sat, 13 Mar 2010 11:29:05 -0800
        dataCollector | No | string |  |  | Specific performance collector instance used
        elementType | No | string |  |  | type of network element - internal ATT field
        eventSeverity | Yes | string |  | {'enum': ['CRITICAL', 'MAJOR', 'MINOR', 'WARNING', 'NORMAL']} | event severity or priority
        eventStartTimestamp | Yes | string |  |  | Time closest to when the measurement was made; with RFC 2822 compliant format: Sat, 13 Mar 2010 11:29:05 -0800
        interfaceName | No | string |  |  | Physical or logical port or card (if applicable)
        networkService | No | string |  |  | network name - internal ATT field
        possibleRootCause | No | string |  |  | Reserved for future use
        thresholdCrossingFieldsVersion | Yes | number |  |  | version of the thresholdCrossingAlertFields block

.. _d_b845a2955da4c78bef3ba4d50021a240:

vNicPerformance Model Structure
-------------------------------

describes the performance and errors of an identified virtual network interface card

.. csv-table::
    :delim: |
    :header: "Name", "Required", "Type", "Format", "Properties", "Description"
    :widths: 20, 10, 15, 15, 30, 25

        receivedBroadcastPacketsAccumulated | No | number |  |  | Cumulative count of broadcast packets received as read at the end of the measurement interval
        receivedBroadcastPacketsDelta | No | number |  |  | Count of broadcast packets received within the measurement interval
        receivedDiscardedPacketsAccumulated | No | number |  |  | Cumulative count of discarded packets received as read at the end of the measurement interval
        receivedDiscardedPacketsDelta | No | number |  |  | Count of discarded packets received within the measurement interval
        receivedErrorPacketsAccumulated | No | number |  |  | Cumulative count of error packets received as read at the end of the measurement interval
        receivedErrorPacketsDelta | No | number |  |  | Count of error packets received within the measurement interval
        receivedMulticastPacketsAccumulated | No | number |  |  | Cumulative count of multicast packets received as read at the end of the measurement interval
        receivedMulticastPacketsDelta | No | number |  |  | Count of multicast packets received within the measurement interval
        receivedOctetsAccumulated | No | number |  |  | Cumulative count of octets received as read at the end of the measurement interval
        receivedOctetsDelta | No | number |  |  | Count of octets received within the measurement interval
        receivedTotalPacketsAccumulated | No | number |  |  | Cumulative count of all packets received as read at the end of the measurement interval
        receivedTotalPacketsDelta | No | number |  |  | Count of all packets received within the measurement interval
        receivedUnicastPacketsAccumulated | No | number |  |  | Cumulative count of unicast packets received as read at the end of the measurement interval
        receivedUnicastPacketsDelta | No | number |  |  | Count of unicast packets received within the measurement interval
        transmittedBroadcastPacketsAccumulated | No | number |  |  | Cumulative count of broadcast packets transmitted as read at the end of the measurement interval
        transmittedBroadcastPacketsDelta | No | number |  |  | Count of broadcast packets transmitted within the measurement interval
        transmittedDiscardedPacketsAccumulated | No | number |  |  | Cumulative count of discarded packets transmitted as read at the end of the measurement interval
        transmittedDiscardedPacketsDelta | No | number |  |  | Count of discarded packets transmitted within the measurement interval
        transmittedErrorPacketsAccumulated | No | number |  |  | Cumulative count of error packets transmitted as read at the end of the measurement interval
        transmittedErrorPacketsDelta | No | number |  |  | Count of error packets transmitted within the measurement interval
        transmittedMulticastPacketsAccumulated | No | number |  |  | Cumulative count of multicast packets transmitted as read at the end of the measurement interval
        transmittedMulticastPacketsDelta | No | number |  |  | Count of multicast packets transmitted within the measurement interval
        transmittedOctetsAccumulated | No | number |  |  | Cumulative count of octets transmitted as read at the end of the measurement interval
        transmittedOctetsDelta | No | number |  |  | Count of octets transmitted within the measurement interval
        transmittedTotalPacketsAccumulated | No | number |  |  | Cumulative count of all packets transmitted as read at the end of the measurement interval
        transmittedTotalPacketsDelta | No | number |  |  | Count of all packets transmitted within the measurement interval
        transmittedUnicastPacketsAccumulated | No | number |  |  | Cumulative count of unicast packets transmitted as read at the end of the measurement interval
        transmittedUnicastPacketsDelta | No | number |  |  | Count of unicast packets transmitted within the measurement interval
        vNicIdentifier | Yes | string |  |  | vNic identification
        valuesAreSuspect | Yes | string |  | {'enum': ['true', 'false']} | Indicates whether vNicPerformance values are likely inaccurate due to counter overflow or other condtions

.. _d_d694eebbbc0078612d2ba22e0cbf814c:

vendorVnfNameFields Model Structure
-----------------------------------

provides vendor, vnf and vfModule identifying information

.. csv-table::
    :delim: |
    :header: "Name", "Required", "Type", "Format", "Properties", "Description"
    :widths: 20, 10, 15, 15, 30, 25

        vendorName | Yes | string |  |  | VNF vendor name
        vfModuleName | No | string |  |  | ASDC vfModuleName for the vfModule generating the event
        vnfName | No | string |  |  | ASDC modelName for the VNF generating the event

.. _d_9551641bd1c775d9fcf4e45353de8e43:

voiceQualityFields Model Structure
----------------------------------

provides statistics related to customer facing voice products

.. csv-table::
    :delim: |
    :header: "Name", "Required", "Type", "Format", "Properties", "Description"
    :widths: 20, 10, 15, 15, 30, 25

        additionalInformation | No | array of :ref:`field <d_a9799335edbbc52c7f0c5191f7bd09ee>` |  |  | additional voice quality fields if needed
        calleeSideCodec | Yes | string |  |  | callee codec for the call
        callerSideCodec | Yes | string |  |  | caller codec for the call
        correlator | Yes | string |  |  | this is the same for all events on this call
        endOfCallVqmSummaries | No | :ref:`endOfCallVqmSummaries <d_c911a0a8abdb511d7cd6590f383d817b>` |  |  | 
        midCallRtcp | Yes | string |  |  | Base64 encoding of the binary RTCP data excluding Eth/IP/UDP headers
        phoneNumber | No | string |  |  | phone number associated with the correlator
        vendorVnfNameFields | Yes | :ref:`vendorVnfNameFields <d_d694eebbbc0078612d2ba22e0cbf814c>` |  |  | 
        voiceQualityFieldsVersion | Yes | number |  |  | version of the voiceQualityFields block

