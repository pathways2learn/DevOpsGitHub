# Creating Azure Container Instance (ACI) using the agent images

### Create an Azure Container Instance (ACI)
Update the inputs in `config.auto.tfvars` as needed and use terraform to deploy the infrastructure.

### Dependencies
- Azure Subscription
- Terraform
- An image in ACR which can be pulled
- Azure DevOps
  - Organization URL
  - An agent pool
  - Personal Access Token (PAT) with `Agent Pools (Read & Manage)` permission. 
    > Please don't create a full scoped PAT and make sure to protect your PAT.

### Results
Once the code is ran successfully, you should be able to see the agent in your agent pool.
![image](https://user-images.githubusercontent.com/61077834/153704240-67fc69e5-c80a-4b96-a0ef-39a2ba743ca3.png)


#### Notes
- Sometimes you may not be able to deploy containers on a region due to availability or resource constraints. Please feel free to change the azure region in your configuration parameters and try to deploy the ACI in some other region.
![image](https://user-images.githubusercontent.com/61077834/153704148-debcd785-0752-4e24-8809-bfc6b0d0a12a.png)

- The identity you use to deploy ACI should have permissions to pull the images from the ACR. Else the ACI won't be able to pull the images. Please refer the Microsoft Documentation for more information and understanding limitations.
- You may the see the container in running state but don't see an agent in the Azure DevOps agent pool. This could be due to delays in communication between the agent or the incorrect agent pool names.

- You container might fail to start if the parameters related to Azure DevOps are incorrect. The container in the below screenshot fails to start as the PAT used by the container has been revoked.
![image](https://user-images.githubusercontent.com/61077834/153704831-33bcf40f-754e-4769-8f04-96f3454df71f.png)

