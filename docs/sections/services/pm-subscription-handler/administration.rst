.. This work is licensed under a Creative Commons Attribution 4.0 International License.
.. http://creativecommons.org/licenses/by/4.0

Administration
==============
PMSH has a healthcheck functionality. One can also check the liveliness of the service.

Updating a Subscription
"""""""""""""""""""""""
Current functionality does not support updating an active (UNLOCKED) subscription at runtime.
To update a subscription:

- transition the administrativeState from UNLOCKED to LOCKED

This will attempt to remove any active/running subscriptions from the relevant NFs and set the administrativeState to "LOCKING".
Monitor the administrativeState via the /subscriptions api endpoint until it has fully LOCKED.

- update the relevant fields of the subscription object

See :ref:`Subscription configuration<Subscription>` for details.
All subscription fields except the subscriptionName can be updated.

- transition the administrativeState from LOCKED to UNLOCKED

This will attempt to create the updated subscription on the relevant NFs.