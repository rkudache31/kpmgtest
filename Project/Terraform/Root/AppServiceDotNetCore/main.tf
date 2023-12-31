module "webapp" {
  source                       = ""
  resource_group_name          = var.resource_group_name
  team_number                  = var.team_number
  app_services                 = var.app_services
  keyvault_name                = var.keyvault_name
  integration_subnet_name      = var.integration_subnet_name
  pe_subnet_name               = var.pe_subnet_name
  virtual_network_name         = var.virtual_network_name
  vnet_resource_group_name     = var.vnet_resource_group_name
  app_service_plan_name        = var.app_service_plan_name
  app_settings                 = local.app_settings
  auth_v2_enabled              = var.auth_v2_enabled
  etghub_subscription_id       = var.etghub_subscription_id
  eventhub_namespace           = var.eventhub_namespace
  eventhub_resource_group_name = var.eventhub_resource_group_name
  eventhub_policy_name         = var.eventhub_policy_name
  tags                         = var.tags
}
