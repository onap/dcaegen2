============
Introduction
============

MOD stands for "micro-service onboarding and design" and the project is
an effort to reboot the onboarding and design experience in DCAE.


**Goals and Stretch Goals**
---------------------------


- Due to resource constraints, there are mismatched capabilities between SDC/DCAE-DS and DCAE mS deployment.

- Due to #1, mS developers upload handcrafted blueprint, and stay involved throughout the deployment process. This also ties mS development to specific Cloudify implementation.

- There is no Service Assurance flow design in SDC/DCAE-DS, and so there are no reusable flow designs for the Service Designer.

- There is extensive reliance on developers’ involvement in providing [Inputs.json] as runtime configurations for mS deployment.

- There is no E2E tracking of the microservice lifecycle.


**To address these problems, the new DCAE MOD, replacing the mS onboarding & DCAE-DS in SDC, aims to -**



- Move DCAE mS onboarding & design from SDC project to DCAE Project.

- Provide simplified mS Onboarding, Service Assurance flow design, & mS microservice design time & runtime configurations to support developers, service designers, and operations.

- Auto-generate blueprint at the end of the design process, not onboarded before the design process.

- Support Policy onboarding & artifact distribution to Policy/CLAMP to support Self Service Control Loop.

- Streamline the process of constructing to deploying flows, Provide the ability to track flows - capture and store the progress and evolution of flows and Provide clear coordination and accountability i.e Provide catalog & data for microservice lifecycle tracking. It fits the ECOMP's release process and must provide clear visibility along the entire process and across different environments.

- Support automated adaptation of ML model from Acumos to DCAE design & runtime environment through the Acumos Adapter.

- DCAE-MOD is developed by the DCAE team to ensure consistency across all DCAE implementation, with the long term objective to integrate with SDC as part of the Design Platform.

- Integrate with ONAP User Experience portals (initially ONAP portal, later SDC portal).



