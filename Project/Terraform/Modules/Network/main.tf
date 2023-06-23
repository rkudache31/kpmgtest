resource "azurerm_virtual_network" "azr_vnet" {
    count               = var.provisionvet ? 1 : 0
    name                = var.vnet.name
    location            = var.vnet.location
    address_space       = var.vnet.address_space
    resource_group_name = var.vnet.resource_group_name
    tags                = var.tags
}

###############################Subnets#####################################
resource "azurerm_subnet" "azr_subnet" {
    for_each              = var.subnets
    name                  = each.value["name"]
    resource_group_name   = each.value["vnet_resource_group_name"]
    virtual_network_name  = each.value["virtual_network_name"]
    address_prefixes      = each.value["address_prefixes"]   
    service_endpoints     = each.value["service_endpoints"]
    depends_on = [
      azurerm_virtual_network.azr_vnet
    ]
}


###############################Subnets_delegation#####################################
resource "azurerm_subnet" "azr_subnet_delegate" {
    for_each              = var.subnets_delegation
    name                  = each.value["name"]
    resource_group_name   = each.value["vnet_resource_group_name"]
    virtual_network_name  = each.value["virtual_network_name"]
    address_prefixes      = each.value["address_prefixes"]   
    service_endpoints     = each.value["service_endpoints"]

    delegation {
      name  = each.value["delegation_name"]
      service_delegation {
        name = each.value["service_delegation_name"]
        actions = each.value["actions"]
      }
    }
    depends_on = [
      azurerm_virtual_network.azr_vnet
    ]
}

###############################Network_Security_Groups#####################################
resource "azurerm_network_security_group" "nsg" {
  name                = var.nsg_name
  location            = var.location
  resource_group_name = var.vnet.resource_group_name
  tags                = var.tags
  dynamic "security_rule" {
    for_each = { for nsg in var.security_rules : nsg.name => nsg }
    content {
      name                        = security_rule.value.name
      priority                    = security_rule.value.priority
      direction                   = security_rule.value.direction
      access                      = security_rule.value.access
      protocol                    = security_rule.value.protocol
      source_port_range           = security_rule.value.source_port_range
      destination_port_range      = security_rule.value.destination_port_range
      source_address_prefix       = security_rule.value.source_address_prefix
      destination_address_prefix  = security_rule.value.destination_address_prefix
    }
  }
}

resource "azurerm_subnet_network_security_group_association" "subnetnsgassociation" {
  for_each                  = toset(var.subnet_names)
  subnet_id                 = lookup(merge(azurerm_subnet.azr_subnet, azurerm_subnet.azr_subnet), each.value)["id"]
  network_security_group_id = azurerm_network_security_group.nsg.id
}

resource "azurerm_subnet_network_security_group_association" "delegated_subnetnsgassociation" {
  for_each                  = toset(var.delegated_subnet_names)
  subnet_id                 = lookup(merge(azurerm_subnet.azr_subnet_delegate, azurerm_subnet.azr_subnet_delegate), each.value)["id"]
  network_security_group_id = azurerm_network_security_group.nsg.id
}
/*
data "azurerm_route_table" "rttable" {
  count               = var.provisionroutetable ? 0 : 1
  name                = var.route_table_name
  resource_group_name = var.vnet.resource_group_name
}

resource "azurerm_route_table" "rttable" {
  count               = var.provisionroutetable ? 1 : 0
  name                = var.route_table_name
  location            = var.location
  resource_group_name = var.vnet.resource_group_name
  route {
    name                   = var.route_table_route.name
    address_prefix         = var.route_table_route.address_prefix
    next_hop_type          = var.route_table_route.next_hop_type
    next_hop_in_ip_address = var.route_table_route.next_hop_in_ip_address
  }
  
}

resource "azurerm_subnet_network_security_group_association" "subnetrttableassociation" {
  for_each                  = toset(var.subnet_names)
  subnet_id                 = lookup(merge(azurerm_subnet.azr_subnet, azurerm_subnet.azr_subnet), each.value)["id"]
  network_security_group_id = var.provisionroutetable ? azurerm_route_table.rttable[0].id : data.azurerm_route_table.rttable[0].id
}

resource "azurerm_subnet_network_security_group_association" "delegated_subnetrttableassociation" {
  for_each                  = toset(var.delegated_subnet_names)
  subnet_id                 = lookup(merge(azurerm_subnet.delegated_subnet_names, azurerm_subnet.delegated_subnet_names), each.value)["id"]
  network_security_group_id = var.provisionroutetable ? azurerm_route_table.rttable[0].id : data.azurerm_route_table.rttable[0].id
}
*/