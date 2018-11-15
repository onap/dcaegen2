.. This work is licensed under a Creative Commons Attribution 4.0 International License.
.. http://creativecommons.org/licenses/by/4.0
.. Copyright 2018 Tech Mahindra Ltd.

Mapping File
============

Mapping file is needed by Universal VES Adapter to convert the telemetry data into the VES format.
The Adapter uses Smooks Framework to do the data format conversion by using the mapping files.
Currently it requires to write the mapping file manually and upload it using the SnmpMapper application. The file gets stored into the postgres database. The pgInventory instance is used for this.

| To know more about smooks framework check the following link:
| http://www.smooks.org/guide

Following is the default snmp mapping file which is used when no mapping file is found while processing event from SNMP Trap Collector. 

.. code-block:: xml

 <?xml version="1.0"?>
    <smooks-resource-list
             xmlns="http://www.milyn.org/xsd/smooks-1.1.xsd"
            xmlns:json="http://www.milyn.org/xsd/smooks/json-1.1.xsd"
            xmlns:jb="http://www.milyn.org/xsd/smooks/javabean-1.4.xsd">
        <json:reader rootName="vesevent"  keyWhitspaceReplacement="-">
        <json:keyMap>
                   <json:key from="date&amp;time" to="date-and-time" />
                </json:keyMap>
          </json:reader>
     
       <jb:bean class="org.onap.dcaegen2.ves.domain.VesEvent" beanId="vesEvent" createOnElement="vesevent">
          <jb:wiring property="event" beanIdRef="event"/>
     </jb:bean>
  
       <jb:bean class="org.onap.dcaegen2.ves.domain.Event" beanId="event" createOnElement="vesevent">
           <jb:wiring property="commonEventHeader" beanIdRef="commonEventHeader"/>
           <jb:wiring property="faultFields" beanIdRef="faultFields"/>     
          <!--<jb:wiring property="measurementsForVfScalingFields" beanIdRef="measurementsForVfScalingFields"/> -->       
      </jb:bean>   
      <!--<jb:bean class="org.onap.dcaegen2.ves.domain.MeasurementsForVfScalingFields" beanId="measurementsForVfScalingFields" createOnElement="simple">
          <jb:wiring property="additionalMeasurements" beanIdRef="additionalMeasurements"/>
       </jb:bean>-->
       
       <jb:bean class="org.onap.dcaegen2.ves.domain.CommonEventHeader" beanId="commonEventHeader" createOnElement="vesevent">
                  <jb:expression property="version">"3.0"</jb:expression>
                   <jb:expression property="eventId">"XXXX"</jb:expression>
                   <jb:expression property="reportingEntityName">"VesAdapter"</jb:expression>
                  <jb:expression property="domain">"fault"</jb:expression>
                  <jb:expression property="eventName" execOnElement="vesevent" >commonEventHeader.domain+"_"+"_"+ faultFields.alarmCondition;</jb:expression>
          <jb:value property="sequence" data="0" default="0" decoder="Long"/>
           <jb:value property="lastEpochMicrosec" data="#/time-received"  decoder="Double" />
          <jb:value property="startEpochMicrosec" data="#/time-received"  decoder="Double"/>
                  <jb:expression property="priority">"Medium"</jb:expression>
          <jb:expression property="sourceName">"VesAdapter"</jb:expression>
      </jb:bean>   
      
      <jb:bean class="org.onap.dcaegen2.ves.domain.FaultFields" beanId="faultFields" createOnElement="vesevent">
           <jb:value property="alarmCondition" data="#/trap-category" />
                 <jb:expression property="eventSeverity">"MINOR"</jb:expression>
                   <jb:expression property="eventSourceType">"SNMP Agent"</jb:expression>
           <jb:expression property="specificProblem">"SNMP Fault"</jb:expression>
           <jb:value property="faultFieldsVersion" data="2.0" default="2.0" decoder="Double" />
          <jb:wiring property="alarmAdditionalInformation" beanIdRef="alarmAdditionalInformationroot"/>   
                  <jb:expression property="vfStatus">"Active"</jb:expression>
         
    </jb:bean>  
        <jb:bean class="java.util.ArrayList" beanId="alarmAdditionalInformationroot" createOnElement="vesevent">
         <jb:wiring beanIdRef="alarmAdditionalInformation"/>
      </jb:bean>
      
        <jb:bean class="org.onap.dcaegen2.ves.domain.AlarmAdditionalInformation" beanId="alarmAdditionalInformation" createOnElement="varbinds/element">
        <jb:value property="name" data="#/varbind_oid"/>
         <jb:value property="value" data="#/varbind_value" />
       </jb:bean>
          <!--<jb:bean class="java.util.ArrayList" beanId="additionalMeasurements" createOnElement="simple">
         <jb:wiring beanIdRef="additionalMeasurement"/>
       </jb:bean>    
      
       <jb:bean class="org.onap.dcaegen2.ves.domain.AdditionalMeasurement" beanId="additionalMeasurement" createOnElement="varbinds/element">
          <jb:value property="name" data="#/varbind_value" />
      </jb:bean>  -->  
      
  </smooks-resource-list>


