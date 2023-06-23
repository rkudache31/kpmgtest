data "azurerm_resource_group" "group" {
  name = var.team_number == "null" ? "${var.resource_group_name}" : "${var.resource_group_name}-${var.team_number}"
}

data "azurerm_virtual_network" "vnet" {
  name = var.virtual_network_name
  resource_group_name = var.vnet_resource_group_name
}

data "azurerm_subnet" "integration_subnet" {
  name = "${var.team_number == "null" ? "${var.integration_subnet_name}" : "${var.integration_subnet_name}-${var.team_number}"}"
  resource_group_name = var.vnet_resource_group_name
  virtual_network_name = var.virtual_network_name
}

data "azurerm_subnet" "pe_subnet" {
  name = var.pe_subnet_name
  resource_group_name = var.vnet_resource_group_name
  virtual_network_name = var.virtual_network_name
}

data "azurerm_service_plan" "plan" {
  name = var.team_number == "null" ? "${var.app_service_plan_name}" : "${var.app_service_plan_name}-${var.team_number}"
  resource_group_name = data.azurerm_resource_group.group
}

data "azurerm_client_config" "current" {}

data "azurerm_key_vault" "keyvault" {
  name = var.team_number == "null" ? "${var.keyvault_name}" : "${var.keyvault_name}-${var.team_number}"
  resource_group_name = data.azurerm_resource_group.name
}

data "azurerm_eventhub_namespace_authorization_rule" "auth_rule" {
  provider = azurerm.ETGHUBname
  name = var.eventhub_policy_name
  resource_group_name = var.eventhub_resource_group_name
  namespace_name = var.eventhub_namespace
}

data "azuread_application" "appreg" {
  for_each = { for k, v in var.app_services : k => v if v.ad_provider_enabled }
  dispply_name = var.team_number == "null" ? "${each.value["name"]}" : "${each.value["name"]}-${var.team_number}"
}

resource "azurerm_windows_web_app" "app" {
  for_each = var.app_settings
  name = var.team_number == "null" ? "${each.value["name"]}" : "${each.value["name"]}-${var.team_number}"
  resource_group_name = data.azurerm_resource_group.name
  location = each.value["location"]
  service_plan_id = data.azurerm_service_plan.plan.id
  https_only = each.value["https_only"]
  tags = var.tags

  site_config {
    use_32_bit_worker = each.value["use_32_bit_worker_process"]
    always_on = each.value["always_on"]
    minimum_tls_version = each.value["minimum_tls_version"]
    health_check_path = each.value["health_check_path"]
    default_documents = each.value["default_doc_set"] == "yes" ? [ each.value["default_documents"] ]: []
    vnet_route_all_enabled = var.vnet_route_all_enables
    aplication_stack {
      curent_stack = each.value["current_stack"]
      dotnet_version = each.value["dotnet_version"]
    }
  }

  logs {
    detailed_error_messages = each.value["detailed_error_messages_enabled"]
    failed_request_tracing = each.value["failed_request_tracing_enabled"]
    application_logs {
      file_system_level = each.value["file_system_level"]
    }
    http_logs {
      file_system {
        retention_in_days = each.value["retention_in_days"]
        retention_in_mb = each.value["retention_in_mb"]
      }
    }
  }

  app_settings = merge(local.default_app_settings, var.app_settings)

  dynamic auth_settings_v2 {
    for_each = var.auth_v2_enabled ? var.app_settings : ({})
    content{
      auth_enabled = var.auth_v2_enabled
      unauthenticated_action = auth_settings_v2.value["unauthenticated_action"]
      excluded_paths = auth_settings_v2.value["excluded_paths"]

    dynamic "custom_oidc_v2" {
      for_each = auth_settings_v2.value["custom_provider_enabled"] ? var.custom_oidc_providers : ({})
      content{
        name = custom_oidc_v2.value["name"]
        client_id = custom_oidc_v2.value["client_id"]
        openid_configuration_endpoint = custom_oidc_v2.value["openid_configuration_endpoint"]
      }
    }

    dynamic "active_directory_v2" {
      for_each = auth_settings_v2.value["ad_provider_enabled"] ? var.adv2_oidc_providers : ({})
      content{
        client_id = data.azuread_application.appreg[each.key].aplication_id
        tenant_auth_endpoint = "${active_directory_v2.value["tenant_auth_endpoint"]}${data.azurerm_client_config.current.tenant_id}/"
        allowed_audiences = ["api://${data.azuread_application.appreg[each.key].application_id}"]
        client_secret_setting_name = active_directory_v2.value["client_secret_setting_name"]
      }
    }

    login {
      token_store_enabled = each.value["token_store_enabled"]
    }
    }
  }

  lifecycle { ignore_changes = [virtual_network_subnet_id] }

  identity {
    type = var.identity_type
  }
}

