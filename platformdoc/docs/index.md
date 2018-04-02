# DCAE Platform

## Welcome

This is the home for the documentation for the DCAE platform. 

* Details of the platform's architecture
* User guides for the different roles
    - [Component developers](components/intro.md)

## Background

DCAE is composed of a platform and services.  The DCAE platform is all of the technical pieces responsible for the deployment and the management of DCAE services.  The DCAE services are the components responsible for monitoring network services, and data collection and analytics.

Currently, the current DCAE Platform is a hybrid running both the 'classic (or old) controller' and what's commonly called the 'new controller'. 

### For 1710

The classic controller is deploying and managing all CDAP applications, and docker applications that were deployed prior to 1710.
All other docker applications are being deployed and mananged by the new controller.

### For 1802

The classic controller is deploying and managing all CDAP applications, and some docker applications that were deployed prior to 1710.
Some docker applications are being migrated from the classic to the new controller. All new docker applications are being deployed and mananged by the new controller.



## Contacts

Name | Email | Role
---- | ----- | ----
Dan Musgrove | dm4812@att.com | Lead
Shrinkant Acharya | sa8763@att.com | Systems Engineer
Kailas Deshmukh | kd046m@att.com | Technical Lead
Anurag Agarwal | aa0918@att.com | Cloudify Manager Support 
Henry Thorpe | ht1659@att.com | CDAP Broker Support
Hong Guan | hg4105@att.com | Clamp Integration Support
Ken Lehner | kl525c@att.com | Consul, Config Binding Service and Docker Container Support
Kuldeep Sharma | ks958r@att.com | DTI Topology VM, Docker Platform and CDAP Cluster Blueprint Support
Lisa Revel | lr0306@att.com | TOSCA Model Tool and Blueprint Generation 
Patty Heffner | ph8547@att.com | Onboarding to the DCAE Platform
Shadi Haidar | sh1986@att.com | DTI Handler, Deployment Handler, Inventory, and A&AI Broker Support
Sue Steele | ss477j@att.com | CDAP Platform Support
Swapna Anne | sa9226@att.com | Docker Plugins Support 
Terry Schmalzried | ts862m@att.com | Cloudify and CDAP Plugin Support
Tony Hansen | tony@att.com | Postgres Support
William Au | sa998j@att.com | Service Change Handler Support

