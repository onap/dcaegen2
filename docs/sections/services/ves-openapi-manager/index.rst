.. This work is licensed under a Creative Commons Attribution 4.0 International License.
.. http://creativecommons.org/licenses/by/4.0


VES OpenAPI Manager
===================

VES OpenAPI Manager has been created to validate the presence of OpenAPI schemas declared in *VES_EVENT* type artifacts,
within the DCAE run-time environment during Service Model distribution in SDC. When deployed, it automatically listens
to events of Service Models distributions by using SDC Distribution Client in order to read the declared OpenAPI
descriptions. Purpose of this component is to partially validate artifacts of type *VES_EVENT* from Resources of
distributed services. During validation phase it checks whether *stndDefined* events defined in VES_EVENT type artifact,
contain only *schemaReferences* that local copies are accessible by DCAE VES Collector. If any of schemaReference is
absent in local externalSchema repository, the VES OpenAPI Manager informs ONAP user which schemas need to be uploaded
to the DCAE run-time environment.


VES OpenAPI Manager overview and functions
------------------------------------------

.. toctree::
  :maxdepth: 1

  ./architecture.rst
  ./artifacts.rst
  ./deployment.rst
  ./use-cases.rst
