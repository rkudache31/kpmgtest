#######################################################################################
#This file contains terraform code to provision sql managed instance
#######################################################################################

######################Resource group##################################
#Importing pre-existing resource group
data "azurerm_resource_group"   "rg" {
    name        =   "${var.resource_group_name}"
}

##############################Database Vnet & subnet###################
# Importing subnet created in previous pipeline
data "azurerm_subnet" "dbsubnet" {
  name                      = var.subnet_name
  resource_group_name       = var.vnet_resource_group_name
  virtual_network_name      = var.virtual_network_name
}

data "azurerm_subnet" "pe_subnet" {
  name                      = var.pe_subnet_name
  resource_group_name       = var.vnet_resource_group_name
  virtual_network_name      = var.virtual_network_name
}

###########################SQL Managed Instance########################
resource "azurerm_sql_managed_instance" "sqlmi" {
  for_each                     = var.DatabaseSQLMI  
  name                         = each.value["name"]
  resource_group_name          = each.value["resource_group_name"]
  location                     = each.value["location"]
  administrator_login          = var.administrator_login
  administrator_login_password = var.administrator_password
  license_type                 = each.value["license_type"]
  subnet_id                    = data.azurerm_subnet.dbsubnet.id
  sku_name                     = each.value["sku_name"]
  vcores                       = each.value["vcores"]
  public_data_endpoint_enabled = each.value["public_data_endpoint_enabled"]
  storage_size_in_gb           = each.value["storage_size_in_gb"]
  storage_account_type         = each.value["storage_account_type"]
  tags                         = var.tags

  identity  {
    type    = var.license_type
  }
}

############################Private Endpoint##############################
resource "azurerm_private_endpoint" "privateendpoint" {
  for_each                = var.DatabaseSQLMI
  name                    = "${resource.azurerm_mssql_managed_instance.sqlmi[each.key].name}-endpoint" 
  resource_group_name     = data.azurerm_resource_group.rg.name
  location                = each.value["location"]
  subnet_id               = data.azurerm_subnet.pe_subnet.id

  private_service_connection {
    name                           = "${resource.azurerm_mssql_managed_instance.sqlmi[each.key].name}-privateconnection"
    private_connection_resource_id = azurerm_mssql_managed_instance.sqlmi[each.key].id
    is_manual_connection           = false    
    subresource_names              = ["managedInstance"]
  }
}