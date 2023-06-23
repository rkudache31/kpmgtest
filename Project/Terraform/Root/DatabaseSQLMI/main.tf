################################################################################
#This file contains terraform code to provision sql manged instance
################################################################################

###########################Managed Instance SQL Database #########################
module "DatabaseSQLMI" {
  source                =   "../../Modules/DatabaseSQLMI"
  DatabaseSQLMI         =   var.DatabaseSQLMI
  administrator_login   =   var.administrator_login
  administrator_password =  var.administrator_password
  resource_group_name   =   var.resource_group_name
  virtual_network_name  =   var.virtual_network_name
  vnet_resource_group_name = var.vnet_resource_group_name
  subnet_name           =   var.subnet_name
  pe_subnet_name        =   var.pe_subnet_name
  tags                  =   var.tags
}