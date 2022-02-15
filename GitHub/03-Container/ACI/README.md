# Creating Azure Container Instance (ACI) using the runner images

### Create an Azure Container Instance (ACI)
Update the inputs in `config.auto.tfvars` as needed and use terraform to deploy the infrastructure.

### Dependencies
- Azure Subscription
- Terraform
- An image in ACR which can be pulled
- GitHub
  - Enterprise/Organization/Repository URL where the runner needs to be added
  - Agent registration token
    > The registration token we use to register the runner expires after one hour. So, there is no point in using it unless we have an automated solution which can fetch the registration token during the time of the container creation. GitHub provides REST API for this functionality so that we can use our access token and get the registration token. Please explore it to build a more robust and automated container runner solution. As this is a demo, we are just using the registration token to show how the runner works on a container.

### Results
Once the code is ran successfully, you should be able to see the runner in your GitHub Enterprise/Organization/Repository.
![image](https://user-images.githubusercontent.com/61077834/153718086-656d245f-6592-40e1-bc3f-d2f78c80f1cd.png)

#### Notes
- Sometimes you may not be able to deploy containers on a region due to availability or resource constraints. Please feel free to change the azure region in your configuration parameters and try to deploy the ACI in some other region.
- The identity you use to deploy ACI should have permissions to pull the images from the ACR. Else the ACI won't be able to pull the images. Please refer the Microsoft Documentation for more information and understanding limitations.
- You may the see the container in running state but don't see the runner in the GitHub Enterprise/Organization/Repository. This could be due to delays in communication between the runner or the incorrect URL/runner registration tokens.
- You container might fail to start if the parameters related to GitHub are incorrect.

