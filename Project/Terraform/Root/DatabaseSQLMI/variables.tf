###################################################################
#This files contains variable definitions.
###################################################################

################################Resorce Group#####################
variable "resource_group_name"  {
    description  = "shared resource group"
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

variable "administrator_login"  {
    description  = "DB admin login"
}

variable "administrator_password"  {
    description  = "DB admin password"
}

##########################################key vault##############################
variable "DatabaseSQLMI"  {
  type  =  map(object({
    name                             =   string  
    resource_group_name              =   string
    location                         =   string
    license_type                     =   string
    sku_name                         =   string
    vcores                           =   string
    public_data_endpoint_enabled     =   string
    storage_size_in_gb               =   string
    storage_account_type             =   string
  }))
}

variable "identity"  {
  description   =  "Identity used to access other resources"
  default    = "SystemAssigned"
}

############################### Tags #############################
variable "tags"  {
    type    =   map(string)
    description  = "Tags for the resources"
}