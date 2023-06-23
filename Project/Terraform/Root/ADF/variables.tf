variable "vnet_resource_group_name" {
  description = "Vnet resource group"
}

variable "virtual_network_name" {
  description = "Database virtual network name"
}

variable "pe_subnet_name" {
  description = "Private end point subnet"
}

variable "sql_mi_name" {
  description = "SQL managed instance name injected from pipeline"
}

variable "sql_managed_instance_name" {
  description = "SQL managed instance name"
}

variable "sql_resource_group_name" {
  description = "SQL resource group name"
}

variable "adf_name" {
  description = "Name of the Data Factory"
}

variable "location" {
  description = "Location of the resource"
}

variable "resource_group_name" {
  description = "Resource group name"
}

variable "managed_virtual_network_enabled" {
  description = "Is Managed Virtual Network Enabled"
  type = bool
}

variable "adf_ssis_name" {
  description = "Name of the Azure-SSIS"
}

variable "node_size" {
  description = "The size of the nodes on which the Azure-SSIS Integration runtime runs"
}

variable "number_of_nodes" {
  description = "Number of nodes for the Azure-SSIS Integeration Rutime "
}

variable "administrator_login" {
  description = "DB admin login"
}

variable "administrator_password" {
  description = "DB admin password"
}

variable "pricing_tier" {
  description = "Pricing tier for the database that will be created for the SSIS catalog."
}

variable "adfsubnet" {
  description = "Data factory subnet name"
}

variable "azurerm_data_factory_managed_pe_name" {
  description = "Azure Data factory managed private endpoint name"
}

variable "subresource_name" {
  description = "subresource name"
}