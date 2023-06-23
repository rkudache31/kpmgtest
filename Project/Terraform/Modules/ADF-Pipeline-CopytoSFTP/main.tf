data "azurerm_storage_account" "existing_storage" {
  name                = var.team_number == "null" ? "${var.storage_name}" : "${var.storage_name}${var.team_number}"
  resource_group_name = var.team_number == "null" ? "${var.storage_acc_resource_group_name}" : "${var.storage_acc_resource_group_name}-${var.team_number}"
}

data "azurerm_storage_account" "existing_storage_sftp" {
  name                = var.team_number == "null" ? "${var.sftp_storage_name}" : "${var.sftp_storage_name}${var.team_number}"
  resource_group_name = var.team_number == "null" ? "${var.storage_acc_resource_group_name}" : "${var.storage_acc_resource_group_name}-${var.team_number}"
}

data "azurerm_data_factory" "existing_adf" {
  name                = var.adf_name
  resource_group_name = var.adf_resource_group
}

resource "azurerm_data_factory_managed_private_endpoint" "managed_pep_sto" {
  name               = var.team_number == "null" ? "${var.adf_managed_pep}-endpoint" : "${var.adf_managed_pep}-${var.team_number}-endpoint" 
  data_factory_id    = data.azurerm_data_factory.existing_adf.id
  target_resource_id = data.azurerm_storage_account.existing_storage.id
  subresource_name   = var.adf_sftp_managed_pep_sub_resource
}

resource "azurerm_data_factory_linked_service_sftp" "linked_sftp" {
  for_each = var.adf_linked_service_sftp
  name = each.value["name"]
  data_factory_id = data.azurerm_data_factory.existing_adf.id
}
