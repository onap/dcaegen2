.. This work is licensed under a Creative Commons Attribution 4.0 International License.
.. http://creativecommons.org/licenses/by/4.0

Configuration Quick Reference
=============================

The following types of configuration are supported by the DCAE Platform.

+---------+---------+----------+---------+-----------+---+
| Input   | Default | Designer | Clamp   | Policy    | R\|
| Sources | Values  | Input    | Input   | Input     | u\|
|         |         |          |         |           | n\|
|         |         |          |         |           | t\|
|         |         |          |         |           | i\|
|         |         |          |         |           | m\|
|         |         |          |         |           | e |
|         |         |          |         |           | I\|
|         |         |          |         |           | n\|
|         |         |          |         |           | p\|
|         |         |          |         |           | u\|
|         |         |          |         |           | t |
+=========+=========+==========+=========+===========+===+
| Notes   |         | This     | This    |           |   |
|         |         | applies  | applies |           |   |
|         |         | only to  | only to |           |   |
|         |         | componen\| compone\|           |   |
|         |         | ts       | nts     |           |   |
|         |         | that are | that    |           |   |
|         |         | self-ser\| are     |           |   |
|         |         | vice     | part of |           |   |
|         |         | (support\| a       |           |   |
|         |         | ed       | closed-\|           |   |
|         |         | by SDC)  | loop    |           |   |
|         |         |          | interfa\|           |   |
|         |         |          | ce      |           |   |
+---------+---------+----------+---------+-----------+---+
| Who     | Compone\| Service  | CLAMP   | Operatio\ | R\|
| provide\| nt      | Designer |         | ns        | u\|
| s?      | Develop |          |         |           | n\|
|         | er      |          |         |           | t\|
|         |         |          |         |           | i\|
|         |         |          |         |           | m\|
|         |         |          |         |           | e |
|         |         |          |         |           | P\|
|         |         |          |         |           | l\|
|         |         |          |         |           | a\|
|         |         |          |         |           | t\|
|         |         |          |         |           | f\|
|         |         |          |         |           | o\|
|         |         |          |         |           | r\|
|         |         |          |         |           | m |
+---------+---------+----------+---------+-----------+---+
| When/Wh\| During  | At       | At      | Anytime   | W\|
| ere     | onboard\| design   | install\| – in the  | h\|
| it is   | ing     | time –   | ation   | POLICY    | e\|
| provide | – in    | in the   | – in    | GUI       | n |
| d       | the     | SDC UI   | the     |           | t\|
|         | compone\|          | CLAMP   |           | h\|
|         | nt      |          | UI      |           | e |
|         | specifi\|          |         |           | c\|
|         | cation  |          |         |           | o\|
|         |         |          |         |           | m\|
|         |         |          |         |           | p\|
|         |         |          |         |           | o\|
|         |         |          |         |           | n\|
|         |         |          |         |           | e\|
|         |         |          |         |           | n\|
|         |         |          |         |           | t |
|         |         |          |         |           | i\|
|         |         |          |         |           | s |
|         |         |          |         |           | d\|
|         |         |          |         |           | e\|
|         |         |          |         |           | p\|
|         |         |          |         |           | l\|
|         |         |          |         |           | o\|
|         |         |          |         |           | y\|
|         |         |          |         |           | e\|
|         |         |          |         |           | d |
+---------+---------+----------+---------+-----------+---+
| Compone\| For     | ‘designe\|         | ‘policy-\ | ‘\|
| nt      | CDAP:   | r-editab\|         | editable\ | s\|
| Specifi\| ‘value’ | le’      |         | ’         | o\|
| cation  | Name    | must be  |         | must be   | u\|
| Details | and KV  | set to   |         | set to    | r\|
|         | pairs   | ‘true’   |         | ‘true’    | c\|
|         | in      | for      |         | and       | e\|
|         | AppConf\| variable |         | ‘policy_s\| d\|
|         | ig      | in       |         | chema’    | _\|
|         | or      | ‘paramet\|         | must be   | a\|
|         | AppPref\| er’      |         | provided  | t\|
|         | erences | section. |         | for       | _\|
|         | For     |          |         | variable  | \ |
|         | Docker: |          |         | in        | d\|
|         | ‘value’ |          |         | ‘paramet\ | e\|
|         | is      |          |         | er’       | p\|
|         | provide |          |         | section   | l\|
|         | d       |          |         |           | o\|
|         | for     |          |         |           | y\|
|         | variabl\|          |         |           | m\|
|         | e       |          |         |           | e\|
|         | in      |          |         |           | n\|
|         | ‘parame\|          |         |           | t\|
|         | ter’    |          |         |           | ’ |
|         | section |          |         |           | m\|
|         |         |          |         |           | u\|
|         |         |          |         |           | s\|
|         |         |          |         |           | t |
|         |         |          |         |           | b\|
|         |         |          |         |           | e |
|         |         |          |         |           | s\|
|         |         |          |         |           | e\|
|         |         |          |         |           | t |
|         |         |          |         |           | t\|
|         |         |          |         |           | o |
|         |         |          |         |           | ‘\|
|         |         |          |         |           | t\|
|         |         |          |         |           | r\|
|         |         |          |         |           | u\|
|         |         |          |         |           | e |
|         |         |          |         |           | ’\|
|         |         |          |         |           | f\|
|         |         |          |         |           | o\|
|         |         |          |         |           | r |
|         |         |          |         |           | v\|
|         |         |          |         |           | a\|
|         |         |          |         |           | r\|
|         |         |          |         |           | i\|
|         |         |          |         |           | a\|
|         |         |          |         |           | b\|
|         |         |          |         |           | l\|
|         |         |          |         |           | e\|
|         |         |          |         |           | i\|
|         |         |          |         |           | n\|
|         |         |          |         |           | ‘ |
|         |         |          |         |           | p\|
|         |         |          |         |           | a\|
|         |         |          |         |           | r\|
|         |         |          |         |           | a\|
|         |         |          |         |           | m\|
|         |         |          |         |           | e\|
|         |         |          |         |           | t\|
|         |         |          |         |           | e\|
|         |         |          |         |           | r\|
|         |         |          |         |           | ’ |
|         |         |          |         |           | s\|
|         |         |          |         |           | e\|
|         |         |          |         |           | c\|
|         |         |          |         |           | t\|
|         |         |          |         |           | i\|
|         |         |          |         |           | o\|
|         |         |          |         |           | n |
+---------+---------+----------+---------+-----------+---+

