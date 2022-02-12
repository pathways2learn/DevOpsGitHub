terraform {
}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "acirg" {
  name     = var.aci_resource_group_name
  location = var.location
}

resource "azurerm_virtual_network" "acivnet" {
  name                = var.aci_vnet_name
  location            = azurerm_resource_group.acirg.location
  resource_group_name = azurerm_resource_group.acirg.name
  address_space       = [var.aci_vnet_address_space]
}

resource "azurerm_subnet" "acisubnet" {
  name                 = var.aci_subnet_name
  resource_group_name  = azurerm_resource_group.acirg.name
  virtual_network_name = azurerm_virtual_network.acivnet.name
  address_prefixes     = [var.aci_subnet_address_prefixes]
  service_endpoints    = ["Microsoft.Web"]

  delegation {
    name = "delegation"

    service_delegation {
      name    = "Microsoft.ContainerInstance/containerGroups"
      actions = ["Microsoft.Network/virtualNetworks/subnets/action"]
    }
  }
}

resource "azurerm_network_profile" "acinetworkprofile" {
  name                = var.aci_network_profile_name
  location            = azurerm_resource_group.acirg.location
  resource_group_name = azurerm_resource_group.acirg.name

  container_network_interface {
    name = "${var.aci_name}-acinic"

    ip_configuration {
      name      = "aciipconfig01"
      subnet_id = azurerm_subnet.acisubnet.id
    }
  }
}

resource "azurerm_container_group" "aci01" {
  name                = var.aci_name
  resource_group_name = azurerm_resource_group.acirg.name
  location            = azurerm_resource_group.acirg.location
  ip_address_type     = var.aci_ip_address_type
  os_type             = var.aci_os_type
  network_profile_id  = azurerm_network_profile.acinetworkprofile.id
  restart_policy      = "Always"

  container {
    name   = "${var.aci_name}-01"
    image  = "${data.azurerm_container_registry.acr.login_server}/${var.aci_image_repository_name}:${var.aci_image_version}"
    cpu    = "1"
    memory = "1"

    ports {
      port     = 443
      protocol = "TCP"
    }

    environment_variables = {
      GHRP_URL  = var.GHRP_URL
      GHRP_WORK = "_work"
    }
    secure_environment_variables = {
      GHRP_TOKEN = var.GHRP_TOKEN
    }
  }

  image_registry_credential {
    server   = data.azurerm_container_registry.acr.login_server
    username = data.azurerm_container_registry.acr.admin_username
    password = data.azurerm_container_registry.acr.admin_password
  }
}