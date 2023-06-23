############################################################################
# This file containes terraform code to provision Redis Cache
############################################################################

#########################Resource Group#################################
resource "azurerm_resource_group" "red_rg" {
  count    = var.provisionresgrp ? 1 : 0
  name     = var.resource_group_name
  location = var.location
}

data "azurerm_resource_group" "red_rg" {
  count    = var.provisionresgrp ? 0 : 1
  name     = var.resource_group_name
}

######################## Redis Cache #################################
resource "azurerm_redis_cache" "red" {
  for_each                      = var.redis_cache
  name                          = each.value["redis_cache_name"]
  location                      = var.location
  resource_group_name           = var.provisionresgrp ? azurerm_resource_group.red_rg[0].name : data.azurerm_resource_group.red_rg[0].name
  capacity                      = each.value["capacity"]
  family                        = each.value["family"]
  sku_name                      = each.value["sku_name"]
  enable_non_ssl_port           = each.value["enable_non_ssl_port"]
  minimum_tls_version           = each.value["minimum_tls_version"]
  public_network_access_enabled = each.value["public_network_access_enabled"]

  patch_schedule {
    day_of_week        = each.value["day_of_week"]
    start_hour_utc     = each.value["start_hour_utc"]
  }
  tags          = var.tags
}

######################### subnet for PrivateEndpoint #######################
data "azurerm_subnet" "pe_subnet" {
  name                      = var.pe_subnet_name
  resource_group_name       = var.vnet_resource_group_name
  virtual_network_name      = var.virtual_network_name
}

######################## Private Endpoint ##########################
resource "azurerm_private_endpoint" "Privateendpoint" {
  for_each            = var.redis_cache  
  name                = "${resource.azurerm_redis_cache.red[each.key].name}-endpoint"
  location            = var.location
  resource_group_name = var.resource_group_name
  subnet_id           = data.azurerm_subnet.pe_subnet.id

  private_service_connection {
    name                           = "${resource.azurerm_redis_cache.red[each.key].name}-privateconnection"
    private_connection_resource_id = azurerm_redis_cache.red[each.key].id
    is_manual_connection           = false
    subresource_names              = ["redisCache"]
  }
}