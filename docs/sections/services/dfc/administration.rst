.. This work is licensed under a Creative Commons Attribution 4.0 International License.
.. http://creativecommons.org/licenses/by/4.0

Administration
==============
DFC has a healthcheck functionality. The service can then be started and stopped through an API. One can also check the liveliness of the service.

Main API Endpoints
""""""""""""""""""
Running with dev-mode of DFC
    - Heartbeat: **http://<container_address>:8100/heartbeat** or **https://<container_address>:8433/heartbeat**
    - Start DFC: **http://<container_address>:8100/start** or **https://<container_address>:8433/start**
    - Stop DFC: **http://<container_address>:8100/stopDatafile** or **https://<container_address>:8433/stopDatafile**

The external port allocated for 8100 (http) is 30245.
