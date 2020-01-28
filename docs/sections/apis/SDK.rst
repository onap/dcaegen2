.. This work is licensed under a
   Creative Commons Attribution 4.0 International License.


DCAE SDK
========

.. contents::
    :depth: 3
..

Overview
--------

DCAE SDK contains utilities and clients which may be used for fetching
configuration from CBS, consuming messages from DMaaP, etc. SDK is written in Java.

Introduction
------------

      SDK Maven dependencies (modules).

      .. code-block:: XML

            <properties>
                <sdk.version>1.3.4</sdk.version>
            </properties>

            <dependencies>

                <dependency>
                  <groupId>org.onap.dcaegen2.services.sdk.rest.services</groupId>
                  <artifactId>cbs-client</artifactId>
                  <version>${sdk.version}</version>
                </dependency>

                <dependency>
                  <groupId>org.onap.dcaegen2.services.sdk.rest.services</groupId>
                  <artifactId>dmaap-client</artifactId>
                  <version>${sdk.version}</version>
                </dependency>

                <dependency>
                  <groupId>org.onap.dcaegen2.services.sdk.rest.services</groupId>
                  <artifactId>http-client</artifactId>
                  <version>${sdk.version}</version>
                </dependency>

                <dependency>
                  <groupId>org.onap.dcaegen2.services.sdk.security.crypt</groupId>
                  <artifactId>crypt-password</artifactId>
                  <version>${sdk.version}</version>
                </dependency>

                <dependency>
                  <groupId>org.onap.dcaegen2.services.sdk.security</groupId>
                  <artifactId>ssl</artifactId>
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


Revision history
----------------

   **1.3.4**
      - Usage of Java 11

   **1.3.3-SNAPSHOT**
      - Upgrade CBS to support SSL
      - Fix static code vulnerabilities
      - Exclude IT from tests
      - Remove AAI client from SDK

   **1.3.2-SNAPSHOT**
      - Restructure AAI client
      - Get rid of common-dependency module
      - Rearrange files in packages inside rest-services

   **1.3.1-SNAPSHOT**
      - Bugfix release: AAI client
         - Make AaiGetServiceInstanceClient build correct path to the service resource in AAI

   **1.3.0-SNAPSHOT** (ElAlto - under development)
      - All El-Alto work noted under 1.2.0-SNAPSHOT will roll into this version
      - Version update was done for tracking global-jjb migration work and corresponding submission - https://gerrit.onap.org/r/#/c/dcaegen2/services/sdk/+/89902/