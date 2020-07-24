.. This work is licensed under a Creative Commons Attribution 4.0 International License.
.. http://creativecommons.org/licenses/by/4.0

=============================
Configuration and Performance
=============================
The DataFile Collector (DFC) gets fileReady messages from the Message Router (MR) sent from xNFs, via the VES Collector.
These messages contains data about files ready to get from the xNF. DFC then collects these files from the xNF and
publishes them to the DataRouter (DR) on a feed. Consumers can subscribe to the feed from DR and process the file for
its specific purpose. The connection between a file type and the feed it will be published to is the
**changeIdentifier**. DFC can handle multiple **changeIdentifier**/feed combinations, see picture below.

.. image:: ../../images/DFC_config.png



Configuration
^^^^^^^^^^^^^
By default, DFC handles the "PM_MEAS_FILES" change identifier and publishes these files on the "bulk_pm_feed" feed.
But it can also be configured to handle more/other change identifiers and publish them to more/other feeds. The
configuration of DFC is controlled via a blueprint.

Blueprint Configuration Explained
"""""""""""""""""""""""""""""""""

For the communication with the Message Router, the user must provide the **host name**, **port**, and **protocol** of
the DMaaP Message router.

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

DFC can handle multiple change identifiers. For each change identifier/feed combination the user must provide the
**change identifier**, **feed name**, and **feed location**.

**Note!** The **feed name** provided should be used by the consumer/s to set up the subscription to the feed.

The **feed name** and **feed location** are defined as inputs for the user to provide.

.. code-block:: yaml
  :emphasize-lines: 2,6

    inputs:
      feed0_name:
        type: string
        description: The name of the feed the files will be published to. Should be used by the subscriber.
        default: "bulk_pm_feed"
      feed0_location:
        type: string
        description: The location of the feed.
        default: "loc00"

The **feed name** shall be used in the definition of the feed for the DMaaP plugin under the "**node_templates**"
section under a tag for the  internal "**feed identifier**" for the feed (feed0 in the example).

.. code-block:: yaml
  :emphasize-lines: 1,5

    feed0:
      type: ccsdk.nodes.Feed
      properties:
        feed_name:
          get_input: feed0_name
        useExisting: true

The **feed location** shall be used under the **streams_publishes** section under a tag for the internal
"**feed identifier**" for the feed.

.. code-block:: yaml
  :emphasize-lines: 2,4

      streams_publishes:
      - name: feed0
        location:
          get_input: feed0_location
        type: data_router

The **change identifier** shall be defined as an item under the **streams_publishes** tag in the "**application_config**"
section. Under this tag the internal "**feed identifier**" for the feed shall also be added to get the
info about the feed substituted in by CBS (that's what the <<>> tags are for).

.. code-block:: yaml
  :emphasize-lines: 4,5

      application_config:
        service_calls: []
        streams_publishes:
          PM_MEAS_FILES:
            dmaap_info: <<feed0>>
            type: data_router

And, lastly, to set up the publication relationship for the feed, the "**feed identifier**" must be added to the
"**relationships**" section of the blueprint.

.. code-block:: yaml
  :emphasize-lines: 3

   relationships:
    - type: ccsdk.relationships.publish_files
      target: feed0

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
      envs:
        default: {}
      feed0_name:
        type: string
        description: The name of the feed the files will be published to. Should be used by the subscriber.
        default: "bulk_pm_feed"
      feed0_location:
        type: string
        description: The location of the feed.
        default: "loc00"
      feed1_name:
        type: string
        description: The name of the feed the files will be published to. Should be used by the subscriber.
        default: "log_feed"
      feed1_location:
        type: string
        description: The location of the feed.
        default: "loc00"
    node_templates:
      datafile-collector:
        type: dcae.nodes.ContainerizedServiceComponentUsingDmaap
        interfaces:
          cloudify.interfaces.lifecycle:
            start:
              inputs:
            envs:
              get_input: envs
        properties:
          application_config:
            service_calls: []
            dmaap.security.enableDmaapCertAuth: { get_input: secureEnableCert }
            streams_subscribes:
              dmaap_subscriber:
                dmaap_info:
                  topic_url:
                    { concat: [{ get_input: dmaap_mr_protocol },"://",{ get_input: dmaap_mr_host },
                               ":",{ get_input: dmaap_mr_port },"/events/unauthenticated.VES_NOTIFICATION_OUTPUT/OpenDcae-c12/C12"]}
            streams_publishes:
              PM_MEAS_FILES:
                dmaap_info: <<feed0>>
                type: data_router
              LOG_FILES:
                dmaap_info: <<feed1>>
                type: data_router
          image:
            get_input: tag_version
          service_component_type: datafile-collector
          streams_publishes:
          - name: feed0
            location:
              get_input: feed0_location
            type: data_router
          - name: feed1
            location:
              get_input: feed1_location
            type: data_router
        relationships:
          - type: ccsdk.relationships.publish_files
            target: feed0
          - type: ccsdk.relationships.publish_files
            target: feed1
      feed0:
        type: ccsdk.nodes.Feed
        properties:
          feed_name:
            get_input: feed0_name
          useExisting: true
      feed1:
        type: ccsdk.nodes.Feed
        properties:
          feed_name:
            get_input: feed1_name
          useExisting: true

.. _strict_host_checking_config:

Turn On/Off StrictHostChecking
------------------------------
**StrictHostChecking** is SSH connection option. If it is enabled, checks HostName and public keys provided by server and compare them with keys stored locally. 
By default in DataFile Collector this option is enabled (true) and required provide known_hosts list to DFC containter.

**Important: DFC requires public key in sha-rsa KeyAlgorithm** 

**Known_hosts file** is list with following format:

.. code-block:: bash

  <HostName/HostIP> <KeyAlgorithms> <Public Key>

E.g: 

.. code-block:: bash

  172.17.0.3 ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDRibxPenQC//2hzTuscdQDUA7P3gB9k4E8IgwCJxZM8YrJ2vqHomN8boByubebvo0L8+DWqzAtjy0nvgzsoEme9Y3lLWZ/2g9stlsOurwm+nFmWn/RPnwjqsAGNQjukV8C9D82rPMOYRES6qSGactFw4i8ZWLH8pmuJ3js1jb91HSlwr4zbZZd2XPKHk3nudyh8/Mwf3rndCU5FSnzjpBo55m48nsl2M1Tb6Xj1R0jQc5LWN0fsbrm5m+szsk4ccgHw6Vj9dr0Jh4EaIpNwA68k4LzrWb/N20bW8NzUsyDSQK8oEo1dvsiw8G9/AogBjQu9N4bqKWcrk5DOLCZHiCTSbbvdMWAMHXBdxEt9GZ0V53Fzwm8fI2EmIHdLhI4BWKZajumsfHRnd6UUxxna9ySt6qxVYZTyrPvfOFR3hRxVaxHL3EXplGeHT8fnoj+viai+TeSDdjMNwqU4MrngzrNKNLBHIl705uASpHUaRYQxUfWw/zgKeYlIbH+aGgE+4Q1vnh10Y35pATePRZgBIu+h2KsYBAtrP88LqW562OQ6T7VkfoAYwOjx9WV3/y5qonsStPhhzmJHDF22oBh5E5tZQxRcIlQF+5kHmXnFRUZtWshFnQATBh3yhOzJbh66CXn7aPj5Kl8TuuSN48zuI2lulVVqcv7GmTS0tWNpbxpzw==

HostName could be hashed, e.g:

.. code-block:: bash

  |1|FwSOxXYeJyZMAQM3jREjLSIcxRw=|o/b+CHEeHuED7WZS6sb3Y1IyHjk= ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDRibxPenQC//2hzTuscdQDUA7P3gB9k4E8IgwCJxZM8YrJ2vqHomN8boByubebvo0L8+DWqzAtjy0nvgzsoEme9Y3lLWZ/2g9stlsOurwm+nFmWn/RPnwjqsAGNQjukV8C9D82rPMOYRES6qSGactFw4i8ZWLH8pmuJ3js1jb91HSlwr4zbZZd2XPKHk3nudyh8/Mwf3rndCU5FSnzjpBo55m48nsl2M1Tb6Xj1R0jQc5LWN0fsbrm5m+szsk4ccgHw6Vj9dr0Jh4EaIpNwA68k4LzrWb/N20bW8NzUsyDSQK8oEo1dvsiw8G9/AogBjQu9N4bqKWcrk5DOLCZHiCTSbbvdMWAMHXBdxEt9GZ0V53Fzwm8fI2EmIHdLhI4BWKZajumsfHRnd6UUxxna9ySt6qxVYZTyrPvfOFR3hRxVaxHL3EXplGeHT8fnoj+viai+TeSDdjMNwqU4MrngzrNKNLBHIl705uASpHUaRYQxUfWw/zgKeYlIbH+aGgE+4Q1vnh10Y35pATePRZgBIu+h2KsYBAtrP88LqW562OQ6T7VkfoAYwOjx9WV3/y5qonsStPhhzmJHDF22oBh5E5tZQxRcIlQF+5kHmXnFRUZtWshFnQATBh3yhOzJbh66CXn7aPj5Kl8TuuSN48zuI2lulVVqcv7GmTS0tWNpbxpzw==



To provide known_hosts list to DFC, execute following steps:

1. Mount file using config map.

.. code-block:: bash

  kubectl -n <ONAP NAMESPACE> create cm <config map name> --from-file <path to known_hosts file>

2. Edit DFC deployment, add volume and volume monunts. **DFC deployment contains 3 containers, pay attention to mount the file to the appropriate container.**

.. code-block:: yaml
  
  ...
  kind: Deployment
  metadata:
  ...
  spec:
    ...
    template:
      ...
      spec:
        containers:
        - image: <DFC image>
          ...
          volumeMounts:
            ...
          - mountPath: /home/datafile/.ssh/
            name: onap-dcae-dfc-known-hosts
            ...
        volumes:
        ...
        - configMap:
            name: <config map name, same as in step 1>
          name: onap-dcae-dfc-known-hosts
      ...

Known_hosts file path can be control by System Variable *KNOWN_HOST_PATH*, it points to absolute file path. Sample deployment with changed known_hosts file path can be seen below.

.. code-block:: yaml
  
  ...
  kind: Deployment
  metadata:
  ...
  spec:
    ...
    template:
      ...
      spec:
        containers:
        - image: <DFC image>
          envs: 
            - name: KNOWN_HOSTS_FILE_PATH
              value: /home/datafile/.ssh/new/path/<know_host file name>
          ...
          volumeMounts:
            ...
          - mountPath: /home/datafile/.ssh/new/path
            name: onap-dcae-dfc-known-hosts
            ...
        volumes:
        ...
        - configMap:
            name: <config map name, same as in step 1>
          name: onap-dcae-dfc-known-hosts
      ...

To change mounted known_hosts list, edit existing config map or delete and create it again. **The DFC container may refresh a changes with a delay.** 

To edit config map:

.. code-block:: bash

  kubectl -n <ONAP NAMESPACE> edit cm <config map name>

To delete and create again config map: 

.. code-block:: bash

  kubectl -n <ONAP NAMESPACE> delete cm <config map name>
  kubectl -n <ONAP NAMESPACE> create cm <config map name> --from-file <path to known_hosts file>


To turn off **(insecure)** set below option to false, it could be changed by ONAP Consul.

.. code-block:: bash

  "sftp.security.strictHostKeyChecking": false


Performance
^^^^^^^^^^^

To see the performance of DFC, see "`Datafile Collector (DFC) performance baseline results`_".

.. _Datafile Collector (DFC) performance baseline results: https://wiki.onap.org/display/DW/Datafile+Collector+%28DFC%29+performance+baseline+results