+---------+---------+----------+---------+-----------+---+
| How it  | This is | This     | This    | This      | T\|
| is used | passed  | override\| overrid\| override\ | h\|
|         | to the  | s        | es      | s         | i\|
|         | compone\| any      | any     | any       | s |
|         | nt      | values   | values  | values    | o\|
|         | in the  | previous\| previou\| previous\ | v\|
|         | generat\| ly       | sly     | ly        | e\|
|         | ed      | set, but | set,    | set, but  | r\|
|         | configu\| can be   | but can | can be    | r\|
|         | ration  | overridd\| be      | overridd\ | i\|
|         | if not  | en       | overrid\| en        | d\|
|         | overrid\| by CLAMP | den     | at any    | e\|
|         | den.    | or       | by      | point     | s |
|         |         | POLICY.  | POLICY. | thereaft\ | a\|
|         |         |          |         | er.       | n\|
|         |         |          |         |           | y |
|         |         |          |         |           | v\|
|         |         |          |         |           | a\|
|         |         |          |         |           | l\|
|         |         |          |         |           | u\|
|         |         |          |         |           | e\|
|         |         |          |         |           | s |
|         |         |          |         |           | p\|
|         |         |          |         |           | r\|
|         |         |          |         |           | e\|
|         |         |          |         |           | v\|
|         |         |          |         |           | i\|
|         |         |          |         |           | o\|
|         |         |          |         |           | u\|
|         |         |          |         |           | s\|
|         |         |          |         |           | l\|
|         |         |          |         |           | y |
|         |         |          |         |           | s\|
|         |         |          |         |           | e\|
|         |         |          |         |           | t\|
|         |         |          |         |           | , |
|         |         |          |         |           | b\|
|         |         |          |         |           | u\|
|         |         |          |         |           | t |
|         |         |          |         |           | c\|
|         |         |          |         |           | a\|
|         |         |          |         |           | n |
|         |         |          |         |           | b\|
|         |         |          |         |           | e |
|         |         |          |         |           | o\|
|         |         |          |         |           | v\|
|         |         |          |         |           | e\|
|         |         |          |         |           | r\|
|         |         |          |         |           | r\|
|         |         |          |         |           | i\|
|         |         |          |         |           | d\|
|         |         |          |         |           | d\|
|         |         |          |         |           | e\|
|         |         |          |         |           | n |
|         |         |          |         |           | a\|
|         |         |          |         |           | t |
|         |         |          |         |           | a\|
|         |         |          |         |           | n\|
|         |         |          |         |           | y |
|         |         |          |         |           | p\|
|         |         |          |         |           | o\|
|         |         |          |         |           | i\|
|         |         |          |         |           | n\|
|         |         |          |         |           | t |
|         |         |          |         |           | t\|
|         |         |          |         |           | h\|
|         |         |          |         |           | e\|
|         |         |          |         |           | r\|
|         |         |          |         |           | e\|
|         |         |          |         |           | a\|
|         |         |          |         |           | f\|
|         |         |          |         |           | t\|
|         |         |          |         |           | e\|
|         |         |          |         |           | r |
|         |         |          |         |           | b\|
|         |         |          |         |           | y |
|         |         |          |         |           | P\|
|         |         |          |         |           | o\|
|         |         |          |         |           | l\|
|         |         |          |         |           | i\|
|         |         |          |         |           | c\|
|         |         |          |         |           | y\|
|         |         |          |         |           | . |
+---------+---------+----------+---------+-----------+---+
| Additio\| For     |          |         | For       |   |
| nal     | CDAP:   |          |         | Docker:   |   |
| Info    | ‘value’ |          |         | In the    |   |
| for     | is      |          |         | auxiliar\ |   |
| Compone\| provide\|          |         | y         |   |
| nt      | d       |          |         | section:  |   |
| Develop\| for     |          |         | {“policy  |   |
| er      | variabl\|          |         | ”:        |   |
|         | e       |          |         | {“trigge\ |   |
|         | in the  |          |         | r_type”:  |   |
|         | ‘AppCon\|          |         | “policy”  |   |
|         | fig’    |          |         | ,“script\ |   |
|         | or      |          |         | _path”:   |   |
|         | ‘AppPre\|          |         | “/opt/ap\ |   |
|         | ference\|          |         | p/reconf\ |   |
|         | s’      |          |         | igure.sh\ |   |
|         | section\|          |         | ”}        |   |
|         | s       |          |         | } Script  |   |
|         | For     |          |         | interfac\ |   |
|         | Docker: |          |         | e         |   |
|         | ‘value’ |          |         | must be   |   |
|         | is      |          |         | “opt/app\ |   |
|         | provide\|          |         | /reconfi\ |   |
|         | d       |          |         | gure.sh”  |   |
|         | for     |          |         | $trigger\ |   |
|         | variabl\|          |         | _type     |   |
|         | e       |          |         | $updated\ |   |
|         | in      |          |         | _policie\ |   |
|         | ‘parame\|          |         | s         |   |
|         | ter’    |          |         | $updated\ |   |
|         | section |          |         | _appl_co\ |   |
|         |         |          |         | nfig"     |   |
|         |         |          |         | where     |   |
|         |         |          |         | $updated\ |   |
|         |         |          |         | _policie\ |   |
|         |         |          |         | s         |   |
|         |         |          |         | is a      |   |
|         |         |          |         | json      |   |
|         |         |          |         | provided  |   |
|         |         |          |         | by the    |   |
|         |         |          |         | Policy    |   |
|         |         |          |         | Handler   |   |
|         |         |          |         | and       |   |
|         |         |          |         | $update_a\|   |
|         |         |          |         | ppl_con\  |   |
|         |         |          |         | fig       |   |
|         |         |          |         | is the    |   |
|         |         |          |         | post-mer\ |   |
|         |         |          |         | ged       |   |
|         |         |          |         | appl\     |   |
|         |         |          |         | config    |   |
|         |         |          |         | which     |   |
|         |         |          |         | may       |   |
|         |         |          |         | contain   |   |
|         |         |          |         | unresolv\ |   |
|         |         |          |         | ed        |   |
|         |         |          |         | configur\ |   |
|         |         |          |         | ation     |   |
|         |         |          |         | that      |   |
|         |         |          |         | didn’t    |   |
|         |         |          |         | come      |   |
|         |         |          |         | from      |   |
|         |         |          |         | policy.   |   |
|         |         |          |         | Suggesti\ |   |
|         |         |          |         | on        |   |
|         |         |          |         | is for    |   |
|         |         |          |         | script    |   |
|         |         |          |         | to call   |   |
|         |         |          |         | CONFIG    |   |
|         |         |          |         | BINDING   |   |
|         |         |          |         | SERVICE   |   |
|         |         |          |         | to        |   |
|         |         |          |         | resolve   |   |
|         |         |          |         | any       |   |
|         |         |          |         | configur\ |   |
|         |         |          |         | ation.    |   |
+---------+---------+----------+---------+-----------+---+
