###################################################################################
# This file contains terraform code to provision Shared Resource - Redis Cache
###################################################################################

############################ Redis Cache #######################
module "RedisCache" {
  source                       = "../../Modules/RedisCache"
  redis_cache                  = var.redis_cache
  location                     = var.location
  resource_group_name          = var.resource_group_name
  provisionresgrp              = var.provisionresgrp
  vnet_resource_group_name     = var.vnet_resource_group_name
  virtual_network_name         = var.virtual_network_name
  pe_subnet_name               = var.pe_subnet_name
  tags                         = var.tags  
}