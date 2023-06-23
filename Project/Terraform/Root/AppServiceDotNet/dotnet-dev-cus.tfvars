resource_group_name      = ""
virtual_network_name     = ""
integration_subnet_name  = ""
pe_subnet_name           = ""
vnet_resource_group_name = ""
app_service_plan_name    = ""
app_service = {
  app_service-dotnet = {
    name                            = ""
    location                        = ""
    dotnet_version                  = ""
    app_service_key                 = ""
    app_service_plan_key            = ""
    https_only                      = true
    use_32_bit_worker_process       = false
    default_doc_set                 = "yes"
    default_documents               = "hostingstart.html"
    always_on                       = true
    detailed_error_messages_enables = false
    failed_request_tracing_enabled  = false
    file_system_level               = "Error"
    min_tls_version                 = "1.2"
    health_check_path               = "/HealthCheck.svc/api/health"
    excluded_paths                  = ["/HealthCheck.svc/api/health", "/HealthCheck.svc/api/ping"]
    retention_in_days               = 7
    retention_in_mb                 = 50
    current_stack                   = "dotnet"
    ad_provider_enabled             = true
    token_store_enabled             = true
    unacthenticated_action          = "Return401"
    eventhub_logs_name              = "evhb-splunk-lower-digitalchannels-logs"
    eventhub_metrics_name           = "evhb-slunck-lower-digitalchannels-metrics"
  }
}

auth_v2_enabled = true

etghub_subscription_id = ""
eventhub_namespace = "fnv-splunk-lower"
eventhub_resource_group_name = ""
eventhub_policy_name = "pool-splunk-evhb-write"

tags = {}