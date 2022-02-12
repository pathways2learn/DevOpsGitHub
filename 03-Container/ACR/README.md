# Creating Azure Container Registry (ACR) and preparing container images

### Create Azure Container Registry (ACR)

You can refer this tutorial [Tutorial: Create an Azure container registry and push a container image](https://docs.microsoft.com/en-us/azure/container-instances/container-instances-tutorial-prepare-acr) from Microsoft documentation for more information. We will be using [terraform](https://www.terraform.io/) to deploy the ACR. Please visit the `terraform` documentation to know more about `terraform`.

1. Update the inputs in `config.auto.tfvars` as needed and use `terraform` to deploy the infrastructure. As this a demo sample, we won't need the features provided by `Standard` or `Premium` tiers of ACR. But in the actual production environments, you should be using required features to secure your ACR.


### Image Preparation

1. Run the command ` az acr login -n <acrName> ` to login to the ACR. Please replace the ACR name as needed.
2. Run the command `docker build ./` in the ACR directory where our `Dockerfile` is placed. This will prepare our container image.
  > Note: - This may take more than 20 minutes considering the tools installed.
3. If you observe errors related to docker daemon, please verify the status of the docker deamon and ensure that it is running. Else you can start the docker desktop and make sure it is running and then start with the `docker build` task.
4. Once the `docker build` step is completed, please run `docker images` to list the available images.
5. To push a container image to a private registry like Azure Container Registry, you must first tag the image with the full name of the registry's login server. Use `docker tag <imageName> <acrLoginServer>/<imageName>:<versionNumber>` as shown in the tutorial to tag your image.
6. Now that you've tagged the image with the full login server name of your private registry, you can push the image to the registry with the docker push command. Replace <acrLoginServer> with the full login server name you obtained in the earlier step. `docker push <acrLoginServer>/<imageName>:<versionNumber>`
  
### Dependencies

- Docker CLI
- Azure Subscription
- Terraform
