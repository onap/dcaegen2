.. This work is licensed under a Creative Commons Attribution 4.0 International License.
.. http://creativecommons.org/licenses/by/4.0


DataLake-Handler MS
==============

.. Add or remove sections below as appropriate for the platform component.


**DataLake-Handler MS** is a software component of ONAP that can systematically persist the events in DMaaP into supported Big Data storage systems. 
It has a Admin UI, where a system administrator configures which Topics to be monitored, and to which data storage to store the data. 
It is also used to manage the settings of the storage and associated data analytics tool. 
The second part is the Feeder, which does the data transfer work and is horizontal scalable. 
In the next release, R7, we will add the third part, Data Exposure Service (EDS), 
which will expose the data in the data storage via REST API for other ONAP components and external systems to consume. 
Each kind of data exposure only requires a simple configuration.

.. image:: DL-DES.PNG

DataLake-Handler MS overview and functions
-------------------------------------

.. toctree::
    :maxdepth: 1

    ./overview.rst

DataLake-Handler MS Installation Steps and Configurations
-----------------------------------------------------------------------------------

.. toctree::
    :maxdepth: 1

    ./installation.rst

DataLake-Handler MS Admin UI User Guide
-----------------------------------------------------------------------------------

.. toctree::
    :maxdepth: 1

    ./userguide.rst 
