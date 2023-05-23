.. This work is licensed under a Creative Commons Attribution 4.0 International License.
.. http://creativecommons.org/licenses/by/4.0
.. Copyright 2018-2019 Tech Mahindra Ltd.

Mapping File
============

Mapping file is needed by Universal VES Adapter to convert the telemetry data into the VES format.
The Adapter uses Smooks Framework to do the data format conversion by using the mapping files.

| To know more about smooks framework check the following link:
| http://www.smooks.org/guide

SNMP Collector Default Mapping File
===================================
Following is the default snmp mapping file which is used when no mapping file is found while processing event from SNMP Trap Collector.

.. code-block:: xml

 <?xml version="1.0" encoding="UTF-8"?><smooks-resource-list xmlns="http://www.milyn.org/xsd/smooks-1.1.xsd" xmlns:jb="http://www.milyn.org/xsd/smooks/javabean-1.4.xsd" xmlns:json="http://www.milyn.org/xsd/smooks/json-1.1.xsd">
   <json:reader rootName="vesevent" keyWhitspaceReplacement="-">
      <json:keyMap>
         <json:key from="date&amp;time" to="date-and-time" />
      </json:keyMap>
   </json:reader>
   <jb:bean class="org.onap.dcaegen2.ves.domain.ves54.VesEvent" beanId="vesEvent" createOnElement="vesevent">
      <jb:wiring property="event" beanIdRef="event" />
   </jb:bean>
   <jb:bean class="org.onap.dcaegen2.ves.domain.ves54.Event" beanId="event" createOnElement="vesevent">
      <jb:wiring property="commonEventHeader" beanIdRef="commonEventHeader" />
      <jb:wiring property="faultFields" beanIdRef="faultFields" />
   </jb:bean>
   <jb:bean class="org.onap.dcaegen2.ves.domain.ves54.CommonEventHeader" beanId="commonEventHeader" createOnElement="vesevent">
      <jb:expression property="version">'3.0'</jb:expression>
      <jb:expression property="eventType">'FaultField'</jb:expression>
      <jb:expression property="eventId" execOnElement="vesevent">'XXXX'</jb:expression>
      <jb:expression property="reportingEntityName">'VESMapper'</jb:expression>
      <jb:expression property="domain">org.onap.dcaegen2.ves.domain.ves54.CommonEventHeader.Domain.FAULT</jb:expression>
      <jb:expression property="eventName" execOnElement="vesevent">commonEventHeader.domain</jb:expression>
      <jb:value property="sequence" data="0" default="0" decoder="Long" />
      <jb:value property="lastEpochMicrosec" data="#/time-received" />
      <jb:value property="startEpochMicrosec" data="#/time-received" />
      <jb:expression property="priority">org.onap.dcaegen2.ves.domain.ves54.CommonEventHeader.Priority.NORMAL</jb:expression>
      <jb:expression property="sourceName">'VesAdapter'</jb:expression>
   </jb:bean>
   <jb:bean class="org.onap.dcaegen2.ves.domain.ves54.FaultFields" beanId="faultFields" createOnElement="vesevent">
      <jb:value property="faultFieldsVersion" data="2.0" default="2.0" decoder="Double" />
      <jb:value property="alarmCondition" data="#/trap-category" />
      <jb:expression property="specificProblem">'SNMP Fault'</jb:expression>
      <jb:expression property="vfStatus">org.onap.dcaegen2.ves.domain.ves54.FaultFields.VfStatus.ACTIVE</jb:expression>
      <jb:expression property="eventSeverity">org.onap.dcaegen2.ves.domain.ves54.FaultFields.EventSeverity.MINOR</jb:expression>
      <jb:wiring property="alarmAdditionalInformation" beanIdRef="alarmAdditionalInformationroot" />
   </jb:bean>
   <jb:bean class="java.util.ArrayList" beanId="alarmAdditionalInformationroot" createOnElement="vesevent">
      <jb:wiring beanIdRef="alarmAdditionalInformation" />
   </jb:bean>
   <jb:bean class="org.onap.dcaegen2.ves.domain.ves54.AlarmAdditionalInformation" beanId="alarmAdditionalInformation" createOnElement="varbinds/element">
      <jb:value property="name" data="#/varbind_oid" />
      <jb:value property="value" data="#/varbind_value" />
   </jb:bean></smooks-resource-list>

RestConf Collector Default Mapping File
=======================================

Following is the default RestConf collector mapping file which is used when no mapping file is found while processing notification from RestConf Collector.

