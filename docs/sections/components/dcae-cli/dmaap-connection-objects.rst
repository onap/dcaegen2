.. This work is licensed under a Creative Commons Attribution 4.0 International License.
.. http://creativecommons.org/licenses/by/4.0

DMaaP connection objects
========================

DMaaP connection objects are JSON objects that:

1. Components should expect at runtime in their application
   configuration and is to be used to connect to the appropriate DMaaP
   feed or topic.
2. Developers must provide through the command-line argument
   ``--dmaap-file`` to test their component with manually provisioned
   feeds and topics.

This page is a reference to the specific structure that each type of
DMaaP stream requires.

Note for #1 that components should expect the entire object with all
properties at runtime where the default will be ``null`` unless
specified otherwise.

Note for #2 that developers are not required to provide the entire
object. The required properties will be labeled with “*required as
input*”.

.. _dmaap-message-router:

Message router
--------------

Publishers and subscribers both have the same JSON object structure.
Here’s an example:

.. code:: json

    {
        "type": "message_router",
        "aaf_username": "some-user",
        "aaf_password": "some-password",
        "dmaap_info": {
            "client_role": "com.dcae.member",
            "client_id": "1500462518108",
            "location": "mtc00",
            "topic_url": "https://we-are-message-router.us:3905/events/some-topic"
        }
    }


At the top-level:

+-------------+----+--------------------+
| Property    | Ty\| Descript\          |
| Name        | pe | ion                |
+=============+====+====================+
| type        | st\| *Require\          |
|             | ri\| d \                |
|             | ng | as \               |
|             |    | input*.            |
|             |    | Must be            |
|             |    | ``message_router`` |
|             |    | for                |
|             |    | message            |
|             |    | router             |
|             |    | topics             |
+-------------+----+--------------------+
| aaf_usernam\| st\| AAF                |
| e           | ri\| username           |
|             | ng | message            |
|             |    | router             |
|             |    | clients            |
|             |    | use to             |
|             |    | authenti\          |
|             |    | cate               |
|             |    | with               |
|             |    | secure             |
|             |    | topics             |
+-------------+----+--------------------+
| aaf_passwor\| st\| AAF                |
| d           | ri\| password           |
|             | ng | message            |
|             |    | router             |
|             |    | clients            |
|             |    | use to             |
|             |    | authenti\          |
|             |    | cate               |
|             |    | with               |
|             |    | secure             |
|             |    | topics             |
+-------------+----+--------------------+
| dmaap_info  | JS\| *Require\          |
|             | ON | d \                |
|             | ob\| as \               |
|             | je\| input*.            |
|             | ct | Contains           |
|             |    | the                |
|             |    | topic              |
|             |    | connecti\          |
|             |    | on                 |
|             |    | details            |
+-------------+----+--------------------+

The ``dmaap_info`` object contains:

+-------------+----+----------+
| Property    | Ty\| Descript\|
| Name        | pe | ion      |
+=============+====+==========+
| client_role | st\| AAF      |
|             | ri\| client   |
|             | ng | role     |
|             |    | that’s   |
|             |    | requesti\|
|             |    | ng       |
|             |    | publish  |
|             |    | or       |
|             |    | subscrib\|
|             |    | e        |
|             |    | access   |
|             |    | to the   |
|             |    | topic    |
+-------------+----+----------+
| client_id   | st\| Client   |
|             | ri\| id for   |
|             | ng | given    |
|             |    | AAF      |
|             |    | client   |
+-------------+----+----------+
| location    | st\| DCAE     |
|             | ri\| location |
|             | ng | for the  |
|             |    | publishe\|
|             |    | r        |
|             |    | or       |
|             |    | subscrib\|
|             |    | er,      |
|             |    | used to  |
|             |    | set up   |
|             |    | routing  |
+-------------+----+----------+
| topic_url   | st\| *Require\|
|             | ri\| d \      |
|             | ng | as \     |
|             |    | input*.  |
|             |    | URL for  |
|             |    | accessin\|
|             |    | g        |
|             |    | the      |
|             |    | topic to |
|             |    | publish  |
|             |    | or       |
|             |    | receive  |
|             |    | events   |
+-------------+----+----------+

Here’s an example of the minimal JSON that must be provided as an input:

.. code:: json

    {
        "type": "message_router",
        "dmaap_info": {
            "topic_url": "https://we-are-message-router.us:3905/events/some-topic"
        }
    }

.. _dmaap-data-router:

Data router
-----------

Publisher
~~~~~~~~~

Here’s an example of what the JSON object connection for data router
publisher looks like:

.. code:: json

    {
        "type": "data_router",
        "dmaap_info": {
            "location": "mtc00",
            "publish_url": "https://we-are-data-router.us/feed/xyz",
            "log_url": "https://we-are-data-router.us/feed/xyz/logs",
            "username": "some-user",
            "password": "some-password",
            "publisher_id": "123456"
        } 
    }

At the top-level:

+-------------+----+----------------+
| Property    | Ty\| Descript\      |
| Name        | pe | ion            |
+=============+====+================+
| type        | st\| *Require\      |
|             | ri\| d \            |
|             | ng | as \           |
|             |    | input*.        |
|             |    | Must be        |
|             |    | ``data_router``|
|             |    | for data       |
|             |    | router         |
|             |    | feeds          |
+-------------+----+----------------+
| dmaap_info  | JS\| *Require\      |
|             | ON | d \            |
|             | ob\| as \           |
|             | je\| input*.        |
|             | ct | Contains       |
|             |    | the            |
|             |    | topic          |
|             |    | connecti\      |
|             |    | on             |
|             |    | details        |
+-------------+----+----------------+

