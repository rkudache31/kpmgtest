##############################################################################################
#This file contains variables intialization for commercial Development
##############################################################################################

###########################Resource Group#############################################
resource_group_name = "dev-rg"

######################### Virtual Network############################
virtual_network_name        = "non-prod-vnet"
subnet_name                 = "dev-fin-sqm-sub"
vnet_resource_group_name    = "non-prod-vnet-rg"
pe_subnet_name              = "dev-fin-pep-data-sub"

###########################SQL Managed Instance########################
DatabaseSQLMI   =   {
  db_instance_1 =   {
    name                =   "fin-db-instance"
    resource_group_name =   "dev-rg"
    location            =   "centralus"
    license_type        =   "BasePrice"
    sku_name            =   "GP_Gen5"
    vcores              =   "8"
    public_data_endpoint_enabled = "false"
    storage_size_in_gb  =   "1024"
    storage_account_type =  "LRS" 
  }
}

#############################tags#########################################
tags    =   {}