.. code-block:: xml

 <?xml version="1.0" encoding="UTF-8"?><smooks-resource-list xmlns="http://www.milyn.org/xsd/smooks-1.1.xsd" xmlns:jb="http://www.milyn.org/xsd/smooks/javabean-1.4.xsd" xmlns:json="http://www.milyn.org/xsd/smooks/json-1.1.xsd">
   <json:reader rootName="vesevent" keyWhitspaceReplacement="-">
      <json:keyMap>
         <json:key from="date&amp;time" to="date-and-time" />
      </json:keyMap>
   </json:reader>
   <jb:bean class="org.onap.dcaegen2.ves.domain.ves70.VesEvent" beanId="vesEvent" createOnElement="vesevent">
      <jb:wiring property="event" beanIdRef="event" />
   </jb:bean>
   <jb:bean class="org.onap.dcaegen2.ves.domain.ves70.Event" beanId="event" createOnElement="vesevent">
      <jb:wiring property="commonEventHeader" beanIdRef="commonEventHeader" />
      <jb:wiring property="pnfRegistrationFields" beanIdRef="pnfRegistrationFields" />
   </jb:bean>
   <jb:bean class="org.onap.dcaegen2.ves.domain.ves70.CommonEventHeader" beanId="commonEventHeader" createOnElement="vesevent">
      <jb:expression property="version">org.onap.dcaegen2.ves.domain.ves70.CommonEventHeader.Version._4_0_1</jb:expression>
      <jb:expression property="eventType">'pnfRegistration'</jb:expression>
      <jb:expression property="vesEventListenerVersion">org.onap.dcaegen2.ves.domain.ves70.CommonEventHeader.VesEventListenerVersion._7_0_1</jb:expression>
      <jb:expression property="eventId" execOnElement="vesevent">'registration_'+commonEventHeader.ts1</jb:expression>
      <jb:expression property="reportingEntityName">'VESMapper'</jb:expression>
      <jb:expression property="domain">org.onap.dcaegen2.ves.domain.ves70.CommonEventHeader.Domain.PNF_REGISTRATION</jb:expression>
      <jb:expression property="eventName" execOnElement="vesevent">commonEventHeader.domain</jb:expression>
      <jb:value property="sequence" data="0" default="0" decoder="Long" />
      <jb:expression property="lastEpochMicrosec" execOnElement="vesevent">commonEventHeader.ts1</jb:expression>
      <jb:expression property="startEpochMicrosec" execOnElement="vesevent">commonEventHeader.ts1</jb:expression>
      <jb:expression property="priority">org.onap.dcaegen2.ves.domain.ves70.CommonEventHeader.Priority.NORMAL</jb:expression>
      <jb:expression property="sourceName" execOnElement="vesevent">pnfRegistrationFields.vendorName+'-'+pnfRegistrationFields.serialNumber</jb:expression>
   </jb:bean>
   <jb:bean class="org.onap.dcaegen2.ves.domain.ves70.PnfRegistrationFields" beanId="pnfRegistrationFields" createOnElement="vesevent">
      <jb:expression property="pnfRegistrationFieldsVersion">org.onap.dcaegen2.ves.domain.ves70.PnfRegistrationFields.PnfRegistrationFieldsVersion._2_0</jb:expression>
      <jb:value property="serialNumber" data="pnfRegistration/serialNumber" />
      <jb:value property="lastServiceDate" data="pnfRegistration/lastServiceDate" />
      <jb:value property="manufactureDate" data="pnfRegistration/manufactureDate" />
      <jb:value property="modelNumber" data="pnfRegistration/modelNumber" />
      <jb:value property="oamV4IpAddress" data="pnfRegistration/oamV4IpAddress" />
      <jb:value property="oamV6IpAddress" data="pnfRegistration/oamV6IpAddress" />
      <jb:value property="softwareVersion" data="pnfRegistration/softwareVersion" />
      <jb:value property="unitFamily" data="pnfRegistration/unitFamily" />
      <jb:value property="unitType" data="pnfRegistration/unitType" />
      <jb:value property="vendorName" data="pnfRegistration/vendorName" />
      <jb:wiring property="additionalFields" beanIdRef="alarmAdditionalInformation" />
   </jb:bean>
   <jb:bean class="org.onap.dcaegen2.ves.domain.ves70.AlarmAdditionalInformation" beanId="alarmAdditionalInformation" createOnElement="vesevent">
      <jb:wiring property="additionalProperties" beanIdRef="additionalFields2" />
   </jb:bean>
   <jb:bean beanId="additionalFields2" class="java.util.HashMap" createOnElement="vesevent/pnfRegistration/additionalFields">
      <jb:value data="pnfRegistration/additionalFields/*" />
   </jb:bean></smooks-resource-list>
