 .. This work is licensed under a Creative Commons Attribution 4.0 International License.
.. http://creativecommons.org/licenses/by/4.0


VES OpenAPI Manager
===================

VES OpenAPI Manager has been created to validate distributed in SDC Services. When deployed, it automatically listens
to events of Service distributions by using SDC Distribution Client. Purpose of this component is to partially validate
artifacts of type *VES_EVENT* from Resources of distributed services. During validation phase it checks whether
*stndDefined* events defined in VES_EVENT type artifact, contain only *schemaReferences* that local copies are reachable
by DCAE VES Collector. If any of schemaReference is invalid, VES OpenAPI Manger informs ONAP user which schemas are
incorrect during Service Distribution in SDC.


VES OpenAPI Manager overview and functions
------------------------------------------

.. toctree::
  :maxdepth: 1

  ./architecture.rst
  ./artifacts.rst
  ./deployment.rst
  ./use-cases.rst
