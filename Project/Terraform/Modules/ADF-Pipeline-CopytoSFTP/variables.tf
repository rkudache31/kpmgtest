variable "team_number" {
  description = "Team number to assign to resouces"
}

variable "storage_name" {
  description = "Specifies the name of the storage account"
}

variable "storage_acc_resource_group_name" {
  description = "Specifies the name of the resource group storage account is located in"
}

variable "sftp_storage_name" {
  description = "Specifies the name of the sftp storage account"
}

variable "adf_name" {
  description = "Name of the Data Factory"
}

variable "adf_resource_group" {
  description = "ADF resource group name"
}

variable "adf_managed_pep" {
  description = "Specifies the name which should be used for this Managed private endpoint"
}

variable "adf_sftp_managed_pep" {
  description = "Specifies the name which should be used for this Managed private endpoint"
}

variable "adf_sftp_managed_pep_sub_resource" {
  description = "Specifies the sub resource name which the Data Factory Private Endpoint is able to connect to. Changing this forces a new resource to be created"
}

variable "adf_linked_service_sftp" {
  type = map(object({
    name                     = string
    authentication_type      = string
    integration_rutime_name  = string
    host                     = string
    port                     = number
    skip_host_key_validation = bool 
  }))
}

variable "adf_sftp_admin_username" {
  description = "User name used to log on to the SFTP server"
}

variable "adf_sftp_admin_password" {
  description = "Password to log on to the SFTP server"
}