###################################################################
#This files contains variable definitions.
###################################################################

################################Resorce Group#####################
variable "resource_group_name"  {
  description  = "shared resource group"
}

variable "location"  {
  description  = "Location of resource"
}

variable "team_number"  {
  description  = "team number to assign to resources that are being created"
  default =   ""
}

######################### virtual network #######################
variable "virtual_network_name"  {
  description  = "shared virtual network"
}

variable "subnet_name"  {
  description  = "subnet for key vault"
}

variable "vnet_resource_group_name"  {
  description  = "shared virtual network resource group"
}

variable "pe_subnet_name"  {
  description  = "private endpoint subnet name"
}

##########################################key vault##############################
variable "key_vault_name"  {
  description  = "Name of the key vault"
}

variable "enabled_for_deployment"  {
  type    =   bool
  description  = "specifies whether virtual machines are permitted to retrive certificates stored as secrets from the key vault"
}

variable "enabled_for_disk_encryption"  {
  type    =   bool
  description  = "specifies whether disk encryption is permitted to retrive secrets from the vault and unwrap keys"
}

variable "enabled_for_template_deployment"  {
  type    =   bool
  description  = "specifies whether resource manager is permitted to allow soft delete be enabled for this key vault"
}

variable "purge_protection_enabled"  {
  type    =   bool
  description  = "Pure protection enabled"
}

variable "soft_delete_retention_days"  {
  type    =   string
  description  = "soft delete retention days"
}

variable "sku_name"  {
  type    =   string
  description  = "SKU used for the key vault"
}

################################Network Acl##################################
variable "bypass"  {
  description  = "specifies which traffic can bypass the network rules"
}

variable "default_action"  {
  description  = "The default action to use when no rules match from ip_rules / virtual_network_subnet_ids"
}

variable "ip_rules"  {
  type    = list(string)
  description  = "One or more IP addresses, or CIDR blocks which should be able to access the key vault"
}

variable "secret_permissions"  {
  description  = "List of secret permissions"
}

variable "key_permissions"  {
  description  = "List of key permissions"
}

############################### Tags #############################
variable "tags"  {
  type    =   map(string)
  description  = "Tags for the resources"
}