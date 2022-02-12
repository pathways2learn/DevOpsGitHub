# Creating DevOps self-hosted agents using VMSS

### Follow the below steps to deploy a VMSS using Azure ACI:

1) Set the desired subscription where you want to deploy </br>
`az account set -s <your subscription ID>`
2) Create a resource group for your VMSS </br>
```
az group create \
--location westus \
--name vmssagents
```
3) Create a virtual machine scale set in your resource group. In this example the UbuntuLTS VM image is specified.</br>
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
