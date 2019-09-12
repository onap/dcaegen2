.. This work is licensed under a Creative Commons Attribution 4.0 International License.
.. http://creativecommons.org/licenses/by/4.0

Troubleshoot
============

TCA application is deployed on CDAP SDK container; the installation is via a cloudify blueprint deployed by DCAE bootstrap process during ONAP/DCAE installation. The logs for TCA are accessible through CDAP GUI, which is exposed on 11011/http. To enabled external access, K8S nodeport is required.

Prior to El-Alto release, a nodeport 32010 was assigned in default deployment to enable logs/validation. In El-Alto reason for security reasons, the nodeport is no longer enabled by default in ONAP/DCAE deployments.


Enable Nodeport
---------------

Following procedure can be used to enable nodeport for troubleshooting purpose.


- Update existing TCA service to change the service type from ClusterIP to Nodeport by editing service definition
    .. code-block:: bash

        kubectl edit services -n onap dcae-tca-analytics

* Change type from ClusterIP to Nodeport
* Set nodePort: 32010
* Set externalTrafficPolicy: Cluster

Once modifed, save and exit. K8s will redeploy the TCA service and nodeport 32010 will be available for access.

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


Modified service definition to expose nodeport

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