The ``dmaap_info`` object contains:

+-------------+----+----------+
| Property    | Ty\| Descript\|
| Name        | pe | ion      |
+=============+====+==========+
| location    | st\| DCAE     |
|             | ri\| location |
|             | ng | for the  |
|             |    | publishe\|
|             |    | r,       |
|             |    | used to  |
|             |    | set up   |
|             |    | routing  |
+-------------+----+----------+
| publish_url | st\| *Require\|
|             | ri\| d \      |
|             | ng | as \     |
|             |    | input*.  |
|             |    | URL to   |
|             |    | which    |
|             |    | the      |
|             |    | publishe\|
|             |    | r        |
|             |    | makes    |
|             |    | Data     |
|             |    | Router   |
|             |    | publish  |
|             |    | requests |
+-------------+----+----------+
| log_url     | st\| URL from |
|             | ri\| which    |
|             | ng | log data |
|             |    | for the  |
|             |    | feed can |
|             |    | be       |
|             |    | obtained |
+-------------+----+----------+
| username    | st\| Username |
|             | ri\| the      |
|             | ng | publishe\|
|             |    | r        |
|             |    | uses to  |
|             |    | authenti\|
|             |    | cate     |
|             |    | to Data  |
|             |    | Router   |
+-------------+----+----------+
| password    | st\| Password |
|             | ri\| the      |
|             | ng | publishe\|
|             |    | r        |
|             |    | uses to  |
|             |    | authenti\|
|             |    | cate     |
|             |    | to Data  |
|             |    | Router   |
+-------------+----+----------+
| publisher_i | st\| Publishe\|
| d           | ri\| r        |
|             | ng | id in    |
|             |    | Data     |
|             |    | Router   |
+-------------+----+----------+

Here’s an example of the minimal JSON that must be provided as an input:

.. code:: json

    {
        "type": "data_router",
        "dmaap_info": {
            "publish_url": "https://we-are-data-router.us/feed/xyz"
        }
    }

Subscriber
~~~~~~~~~~

Here’s an example of what the JSON object connection for data router
subscriber looks like:

.. code:: json

    {
        "type": "data_router",
        "dmaap_info": {
            "location": "mtc00",
            "delivery_url": "https://my-subscriber-app.dcae:8080/target-path",
            "username": "some-user",
            "password": "some-password",
            "subscriber_id": "789012"
        } 
    }

At the top-level:

+-------------+----+----------------+
| Property    | Ty\| Descript\      |
| Name        | pe | ion            |
+=============+====+================+
| type        | st\| *Require\      |
|             | ri\| d              |
|             | ng | as \           |
|             |    | input*.        |
|             |    | Must be        |
|             |    | ``data_router``|
|             |    | for data       |
|             |    | router         |
|             |    | feeds          |
+-------------+----+----------------+
| dmaap_info  | JS\| *Require\      |
|             | ON | d \            |
|             | ob\| as \           |
|             | je\| input*.        |
|             | ct | Contains       |
|             |    | the            |
|             |    | topic          |
|             |    | connecti\      |
|             |    | on             |
|             |    | details        |
+-------------+----+----------------+

The ``dmaap_info`` object contains:

+--------------+----+----------+
| Property     | Ty\| Descript\|
| Name         | pe | ion      |
+==============+====+==========+
| location     | st\| DCAE     |
|              | ri\| location |
|              | ng | for the  |
|              |    | publishe\|
|              |    | r,       |
|              |    | used to  |
|              |    | set up   |
|              |    | routing  |
+--------------+----+----------+
| delivery_ur\ | st\| URL to   |
| l            | ri\| which    |
|              | ng | the Data |
|              |    | Router   |
|              |    | should   |
|              |    | deliver  |
|              |    | files    |
+--------------+----+----------+
| username     | st\| Username |
|              | ri\| Data     |
|              | ng | Router   |
|              |    | uses to  |
|              |    | authenti\|
|              |    | cate     |
|              |    | to the   |
|              |    | subscrib\|
|              |    | er       |
|              |    | when     |
|              |    | deliveri\|
|              |    | ng       |
|              |    | files    |
+--------------+----+----------+
| password     | st\| Password |
|              | ri\| Data     |
|              | ng | Router   |
|              |    | uses to  |
|              |    | authenti\|
|              |    | cate     |
|              |    | to the   |
|              |    | subscrib\|
|              |    | er       |
|              |    | when     |
|              |    | deliveri\|
|              |    | ng       |
|              |    | files    |
+--------------+----+----------+
| subscriber_i\| st | Subscrib\|
| d            | ri | er       |
|              | ng | id in    |
|              |    | Data     |
|              |    | Router   |
+--------------+----+----------+

Here’s an example of the minimal JSON that must be provided as an input:

.. code:: json

    {
        "type": "data_router",
        "dmaap_info": {
        }
    }

Developers are recommended to use ``username`` and ``password`` since
this is the recommended security practice.

Note that the dcae-cli will construct the ``delivery_url`` when
deploying the component since this can only be known at deployment time.
