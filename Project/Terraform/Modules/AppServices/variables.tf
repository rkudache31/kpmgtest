variable "resource_group_name" {
  description = "Shared resource group"
}

variable "team_number" {
  description = "team number to assign to resource"
}

variable "vnet_resource_group_name" {
  description = "Vitual network resource group"
}

variable "virtual_network_name" {
  description = "Shared virtual network"
}

variable "integration_subnet_name" {
  description = "Subnet for App service"
}

variable "pe_subnet_name" {
  description = "Private endpoint subnet name"
}

variable "app_service_plan_name" {
  description = "App service plan name"
}

varibale "app_services" {
  type = map(object({
    name = string
    location = string
    app_service_plan_key = string
    app_service_key = string
    dotnet_version = string
    use_32_bit_worker_process = bool
    always_on = bool
    min_tls_version = string
    default_doc_set = string
    default_documents = string
    https_only = bool
    health_check_path = string
    detailed_error_messages_enables = bool
    excluded_paths = optional(list(string), [])
    detailes_error_messages_enables = bool
    failed_request_tracing_enabled = bool
    retention_in_days = string
    retention_in_mb = string
    file_system_level = string
    current_stack = string
    customer_provider_enables = optional(bool, false)
    ad_provider_enables = optional(bool, false)
    token_store_enabled = optiona(bool, false)
    unathenticated_action = optional(string, "RedirectToLoginPage")
    eventhub_logs_name = string
    eventhub_metrics_name = string
  }))
}

variable "vnet_route_all_enables" {
  description = "Virtual Network Security Groups and user Defined Routes applied"
  default = "true"
}

variable "app_settings" {
  type = map(string)
  description = "Dynamic app settings details"
  default = {
    WEBSITE_RUN_FROM_PACKAGE = 0
  }
}

variable "auth_v2_enabled" {
  description = "Enable or Disable auth settings"
  default = false
}

variable "adv2_oidc_providers" {
  type = object({
    adv2_providers = object({
      tenant_auth_endpoint = string
      client_secret_setting_name = string 
    }) 
  })
  default = {
    adv2_providers = {
      tenant_auth_endpoint = "https://login.microsoftonline.com/v2.0/"
      client_secret_setting_name = "MICROSOFT_PROVIDER_AUTHENTICATION_SECRET"
    }
  }
}

variable "custom_oidc_providers" {
  type = object({
    custom_providers = object({
      name = string
      client_id = string
      openid_configuration_endpoint = string
    })
  })
  default = {
    custom_providers = {
      name = "default"
    }
  }
}

