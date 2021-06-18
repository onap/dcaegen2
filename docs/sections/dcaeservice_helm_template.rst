.. This work is licensed under a Creative Commons Attribution 4.0 International License.
.. http://creativecommons.org/licenses/by/4.0

Using Helm to deploy DCAE Microservices
=======================================

Background
----------

Prior to the ONAP Honolulu release, DCAE microservices were deployed
using the Cloudify orchestration tool. Each microservice had a Cloudify
*blueprint* containing the information needed for Cloudify to deploy the
microservice. The DCAE team provided a Cloudify plugin that used the
Kubernetes API to create the Kubernetes resources (including a
Kubernetes Deployment and a Kubernetes Service) that make up a running
instance of the microservice.

Beginning with the Honolulu release, DCAE is migrating to a new approach
for deploying DCAE microservices. Instead of using Cloudify with a
Cloudify blueprint for each microservice, DCAE will use Helm to deploy
microservices. Each microservice will have a Helm chart instead of a
Cloudify blueprint. In the Honolulu release, four DCAE microservices
(the VES and HV-VES collectors, the PNF registration handler, and the
TCA Gen2 analytics service) moved to Helm deployment. All four of these
are deployed “statically”–that is, they are deployed when DCAE is
installed and run continuously.

DCAE Service Templates - Introduction
-------------------------------------

It would be possible to write a Helm chart for each microservice, each
completely unrelated. We are taking a different approach. We are
providing shared Helm templates that (approximately) create the same
Kubernetes resources that the Cloudify plugin created when it processed
a blueprint. Creating a Helm chart for a microservice involves setting
up a Helm chart directory, which can be done by copying the chart
directory for an existing microservice and changing the ``Chart.yaml``
file (to set the name, description, and version of the chart) and the
``values.yaml`` file (to customize the templates for the target
microservice).

Once a chart for a microservice has been created, the chart can be used
to deploy the microservice, on demand, into a running instance of ONAP
and DCAE. This is similar to how we deployed microservices on demand
using a Cloudify blueprint and the Cloudify Manager (or the DCAE
deployment handler).

The bulk of this document describes the different parameters that can be
set in the ``values.yaml`` file. There are two sets of parameters. One
set comes from the ONAP OOM common templates used by all of the ONAP
components that deployed via Helm. The other set consists of parameters
that are specific to the DCAE shared templates.

DCAE Service Templates - Location and content
---------------------------------------------
The DCAE shared Helm charts for microservices are maintained in the
OOM repository, in the ``oom/kubernetes/dcaegen2-services/common/dcaegen2-services-common``
directory.  In this directory subtree are:

- ``Chart.yaml``: the usual Helm chart definition file.
- ``requirements.yaml``: the dependencies for the chart.  Only the OOM "common" chart is needed.
- ``values.yaml``: the file is present for completion, but there are no locally-defined values.
- ``templates/_configmap.tpl``: a template that sets up a configMap containing the microservices initial configuration and,
   if needed, a configMap for filebeat logging configuration.
- ``templates/_deployment.tpl``: a template that sets up a Kubernetes Deployment for the microservice.
- ``templates/_filebeat-config.tpl``: a template containing the standard filebeat configuration for microservices that use filebeat logging.
    It's used in the ``templates/_configmap.tpl`` template.
- ``templates/_job.tpl``: a template that creates a Kubernetes Job that runs when a microservice is deleted.  The job brings up a container
   that removes the microservice configuration information from Consul.

Setting variables in ``values.yaml`` for individual microservices
-----------------------------------------------------------------

Variables used by ONAP OOM common templates
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

**image**:

Name and tag of the Docker image for the microservice.
Required. The image repository is set using the OOM common
``repositoryGenerator.repository`` template. Normally this points to the
ONAP image repository, but it can be overridden on a global basis or a
per-chart basis. See the OOM documentation for more details.

Example:

::

   image: onap/org.onap.dcaegen2.services.prh.prh-app-server:1.5.6

**global.pullPolicy** and **pullPolicy**:

