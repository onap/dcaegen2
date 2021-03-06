.. This work is licensed under a Creative Commons Attribution 4.0 International License.
.. http://creativecommons.org/licenses/by/4.0
.. _moduserguide:

===================
DCAE MOD User Guide
===================



-  `Types of Users and Usage
   Instructions: <#DCAEMODUserGuide(draft)-TypesofUsersand>`__

-  `1.    Deployment of DCAE MOD components via Helm
   charts <#DCAEMODUserGuide(draft)-1.DeploymentofD>`__

   -  `Using DCAE MOD without an Ingress
      Controller <#DCAEMODUserGuide(draft)-UsingDCAEMODwit>`__

-  `2.    Configuring DCAE
   mod <#DCAEMODUserGuide(draft)-2.ConfiguringDC>`__

-  `3.    Design & Distribution
   Flow <#DCAEMODUserGuide(draft)-3.Design&Distri>`__


Types of Users and Usage Instructions:
======================================

+-------+-----------------------------+-----------------------------+
| Sr.No | User                        | Usage Instructions          |
+=======+=============================+=============================+
| 1.    | Developers who are looking  | -        Access the Nifi    |
|       | to onboard their mS         | Web UI url provided to you  |
|       |                             |                             |
|       |                             | -        Follow steps  2.c  |
|       |                             | to 2.f                      |
|       |                             |                             |
|       |                             | -        You should be able |
|       |                             | to see your microservices   |
|       |                             | in the Nifi Web UI by       |
|       |                             | clicking and dragging       |
|       |                             | ‘Processor’ on the canvas,  |
|       |                             | and searching for the name  |
|       |                             | of the                      |
|       |                             | micros                      |
|       |                             | ervice/component/processor. |
+-------+-----------------------------+-----------------------------+
| 2.    | Designers who are building  | -        Access the Nifi    |
|       | the flows through UI and    | Web UI url provided to you  |
|       | triggering distribution     |                             |
|       |                             | -        Follow steps 3 to  |
|       |                             | the end of the document     |
+-------+-----------------------------+-----------------------------+
| 3.    | Infrastructure/ Admins who  | -        Follow start to    |
|       | want to stand up DCAE Mod   | the end                     |
|       | and validate it             |                             |
+-------+-----------------------------+-----------------------------+


1.    Deployment of DCAE MOD components via Helm charts
=======================================================

The DCAE MOD components are deployed using the standard ONAP OOM
deployment process.   When deploying ONAP using the helm deploy command,
DCAE MOD components are deployed when the dcaemod.enabled flag is set to
true, either via a --set option on the command line or by an entry in an
overrides file.  In this respect, DCAE MOD is no different from any
other ONAP subsystem.

The default DCAE MOD deployment relies on an nginx ingress controller
being available in the Kubernetes cluster where DCAE MOD is being
deployed.   The Rancher RKE installation process sets up a suitable
ingress controller.   In order to enable the use of the ingress
controller, it is necessary to override the OOM default global settings
for ingress configuration.   Specifically, the installation needs to set
the following configuration in an override file::
 
  ingress:
    enabled: true
    virtualhost:
      baseurl: "simpledemo.onap.org"

When DCAE MOD is deployed with an ingress controller, several endpoints
are exposed outside the cluster at the ingress controller's external IP
address and port.   (In the case of a Rancher RKE installation, there is
an ingress controller on every worker node, listening at the the
standard HTTP port (80).)  These exposed endpoints are needed by users
using machines outside the Kubernetes cluster.

+--------------+--------------------------------------------------+--------------------------+
| **Endpoint** | ** Routes to (cluster                            | **Description**          |
|              | internal address)**                              |                          |
+==============+==================================================+==========================+
| /nifi        | http://dcaemod-designtool:8080/nifi              | Design tool Web UI       |
|              |                                                  |                          |
+--------------+--------------------------------------------------+--------------------------+
| /nifi-api    | http://dcaemod-designtool:8080/nifi-api          | Design tool API          |
|              |                                                  |                          |
+--------------+--------------------------------------------------+--------------------------+
| /nifi-jars   | http://dcaemod-nifi-registry:18080/nifi-jars     | Flow registry listing of |
|              |                                                  | JAR files built from     |
|              |                                                  | component specs          |
+--------------+--------------------------------------------------+--------------------------+
| /onboarding  | http://dcaemod-onboarding-api:8080/onboarding    | Onboarding API           |
|              |                                                  |                          |
+--------------+--------------------------------------------------+--------------------------+
| /distributor | http://dcaemod-distributor-api:8080/distributor  | Distributor API          |
|              |                                                  |                          |
+--------------+--------------------------------------------------+--------------------------+

| To access the design Web UI, for example, a user would use the URL :
  http://*ingress_controller_address:ingress_controller_port*/nifi.
| *ingress_controller_address* is the the IP address or DNS FQDN of the
  ingress controller and
