.. This work is licensed under a Creative Commons Attribution 4.0 International License.
.. http://creativecommons.org/licenses/by/4.0

Installation
============

VESCollector
------------

DCAE VES Collector can be configured on VM with ubuntu-16.04 image
(m1.small should suffice if this is only service) and 20Gb cinder
storage

1) Install docker

   sudo apt-get update
   sudo apt install docker.io

2) Pull the latest container from onap nexus

   sudo docker login -u docker -p docker nexus.onap.org:10001
   sudo docker pull
   nexus.onap.org:10001/onap/org.onap.dcaegen2.collectors.ves.vescollector:1.1

3) Start the VESCollector with below command

   Note: Change the dmaaphost to required DMAAP ip

   sudo docker run -d --name vescollector -p 8080:8080/tcp -p
   8443:8443/tcp -P -e DMAAPHOST='10.12.25.96'
   nexus.onap.org:10001/onap/org.onap.dcaegen2.collectors.ves.vescollector:1.1

   Note: To change the dmaap information for a running container, stop the active container and rerun above command changing the dmaap IP. 

4) Verification

   a. Check logs under container  /opt/app/VESCollector/logs/collector.log for errors
 
   b. If no active feed, you can simulate an event into collector via curl
      curl -i -X POST -d @<sampleves> --header "Content-Type:application/json" http://localhost:8080/eventListener/v5 -k

   c. Topic configuration are pre-set into this container. When valid DMAAP instance ip was provided and VES events are received, the collector will post to MEASUREMENT and FAULT Topics.
   Fault -  http://<dmaaphost>:3904/events/unauthenticated.SEC\_FAULT\_OUTPUT
   Measurement - http://<dmaaphost>:3904/events/unauthenticated.SEC\_MEASUREMENT\_OUTPUT

VM INIT
---------------
To address windriver server in-stability, the following init.sh script was used to start the container on VM restart. 

::
  #!/bin/sh
  sudo docker ps \| grep "vescollector"
  if [ $? -ne 0 ]; then
  sudo docker login -u docker -p docker nexus.onap.org:10001
  sudo docker pull
  nexus.onap.org:10001/onap/org.onap.dcaegen2.collectors.ves.vescollector:1.1
  sudo docker rm -f vescollector
  echo "Collector process not running - $(date)" >>
  /home/ubuntu/startuplog
  sudo docker run -d --name vescollector -p 8080:8080/tcp -p
    8443:8443/tcp -P -e DMAAPHOST='10.12.25.96'
    nexus.onap.org:10001/onap/org.onap.dcaegen2.collectors.ves.vescollector:1.1
  else
    echo "Collector process running - $(date)" >>/home/ubuntu/startuplog
    fi

::
    ln -s /home/ubuntu/init.sh /etc/init.d/init.sh
    sudo update-rc.d init.sh start 2
