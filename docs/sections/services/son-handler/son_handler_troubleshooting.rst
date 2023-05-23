.. This work is licensed under a
   Creative Commons Attribution 4.0 International License.
   http://creativecommons.org/licenses/by/4.0

Troubleshooting steps
---------------------

1. Microservice stops and restarts during startup

    Possible reasons & Solutions:
     1. Microservice is not registered with the consul
            - Check the consul if the microservice is registered with it and the MS is able to fetch the app config from the CBS. Check if CBS and consul are deployed properly and try to redeploy the MS

	The below logs will be seen if CBS is not reachable by the MS

  .. code-block:: none

        15:14:13.861 [main] WARN  org.postgresql.Driver - JDBC URL port: 0 not valid (1:65535)
	15:14:13.862 [main] WARN  o.s.b.w.s.c.AnnotationConfigServletWebServerApplicationContext - Exception encountered during context initialization - cancelling refresh attempt: org.springframework.beans.factory.UnsatisfiedDependencyException: Error creating bean with name 'org.springframework.boot.autoconfigure.orm.jpa.HibernateJpaConfiguration': Unsatisfied dependency expressed through constructor parameter 0; nested exception is org.springframework.beans.factory.BeanCreationException: Error creating bean with name 'dataSource' defined in org.onap.dcaegen2.services.sonhms.Application: Initialization of bean failed; nested exception is org.springframework.beans.factory.BeanCreationException: Error creating bean with name 'org.springframework.boot.autoconfigure.jdbc.DataSourceInitializerInvoker': Invocation of init method failed; nested exception is org.springframework.jdbc.datasource.init.UncategorizedScriptException: Failed to execute database script; nested exception is java.lang.RuntimeException: Driver org.postgresql.Driver claims to not accept jdbcUrl, jdbc:postgresql://null:0/sonhms
	15:14:13.865 [main] INFO  o.a.catalina.core.StandardService - Stopping service [Tomcat]
	15:14:13.877 [main] INFO  o.s.b.a.l.ConditionEvaluationReportLoggingListener - Error starting ApplicationContext. To display the conditions report re-run your application with 'debug' enabled.
	15:14:13.880 [main] ERROR o.s.boot.SpringApplication - Application run failed

    2. MS is not able to fetch the config policies from the policy handler.
            - Check if the config policy for the MS is created and pushed into the policy module. The below logs will be seen if the config policies are not available.

  .. code-block:: none

	2019-05-16 14:48:48.651  LOG <sonhms> [son_policy_widelm.create] INFO: latest policy for policy_id(com.Config_PCIMS_CONFIG_POLICY.1.xml) status(404) response: {}
	2019-05-16 14:48:49.661  LOG <sonhms> [son_policy_widelm.create] INFO: exit policy_get
	2019-05-16 14:48:49.661  LOG <sonhms> [son_policy_widelm.create] INFO: policy not found for policy_id com.Config_PCIMS_CONFIG_POLICY.1.xml
	2019-05-16 14:48:49.456  CFY <sonhms> [son_policy_widelm.create] Task succeeded 'dcaepolicyplugin.policy_get'
	2019-05-16 14:48:50.283  CFY <sonhms> [son_policy_widelm] Configuring node
	2019-05-16 14:48:50.283  CFY <sonhms> [son_policy_widelm] Configuring node
	2019-05-16 14:48:51.333  CFY <sonhms> [son_policy_widelm] Starting node
	2019-05-16 14:50:02.996  LOG <sonhms> [pgaasvm_fb20w3.create] WARNING: All done
	2019-05-16 14:50:02.902  CFY <sonhms> [pgaasvm_fb20w3.create] Task succeeded 'pgaas.pgaas_plugin.create_database'



Logging
-------

1. Logs can be found either from kubernetes UI or from kubectl. Since, the MS is deployed as a pod in the kubernetes, you can check the logs by using the command

  .. code-block:: bash

        kubectl logs <pod-name> --namespace onap