| *ingress_controller_port* is the port on which the ingress controller
  is listening for HTTP requests.  (If the port is 80, the HTTP default,
  then there is no need to specify a port.)

There are two additional *internal* endpoints that users need to know,
in order to configure a registry client and a distribution target in the
design tool's controller settings.

+------------------------+--------------------------------------------+
| **Configuration Item** | **Endpoint URL**                           |
+========================+============================================+
| Registry client        | http://dcaemod-nifi-registry:18080         |
+------------------------+--------------------------------------------+
| Distribution target    | http://dcaemod-runtime-api:9090            |
+------------------------+--------------------------------------------+

With Guilin release, OOM/ingress template has been updated to enable virtual host by default. 
All MOD API's and UI access via ingress should use dcaemod.simpledemo.onap.org.  

In order to access Design UI from local, add an entry for dcaemod.simpledemo.onap.org in /etc/hosts with the correct IP (any K8S node IP can be specified).


Using DCAE MOD without an Ingress Controller


Not currently supported


2.    Configuring DCAE mod
==========================

**a. Configure Nifi Registry url**

Next check Nifi settings by selecting the Hamburger button in the Nifi
UI. It should lead you to the Nifi Settings screen

|image16|

|image3|

Add a registry client. The Registry client url will be
http://dcaemod-nifi-registry:18080

|image4|


**b. Add distribution target which will be the runtime api url**

Set the distribution target in the controller settings

|image17|

Distribution target URL will be
`http://dcaemod-runtime-api:9090 <http://dcaemod-runtime-api:9090/>`__



Now let’s access the Nifi (DCAE designer) UI - http://dcaemod.simpledemo.onap.org/nifi

IPAddress is the host address or the DNS FQDN, if there is one, for one of the Kubernetes nodes.

|image0|


**c. Get the artifacts to test and onboard.**

Let's fetch the artifacts/ spec files 

**Component Spec for DCAE-VES-Collector :** https://git.onap.org/dcaegen2/collectors/ves/tree/dpo/spec/vescollector-componentspec.json

**Component Spec for DCAE-TCAgen2 :** https://git.onap.org/dcaegen2/collectors/ves/tree/dpo/spec/vescollector-componentspec.json

**VES 5.28.4 Data Format :** https://git.onap.org/dcaegen2/collectors/ves/tree/dpo/data-formats/VES-5.28.4-dataformat.json

**VES 7.30.2.1 Data Format :** https://git.onap.org/dcaegen2/collectors/ves/tree/etc/CommonEventFormat_30.2.1_ONAP.jsonormat.json

**VES Collector Response Data Format :** https://git.onap.org/dcaegen2/collectors/ves/tree/dpo/data-formats/ves-response.json

**TCA CL Data Format :** https://git.onap.org/dcaegen2/analytics/tca-gen2/tree/dcae-analytics/dpo/dcaeCLOutput.json


For the purpose of onboarding, a Sample Request body should be of the type -::

  { "owner": "<some value>", "spec": <some json object> }

where the json object inside the spec field can be a component spec json.

Request bodies of this type will be used in the onboarding requests you make using curl or the onboarding swagger interface.

**The prepared Sample Request body for a component dcae-ves-collector looks like
so –**

See :download:`VES Collector Spec <./Sample-Input-Files/Request-body-of-Sample-Component.json>`

**The prepared Sample request body for a sample data format  looks like so -**

See :download:`VES data Format <./Sample-Input-Files/Request-body-of-Sample-Data-Format.json>`



**d. To onboard a data format and a component**

Each component has a description that tells what it does.

These requests would be of the type

curl -X POST http://<onboardingapi host>/onboarding/dataformats     -H "Content-Type: application/json" -d
@<filepath to request>

curl -X POST http://<onboardingapi host>/onboarding/components     -H "Content-Type: application/json" -d
@<filepath to request>

In our case,

curl -X POST http://dcaemod.simpledemo.onap.org/onboarding/dataformats     -H "Content-Type: application/json" -d @<filepath to request>

curl -X POST http://dcaemod.simpledemo.onap.org/onboarding/components    -H "Content-Type: application/json" -d @<filepath to request>



**e. Verify the resources were created using**

curl -X GET http://<IPAddress>/onboarding/dataformats

curl -X GET http://<IPAddress>/onboarding/components

**f. Verify the genprocessor (which polls onboarding periodically to convert component specs to nifi processor), converted the component**

Open http://dcaemod.simpledemo.onap.org/nifi-jars in a browser.

These jars should now be available for you to use in the nifi UI as
processors

|image1|

3.    Design & Distribution Flow
================================


**a**. To start creating flows, we need to create a process group first. The
name of the process group will be the name of the flow. Drag and Drop on
the canvas, the ‘Processor Group’ icon from the DCAE Designer bar on the
top.

|image2|


Now enter the process group by double clicking it,

You can now drag and drop on the canvas ‘Processor’ icon from the top
DCAE Designer tab. You can search for a particular component in the
search box that appears when you attempt to drag the ‘Processor’ icon to
the canvas.

