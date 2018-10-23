.. This work is licensed under a Creative Commons Attribution 4.0 International License.
.. http://creativecommons.org/licenses/by/4.0

OpenStack Heat Orchestration Template Based DCAE Deployment
===========================================================

This document describes the details of the OpenStack Heat Orchestration Template deployment process and how to configure DCAE related parameters in the Heat template and its parameter file.


ONAP Deployment Overview
------------------------

ONAP R3 supports an OpenStack Heat template based system deployment.  The Heat Orchestration Template file and its parameter input file can be found under the **heat/ONAP** directory of the **demo** repo.  

When a new "stack" is created using the template, the following virtual resources will be launched in the target OpenStack tenant:

* A four-character alphanumerical random text string, to be used as the ID of the deployment.  It is denoted as {{RAND}} in the remainder of this document.
* A private OAM network interconnecting all ONAP VMs, named oam_onap_{{RAND}}.
* A virtual router interconnecting the private OAM network with the external network of the OpenStack installation.
* A key-pair named onap_key_{{RAND}}.
* A security group named onap_sg_{{RAND}}.
* A list of VMs for ONAP components. Each VM has one NIC connected to the OAM network and assigned a fixed IP. Each VM is also assigned a floating IP address from the external network. The VM hostnames are name consistently across different ONAP deployments, a user defined prefix, denoted as {{PREFIX}}, followed by a descriptive string for the ONAP component this VM runs, and optionally followed by a sub-function name.  In the parameter env file supplied when running the Heat template, the {{PREFIX}} is defined by the **vm_base_name** parameter.  The VMs of the same ONAP role across different ONAP deployments will always have the same OAM network IP address. For example, the Message Router will always have the OAM network IP address of 10.0.11.1.  


The list below provides the IP addresses and hostnames for ONAP components that are relevant to DCAE.

==============     ==========================    ==========================
ONAP Role          VM (Neutron) hostname          OAM IP address(s)
==============     ==========================    ==========================
A&AI               {{PREFIX}}-aai-inst1          10.0.1.1
SDC                {{PREFIX}}-sdc                10.0.3.1
DCAE               {{PREFIX}}-dcae               10.0.4.1
Policy             {{PREFIX}}-policy             10.0.6.1
SD&C               {{PREFIX}}-sdnc               10.0.7.1
Robot TF           {{PREFIX}}-robot              10.0.10.1
Message Router     {{PREFIX}}-message-router     10.0.11.1
CLAMP              {{PREFIX}}-clamp              10.0.12.1
Private DNS        {{PREFIX}}-dns-server         10.0.100.1
==============     ==========================    ==========================

(Each of the above VMs will also be associated with a floating IP address from the external network.)


DCAE Deployment
---------------

Within the Heat template yaml file, there is a section which specifies the DCAE VM as a "service".  Majority of the service block is the script that the VM will execute after being launched.  This is known as the "cloud-init" script.  This script writes configuration parameters to VM disk files under the /opt/config directory of the VM file system, one parameter per file, with the file names matching with the parameter names.  At the end, the cloud-init script invokes DCAE's installtioan script dcae2-install.sh, and DCAE deployment script dcae2_vm_init.sh.  While the dace2_install.sh script installs the necessary software packages, the dcae2_vm_init.sh script actually deploys the DCAE Docker containers to the DCAE VM.  

