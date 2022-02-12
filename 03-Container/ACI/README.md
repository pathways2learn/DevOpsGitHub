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