These settings control when
the image is pulled from the repository. ``Always`` means the image is
always pulled from the repository when a container is created from the
image, while ``IfNotPresent`` means that the image is pulled from the
repository only if the image is not already present on the host machine
where the container is being created. Typical ONAP OOM practice is to
set ``pullPolicy`` to ``Always`` in the chart. During development and
testing, this can be overriden during the Helm install with
``global.pullPolicy`` set to ``IfNotPresent``, to speed up deployment by
reducing the number of times images are pulled from the repository.

Example:

::

   pullPolicy: Always

**readinessCheck**:

Many microservices depend on having other services
up and running in the DCAE and ONAP environment–services like AAF to get
certificates or DMaaP to communicate with other services.
``readinessCheck.wait_for`` is a list of the *containers* that the
microservice needs to have available. If this parameter is present, an
initContainer will run and wait for all of the listed containers to
become ready. (Unfortunately, it’s necessary to know the name of a
*container*; it isn’t sufficient to list the name of a service.)

Example:

::

   readinessCheck:
     wait_for:
       - dcae-config-binding-service
       - aaf-cm

**readiness**:

If this parameter is present, a Kubernetes readiness
probe will be configured for the microservice. The template supports
either an HTTP(S) readiness probe or a script-based readiness probe. The
parameter has the following fields that apply to both types:

1. ``initialDelaySeconds``: The number of seconds to wait after container startup before attempting the first readiness probe. *[Optional, default 5]*
2. ``periodSeconds``: The number of seconds between readiness probes. *[Optional, default 15]*
3. ``timeoutSeconds``: The number of seconds to wait for a connection to the container before timing out. *[Optional, default 1]*
4. ``probeType``: The type of readiness probe–``httpGet`` for an HTTP probe or ``exec`` for a script-based probe. *[Optional, default ``httpGet``]*

For HTTP(S) readiness probes, the following fields are *required*:

1. ``scheme``: ``HTTP`` or ``HTTPS``
2. ``path``: the path to the readiness probe API endpoint on the container
3. ``port``: the *container port* on which the microservice is listening for readiness probe requests.
   (This is the *internal* port, not a NodePort or Ingress port.)

For script-based readiness probe, the following field is *required*:
 1. ``command``: an array consisting of the command to be executed to run
    the readiness probe and any command arguments that are needed.

Example (HTTP probe):

::

   readiness:
     initialDelaySeconds: 5
     periodSeconds: 15
     path: /heartbeat
     scheme: HTTP
     port: 8100

Example (script-based probe):

::

   readiness:
     type: exec
     initialDelaySeconds: 5
     periodSeconds: 15
     timeoutSeconds: 2
     command:
     - /opt/ves-hv-collector/healthcheck.sh

Variables used by the DCAE services common templates
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

**applicationConfig:**

*[Optional]*. Initial configuration for
microservice. Pushed into Consul for retrieval by config-binding-service
and mapped to a file mounted at ``/app-config``. This is a YAML object
with keys and values as needed for the specific microservice. It will be
converted to JSON before being pushed to Consul or mounted as a file. If
not present, defaults to an empty object ({}).

*Note: Due to a bug in the Honolulu release (DCAEGEN2-2782), it is
necessary to supply an ``applicationConfig`` in the ``values.yaml`` for
a microservice even if the microservice does not have any configuration.
The workaround is to supply an empty configuration:*

::

   applicationConfig: {}

*This is being fixed in the Istanbul release.*

**applicationEnv:**

Microservice-specific environment variables to be
set for the microservice’s container. Environment variables can be set
to literal string values or a value from a Kubernetes Secret that has
been set up using the ONAP OOM common secret template.

For a literal string value, use the environment variable name as the
key, and the desired string as the value:

::

   applicationEnv:
     EXAMPLE_ENV_VAR: "example variable content"

For a value taken from a secret, use the environment variable name as
the key and set the value to an object with the following fields:

1. ``secretUid``: *[Required]* The ``uid`` of the secret (set up with the
   ONAP OOM common secret template) from which the value will be taken.
2. ``key``: *[Required]* The key within the secret that holds the desired value.
   (A secret can contain several values, each with its own key. One frequently
   used form of secrets contains login credentials, with keys for username
   and password.)

Example of an environment variable set from a secret:

::

   applicationEnv:
     EXAMPLE_PASSWORD:
       secretUid: example-secret
       key: password

