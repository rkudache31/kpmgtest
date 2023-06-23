module "adf_pipeline_CopytoSFTP" {
  source                               = "../../Modules/ADF-Pipeline-CopytoSFTP"
  team_number = var.team_number
  storage_name = var.storage_name
  storage_acc_resource_group_name = var.storage_acc_resource_group_name
  sftp_storage_name = var.sftp_storage_name
  adf_name = var.adf_name
  adf_resource_group = var.adf_resource_group
  adf_managed_pep = var.adf_managed_pep
  adf_sftp_managed_pep = var.adf_sftp_managed_pep
  adf_sftp_managed_pep_sub_resource = var.adf_sftp_managed_pep_sub_resource
}