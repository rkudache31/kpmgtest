##############################################################################################
#This file contains variables intialization for commercial Development
##############################################################################################

###########################Resource Group#############################################
resource_group_name = "dev-rg"
location            = "centralus"

######################### Virtual Network############################
virtual_network_name        = "non-prod-vnet"
subnet_name                 = "dev-fin-key-sub"
vnet_resource_group_name    = "non-prod-vnet-rg"
pe_subnet_name              = "dev-fin-pep-app-sub"

######################### key vault########################################
key_vault_name                       = "dev-fin-shr-key-cus"
enabled_for_deployment               = false
enabled_for_disk_encryption          = true
enabled_for_template_deployment      = false
purge_protection_enabled             = true
soft_delete_retention_days           = 7
sku_name                             = "standard"

######################## network ACL###################################
default_action                  = "Deny"
bypass                          = "AzureServices"
ip_rules                        = ["100.0.0.1"]

###########################key vault access################################
secret_permissions              = "Get"
key_permissions                 = "Get"

#############################tags#########################################
tags    = {}