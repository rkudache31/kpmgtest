resource_group = {
  "resource_group_appserviceplan" = {
    location = "centralus"
    name     = "dev-rg"
  },
  "resource_group_network" = {
    location = "centralus"
    name     = "non-prod-vnet-rg"
  }
}

vnet = {
  address_space       = ["10.8.0.0/16"]
  location            = "centralus"
  name                = "non-prod-vnet"
  resource_group_name = "non-prod-vnet-rg"
}

provisionvet        = true
provisionroutetable = false
route_table_name    = "transit-rt"
route_table_route = {
  name                   = "route1"
  address_prefix         = "0.0.0.0/0"
  next_hop_type          = "VirtualAppliance"
  next_hop_in_ip_address = "10.7.129.4"
}

###############################Subnets#####################################
subnets = {
  "subnet_pe_frontend" = {
    address_prefixes = [ "10.8.1.0/27" ]
    name = "dev-fin-pep-app-sub"
    service_endpoints = [ "Microsoft.Storage", "Microsoft.Sql" ]
    virtual_network_name = "non-prod-vnet"
    vnet_resource_group_name = "non-prod-vnet-rg"    
  }
  "subnet_pe_backend" = {
    address_prefixes = [ "10.8.2.0/27" ]
    name = "dev-fin-pep-data-sub"
    service_endpoints = [ "Microsoft.Storage", "Microsoft.KeyVault", "Microsoft.Sql" ]
    virtual_network_name = "non-prod-vnet"
    vnet_resource_group_name = "non-prod-vnet-rg"    
  }
  "subnet_adf" = {
    address_prefixes = [ "10.8.3.0/27" ]
    name = "dev-fin-adf-sub"
    service_endpoints = [ "Microsoft.AzureActiveDirectory", "Microsoft.AzureCosmosDB", "Microsoft.CognitiveServices", "Microsoft.ContainerRegistry", "Microsoft.ServiceBus", "Microsoft.Web", "Microsoft.EventHub", "Microsoft.Storage", "Microsoft.KeyVault", "Microsoft.Sql" ]
    virtual_network_name = "non-prod-vnet"
    vnet_resource_group_name = "non-prod-vnet-rg"    
  }  
  "subnet_key1" = {
    address_prefixes = [ "10.8.4.0/27" ]
    name = "dev-fin-key-sub"
    service_endpoints = [ "Microsoft.KeyVault" ]
    virtual_network_name = "non-prod-vnet"
    vnet_resource_group_name = "non-prod-vnet-rg"
  }
}

###############################Subnets_delegation#####################################
subnets_delegation = {
  "subnets_delegation_app" = {
    actions                  = [ "Microsoft.Network/virtualNetworks/subnets/action", "Microsoft.Network/virtualNetworks/subnets/join/action", "Microsoft.Network/virtualNetworks/subnets/prepareNetworkPolicies/action", "Microsoft.Network/virtualNetworks/subnets/unprepareNetworkPolicies/action" ]
    address_prefixes         = [ "10.8.5.0/27" ]
    delegation_name          = "serverFarmsService"
    name                     = "dev-fin-apps-sub"
    service_delegation_name  = "Microsoft.Web/serverFarms"
    service_endpoints        = [ "Microsoft.KeyVault", "Microsoft.Sql", "Microsoft.Web", "Microsoft.Storage", "Microsoft.AzureActiveDirectory" ]
    virtual_network_name     = "non-prod-vnet"
    vnet_resource_group_name = "non-prod-vnet-rg"
  }
  "subnets_delegation_database" = {
    actions                  = [ "Microsoft.Network/virtualNetworks/subnets/action", "Microsoft.Network/virtualNetworks/subnets/join/action", "Microsoft.Network/virtualNetworks/subnets/prepareNetworkPolicies/action", "Microsoft.Network/virtualNetworks/subnets/unprepareNetworkPolicies/action" ]
    address_prefixes         = [ "10.8.6.0/27" ]
    delegation_name          = "ManagedInstanceDelegation"
    name                     = "dev-fin-sqm-sub"
    service_delegation_name  = "Microsoft.Sql/managedInstances"
    service_endpoints        = ["Microsoft.Sql", "Microsoft.Storage", "Microsoft.AzureActiveDirectory" ]
    virtual_network_name     = "non-prod-vnet"
    vnet_resource_group_name = "non-prod-vnet-rg"
  }  
}

nsg_name = "dev-fin-nsg"
subnet_names = ["subnet_pe_frontend", "subnet_pe_backend", "subnet_adf", "subnet_key1"]
delegated_subnet_names = ["subnets_delegation_app", "subnets_delegation_database"]
security_rules = [
  {
    name                        = "AllowAnyRedisInbound"
    priority                    = 174
    direction                   = "Inbound"
    access                      = "Allow"
    protocol                    = "Tcp"
    source_port_range           = "*"
    destination_port_range      = "6379"
    source_address_prefix       = "*"
    destination_address_prefix  = "*"
  }
]

location = "centralus"
tags = {}