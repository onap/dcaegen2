.. This work is licensed under a Creative Commons Attribution 4.0 International License.
.. http://creativecommons.org/licenses/by/4.0


Troubleshooting
===============

Configuration Errors
""""""""""""""""""""

If the PMSH fails to start and is in CrashLoopBackOff, it is likely due to a configuration error.

Unable to connect to Config Binding Service
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

The PMSH may not be able to reach the Config Binding Service. If this is the case you will be able to
see an error connecting to Config Binding Service, by checking the container logs.

Invalid Configuration
^^^^^^^^^^^^^^^^^^^^^

If the PMSH is able to connect to Config Binding Service, but is failing to start. It may be due to
invalid configuration. Check the container logs for an incorrect configuration error.

Failure to create/delete Subscription
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

If an error occurs when UN/LOCKING the administrativeState of the subscription, this may be due to a failure
in one of the following ONAP services/applications. Check the logs of each to debug the issue.

- dmaap-message-router
- policy-apex-pdp
- cds-blueprints-processor
- sdnc
