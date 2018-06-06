.. This work is licensed under a Creative Commons Attribution 4.0 International License.
.. http://creativecommons.org/licenses/by/4.0

Human Interfaces
================


DCAE provides a number of interfaces for users to interact with the DCAE system.

1. DCAE Bootstrap VM
    * The DCAE bootstrap VM accepts ssh connection with the standard access key.
    * After ssh into the VM, the DCAE bootstarp docker container can be access via "docker exec" command.

2. DCAE Clouify Manager
    * The DCAE Clouify Manager VM accepts ssh connection with the standard access key.  The access account is **centos** because this is a CentOS 7 VM.
    * The Cloudify Manager GUI can be accessed from http://{{CLOUDIFY_MANAGER_VM_IP}} .
    * The standard Cloudify command line CLI as specified here: http://cloudify.co/guide/3.2/cli-general.html .

3. DCAE Consul Cluster
    * The DCAE Consul Cluster VMs accept ssh connection with the standard access key.
    * The Consul GUI can be accessed from http://{{ANY_CONSUL_CLUSTER_VM_IP}}:8500 .
    * The standard Consul HTTP API as specified here: https://www.consul.io/api/index.html .
    * The standard Consul CLI access as specified here: https://www.consul.io/docs/commands/index.html .

4. DCAE Docket hosts
    * The DCAE Docker host VMs accept ssh connection with the standard access key.
    * After ssh into the VM, the running docker containers can be access via "docker exec" command.

5. DCAE CDAP
    * The CDAP VMs accept ssh connection with the standard access key.
    * The CDAP GUI can be accessed from http://{{CDAP02_VM_IP}}:11011 .


