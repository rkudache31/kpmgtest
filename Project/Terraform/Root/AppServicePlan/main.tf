###################################################################################
#This file contains terraform code to provision shared Resources - app service plan
###################################################################################

module "AppServicePlan" {
  source = "../../Modules/AppServicePlan"
  resource_group_name = var.resource_group_name
  app_service_plan = var.app_service_plan
  tags = var.tags
}