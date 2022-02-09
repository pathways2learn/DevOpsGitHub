terraform {
}

provider "azurerm" {
  features {}
}

// ResourceGroup for the ACR
resource "azurerm_resource_group" "acrrg" {
  name     = var.acr_resource_group_name
  location = var.location
}

// ACR
resource "azurerm_container_registry" "acr" {
  name                          = var.acr_name
  resource_group_name           = azurerm_resource_group.acrrg.name
  location                      = azurerm_resource_group.acrrg.location
  sku                           = var.acr_sku
  public_network_access_enabled = true
  admin_enabled                 = true
}

// This is required for ACR and ACI tasks
resource "azurerm_role_definition" "AcrListCredentials" {
  name        = "AcrListCredentials"
  scope       = azurerm_resource_group.acrrg.id
  description = "This custom role provides list credentials and pull/push images access for the Azure Container Registry resources"
  permissions {
    actions     = ["Microsoft.ContainerRegistry/registries/read", "Microsoft.ContainerRegistry/registries/listCredentials/action", "Microsoft.ContainerRegistry/registries/pull/read", "Microsoft.ContainerRegistry/registries/push/write"]
    not_actions = []
  }
}

// Role assignment for the current user.
resource "azurerm_role_assignment" "AcrPullPush" {
  role_definition_id = azurerm_role_definition.AcrListCredentials.role_definition_resource_id
  scope              = azurerm_container_registry.acr.id
  principal_id       = data.azurerm_client_config.current.object_id
}