The ``applicationEnv`` section of ``values.yaml`` can contain an
arbitrary number of environment variables and can contain both literal
values and values from secrets. ``applicationEnv`` is optional. If it is
not present in the ``values.yaml`` file, no microservice-specific
environment variables will be set for the microservice’s container.

Note that ``applicationEnv`` is a YAML object (or “dictionary”), not an
array.

**externalVolumes:**

Controls microservice-specific volumes and volume
mounts. Allows a microservice to access an externally-created data
store. Currently only configMaps are supported. ``externalVolumes`` is a
YAML array of objects. Each object has three required fields and two
optional fields:

1. ``name``: *[Required]* The Kubernetes name of the configMap to be mounted.
   The value is a case sensitive string. Because the names of configMaps are
   sometimes set at deployment time (for instance, to prefix the Helm release to
   the name), the string can be a Helm template fragment that will be expanded
   at deployment time.
2. ``type``: *[Required]* For now, this is always ``configMap``. This is a
   case-insensitive string.
3. ``mountPath``: *[Required]* The path to the mount point for the volume
   in the container file system. The value is a case-sensitive string.
4. ``readOnly``: *[Optional]* Boolean flag. Set to ``true`` to mount the volume
   as read-only. Defaults to ``false``.
5. ``optional``: *[Optional]* Boolean flag. Set to ``true`` to make the
   configMap optional (i.e., to allow the microservice’s pod to start even
   if the configMap doesn’t exist). If set to ``false``, the configMap must
   be present in order for the microservice’s pod to start. Defaults to
   ``true``. *Note that this default is the opposite of the Kubernetes
   default. We’ve done this to be consistent with the behavior of the DCAE
   Cloudify plugin for Kubernetes (``k8splugin``), which always set
   ``optional`` to ``true`` and did not allow for overriding this value.*

Example of an ``externalVolumes`` section:

::

   externalVolumes:
     - name: my-example-configmap
       type: configmap
       mountPath: /opt/app/config
     - name: '{{ include "common.release" . }}-another-example'
       type: configmap
       mountPath: /opt/app/otherconfig

The dcaegen2-services-common deployment template will set up a volume
pointing to the specific configMap in the microservice’s pod and a
volume mount (mounted at ``mountPath`` on the microservice’s container.)

The ``externalVolumes`` section is optional. If it is not present, no
external volumes will be set up for the microservice.

**certDirectory:**

Path to the directory in the microservice’s
container file system where TLS-certificate information from AAF should
be mounted. This is an optional field. When it is present, the
dcaegen2-services-common deployment template will set up an
initContainer that retrieves the certificate information into a shared
volume, which will then be mounted at the path specified by
``certDirectory``.

Example:

::

   certDirectory: /etc/ves-hv/ssl

**tlsServer:**

Boolean flag. If set to ``true``, the
dcaegen2-services-common deployment will configure the initContainer
described above to fetch a server certificate for the microservice. If
set to ``false``, the initContainer will fetch only a CA certificate for
the AAF certificate authority. ``tlsServer`` is optional. The value
defaults to ``false``. ``tlsServer`` is ignored if ``certDirectory`` is
not set.

**logDirectory:**

Path to the directory where the microservice writes
its log files. ``logDirectory`` is optional. If ``logDirectory`` is
present, the dcaegen2-services-common deployment template will deploy a
sidecar container that forwards the log file content to a log server.

Example:

::

   logDirectory: /var/log/ONAP/dcae-hv-ves-collector

Note that ONAP is moving away from the sidecar approach and encouraging
applications (including DCAE microservices) to write log information to
``stdout`` and ``stderr``.

**policies:**

If present, the dcaegen2-services-common deployment
template will deploy a sidecar container that polls the ONAP policy
subsystem for policy-driven configuration information.

``policies`` is a YAML object (“dictionary”) that can contain the
following keys:

1. ``policyID``: *[Optional]* A string representation of a JSON array of policy ID
   values that the sidecar should monitor.   Default ‘[]’.
2. ``filter``: *[Optional]* A string representation of a JSON array of regular
    expressions that match policy IDs that the sidecar should monitory. Default ‘[]’.
3. ``duration``: *[Optional]* The interval (in seconds) between polling requests
   made by the sidecar to the policy subsystem. Default: 2600.

