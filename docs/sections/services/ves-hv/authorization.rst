    **WARNING: SSL/TLS authorization is a part of an experimental feature for ONAP Casablanca release and thus should be treated as unstable and subject to change in future releases.**

.. _authorization:

SSL/TLS authorization
=====================

HV-VES can be configured to require usage of SSL/TLS on every TCP connection. This can be done only during deployment of application container. For reference about exact commands, see :ref:`deployment`.

General steps for configuring TLS for HV-VES collector:

1. Create the collector's key-store in **PKCS #12** format and add HV-VES server certificate to it.
2. Create the collector's trust-store in **PKCS #12** format with all trusted certificates and certification authorities. Every client with certificate signed by a Certificate Authority (CA) in chain of trust is allowed. The trust-store should not contain ONAP's root CAs.
3. Start the collector with all required options specified.

    .. code-block:: bash

        docker run -v /path/to/key/and/trust/stores:/etc/hv-ves nexus3.onap.org:10001/onap/org.onap.dcaegen2.collectors.hv-ves.hv-collector-main --listen-port 6061 --config-url http://consul:8500/v1/kv/dcae-hv-ves-collector --key-store /etc/hv-ves/keystore.p12  --key-store-password keystorePass --trust-store /etc/hv-ves/truststore.p12 --trust-store-password truststorePass



HV-VES uses OpenJDK (version 8u181) implementation of TLS ciphers. For reference, see https://docs.oracle.com/javase/8/docs/technotes/guides/security/overview/jsoverview.html.

If SSL/TLS is enabled for HV-VES container then service turns on also client authentication. HV-VES requires clients to provide their certificates on connection. In addition, HV-VES provides its certificate to every client during SSL/TLS-handshake to enable two-way authorization.

The service rejects any connection attempt that is not secured by SSL/TLS and every connection made by unauthorized client - this is client which certificate is not signed by CA contained within the HV-VES Collector trust store. With TLS tunneling, the communication protocol does not change (see the description in :ref:`hv_ves_behaviors`). In particular there is no change to Wire Frame Protocol.
