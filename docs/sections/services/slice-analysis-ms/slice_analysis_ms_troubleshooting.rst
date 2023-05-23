.. This work is licensed under a
   Creative Commons Attribution 4.0 International License.
   http://creativecommons.org/licenses/by/4.0

Trouble shooting steps
----------------------
1. **Microservice stops and restarts during startup**

    Possible reason & Solution: Microservice is not registered with the consul 
     - Check the consul if the microservice is registered with it and the MS is able to fetch the app config from the CBS. Check if CBS and consul are   deployed properly and try to redeploy the MS
        The below logs will be seen if CBS is not reachable by the MS

       15:14:13.861 [main] WARN  org.postgresql.Driver - JDBC URL port: 0 not valid (1:65535) 
       15:14:13.862 [main] WARN  o.s.b.w.s.c.AnnotationConfigServletWebServerApplicationContext -
       Exception encountered during context initialization - cancelling refresh attempt: 
       org.springframework.beans.factory.UnsatisfiedDependencyException: Error creating bean with name
       'org.springframework.boot.autoconfigure.orm.jpa.HibernateJpaConfiguration': Unsatisfied
       dependency expressed through constructor parameter 0; nested exception is
       org.springframework.beans.factory.BeanCreationException: Error creating bean with name 'dataSource'
       defined in org.onap.dcaegen2.services. sliceanalysisms.Application: Initialization of bean failed;
       nested exception is org.springframework.beans.factory.BeanCreationException: Error creating bean with name
       'org.springframework.boot.autoconfigure.jdbc.DataSourceInitializerInvoker': Invocation of init method failed; nested exception is
       org.springframework.jdbc.datasource.init.UncategorizedScriptException: Failed to execute database script; nested exception is
       java.lang.RuntimeException: Driver org.postgresql.Driver claims to not accept jdbcUrl, jdbc:postgresql://null:0/sliceanalysisms
       15:14:13.865 [main] INFO  o.a.catalina.core.StandardService - Stopping service [Tomcat]
       15:14:13.877 [main] INFO  o.s.b.a.l.ConditionEvaluationReportLoggingListener - Error starting ApplicationContext.
       To display the conditions report re-run      your application with 'debug' enabled.
       15:14:13.880 [main] ERROR o.s.boot.SpringApplication - Application run failed

2. **No PostgreSQL clusters have been deployed on this manager**

   Solution:
   
    kubectl exec -ti -n onap dev-dcaemod-db-primary-56ff585cf7-dxkkx bash
    psql
    ALTER ROLE "postgres" WITH PASSWORD 'onapdemodb';
    \q

    kubectl exec -ti -n onap dev-dcae-bootstrap-b47854569-dnrqf bash
    cfy blueprints upload -b pgaas_initdb /blueprints/k8s-pgaas-initdb.yaml
    cfy deployments create -b pgaas_initdb -i k8s-pgaas-initdb-inputs.yaml pgaas_initdb
    cfy executions start -d pgaas_initdb install


Logging
-------
Since the Slice Analysis MS is deployed as a pod in the kubernetes, we can check the logs by
using the following command:

 $ kubectl logs <pod-name> -namespace onap