Example:

::

   policies:
     policyID: |
       '["onap.vfirewall.tca","abc"]'
     filter: |
       '["DCAE.Config_vfirewall_.*"]'
     duration: 300

**dcaePolicySyncImage:**

Name and tag of the policy sidecar image to be
used. Required if the policy sidecar is being used. The image repository
is set using the OOM common ``repositoryGenerator.repository`` template.
Normally this points to the ONAP image repository, but it can be
overridden on a global basis or a per-chart basis. See the OOM
documentation for more details.

Example:

::

   dcaePolicySyncImage: onap/org.onap.dcaegen2.deployments.dcae-services-policy-sync:1.0.1

**consulLoaderImage:**

Name and tag of the consul loader image to be
used. Required. The consul loader image runs in an initContainer that
loads application configuration information into Consul. The image
repository is set using the OOM common
``repositoryGenerator.repository`` template. Normally this points to the
ONAP image repository, but it can be overridden on a global basis or a
per-chart basis. See the OOM documentation for more details.

Example:

::

   consulLoaderImage: onap/org.onap.dcaegen2.deployments.consul-loader-container:1.1.0

**tlsImage:**

Name and tag of the TLS initialization image to be used.
Required if the microservice is configured to act as a TLS client and/or
server using AAF certificates. The TLS initialization image runs in an
initContainer and pulls TLS certificate information from AAF and stores
it in a volume on the microservice’s pod. The image repository is set
using the OOM common ``repositoryGenerator.repository`` template.
Normally this points to the ONAP image repository, but it can be
overridden on a global basis or a per-chart basis. See the OOM
documentation for more details.

Example:

::

   tlsImage: onap/org.onap.dcaegen2.deployments.tls-init-container:2.1.0

**certProcessorImage:**

Name and tag of the CMPv2 certificate
initialization image to be used. Required if the microservice is
configured to act as a TLS client and/or server using CMPv2
certificates. This image runs in an initContainer and sets up trust
stores and keystores for CMPv2 use. The image repository is set using
the OOM common ``repositoryGenerator.repository`` template. Normally
this points to the ONAP image repository, but it can be overridden on a
global basis or a per-chart basis. See the OOM documentation for more
details.

Example:

::

   onap/org.onap.oom.platform.cert-service.oom-certservice-post-processor:2.1.0


Deploying multiple instances of a microservice
----------------------------------------------
The dcaegen2-services-common charts can be used to deploy multiple instances of the same microservice.  To do this successfully,
it's necessary to make sure that any Kubernetes service that the microservice exposes has different service names for each instance and,
if the service is exposed outside the Kubernetes cluster, a different external port assignment.  This can be done by overriding the default
settings in the ``values.yaml`` file.

As an example, consider the DCAE VES collector (``dcae-ves-collector``).  One instance of the VES collector is deployed by default when DCAE is installed using the ONAP installation
process.  It exposes a service with the name ``dcae-ves-collector`` which is also exposed outside the Kubernetes cluster on NodePort 30417.

To deploy a second instance of the VES collector, we can create a YAML override file to define the service exposed by the second instance.  The following
override file (``ves2.yaml``) will name the service as ``dcae-ves-collector-2`` and expose it on port 30499:

::

  service:
    name: dcae-ves-collector-2
    ports:
      - name: http
        port: 8443
        plain_port: 8080
        port_protocol: http
        nodePort: 99
        useNodePortExt: true

In the directory containing the ``dcae-ves-collector`` chart and the file ``ves.yaml``, running the following command will deploy a second instance
of the VES collector:

``helm install -n onap --set global.masterPassword=whatever --set pullPolicy=IfNotPresent -f ves2.yaml ves2 .``

This creates a new Helm release called ``ves2``.   The instance can be removed with:

``helm delete -n onap ves2``

Note that if a component is using TLS with an AAF certificate, the DCAE certificate would need to include the new service name.
If a component is using an external certificate (CMPv2), the override file would need to supply the proper parameters to get a certificate with
correct common name/SAN.

Also note that if the chart for ``dcae-ves-collector`` has been pushed into a Helm repository, the ``helm install`` command can refer to the
repository (for instance, ``local/dcae-ves-collector``) instead of using the chart on the local filesystem.