Compiling TCA
=============

TCA code is maintained under https://gerrit.onap.org/r/#/admin/projects/dcaegen2/analytics/tca 
To build just the TCA component, run the following maven command
`mvn clean install`   

 
Maven GroupId
-------------

org.onap.dcaegen2.analytics.tca

Maven Parent ArtifactId
-----------------------
dcae-analytics

Maven Children Artifacts
------------------------
1. dcae-analytics-test: Common test code for all DCAE Analytics Modules
2. dcae-analytics-model: Contains models (e.g. Common Event Format) which are common to DCAE Analytics
3. dcae-analytics-common: Contains Components common to all DCAE Analytics Modules - contains high level abstractions
4. dcae-analytics-dmaap: DMaaP(Data Movement as a Platform) MR (Message Router)API using AAF(Authentication and Authorization Framework)
5. dcae-analytics-tca: DCAE Analytics TCA (THRESHOLD CROSSING ALERT) Core
6. dcae-analytics-cdap-common: Common code for all cdap modules
7. dcae-analytics-cdap-tca: CDAP Flowlet implementation for TCA
8. dcae-analytics-cdap-plugins: CDAP Plugins
9. dcae-analytics-cdap-it: Cucumber and CDAP Pipeline integration tests


API Endpoints
-------------

For deployment into CDAP,  following API's can be used to deploy TCA application.

# create namespace
curl -X PUT http://<k8s-clusterIP>:11015/v3/namespaces/cdap_tca_hi_lo

# load artifact
curl -X POST --data-binary @/c/usr/tmp/dcae-analytics-cdap-tca-2.0.0-SNAPSHOT.jar http://<k8s-clusterIP>:11015/v3/namespaces/cdap_tca_hi_lo/artifacts/dcae-analytics-cdap-tca

# create app
curl -X PUT -d @/c/usr/docs/ONAP/tca_app_config.json http://<k8s-clusterIP>:11015/v3/namespaces/cdap_tca_hi_lo/apps/dcae-tca

# load preferences
curl -X PUT -d @/c/usr/docs/ONAP/tca_app_preferences.json http://<k8s-clusterIP>:11015/v3/namespaces/cdap_tca_hi_lo/apps/dcae-tca/preferences

# start program
curl -X POST http://<k8s-clusterIP>:11015/v3/namespaces/cdap_tca_hi_lo/apps/dcae-tca/workers/TCADMaaPMRPublisherWorker/start
curl -X POST http://<k8s-clusterIP>:11015/v3/namespaces/cdap_tca_hi_lo/apps/dcae-tca/workers/TCADMaaPMRSubscriberWorker/start
curl -X POST http://<k8s-clusterIP>:11015/v3/namespaces/cdap_tca_hi_lo/apps/dcae-tca/flows/TCAVESCollectorFlow/start

# check status
curl http://<k8s-clusterIP>:11015/v3/namespaces/cdap_tca_hi_lo/apps/dcae-tca/workers/TCADMaaPMRPublisherWorker/status
curl http://<k8s-clusterIP>:11015/v3/namespaces/cdap_tca_hi_lo/apps/dcae-tca/workers/TCADMaaPMRSubscriberWorker/status
curl http://<k8s-clusterIP>:11015/v3/namespaces/cdap_tca_hi_lo/apps/dcae-tca/flows/TCAVESCollectorFlow/status

# Delete namespace (and all its content)
# curl -X DELETE http://<k8s-clusterIP>:11015/v3/unrecoverable/namespaces/cdap_tca_hi_lo

# Delete artifact
# curl -X DELETE http://<k8s-clusterIP>:11015/v3/namespaces/cdap_tca_hi_lo/artifacts/dcae-analytics-cdap-tca/versions/2.0.0.SNAPSHOT


TCA CDAP Container
------------------
If new jar is generated, corresponding version should be updated into https://git.onap.org/dcaegen2/deployments/tree/tca-cdap-container.

Following files should be revised
- tca_app_config.json
- tca_app_preferences.json
- restart.sh

