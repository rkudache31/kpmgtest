variable "resource_group_name" {
  description = "Shared resource group"
}

variable "team_number" {
  description = "team number to assign to resource"
  default     = ""
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

variable "RedisAccessKey" {
  description = "Access key for azure redis instance with key vault reference syntax"
}

variable "ConfigEncryptionKey" {
  description = "Access key for storage account instance with key vault reference syntax"
}

variable "app_service_plan_name" {
  description = "App service plan name"
}

variable "keyvault_name" {
  description = "Name of the key vault resource"
}

varibale "app_services" {
  type = map(object({
    name                            = string
    location                        = string
    app_service_plan_key            = string
    app_service_key                 = string
    dotnet_version                  = string
    use_32_bit_worker_process       = bool
    always_on                       = bool
    min_tls_version                 = string
    default_doc_set                 = string
    default_documents               = string
    https_only                      = bool
    health_check_path               = string
    detailed_error_messages_enables = bool
    excluded_paths                  = optional(list(string), [])
    detailes_error_messages_enables = bool
    failed_request_tracing_enabled  = bool
    retention_in_days               = string
    retention_in_mb                 = string
    file_system_level               = string
    current_stack                   = string
    customer_provider_enables       = optional(bool, false)
    ad_provider_enables             = optional(bool, false)
    token_store_enabled             = optiona(bool, false)
    unathenticated_action           = optional(string, "RedirectToLoginPage")
    eventhub_logs_name              = string
    eventhub_metrics_name           = string
  }))
}

locals {
  app_settings = {
    KeyVault_RedisAccessKey          = var.KeyVault_RedisAccessKey
    KeyVault_ConfigEncryptionKey     = var.KeyVault_ConfigEncryptionKey
    KeyVault_StorageAccountAccessKey = var.KeyVault_StorageAccountAccessKey
  }
}

variable "auth_v2_enabled" {
  description = "Enable or Disable auth settings"
  default     = false
}

variable "etghub_subscription_id" {
  description = "Subscription of the eventhub instance used for logs and metrics"
}

variable "eventhub_namespace" {
  description = "Eventhub namepsace resource name for telemetry"
}

variable "eventhub_resource_group_name" {
  description = "ResourceGroup that contains the eventhub namespace"
}

variable "eventhub_policy_name" {
  description = "The eventhub policy ti use defined in the Eventhub namespace resource"
}

variable "tags" {
  type        = map(string)
  description = "tags for the resources"
}