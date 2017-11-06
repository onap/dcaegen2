OpenStack Heat Template Based ONAP Deployment
=============================================

For ONAP R1, ONAP is deployed using OpenStack Heat template.  DCAE is also deployed through this process.  This document describes the details of the Heat template deployment process and how to configure DCAE related parameters in the Heat template and its parameter file.


ONAP Deployment 
---------------

ONAP supports an OpenStack Heat template based system deployment.  When a new "stack" is created using the template, the following virtual resources will be launched in the target OpenStack tenant:

* A four-character alphanumerical random text string, to be used as the ID of the deployment.  It is denoted as {{RAND}} in the remainder of this document.
* A private OAM network interconnecting all ONAP VMs, named oam_onap_{{RAND}}.
* A virtual router interconnecting the private OAM network with the external network of the OpenStack installation.
* A key-pair named onap_key_{{RAND}}.
* A security group named onap_sg_{{RAND}}.
* A list of VMs for ONAP components.  Each VM has one NIC connected to the OAM network and assigned a fixed IP.  Each VM is also assigned a floating IP address from the external network.  The VM hostnames are name consistently across different ONAP deployments, a user defined prefix, denoted as {{PREFIX}}, followed by a descriptive string for the ONAP component this VM runs, and optionally followed by a sub-function name.  The VMs of the same ONAP role across different ONAP deployments will always have the same OAM network IP address.  For example, the Message Router will always have the OAM network IP address of 10.0.11.1. 

    ==============     ==========================    ==========================
    ONAP Role          VM (Neutron) hostname          OAM IP address(s)
    ==============     ==========================    ==========================
    A&AI               {{PREFIX}}-aai-inst1          10.0.1.1
    A&AI               {{PREFIX}}-aai-inst2          10.0.1.2
    APPC               {{PREFIX}}-appc               10.0.2.1
    SDC                {{PREFIX}}-sdc                10.0.3.1
    DCAE               {{PREFIX}}-dcae-bootstrap     10.0.4.1
    SO                 {{PREFIX}}-so                 10.0.5.1
    Policy             {{PREFIX}}-policy             10.0.6.1
    SD&C               {{PREFIX}}-sdnc               10.0.7.1
    VID                {{PREFIX}}-vid                10.0.8.1
    Portal             {{PREFIX}}-portal             10.0.9.1
    Robot TF           {{PREFIX}}-robot              10.0.10.1
    Message Router     {{PREFIX}}-message-router     10.0.11.1
    CLAMP              {{PREFIX}}-clamp              10.0.12.1
    MultiService       {{PREFIX}}-multi-service      10.0.14.1
    Private DNS        {{PREFIX}}-dns-server         10.0.100.1
    ==============     ==========================    ==========================

* A list of DCAE VMs, launched by the {{PREFIX}}-dcae-bootstrap VM.  These VMs are also connected to the OAM network and associated with floating IP addresses on teh external network.  What's different is that their OAM IP addresses are DHCP assigned, not statically assigned.  The table below lists the DCAE VMs that are deployed for R1 use stories.

    =====================     ============================    
    DCAE Role                 VM (Neutron) hostname(s)     
    =====================     ============================   
    Cloudify Manager          {{DCAEPREFIX}}orcl{00}
    Consul cluster            {{DCAEPREFIX}}cnsl{00-02}
    Platform Docker Host      {{DCAEPREFIX}}dokp{00}
    Service Docker Host       {{DCAEPREFIX}}dokp{00}
    CDAP cluster              {{DCAEPREFIX}}cdap{00-06}
    Postgres                  {{DCAEPREFIX}}pgvm{00}
    =====================     ============================   

DNS
===

ONAP VMs deployed by Heat template are all registered with the private DNS server under the domain name of **simpledemo.onap.org**.  This domain can not be exposed to any where outside of the ONAP deployment because all ONAP deployments use the same domain name and same address space.  Hence these host names remain only resolvable within the same ONAP deployment. 

On the other hand DCAE VMs, although attached to the same OAM network as the rest of ONAP VMs, all have dynamic IP addresses allocated by the DHCP server and resort to a DNS based solution for registering the hostname and IP address mapping.  DCAE VMs of different ONAP deployments are registered under different zones named as **{{RAND}}.dcaeg2.onap.org**.  The API that DCAE calls to request the DNS zone registration and record registration is provided by OpenStack's DNS as a Service technology Designate.  

To enable VMs spun up by ONPA Heat template and DCAE's bootstrap process communicate with each other using hostnames, all VMs are configured to use the private DNS server launched by the Heat template as their name resolution server.  In the configuration of this private DNS server, the DNS server that backs up Designate API frontend is used as the DNS forwarder. 

For simpledemo.onap.org VM to simpledemo.onap.org VM communications and {{RAND}}.dcaeg2.onap.org VM to simpledemo.onap.org VM communications, the resolution is completed by the private DNS server itself.  For simpledemo.onap.org VM to {{RAND}}.dcaeg2.onap.org VM communications and {{RAND}}.dcaeg2.onap.org VM to {{RAND}}.dcaeg2.onap.org VM communications, the resolution request is forwarded from the private DNS server to the Designate DNS server and resolved there.  Communications to outside world are resolved also by the Designate DNS server if the hostname belongs to a zone registered under the Designate DNS server, or forwarded to the next DNS server, either an organizational DNS server or a DNS server even higher in the global DNS server hierarchy. 

