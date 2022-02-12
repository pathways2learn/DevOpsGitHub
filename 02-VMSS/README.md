# Creating Azure DevOps self-hosted agents using VMSS

Currently only Windows or Linux VMSS agents are supported and not macOS.

In this example we will be deploying a Linux VMSS agent.

### Follow the below steps to deploy a VMSS using Azure ACI:

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
--ephemeral-os-disk true \
--os-disk-caching readonly \
--load-balancer ""
```
For more details on the above parameters and why it is required, refer <a href='https://docs.microsoft.com/en-us/azure/devops/pipelines/agents/scale-set-agents?view=azure-devops#create-the-scale-set'>here.</a>

5) If you want to use a <a href='</a>https://docs.microsoft.com/en-us/azure/devops/pipelines/agents/scale-set-agents?view=azure-devops#create-a-scale-set-with-custom-image-software-or-disk-size'>custom image</a> you can create one and use it to deploy VMSS. To use the VM images used in Microsoft-hosted agents, refer <a href='https://github.com/actions/virtual-environments/tree/main/images'>here.</a>
6) To add start up script for example to preinstall software etc. install the <a href='https://docs.microsoft.com/en-us/azure/devops/pipelines/agents/scale-set-agents?view=azure-devops#customizing-virtual-machine-startup-via-the-custom-script-extension'>Custom Script Extension</a> for Windows or for Linux. This extension will be executed on every virtual machine in the scaleset immediately after it is created or reimaged. The custom script extension will be executed before the Azure Pipelines agent extension is executed.


