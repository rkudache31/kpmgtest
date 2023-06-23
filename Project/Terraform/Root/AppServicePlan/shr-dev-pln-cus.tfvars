##################################################################
#This file contains variable initialization for commercial sandbox
##################################################################

#################### Resource Group ################
resource_group_name = "dev-rg" 

###################### App service Plan #########################
app_service_plan = {
  app_service_plan_attributes = {
    name                            = "dev-fiv-pln-cus"
    resource_group_name             = "dev-rg"
    location                        = "East US"
    sku_name                        = "P1v2"
    os_type                         = "Windows"
    zone_balancing_enabled          = false
    app_service_plan_key            = "app_service_plan_attributes"
    autoscalling_name               = "dev-fin-pln-cus-autoscalling"
    profile_name                    = "AppServicePlanProfile"
    capacity_default                = 1
    capacity_minimum                = 1
    capacity_maximum                = 1
    metric_trigger_metric_name      = "CpuPercentage"
    metric_trigger_time_grain       = "PT1M"
    metric_trigger_statistic        = "Average"
    metric_trigger_time_window      = "PT5M"
    metric_trigger_time_aggregation = "Average"
    rule1_metric_trigger_operator   = "GreaterThan"
    rule1_metric_trigger_threshold  = 80
    rule1_scale_action_direction    = "Increase"
    scale_action_type               = "ChangeCount"
    scale_action_value              = "1"
    scale_action_cooldown           = "PT1M"
    rule2_metric_trigger_operator   = "LessThan"
    rule2_metric_trigger_threshold  = 50
    rule2_scale_action_direction    = "Decrease"
  }
}

########################## Tags ##############################
tags = {}