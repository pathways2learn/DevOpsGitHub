
# Creating Azure DevOps self-hosted agents using VMSS

Currently only Windows or Linux VMSS agents are supported and not macOS.

In this example we will be deploying a Linux VMSS agent.

### Part 1: Follow the below steps to deploy a VMSS using Azure CLI

1) Browse to cloud shell at https://shell.azure.com/.
2) Set the desired subscription where you want to deploy </br>
`az account set -s <your subscription ID>`
3) Create a resource group for your VMSS </br>
```
az group create \
--location westus \
--name vmssagents
```
4) Create a virtual machine scale set in your resource group. In this example the UbuntuLTS VM image is specified.</br>
```
az vmss create \
--name vmssagentspool \
--resource-group vmssagents \
--image UbuntuLTS \
--vm-sku Standard_D2_v3 \
--storage-sku StandardSSD_LRS \
--authentication-type SSH \
--instance-count 2 \
--generate-ssh-keys \
--disable-overprovision \
--upgrade-policy-mode manual \
--single-placement-group false \
--platform-fault-domain-count 1 \
--load-balancer ""
```
For more details on the above parameters and why it is required, refer <a href='https://docs.microsoft.com/en-us/azure/devops/pipelines/agents/scale-set-agents?view=azure-devops#create-the-scale-set'>here.</a>

5) If you want to use a <a href='</a>https://docs.microsoft.com/en-us/azure/devops/pipelines/agents/scale-set-agents?view=azure-devops#create-a-scale-set-with-custom-image-software-or-disk-size'>custom image</a> you can create one and use it to deploy VMSS. To use the VM images used in Microsoft-hosted agents, refer <a href='https://github.com/actions/virtual-environments/tree/main/images'>here.</a>
6) To add start up script for example to preinstall software etc. install the <a href='https://docs.microsoft.com/en-us/azure/devops/pipelines/agents/scale-set-agents?view=azure-devops#customizing-virtual-machine-startup-via-the-custom-script-extension'>Custom Script Extension</a> for Windows or for Linux. This extension will be executed on every virtual machine in the scaleset immediately after it is created or reimaged. The custom script extension will be executed before the Azure Pipelines agent extension is executed.
</br>

### Part 2: Configure Agent Pool to use VMSS agents
1) Go to organisation setting/project setting and select Agent Pools. Create new agent pool and select 'Azure virtual machine scale set'. Select the appropriate subscription and _Authorize_. If you have an existing service connection you can choose that from the list instead of the subscription. If you are not able to view your VMSS then check your service connection/subscription permissions else refer <a href='https://docs.microsoft.com/en-us/azure/devops/pipelines/release/azure-rm-endpoint?view=azure-devops#insufficient-privileges-to-complete-the-operation'>troubleshoot.</a></br>
![image](https://user-images.githubusercontent.com/57246376/153708379-dc3d7938-beb1-4f4e-9252-5c9ad17b98e3.png)
2) To configure a scale set agent pool, you must have either _Owner_ or _User Access Administrator_ permissions on the selected subscription.
3) Fill the below parameters and click _Create_:
    - **Automatically tear down virtual machines after every use** - A new VM instance is used for every job. After running a job, the VM will go offline and be reimaged before it picks up another job. If is is unchecked then the VM agent immediately picks another job without getting reimaged.
    - **Save an unhealthy agent for investigation** - Whether to save unhealthy agent VMs for troubleshooting instead of deleting them.
    - **Maximum number of virtual machines in the scale set** - Azure Pipelines will automatically scale out(increase) the number of agents, but won't exceed this limit.
    - **Number of agents to keep on standby** - Azure Pipelines will automatically scale in(decrease) the number of agents, but will ensure that there are always this many agents available to run new jobs. If you set this to 0, for example to conserve cost for a low volume of jobs, Azure Pipelines will start a VM only when it has a job.
    - **Delay in minutes before deleting excess idle agents** - To account for the variability in build load throughout the day, Azure Pipelines will wait this long before deleting an excess idle agent(agents which are online and not running any job).
    - **Configure VMs to run interactive tests (Windows Server OS Only)** - Windows agents can either be configured to run unelevated with autologon and with interactive UI, or they can be configured to run with elevated permissions. Check this box to run unelevated with interactive UI. In either case, the agent user is a member of the Administrators group.</br>
![image](https://user-images.githubusercontent.com/57246376/153709304-0c3a50b7-1166-4c7d-8467-82538afc2c0f.png)
4) The VMSS agent pool gets created</br>
![image](https://user-images.githubusercontent.com/57246376/153709495-0f603b38-d409-4528-9915-55bba0e8c1d1.png)
5) Allow 20 minutes for machines to be created for each step.</br>
![image](https://user-images.githubusercontent.com/57246376/153709566-e4cc2be8-24f5-4090-8985-bb28c65d67ca.png)
</br>

**Azure pipelines manages the scaling by:**
- Checking the state of the agents in the pool and VMs in the scale set every 5 min.
- Performing  scale out when:
    - The number of idle agents falls below the number of standby agents you specify
    - There are no idle agents to service pipeline jobs waiting in the queue
- Performing scale in when:
    - the number of idle agents exceeds the standby count for more than 30 minutes(configurable using _Delay in minutes before deleting excess idle agents_)

Due to the sampling size of 5 minutes, it is possible that all agents can be running pipelines for a short period of time and no scaling out will occur.

Check the Diagnostics tab in the VMSS agent pool to view the scale in and out logs.
![image](https://user-images.githubusercontent.com/57246376/153710008-6cb62c0e-79aa-47b0-8818-be0897b6d576.png)


For more details refer the <a href='</a>https://docs.microsoft.com/en-us/azure/devops/pipelines/agents/scale-set-agents?view=azure-devops'>official documentation.</a>





