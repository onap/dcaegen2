.. This work is licensed under a Creative Commons Attribution 4.0 International License.
.. http://creativecommons.org/licenses/by/4.0

Troubleshooting Steps
=====================

To support K8S deployment, TCA is packaged using CDAP SDK as base container. Deployment of TCA is done using cloudify blueprint which gets executed part of DCAE bootstrap container during ONAP/DCAE installation. 

The logs for TCA are accessible through CDAP GUI which is exposed on 11011/http. To enable external cluster access, a K8S nodeport is required.

Prior to El-Alto release, 32010 nodeport was assigned by default to enable logs/validation. In El-Alto reason for security reasons,  nodeport is no longer enabled by default under ONAP/DCAE deployment.


Enable Nodeport
---------------

Following procedure can be used to enable nodeport for troubleshooting purpose.


Update existing TCA service to change the service type from ClusterIP to NodePort by editing service definition
    .. code-block:: bash

        kubectl edit services -n onap dcae-tca-analytics

* Change type from ClusterIP to NodePort
* Set nodePort: 32010
* Set externalTrafficPolicy: Cluster

Once modified, save and exit. K8s will redeploy the TCA service and nodeport 32010 will be available for access.

Following is an example

Original service definition  

    .. code-block:: bash

            spec:
              clusterIP: 10.43.62.180
              ports:
              - name: port-t-11011
                port: 11011
                protocol: TCP
                targetPort: 11011
              selector:
                app: dcae-tca-analytics
              sessionAffinity: None
              type: ClusterIP
            status:
              loadBalancer: {}


Modified service definition to expose NodePort

    .. code-block:: bash

            spec:
              clusterIP: 10.43.62.180
              externalTrafficPolicy: Cluster
              ports:
              - name: port-t-11011
                nodePort: 32010
                port: 11011
                protocol: TCP
                targetPort: 11011
              selector:
                app: dcae-tca-analytics
              sessionAffinity: None
              type: NodePort
            status:
              loadBalancer: {}



- Verify if updates done are reflected in K8S

        .. code-block:: bash

          kubectl get svc -n onap | grep dcae-tca-analytics
          dcae-tca-analytics          NodePort       10.43.62.180    <none>                                 11011:32010/TCP                       83


- CDAP GUI can now be accessed using **http://<k8snodeip>:32010**

- Verify if following TCA process are in "RUNNING" state under **http://<k8snodeip>:32010/oldcdap/ns/cdap_tca_hi_lo/apps/dcae-tca/overview/programs**

           * TCADMaaPMRPublisherWorker 
           * TCADMaaPMRSubscriberWorker
           * TCAVESCollectorFlow 


- Under each process, logs can be viewed (or downloaded) by clicking on "Logs" tab