For OpenStack installations where there is no existing DNS service, a "proxyed" Designate solution is supported.  In this arrangement, DCAE bootstrap process will use MultiCloud service node as its Keystone API endpoint.  For non Designate API calls, the MultiCloud service node forwards to the underlying cloud provider.  However, for Designate API calls, the MultiCloud service node forwards to an off-stack Designate server.  

Heat Template Parameters
========================

Here we list Heat template parameters that are related to DCAE operation.  Bold values are the default values that should be used "as-is".

* public_net_id: the UUID of the external network where floating IPs are assigned from.  For example: 971040b2-7059-49dc-b220-4fab50cb2ad4
* public_net_name: the name of the external network where floating IPs are assigned from.  For example: external
* openstack_tenant_id: the ID of the OpenStack tenant/project that will host the ONPA deployment.  For example: dd327af0542e47d7853e0470fe9ad625.
* openstack_tenant_name: the name of the OpenStack tenant/project that will host the ONPA deployment.  For example: Integration-SB-01.
* openstack_username: the username for accessing the OpenStack tenant specified by openstack_tenant_id/ openstack_tenant_name.
* openstack_api_key: the password for accessing the OpenStack tenant specified by openstack_tenant_id/ openstack_tenant_name.
* openstack_auth_method: **password**
* openstack_region: **RegionOne**
* cloud_env: **openstack**
* dns_forwarder:  This is the DNS forwarder for the ONAP deployment private DNS server.  It must point to the IP address of the Designate DNS.  For example '10.12.25.5'. 
* dcae_ip_addr: **10.0.4.1**.  The static IP address on the OAM network that is assigned to the DCAE bootstraping VM.
* dnsaas_config_enabled: Whether a proxy-ed Designate solution is used.  For example: **true**.
* dnsaas_region: The region of the Designate providing OpenStack.  For example: RegionOne
* dnsaas_tenant_name: The tenant/project name of the Designate providing OpenStack. For example Integration-SB-01.
* dnsaas_keystone_url: The keystone URL of the Designate providing OpenStack. For example http://10.12.25.5:5000/v3.
* dnsaas_username: The username for accessing the Designate providing OpenStack. 
* dnsaas_password: The password for accessing the Designate providing OpenStack. 
* dcae_keystone_url: This is the API endpoint for MltiCloud service node.  **"http://10.0.14.1/api/multicloud-titanium_cloud/v0/pod25_RegionOne/identity/v2.0"**
* dcae_centos_7_image: The name of the CentOS-7 image.
* dcae_domain: The domain under which ONAP deployment zones are registered. For example: 'dcaeg2.onap.org'.
* dcae_public_key: the public key of the onap_key_{{RAND}} key-pair.
* dcae_private_key: The private key of the onap_key_{{RAND}} key-pair (put a literal \n at the end of each line of text).

Heat Deployment
===============

Heat template can be deployed using the OpenStack CLI.  For more details, please visit the demo project of ONAP.  All files references in this secton can be found under the **demo** project.

In the Heat template file **heat/ONAP/onap_openstack.yaml** file, there is one block of sepcification towrads the end of the file defines the dcae_bootstrap VM.  This block follows the same approach as other VMs defined in the same template.  That is, a number of parameters within the Heat context, such as the floating IP addresses of the VMs and parameters provided in the user defined parameter env file, are written to disk files under the /opt/config directory of the VM during cloud init time.  Then a script, found under the **boot** directory of the **demo** project, **{{VMNAME}}_install.sh**, is called to prepare the VM.  At the end of running this script, another script **{VMNAME}}_vm_init.sh** is called.

For DCAE bootstrap VM, the dcae2_vm_init.sh script completes the following steps:

* If we use proxy-ed Designate solution, runs:
    * Wait for A&AI to become ready
    * Register MultiCloud proxy information into A&AI
    * Wait for MultiCloud proxy node ready
    * Register the DNS zone for the ONAP installation, **{{RAND}}.dcaeg2.onap.org**
* Runs DCAE bootstrap docker container
    * Install Cloudify locally
    * Launch the Cloudify Manager VM
    * Launch the Consul cluster
    * Launch the platform component Docker host
    * Launch the service component Docker host
    * Launch the CDAP cluster
    * Install Config Binding Service onto platform component Docker host
    * Launch the Postgres VM
    * Install Platform Inventory onto platform component Docker host
    * Install Deployment Handler onto platform component Docker host
    * Install Policy Handler onto platform component Docker host
    * Install CDAP Broker onto platform component Docker host
    * Install VES collector onto service component Docker host
    * Install TCA analytics onto CDAP cluster
    * Install Holmes Engine onto service component Docker host
    * Install Holmes Rules onto service component Docker host
* Starts a Nginx docker container to proxy the healthcheck API to Consul
* Enters a infinite sleep loop to keep the bootstrap container up


