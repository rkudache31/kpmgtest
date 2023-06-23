###################################################################
#This files contains variable definitions.
###################################################################

################################Resorce Group#####################
variable "resource_group_name"  {
  description  = "shared resource group"
}

variable "provisionresgrp" {
  description =   "provision resource group"
  type        =   bool
}

variable "location"  {
  description  = "Location of resource"
}

######################### subnet for PrivateEndpoint #######################
variable "pe_subnet_name"  {
  description  = "private endpoint subnet name"
}

variable "virtual_network_name"  {
  description  = "shared virtual network"
}

variable "vnet_resource_group_name"  {
  description  = "shared virtual network resource group"
}

######################## Redis Cache #################################
variable "redis_cache" {
  type = map(object({
    redis_cache_name              = string
    capacity                      = string
    sku_name                      = string
    family                        = string
    enable_non_ssl_port           = string
    minimum_tls_version           = string
    public_network_access_enabled = string
    day_of_week                   = string
    start_hour_utc                = string
  }))
}

############################### Tags #############################
variable "tags"  {
  type    =   map(string)
  description  = "Tags for the resources"
}