.. _sdk_api:

========
DCAE SDK
========

:Date: 2019-04-24

.. contents::
:depth: 3
..

Overview
========

DCAE SDK contains utilities and clients which may be used for fetching configuration from CBS, consuming messages from
DMaaP, interacting with A&AI, etc. SDK is written in Java.

Introduction
============

SDK Maven dependencies (modules).

.. code-block:: XML

<properties>
  <sdk.version>1.1.4</sdk.version>
</properties>

<dependencies>
  <dependency>
    <groupId>org.onap.dcaegen2.services.sdk.rest.services</groupId>
    <artifactId>cbs-client</artifactId>
    <version>${sdk.version}</version>
  </dependency>

  <dependency>
    <groupId>org.onap.dcaegen2.services.sdk.security.crypt</groupId>
    <artifactId>crypt-password</artifactId>
    <version>${sdk.version}</version>
  </dependency>

  <dependency>
    <groupId>org.onap.dcaegen2.services.sdk</groupId>
    <artifactId>hvvesclient-producer-api</artifactId>
    <version>${sdk.version}</version>
  </dependency>

  <dependency>
    <groupId>org.onap.dcaegen2.services.sdk</groupId>
    <artifactId>hvvesclient-producer-impl</artifactId>
    <version>${sdk.version}</version>
    <scope>runtime</scope>
  </dependency>

 <!-- more to go -->

</dependencies>



