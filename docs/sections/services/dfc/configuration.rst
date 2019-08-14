.. This work is licensed under a Creative Commons Attribution 4.0 International License.
.. http://creativecommons.org/licenses/by/4.0

=============================
Configuration and Performance
=============================

Configuration
^^^^^^^^^^^^^
By default, DFC handles the "PM_MEAS_FILES" change identifier and publishes these files on the "bulk_pm_feed" feed.
But it can also be configured to handle other change identifiers and publish them to other feeds, see picture below.

.. image:: ../../images/DFC_config.png

The configuration of DFC is controlled via a blueprint.

Blueprint Configuration Explained
"""""""""""""""""""""""""""""""""

For the communication with the Message Router, the user must provide the **host name**, **port**, and **protocol** of the DMaaP Message router.

.. code-block:: yaml
  :emphasize-lines: 2,6,10

    inputs:
      dmaap_mr_host:
        type: string
        description: dmaap messagerouter host
        default: message-router.onap.svc.cluster.local
      dmaap_mr_port:
        type: integer
        description: dmaap messagerouter port
        default: 3904
      dmaap_mr_protocol:
        type: string
        description: dmaap messagerouter protocol
        default: "http"

The user can also specify which version of DFC to use.

.. code-block:: yaml
  :emphasize-lines: 2

    inputs:
      tag_version:
        type: string
        description: DFC image tag/version
        default: "nexus3.onap.org:10001/onap/org.onap.dcaegen2.collectors.datafile.datafile-app-server:1.2.0"

The user can also enable secure communication with the DMaaP Message Router.

.. code-block:: yaml
  :emphasize-lines: 2

    inputs:
      secureEnableCert:
        type: boolean
        description: enable certificate based connection with DMaap
        default: false

DFC can handle multiple change identifiers. This will require to create manually a new block for each change identifier.

.. code-block:: yaml
  :emphasize-lines: 2
  
    streams_publishes:
      dfcFeed00ChangeIdentifier:
        dmaap_info: <<bulk_pm_feed>>
        type: data_router

For each feed related to a change identifier the user must provide the **feed name**, and **feed description**.

.. code-block:: yaml
  :emphasize-lines: 2,6

    inputs:
      dfcFeed00Name:
        type: string
        description: The name of the feed the files will be published to. Should be used by the subscriber.
        default: "bulk_pm_feed"
      dfcFeed00Description:
        type: string
        description: A description of the feed the files will be published to.
        default: "Feed for Bulk PM files"

**Note!** The feed name provided should be used by the subscriber/s to set up the subscription to the feed.

To dynamically create the feeds, DFC uses the DCAE DMaaP plugin. This means that for each feed the user must also add an
item under the "**node_templates**" section of the blueprint. The feed is identified within the blueprint with a feed identifier, "**dfcFeed00**" in the example.

.. code-block:: yaml
  :emphasize-lines: 2

    node_templates:
      dfcFeed00:
        type: ccsdk.nodes.Feed
        properties:
          feed_name: { get_input: dfcFeed00Name }
          feed_description: { get_input: dfcFeed00Description }

To configure DFC micro service itself, the user must also add the change identifier and the feed identifier to the "**application_config**" section
under the tag "**dmaap.dmaapProducerConfiguration**" in the blueprint. **Note!** The identifier should be surrounded by **<<>>** for the feed's configuration to be bound to the DFC configuration in CBS.

.. code-block:: yaml
  :emphasize-lines: 4

          application_config:
            dmaap.dmaapProducerConfiguration:
              - changeIdentifier: {get_input: dfcFeed00ChangeIdentifier}
                feedInfo: <<dfcFeed00>>

And, lastly, to set up the publication to the feed, the feed identifier must be added to the "**streams_publishes**" section
of the blueprint.

.. code-block:: yaml
  :emphasize-lines: 2

          streams_publishes:
            - name: dfcFeed00
              type: data_router
              location: "loc00"

Sample blueprint configuration
""""""""""""""""""""""""""""""

The format of the blueprint configuration that drives all behavior of DFC is probably best described using an example.
The blueprint below configures DFC to handle the two feeds shown in the picture above.

.. code-block:: yaml

    inputs:
      dmaap_mr_host:
        type: string
        description: dmaap messagerouter host
        default: message-router.onap.svc.cluster.local
      dmaap_mr_port:
        type: integer
        description: dmaap messagerouter port
        default: 3904
      dmaap_mr_protocol:
        type: string
        description: dmaap messagerouter protocol
        default: "http"
      tag_version:
        type: string
        description: DFC image tag/version
        default: "nexus3.onap.org:10001/onap/org.onap.dcaegen2.collectors.datafile.datafile-app-server:1.2.0"
      replicas:
        type: integer
        description: number of instances
        default: 1
      secureEnableCert:
        type: boolean
        description: enable certificate based connection with DMaap
        default: false
      dfcFeed00Name:
        type: string
        description: The name of the feed the files will be published to. Should be used by the subscriber.
        default: "bulk_pm_feed"
      dfcFeed00Description:
        type: string
        description: A description of the feed the files will be published to.
        default: "Feed for Bulk PM files"
      dfcFeed01Name:
        type: string
        description: The name of the feed the files will be published to. Should be used by the subscriber.
        default: "log_feed"
      dfcFeed01Description:
        type: string
        description: A description of the feed the files will be published to.
        default: "Feed for log files"

    node_templates:
      dfcFeed00:
        type: ccsdk.nodes.Feed
        properties:
          feed_name: { get_input: dfcFeed00Name }
          feed_description: { get_input: dfcFeed00Description }
      dfcFeed01:
        type: ccsdk.nodes.Feed
        properties:
          feed_name: { get_input: dfcFeed01Name }
          feed_description: { get_input: dfcFeed01Description }

      datafile-collector:
        type: dcae.nodes.ContainerizedServiceComponentUsingDmaap

        relationships:
          - type: ccsdk.relationships.publish_files
            target: dfcFeed00
          - type: ccsdk.relationships.publish_files
            target: dfcFeed01

        interfaces:
          cloudify.interfaces.lifecycle:
            start:
              inputs:
                ports:
                  - concat: ["8100:0"]
                  - concat: ["8433:0"]

        properties:
          service_component_type: 'dcae-datafile'
          application_config:
            dmaap.security.enableDmaapCertAuth: { get_input: secureEnableCert }
            streams_publishes:
              dfcFeed00ChangeIdentifier:
                dmaap_info: <<dfcFeed00>>
                type: data_router
              dfcFeed01ChangeIdentifier:
                dmaap_info: <<dfcFeed01>>
                type: data_router
            streams_subscribes:
              dmaap_subscriber:
                type:
                  "message_router"
                dmaap_info:
                  topic_url:
                    { concat: [{ get_input: dmaap_mr_protocol },"://",{ get_input: dmaap_mr_host },
                               ":",{ get_input: dmaap_mr_port },"/events/unauthenticated.VES_NOTIFICATION_OUTPUT/OpenDcae-c12/C12"]}
          streams_publishes:
            - name: dfcFeed00
              type: data_router
              location: "loc00"
            - name: dfcFeed01
              type: data_router
              location: "loc00"

Performance
^^^^^^^^^^^

To see the performance of DFC, see "`Datafile Collector (DFC) performance baseline results`_".

.. _Datafile Collector (DFC) performance baseline results: https://wiki.onap.org/display/DW/Datafile+Collector+%28DFC%29+performance+baseline+results