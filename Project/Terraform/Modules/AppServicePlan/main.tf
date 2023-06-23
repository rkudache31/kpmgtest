############### Resource Group ##################
#Importing pre-existing resource group
data "azurerm_resource_group" "group" {
  name = var.resource_group_name
}

############### App Service Plan #################
resource "azurerm_service_plan" "plan" {
  for_each               = var.app_service_plan
  name                   = each.value["name"]
  resource_group_name    = each.value["resource_group_name"]
  location               = each.value["location"]
  os_type                = each.value["os_type"]
  zone_balancing_enabled = each.value["zone_balancing_enabled"]
  sku_name               = each.value["sku_name"]
  tags                   = var.tags
}

resource "azurerm_monitor_autoscale_setting" "aspautoscalling" {
  for_each            = var.app_service_plan
  name                = each.value["autoscalling_name"]
  resource_group_name = each.value["resource_group_name"]
  location            = each.value["location"]
  target_resource_id  = lookup(merge(azurerm_service_plan.plan, azurerm_service_plan.plan), each.value["app_service_plan_key"])["id"]

  profile {
    name = each.value["profile_name"]

    capacity {
      default = each.value["capacity_default"]
      minimum = each.value["capacity_minimum"]
      maximum = each.value["capacity_maximum"]
    }

    rule {
      metric_trigger {
        metric_name        = each.value["metric_trigger_metric_name"]
        metric_resource_id = lookup(merge(azurerm_service_plan.plan, azurerm_service_plan.plan), each.value["app_service_plan_key"])["id"]
        time_grain         = each.value["metric_trigger_time_grain"]
        statistic          = each.value["metric_trigger_statistic"]
        time_window        = each.value["metric_trigger_time_window"]
        time_aggregation   = each.value["metric_trigger_time_aggregation"]
        operator           = each.value["rule1_metric_trigger_operator"]
        threshold          = each.value["rule1_metric_trigger_threshold"]
      }

      scale_action {
        direction = each.value["rule1_scale_action_direction"]
        type      = each.value["scale_action_type"]
        value     = each.value["scale_action_value"]
        cooldown  = each.value["scale_action_cooldown"]
      }
    }

    rule {
      metric_trigger {
        metric_name        = each.value["metric_trigger_metric_name"]
        metric_resource_id = lookup(merge(azurerm_service_plan.plan, azurerm_service_plan.plan), each.value["app_service_plan_key"])["name"]
        time_grain         = each.value["metric_trigger_time_grain"]
        statistic          = each.value["metric_trigger_statistic"]
        time_window        = each.value["metric_trigger_time_window"]
        time_aggregation   = each.value["metric_trigger_time_aggregation"]
        operator           = each.value["rule1_metric_trigger_operator"]
        threshold          = each.value["rule1_metric_trigger_threshold"]
      }

      scale_action {
        direction = each.value["rule1_scale_action_direction"]
        type      = each.value["scale_action_type"]
        value     = each.value["scale_action_value"]
        cooldown  = each.value["scale_action_cooldown"]
      }
    }
  }
}
