.. This work is licensed under a Creative Commons Attribution 4.0 International License.
.. http://creativecommons.org/licenses/by/4.0

Installation
============

To run HV-VES Collector container you need to specify required parameters:

- listen-port - the port on which HV-VES will listen internally
- config-url - URL of HV-VES configuration on consul

There are also optional configuration parameters:

- health-check-api-port - Health check rest api listen port
- first-request-delay - Delay of first request to consul in seconds
- request-interval - Interval of consul configuration requests in seconds
- ssl-disable - Disable SSL encryption
- key-store - Key store in PKCS12 format path
- key-store-password - Key store password
- trust-store - File with trusted certificate bundle in PKCS12 format path
- trust-store-password - Trust store password
- idle-timeout-sec - Idle timeout for remote hosts. After given time without any data exchange the connection might be closed


These parameters can be configured either by passing command line option during `docker run` call or
by specifying environment variables named after command line option name
rewritten using `UPPER_SNAKE_CASE` and prepended with `VESHV_` prefix e.g. `VESHV_LISTEN_PORT`.