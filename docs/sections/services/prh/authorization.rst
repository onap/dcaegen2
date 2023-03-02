.. This work is licensed under a Creative Commons Attribution 4.0 International License.
.. http://creativecommons.org/licenses/by/4.0

.. _authorization:

SSL/TLS Authentication & Authorization
======================================

| PRH does not perform any authorization in AAF, as the only endpoint which is provided by the service is the healthcheck, which is unsecured.
| For authentication settings there is a possibility to change from default behavior to certificate-based solution independently for DMaaP and AAI communication.

AAI authentication
^^^^^^^^^^^^^^^^^^

Default
"""""""
| By default basic authentication is being used with following credentials:
| user=AAI
| password=AAI

Certificate-based
"""""""""""""""""
| There is an option to enable certificate-based authentication for PRH towards AAI service calls.
| To achieve this secure flag needs to be turned on in PRH :ref:`configuration<prh_configuration>` :

.. code-block:: json

  security.enableAaiCertAuth=true

DMaaP BC authentication
^^^^^^^^^^^^^^^^^^^^^^^

Default
"""""""
| By default basic authentication is being used with following credentials (for both DMaaP consumer and DMaaP publisher endpoints):
| user=admin
| password=admin

Certificate-based
""""""""""""""""""
| There is an option to enable certificate-based authentication for PRH towards DMaaP Bus Controller service calls.
| To achieve this secure flag needs to be turned on in PRH :ref:`configuration<prh_configuration>` :

.. code-block:: json

  --security.enableDmaapCertAuth=true

PRH identity and certificate data
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
| PRH is using ``dcae`` identity when certificate-based authentication is turned on.
| It's the DCAEGEN2 responsibility to generate certificate for dcae identity and provide it to the collector.
|
| PRH by default expects that the volume ``tls-info`` is being mounted under path ``/opt/app/prh/etc/cert``.
| It's the component/collector responsibility to provide necessary inputs in Helm charts to get the volume mounted.
| See :doc:`../../tls_enablement` for detailed information.
|
| PRH is using four files from ``tls-info`` DCAE volume (``cert.jks, jks.pass, trust.jks, trust.pass``).
| Refer :ref:`configuration<prh_configuration>` for proper security attributes settings.
|
| **IMPORTANT** Even when certificate-based authentication security features are disabled,
| still all security settings needs to be provided in configuration to make PRH service start smoothly.
| Security attributes values are not validated in this case, and can point to non-existent data.
