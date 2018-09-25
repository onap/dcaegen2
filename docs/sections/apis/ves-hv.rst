.. This work is licensed under a Creative Commons Attribution 4.0 International License.
.. http://creativecommons.org/licenses/by/4.0

========================
HV-VES (High Volume VES)
========================

:Date: 2018-09-24

.. contents::
    :depth: 3
..

Overview
========

Component description can be found under `HV-VES Collector`_.

.. _HV-VES Collector: ../services/ves-hv/index.html


TCP Endpoint
============

HV-VES is exposed as NodePort service on Kubernetes cluster on port 30222/tcp.
It uses plain TCP connections tunneled in SSL/TLS or can be run in insecure manner without data encryption on the socket.
Connections are stream-based (as opposed to request-based) and long running.

Payload is binary-encoded, currently using Google Protocol Buffers representation of the VES Common Header.
The PROTO file, which contains the VES CommonHeader, comes with a binary-type Payload parameter, where domain-specific
data shall be placed. Domain-specific data are encoded as well with GPB, and they do require a domain-specific
PROTO file to decode the data.

HV-VES makes routing decisions based mostly on the content of the **Domain** parameter in VES Common Header.


Healthcheck
===========

Inside HV-VES docker container runs small http service for healthcheck - exact port for this service can be configured
at deployment using `--health-check-api-port` command line option.

This service exposes single endpoint **GET /health/ready** which returns **HTTP 200 OK** in case HV-VES is healthy
and ready for connections. Otherwise it returns **HTTP 503 Service Unavailable** with short reason of unhealthiness.





