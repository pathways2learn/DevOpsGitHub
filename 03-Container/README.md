# Deploy an Azure DevOps agent on containers

### Container Image

- To run a container we need an image to start with. In this sample, we will be using Ubuntu 18.04 image provided by Canonical on the docker hub registry.
- We will install the tools we needed on that image and prepare an agent image we need. The sample `Dockerfile` used in here install below tools along with agent software.
  - unzip
  - wget
  - PowerShell
  - Az CLI
  - Terraform
  - PowerShell Modules
    - Az
    - Pester
    - PSScriptAnalyzer
- The code files are in `ACR` folder. Please read the `README` file in `ACR` folder to know more.

### Container
- The code files are in `ACI` folder. Please read the `README` file in `ACI` folder to know more.

### Deployment Order

1. Deploy the Azure Container Registry (ACR)
2. Use the `DockerFile` to prepare the image and push the image to Azure Container Registry (ACR)
3. Deploy a container on Azure Container Instances (ACI) using the image from Azure Container Registry (ACR)

### Dependencies

#### Softwares/Tools
- Terraform (Infrastructure as code tool)

#### Cloud Platform
- Azure

#### Cloud Services 
- Azure Container Registry (ACR)
- Azure Container Instances (ACI)
- Azure DevOps (ADO)
