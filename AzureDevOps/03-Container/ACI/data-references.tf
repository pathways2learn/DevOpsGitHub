// ResourceGroup of the ACR
data "azurerm_resource_group" "acrrg" {
  name     = var.acr_resource_group_name
}

// ResourceGroup of the ACI
data "azurerm_container_registry" "acr" {
  name                = var.acr_name
  resource_group_name = data.azurerm_resource_group.acrrg.name
}