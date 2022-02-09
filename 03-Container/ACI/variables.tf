
variable "acr_resource_group_name" {
  type = string
}

variable "aci_resource_group_name" {
  type = string
}

variable "location" {
  type = string
}

variable "acr_name" {
  type = string
}

variable "aci_name" {
  type = string
}

variable "aci_vnet_name" {
  type = string
}

variable "aci_vnet_address_space" {
  type = string
}

variable "aci_subnet_name" {
  type = string
}

variable "aci_subnet_address_prefixes" {
  type = string
}

variable "aci_network_profile_name" {
  type = string
}

variable "aci_ip_address_type" {
  type = string
}

variable "aci_os_type" {
  type = string
}

variable "aci_image_repository_name" {
  type = string
}

variable "aci_image_version" {
  type = string
}

variable "AZP_URL" {
  type = string
}

variable "AZP_POOL" {
  type = string
}

variable "AZP_TOKEN" {
  type      = string
  sensitive = true
}
