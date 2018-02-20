
.. http://creativecommons.org/licenses/by/4.0

.. _glossary:

Glossary
========

.. _glossary-asdc:

ASDC
----

The ECOMP resource catalog. We assume the existince and usage of ASDC, though for near term testing purposes, we use a mock version of the catalog. 
We assume all DCAE artifacts: components like collectors, CDAP applications, data formats (see below), etc, are onboarded and searchable in the catalog. 
Further, we assume that every catalog artifact has a *UUID*, a globally unique identifier that identifies that artifact. 

.. _glossary-component:

Component
---------

Refers to a DCAE service component which is a single micro-service that is written to be run by the DCAE platform and to be composeable to form a DCAE service.

.. _glossary-data-format:

Data format
-----------

Artifact that describes a data structure and schema.

.. _glossary-onboarding-catalog:

Onboarding catalog
------------------

The onboarding catalog is the intermediary store for project details, component specifications and data formats.  This is to be used by component developers through the `dcae-cli` to browse and to launch existing components and push their own component artifacts in preparation to move their component to the ASDC resource catalog.
