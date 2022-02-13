

# Creating Azure DevOps self-hosted agents using VM

You can install the agent on Linux, macOS, or Windows machines. You can also install an agent on a Docker container.

In this example we will be deploying a Linux VM agent.

### Part 1: Follow the below steps to deploy a Linux VM  using Azure CLI

1) Browse to cloud shell at https://shell.azure.com/.
2) Set the desired subscription where you want to deploy </br>
`az account set -s <your subscription ID>`
3) Create a resource group for your VMSS </br>
```
az group create \
--location westus \
--name vmagentrg
```
4) Create a virtual machine in your resource group. In this example the UbuntuLTS VM image is specified.</br>
```
az vm create --resource-group vmagentrg --name vmagentlinux --image UbuntuLTS --admin-username azureuser --generate-ssh-keys
```
The above command creates  default Virtual network, NIC, NSG, Public IP.
To further tweak the components created refer <a href='https://docs.microsoft.com/en-us/azure/virtual-machines/linux/quick-create-cli'>here.</a>

5) After the VM is created , you would get the SSH Key files stored in your local (Either CMD / CLoud Shell / Powershell) 

     ![image](https://user-images.githubusercontent.com/94544313/153742532-5c49040b-5f74-43e3-85cd-f24dd8ca876d.png)
     
6) To login into the VM upload the id_rsa file to the Putty Session
     ![image](https://user-images.githubusercontent.com/94544313/153747721-73f4458e-7e09-4f28-a967-e3607ed2ed6e.png)
     
Here we have used MobaXterm and entered our details under Advanced settings in a New Session.

### Part 2: Create Agent Pool in Azure Devops Portal
1) Go to organisation setting/project setting and select Agent Pools. Create new agent pool and select 'Self-Hosted'.
  !![image](https://user-images.githubusercontent.com/94544313/153747609-5840d998-b7bf-4da4-a6f9-111404e3e403.png)

2) The user configuring the agent needs pool admin permissions, but the user running the agent does not

### Part 3: Download , Create and Configure the Agent
 1) Click on the Agent Pool and New Agent.
 
 2) Download the Agent , Create Agent folder <myagent>.
  
 3) Run ./config.sh for configuration
This step would ask for details
Server URL : https://dev.azure.com/{your-organization}
PAT Token : Enter the PAT token from DevOps portal 
Follow link to create PAT 
<a href='https://docs.microsoft.com/en-us/azure/devops/pipelines/agents/v2-linux?view=azure-devops#authenticate-with-a-personal-access-token-pat'>here.</a>
  
 4) Enter the Agent Pool Name 
 5) Enter the Agent Name (Name of the VM created in Part 1) 
  Post this step the agent would appear in the Agent Pool

  ![image](https://user-images.githubusercontent.com/94544313/153749319-9ab21032-1fae-4bd7-9a84-22f952c16bc5.png)

  ![image](https://user-images.githubusercontent.com/94544313/153749344-8e48ea42-72c8-4a59-a631-63110b5718c1.png)

 6) Enter the work folder ( can be _work)
 4) Run the Agent Interactively, for the Agent to be online 
Execute ./run.sh 
  
  ![image](https://user-images.githubusercontent.com/94544313/153749540-589d94c5-8452-4155-af79-bb97b5c3f21a.png)

  

![image](https://user-images.githubusercontent.com/94544313/153748540-7bb74776-2dac-40bf-ab66-1ed71ad23186.png)

  




For more details refer the <a href='</a>https://docs.microsoft.com/en-us/azure/devops/pipelines/agents/scale-set-agents?view=azure-devops'>official documentation.</a>