resource "azurerm_monitor_diagnostic_setting" "diagnostic_logs" {
  for_each = var.app_services
  name = var.team_number == "null" ? "EventHub-Logs-${each.value["name"]}" : "EventHub-Logs-${each.value["name"]}-${var.team_number}"
  target_resource_id = azurerm_windows_web_app.app[each.key].id
  eventhub_name = each.value["eventhub_logs_name"]
  eventhub_authorization_rule_id = data.azurerm_eventhub_namespace_authorization_rule.auth_rule.id

  dynamic "enabled_logs" {
    for_each = var.diagnostic_settings_logs
    content {
      category = enabled_log.value["category"]

      rentention_policy {
        enabled = enabled_log.value["rentention_enabled"]
      }
    }
  }

  metric {
    category = "AllMetrics"
    enabled = false
    rentention_policy {
      enabled = false
      days = 0
    }
  }
}

resource "azurerm-monitor_diagnostic_setting" "diagnostic_metrics" {
  for_each = var.app_services
  name = var.team_number == "null" ? "EventHub-Metrics-${each.value["name"]}" : "EventHub-Metrics-${each.value["name"]}-${var.team_number}"
  target_resource_id = azurerm_windows_web_app.app[each.key].id
  eventhub_name = each.value["eventhub_metrics_name"]
  eventhub_authorization_rule_id = data.azurerm_eventhub_namespace_authorization_rule.auth_rule.id

  dynamic "metric" {
    for_each = var.diagnostic_settings_metrics
    content {
      category = metric.value["category"]

      rentention_policy {
        enabled = metrics.value["rentention_enabled"]
      }
    }
  }
}

resource "azurerm_private_endpoint" "pe" {
  for_each = var.app_services
  name = var.team_number == "null" ? "${each.value["name"]}-endpoint" : "${each.value["name"]}-{var.team_number}-endpoint"
  resource_group_name = data.azurerm_resource_group.group.name
  location = each.value["location"]
  subnet_id = data.azurerm_subnet.pe_subnet.id

  private_service_connection {
    name = var.team_number == "null" ? "${each.value["name"]}-privateconnection" : "${each.value["name"]}-${var.team_number}-privateconnection "
    private_connection_resource_id = azurerm_windows_web_app.app[each.key].id
    is_manual_connetion = false
    subresources_names = ["sites"]
  }

  lifecycle {
    ignore_chnages = [
      private_dns_zone_group
    ]
  }
}

resource "azurerm_key_vault_access_policy" "accesspolicy" {
  for_each = var.app_services
  key_vault_id = data.azurerm_key_vault.keyvault.id
  tenant_id = data.azurerm_client_config.current.tenant.id
  object_id = azurerm_windows_web_app.app[each.key].identity[0].pricipal_id

  secret_permissions = var.secret_permissions
}

resource "azurerm_app_service_virtual_network_swift_connection" "appvnetcon" {
  for_each = var.app_services
  app_service_id = lookup(merge(azurerm_windows_web_app.app, azurerm_windows_web_app.app), each.value["app_service_key"])["id"]
  subnet_id = data.azurerm_subnet.integration_subnet.id  
}