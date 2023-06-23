vnet_resource_group_name = "non-prod-vnet-rg"
virtual_network_name     = "non-prod-vnet"

pe_subnet_name = "dev-fin-pep-app-sub"

sql_managed_instance_name = ""
sql_resource_group_name   = "dev-rg"

adf_name                        = "dev-adf"
location                        = "centralus"
resource_group_name             = "dev-rg"
managed_virtual_network_enabled = true

adf_ssis_name   = "dev-sis"
node_size       = "Standard_D2_V2"
number_of_nodes = "1"
pricing_tier    = "Basic"
adfsubnet       = "dev-fin-adf-sub"

azurerm_data_factory_managed_pe_name = "dev-mpe"
subresource_name                     = "managedInstance"