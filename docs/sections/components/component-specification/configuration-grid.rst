.. This work is licensed under a Creative Commons Attribution 4.0 International License.
.. http://creativecommons.org/licenses/by/4.0

Configuration Quick Reference
=============================

Default Values
^^^^^^^^^^^^^^

The component developer can provide default values for any ``parameter``
in the component specification. These defaults will be passed to the
component in its generated configuration.

Overridden/Entered Values
^^^^^^^^^^^^^^^^^^^^^^^^^

Depending on the other properties set for the parameter, the default
value can be overridden at ‘design-time’, ‘deploy-time’ or once the
microservice is running (‘run-time’). (*In the future, when Policy is
supported, configuration will also be able to be provided/changed in the
Policy UI at any time).*


+--------+--------+--------+--------+------------+
|        | Design\| CLAMP  | Policy | Deploy-Time|
|        | -Time  | Input  | Input  | Input      |
|        | Input  |        | (futur\|            |
|        |        |        | e)     |            |
+========+========+========+========+============+
| Descri\| Applie\| Applie\| (not   | Applies to |
| ption  | s      | s      | yet    | manually   |
|        | to SDC | to     | suppor\| deployed   |
|        | self-s\| compon\| ted)   | services   |
|        | ervice | ents   |        |            |
|        | compon\| deploy\|        |            |
|        | ents   | ed     |        |            |
|        |        | by     |        |            |
|        |        | CLAMP  |        |            |
+--------+--------+--------+--------+------------+
| Input  | Servic\| CLAMP  | Operat\| DevOps     |
| provid\| e      |        | ions   |            |
| ed     | Design |        |        |            |
| by     | er     |        |        |            |
+--------+--------+--------+--------+------------+
| How it | In the | In the | In the | In the DCAE|
| is     | SDC UI | CLAMP  | POLICY | Dashboard  |
| provid\|        | UI     | GUI    | (or Jenkins|
| ed     |        |        |        | job)       |
+--------+--------+--------+--------+------------+
| Compon\| ‘desig\| None.  | ‘polic\| ‘sourced\  |
| ent    | ner-ed\| Develo\| y_edit\| _at_deploy\|
| Specif\| itable\| per    | able’  | ment’ must |
| icatio\| ’      | provid\| must   | be set to  |
| n      | set to | es     | be set | ‘true’     |
| Detail\| ‘true’ | CLAMP  | to     |            |
| s      |        | an     | ‘true’ |            |
|        |        | email  | and    |            |
|        |        | with   | ‘polic\|            |
|        |        | parame\| y_sche\|            |
|        |        | ters   | ma’    |            |
|        |        | to be  | must   |            |
|        |        | suppor\| be     |            |
|        |        | ted    | provid\|            |
|        |        |        | ed     |            |
|        |        |        |        |            |
|        |        |        |        |            |
+--------+--------+--------+--------+------------+
| Additi\|        |        | For    |            |
| onal   |        |        | Docker |            |
| Info   |        |        | only:  |            |
| for    |        |        | In the |            |
| Compon\|        |        | auxili\|            |
| ent    |        |        | ary    |            |
| Develo\|        |        | sectio\|            |
| per    |        |        | n:     |            |
|        |        |        | {“poli\|            |
|        |        |        | cy”:   |            |
|        |        |        | {“trig\|            |
|        |        |        | ger_ty\|            |
|        |        |        | pe”:   |            |
|        |        |        | “polic\|            |
|        |        |        | y”,“sc\|            |
|        |        |        | ript_p\|            |
|        |        |        | ath”:  |            |
|        |        |        | “/opt/\|            |
|        |        |        | app/re\|            |
|        |        |        | config\|            |
|        |        |        | ure.sh |            |
|        |        |        | ”}     |            |
|        |        |        | }      |            |
|        |        |        | Script |            |
|        |        |        | interf\|            |
|        |        |        | ace    |            |
|        |        |        | would  |            |
|        |        |        | then   |            |
|        |        |        | be     |            |
|        |        |        | “/opt/\|            |
|        |        |        | app/re\|            |
|        |        |        | config\|            |
|        |        |        | ure.sh |            |
|        |        |        | ”      |            |
|        |        |        | $trigg\|            |
|        |        |        | er_typ\|            |
|        |        |        | e      |            |
|        |        |        | $updat\|            |
|        |        |        | ed_pol\|            |
|        |        |        | icy"   |            |
|        |        |        | where  |            |
|        |        |        | $updat\|            |
|        |        |        | ed_pol\|            |
|        |        |        | icy    |            |
|        |        |        | is     |            |
|        |        |        | json   |            |
|        |        |        | provid\|            |
|        |        |        | ed     |            |
|        |        |        | by the |            |
|        |        |        | Policy |            |
|        |        |        | Handle\|            |
|        |        |        | r.     |            |
+--------+--------+--------+--------+------------+

