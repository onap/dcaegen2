.. This work is licensed under a Creative Commons Attribution 4.0 International License.
.. http://creativecommons.org/licenses/by/4.0

Logging
=======

DCAE logging is available in several levels.

Platform VM Logging
-------------------
1. DCAE bootstrap VM: 
    * /var/log directory containing various system logs including cloud init logs.
    * /tmp/dcae2_install.log file provided installation logs.
    * **docker logs** command for DCAE bootstrap container logs.
2. Cloudify Manager VM: 
    * /var/log directory containing various system logs including cloud init logs.
    * Cloudify Manager GUI provides viewing access to Cloudify's operation logs.
3. Consul cluster: 
    * /var/log directory containing various system logs including cloud init logs.
    * Consul GUI provides viewing access to Consul registered platform and service components healthcheck logs.
4. Docker hosts
    * /var/log directory containing various system logs including cloud init logs.
    * **docker logs** command for Docker container logs.


Component Logging
-----------------

In general the logs of service component can be accessed under the /opt/log directory of the container, either the Docker container or the VM.  Their deployment logs can be found at the deployment engine and deployment location, e.g. Cloudify Manager, CDAP, and Docker hosts.  

