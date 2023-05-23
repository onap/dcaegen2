.. This work is licensed under a
   Creative Commons Attribution 4.0 International License.
   http://creativecommons.org/licenses/by/4.0


DCAE SDK
========

.. contents::
    :depth: 3
..

Overview
--------

DCAE SDK contains utilities and clients which may be used for fetching
configuration from CBS, consuming messages from DMaaP, etc. SDK is written in Java.

Artifacts
---------

Current version
~~~~~~~~~~~~~~~
.. code-block:: xml

    <properties>
        <sdk.version>1.4.2</sdk.version>
    </properties>


SDK Maven dependencies (modules)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code-block:: xml

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

                <dependency>
                  <groupId>org.onap.dcaegen2.services.sdk</groupId>
                  <artifactId>dcaegen2-services-sdk-services-external-schema-manager</artifactId>
                  <version>${sdk.version}</version>
                </dependency>

                <!-- more to go -->
            </dependencies>
