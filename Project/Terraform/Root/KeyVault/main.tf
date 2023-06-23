###################################################################################
# This file contains terraform code to provision Shared Resource - Keyvault
###################################################################################

############################ subnet for Keyvault #######################
# Importing subnet created in previous pipeline
data "azurerm_subnet"   "snet"  {
  # subnet namec derived conditinally
  name                      = var.subnet_name
  resource_group_name       = var.vnet_resource_group_name
  virtual_network_name      = var.virtual_network_name
}

data "azurerm_subnet"   "pe_subnet"  {
  name                      = var.pe_subnet_name
  resource_group_name       = var.vnet_resource_group_name
  virtual_network_name      = var.virtual_network_name
}

########################### Key Vault ########################################
data "azurerm_client_config" "current"  {}
resource "azurerm_key_vault" "kvault" {
  name                                 = var.key_vault_name
  resource_group_name                  = var.resource_group_name
  location                             = var.location
  tenant_id                            = data.azurerm_client_config.current.tenant_id  
  enabled_for_deployment               = var.enabled_for_deployment
  enabled_for_disk_encryption          = var.enabled_for_disk_encryption
  enabled_for_template_deployment      = var.enabled_for_template_deployment
  purge_protection_enabled             = var.purge_protection_enabled
  soft_delete_retention_days           = var.soft_delete_retention_days
  sku_name                             = var.sku_name
  network_acls {
    default_action             = var.default_action
    bypass                     = var.bypass
    ip_rules                   = var.ip_rules
    virtual_network_subnet_ids = [data.azurerm_subnet.snet.id]   
  }
  tags  = var.tags
}

######################### Keyvault access policy#######################
resource "azurerm_key_vault_access_policy" "kvault_access_policy" {
  key_vault_id           = azurerm_key_vault.kvault.id
  tenant_id              = data.azurerm_client_config.current.tenant_id
  object_id              = data.azurerm_client_config.current.object_id
  key_permissions        = [var.key_permissions]
  secret_permissions     = [var.secret_permissions]
}

############################# Keyvault private endpoint###########################
resource "azurerm_private_endpoint" "sandbox_kv" {
  name                        = "${var.key_vault_name}-endpoint"
  resource_group_name         = "${var.resource_group_name}"
  location                    = var.location  
  subnet_id                   = data.azurerm_subnet.pe_subnet.id

  private_service_connection {
    name                           = "${var.key_vault_name}-privateconnection"
    private_connection_resource_id = azurerm_key_vault.kvault.id
    is_manual_connection           = false
    subresource_names              = ["Vault"]
  }
}