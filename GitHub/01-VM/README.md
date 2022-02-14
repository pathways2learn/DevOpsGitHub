


# Creating GitHub self-hosted runners using VM

You can install the GitHub runner application on Linux, macOS, or Windows machines. You can also install an  GitHub runner application on a Docker container.

In this example we will be deploying a Linux VM agent.

### Part 1: Follow the below steps to deploy a Linux VM  using Azure CLI

1) Browse to cloud shell at https://shell.azure.com/. In this demo we are using Powershell.
2) Set the desired subscription where you want to deploy </br>
`az account set -s <Name or ID of your subscription>`
3) Create a resource group for your VMSS </br>
```
az group create \
--location westus \
--name vmagentrg
```
4) Create a virtual machine in your resource group. In this example the UbuntuLTS VM image is specified.</br>
```
az vm create --resource-group vmagentrg --name vmagentlinuxgit --image UbuntuLTS --admin-username azureuser --generate-ssh-keys
```
The above command creates  default Virtual network, NIC, NSG, Public IP.
To further tweak the components created refer <a href='https://docs.microsoft.com/en-us/azure/virtual-machines/linux/quick-create-cli'>here.</a>

5) After the VM is created , you would get the SSH Key files stored in your local (Either CMD / CLoud Shell / Powershell) 

     ![image](https://user-images.githubusercontent.com/94544313/153742532-5c49040b-5f74-43e3-85cd-f24dd8ca876d.png)
     
6) To login into the VM upload the id_rsa file to the Putty Session
     ![image](https://user-images.githubusercontent.com/94544313/153747721-73f4458e-7e09-4f28-a967-e3607ed2ed6e.png)
     
Here we have used MobaXterm and entered our details under Advanced settings in a New Session.

### Part 2: Configure the Runner from the GitHub Portal
 Self Hosted runner can be at Repository , Organization and Enterprise Level
 1) In this demo , we would be creating Self hosted runner at a repo level </br>
    Click on the repo and on settings
    
    ![image](https://user-images.githubusercontent.com/94544313/153846106-35cc3619-b1e9-46d4-86a0-94a2f332e9e3.png)
 
 2) Click on Actions and on New Self-Hosted Runner , Choose Linux : This would give a list of steps

   ![image](https://user-images.githubusercontent.com/94544313/153846629-8e376f5b-9285-4bac-a4f5-359cc6ace8f4.png)  
 
 ### Part 3: Configure the Application inside the Runner
 
 1) Login to the VM
 2) Follow the steps from Part2 step2. The steps would run the application in an interactive mode</br>
 3) Alternatively , in this demo we would running it as a service </br>
   `sudo ./svc.sh install` </br>
   `sudo ./svc.sh start` </br>
   
     ![image](https://user-images.githubusercontent.com/94544313/153847551-47ac2657-cbbb-4c58-a22c-fc55cc9f9dd4.png)
     
 4) Post these steps the runner would be available in the GitHub Runner section

 ![image](https://user-images.githubusercontent.com/94544313/153847748-651d411c-5f4d-4c18-9bfa-122edc4bc5e7.png)   
  

For more details refer the <a href='</a>https://docs.github.com/en/actions/hosting-your-own-runners/adding-self-hosted-runners'>official documentation.</a>





