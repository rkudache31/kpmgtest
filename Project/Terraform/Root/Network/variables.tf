variable "resource_group" {
  type = map(object({
    name     = string
    location = string
  }))
}

variable "vnet" {
    type = object({
      name                = string
      location            = string
      resource_group_name = string
      address_space       = list(string)
    })
}

variable "provisionvet" {
  type = bool
  default = false
}

variable "provisionroutetable" {
  type = bool
  default = false
}

###############################Subnets#####################################
variable "subnets" {
  type = map(object({
    name                     = string
    vnet_resource_group_name = string
    virtual_network_name     = string    
    address_prefixes         = list(string)
    service_endpoints        = list(string)    
  }))
}

###############################Subnets_Delegation#####################################
variable "subnets_delegation" {
  type = map(object({
    name                        = string
    vnet_resource_group_name    = string
    virtual_network_name        = string    
    address_prefixes            = list(string)
    service_endpoints           = list(string)
    delegation_name             = string    
    service_delegation_name     = string
    actions                     = list(string)    
  }))
}

###############################Network_Security_Groups#####################################
variable "nsg_name" {
  description = "Name of the network Security Group"
}

variable "security_rules" {
  description = "A list of security rules to be created"
  type = list(object({
    name                        = string
    priority                    = number
    direction                   = string
    access                      = string
    protocol                    = string
    source_port_range           = string
    destination_port_range      = string
    source_address_prefix       = string
    destination_address_prefix  = string
  }))
}

variable "subnet_names" {
  description = "Subnet names"
  type        = set(string)
}

variable "delegated_subnet_names" {
  description = "Delegated Subnet names"
  type        = set(string)
}

variable "route_table_name" {
  description = "Routing table name"
}

variable "route_table_route" {
  type  = object({
    name                    = string
    address_prefix          = string
    next_hop_type           = string
    next_hop_in_ip_address  = string

  })
}

variable "tags" {
  type = map(string)
  description = "Tags for the resources"
}

variable "location" {
  description = "Azure region"
}