Firstly, during the execution of the dcae2_vm_init.sh script, files under the **heat** directory of the **dcaegen2/deployments** repo are downloaded and any templates in these files referencing the configuration files under the /opt/config directories are expanded by the contents of the corresponding files.  For example, a template of {{ **dcae_ip_addr** }} is replaced with the contents of the file /opt/config/**dcae_ip_addr**.txt file.  The resultant files are placed under the /opt/app/config directory of the DCAE VM file system.  

In addition, the dcae2_vm_init.sh script also calls the scripts to register the components with Consul about their health check APIs, and their default configurations.

Next, the dcae2_vm_init.sh script deploys the resources defined in the docker-compose-1.yaml and docker-compose-2.yaml files, with proper waiting in between to make sure the resource in docker-compose-1.yaml file have entered ready state before deploying the docker-compose-2.yaml file because the formers are the dependencies of the latter.  These resources are a number of services components and their minimum supporting platform components (i.e. Consul server and Config Binding Service).  With these resources, DCAE is able to provide a minimum configuration that supports the ONAP R2 use cases, namely, the vFW/vDNS, vCPE, cVoLTE use cases.  However, lacking the DCAE full platform, this configuration does not support CLAMP and Policy update from Policy Framework.  The only way to change the configurations of the service components (e.g. publishing to a different DMaaP topic) can only be accomplished by changing the value on the Consul for the KV of the service component, using Consul GUI or API call.

For more complete deployment, the dcae2_vm_init.sh script further deploys docker-compose-3.yaml file, which deploys the rest of the DCAE platform components, and if configured so docker-compose-4.yaml file, which deploys DCAE R3 stretch goal service components such as PRH, Missing Heartbeat,HV-VES, DataFile etc.

After all DCAE components are deployed, the dcae2_vm_init.sh starts to provide health check results.  Due to the complexity of the DCAE system, a proxy is set up for returning a single binary result for DCAE health check instead of having each individual DCAE component report its health status.  To accomplish this, the dcae2_vm_init.sh script deploys a Nginx reverse proxy then enters an infinite health check loop.  

During each iteration of the loop, the script checks Consul's service health status API and compare the received healthy service list with a pre-determined list to assess whether the DACE system is healthy.  The list of services that must be healthy for the DCAE system to be assessed as healthy depends on the deployment profile which will be covered in the next subsection.  For example, if the deployment profile only calls for a minimum configuration for passing use case data, whether DCAE platform components such as Deployment Handler are heathy does not affect the result.  

If the DCAE system is considered healthy, the dcae2_vm_init.sh script will generate a file that lists all the healthy components and the Nginx will return this file as the body of a 200 response for any DCAE health check.  Otherwise, the Nginx will return a 404 response.


Heat Template Parameters
------------------------

In DCAE R3, the configuration for DCAE deployment in Heat is greatly simplified.  In addition to paramaters such as docker container image tags, the only parameter that configures DCAE deployment behavior is dcae_deployment_profiles.

* dcae_deployment_profile: the parameter determines which DCAE components (containers) will be deployed.  The following profiles are supported for R2:
    * R3MVP: This profile includes a minimum set of DACE components that will support the vFW/vDNS, vCPE. and vVoLTE use cases.  It will deploy the following components: 
        * Consul server,
        * Config Binding Service,
        * Postgres database,
        * VES collector
        * TCA analytics
        * Holmes rule management
        * Holmes engine management.
    * R3: This profile also deploys the rest of the DCAE platform.  With R3 deployment profile, DCAE supports CLAMP and full control loop functionalities.  These additional components are:
        * Cloudify Manager,
        * Deployment Handler,   
        * Policy Handler,
        * Service Change Handler,
        * Inventory API.
    * R3PLUS: This profile deploys the DCAE R2 stretch goal service components, namely:
        * PNF Registration Handler,
        * SNMP Trap collector,
        * HV-VES Collector
        * Missing Heartbeat Detection analytics,
        * Universal Mapper


Tips for Manual Interventions
-----------------------------

During DCAE deployment, there are several places where manual interventions are possible:

* Running dcae2_install.sh
* Running dcae2_vm_init.sh
* Individual docker-compose-?.yaml file

All these require ssh-ing into the dcae VM, then change directory or /opt and sudo.  
Configurations injected from the Heat template and cloud init can be found under /opt/config.
DCAE run time configuration values can be found under /opt/app/config.  After any parameters are changed, the dcae2_vm_init.sh script needs to be rerun.

Redpeloying/updating resources defines in docker-compose-?.yaml files can be achieved by running the following:

   $ cd /opt/app/config
   $ /opt/docker/docker-compose -f ./docker-compose-4.yaml down
   $ /opt/docker/docker-compose -f ./docker-compose-4.yaml up -d


Some manual interventions may also require interaction with the OpenStack environment.  This can be 
done by using the OpenStack CLI tool.  OpenStack CLI tool comes very handy for various uses in deployment and maintenance of ONAP/DCAE.  

It is usually most convenient to install OpenStack CLI tool in a Python virtual environment.  Here are the steps and commands::

    # create and activate the virtual environment, install CLI
    $ virtualenv openstackcli
    $ . openstackcli/bin/activate
    $ pip install --upgrade pip python-openstackclient python-designateclient python-novaclient python-keystoneclient python-heatclient

    # here we need to download the RC file form OpenStack dashboard: 
    # Compute->Access & Security_>API Aceess->Download OpenStack RC file 

    # activate the environment variables with values point to the taregt OpenStack tenant
    (openstackcli) $ . ./openrc.sh
    
Now we are all set for using OpenStack cli tool to run various commands.  For example::

    # list all tenants
    (openstackcli) $ openstack project list

Finally to deactivate from the virtual environment, run::

    (openstackcli) $ deactivate
 

