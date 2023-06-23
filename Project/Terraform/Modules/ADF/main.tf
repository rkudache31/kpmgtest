data "azurerm_virtual_network" "vnet" {
    name                = var.virtual_network_name
    resource_group_name = var.vnet_resource_group_name
}

data "azurerm_subnet" "pe_subnet" {
    name                    = var.pe_subnet_name
    resource_group_name     = var.vnet_resource_group_name
    virtual_network_name    = var.virtual_network_name
}

data "azurerm_sql_managed_instance" "SQLMI" {
    name                 = var.sql_mi_name == "null" ? "${var.sql_managed_instance_name}" : "${var.sql_mi_name}"
    resource_group_name  = var.sql_resource_group_name
}

resource "azurerm_data_factory" "adf" {
  name                            = var.adf_name
  location                        = var.location
  resource_group_name             = var.resource_group_name
  managed_virtual_network_enabled = var.managed_virtual_network_enabled
}

resource "azurerm_data_factory_integration_runtime_azure_ssis" "adfssis" {
  name            = var.adf_ssis_name
  data_factory_id = azurerm_data_factory.adf.id
  location        = var.location
  node_size       = var.node_size
  number_of_nodes = var.number_of_nodes
  catalog_info {
    server_endpoint        = data.azurerm_sql_managed_instance.SQLMI.fqdn
    administrator_login    = var.administrator_login
    administrator_password = var.administrator_password
    pricing_tier           = var.pricing_tier
  }
  vnet_integration {
    vnet_id     = data.azurerm_virtual_network.vnet.id
    subnet_name = var.adfsubnet
  }
}

resource "azurerm_private_endpoint" "Privateendpoint" {
  name                = "${var.adf_name}-endpoint"
  resource_group_name = "${var.resource_group_name}"
  location            = var.location
  subnet_id           = data.azurerm_subnet.pe_subnet.id

  private_service_connection {
    name                           = "${var.adf_name}-privateconnection"
    private_connection_resource_id = azurerm_data_factory.adf.id
    is_manual_connection           = false
    subresource_names              = ["dataFactory"]
  }
}

resource "azurerm_data_factory_managed_private_endpoint" "adfmgnpe" {
  name               = var.azurerm_data_factory_managed_pe_name
  data_factory_id    = azurerm_data_factory.adf.id
  target_resource_id = data.azurerm_sql_managed_instance.SQLMI.id
  subresource_name   = var.subresource_name
}