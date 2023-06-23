############################################
#This file contains variable definitions
############################################

################## Resource Group #################
variable "resource_group_name" {
  description = "Shared Resource Group"
}

####################### App Service Plan ######################
variable "app_service_plan" {
  type = map(object({
    name                            = string
    resource_group_name             = string
    location                        = string
    sku_name                        = string
    os_type                         = string
    zone_balancing_enabled          = bool
    app_service_plan_key            = string
    autoscalling_name               = string
    profile_name                    = string
    capacity_default                = number
    capacity_minimum                = number
    capacity_maximum                = number
    metric_trigger_metric_name      = string
    metric_trigger_time_grain       = string
    metric_trigger_statistic        = string
    metric_trigger_time_window      = string
    metric_trigger_time_aggregation = string
    rule1_metric_trigger_operator   = string
    rule1_metric_trigger_threshold  = number
    rule1_scale_action_direction    = string
    scale_action_type               = string
    scale_action_value              = number
    scale_action_cooldown           = string
    rule2_metric_trigger_operator   = string
    rule2_metric_trigger_threshold  = number
    rule2_scale_action_direction    = string
  }))
}

############################ tags #############################
variable "tags" {
  type       = map(string)
  description = "Tags for the resources"
}