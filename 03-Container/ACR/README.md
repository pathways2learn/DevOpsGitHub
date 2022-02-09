# Creating ACR and preparing container images

- AZ CLI
- Docker
- Azure Subscription
- Terraform

## Image Preparation

" Run the command ` az acr login -n wus3acradoagent01 ` to login to the ACR."

- Verify the status of the docker deamon and ensure that it is running. Or start the docker desktop and make sure it is running.

" Run the command `docker build ./` "

"docker images"

"docker tag aci-tutorial-app <acrLoginServer>/aci-tutorial-app:v1"

"docker push <acrLoginServer>/aci-tutorial-app:v1"

Ref: -
- https://docs.microsoft.com/en-us/azure/container-registry/container-registry-get-started-docker-cli?tabs=azure-cli
- 
- https://docs.microsoft.com/en-us/azure/container-instances/container-instances-tutorial-prepare-acr