|image5|

If the Nifi registry linking worked, you should see the “Import” button
when you try to add a Processor or Process group to the Nifi canvas,
like so-

|image6|

By clicking on the import button, we can import already created saved
and version controlled flows from the Nifi registry, if they are
present.

|image7|

We can save created flows by version controlling them like so starting
with a 'right click' anywhere on the canvas-

|image8|

Ideally you would name the flow and process group the same, because
functionally they are similar.

|image9|

When the flow is checked in, the bar at the bottom shows a green
checkmark

|image10|

Note: Even if you move a component around on the canvas, and its
position on the canvas changes, it is recognized as a change, and it
will have to recommitted.

You can add additional components in your flow and connect them.

DcaeVesCollector connects to DockerTcagen2.

|image11|

|image12|

|image13|

Along the way you need to also provide topic names in the settings
section. These can be arbitrary names.

|image14|

To recap, see how DcaeVesCollector connects to DockerTcagen2. Look at
the connection relationships. Currently there is no way to validate
these relationships. Notice how it is required to name the topics by
going to Settings.

The complete flow after joining our components looks like so

|image15|


**b. Submit/ Distribute the flow:**

Once your flow is complete and saved in the Nifi registry, you can
choose to submit it for distribution.

|image18|

If the flow was submitted successfully to the runtime api, you should
get a pop up a success message like so -

|image19|

At this step, the design was packaged and sent to Runtime api.

The runtime is supposed to generate the blueprint out of the packaged
design/flow and push it to the DCAE inventory and the DCAE Dasboard.

**c. Checking the components in the DCAE Dashboard**

You should see the generated artifact/ blueprint in the DCAE Dashboard
dashboard at https://<IPAddress>:30418/ccsdk-app/login_external.htm in
our deployment. The name for each component will be appended by the flow
name followed by underscore followed by the component’s name.

The credentials to access the DCAE Dashboard 

Login: su1234
Password: fusion


|image20|

|image21|

|image22|

The generated Blueprint can be viewed.

|image23|

Finally, the generated Blueprint can be deployed.

|image24|

You can use/import the attached input configurations files to deploy. Drag and Drop these sample JSON files to fill in the configuration values.
See :download:`VES Collector Input Configuration <./Sample-Input-Files/ves-deploy.input.json>`
See :download:`Tcagen2 Input Configuration <./Sample-Input-Files/tca-deploy.input.json>`

|image25|

|image26|

.. |image0| image:: ../images/1.png
   :width: 6.5in
   :height: 1.08333in
.. |image1| image:: ../images/2.png
   :width: 6.5in
   :height: 1.58333in
.. |image2| image:: ../images/3.png
   :width: 5.83333in
   :height: 3.58333in
.. |image3| image:: ../images/4.png
   :width: 4.91667in
   :height: 2.16667in
.. |image4| image:: ../images/5.png
   :width: 6.5in
   :height: 2.66667in
.. |image5| image:: ../images/6.png
   :width: 6.5in
   :height: 3.33333in
.. |image6| image:: ../images/7.png
   :width: 4.91667in
   :height: 2.25in
.. |image7| image:: ../images/8.png
   :width: 4.91667in
   :height: 2.58333in
.. |image8| image:: ../images/9.png
   :width: 6.5in
   :height: 4.58333in
.. |image9| image:: ../images/10.png
   :width: 6.5in
   :height: 4in
.. |image10| image:: ../images/11.png
   :width: 4.91667in
   :height: 0.41667in
.. |image11| image:: ../images/12.png
   :width: 6.33333in
   :height: 3.16667in
.. |image12| image:: ../images/13.png
   :width: 6in
   :height: 2.66667in
.. |image13| image:: ../images/14.png
   :width: 6.5in
   :height: 3.41667in
.. |image14| image:: ../images/15.png
   :width: 6.5in
   :height: 3.58333in
.. |image15| image:: ../images/16.png
   :width: 6.5in
   :height: 2.25in
.. |image16| image:: ../images/17.png
   :width: 6.5in
   :height: 2.83333in
.. |image17| image:: ../images/18.png
   :width: 6.5in
   :height: 3.08333in
.. |image18| image:: ../images/19.png
   :width: 4.91667in
   :height: 1.91667in
.. |image19| image:: ../images/20.png
   :width: 4.91667in
   :height: 2.41667in
.. |image20| image:: ../images/21.png
   :width: 6.5in
   :height: 2.41667in
.. |image21| image:: ../images/22.png
   :width: 6.5in
   :height: 3in
.. |image22| image:: ../images/23.png
   :width: 6.5in
   :height: 2.16667in
.. |image23| image:: ../images/24.png
   :width: 6.5in
   :height: 2.83333in
.. |image24| image:: ../images/25.png
   :width: 6.5in
   :height: 3in
.. |image25| image:: ../images/26.png
.. |image26| image:: ../images/27.png

  
