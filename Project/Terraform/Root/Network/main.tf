module "ResourceGroups" {
  source         = "../../Modules/ResourceGroup"
  resource_group = var.resource_group
  tags           = var.tags
}

module "Networks" {
  source                  = "../../Modules/Network"
  provisionvet            = var.provisionvet
  provisionroutetable     = var.provisionroutetable
  vnet                    = var.vnet
  subnets                 = var.subnets
  subnets_delegation      = var.subnets_delegation
  nsg_name                = var.nsg_name
  security_rules          = var.security_rules
  subnet_names            = var.subnet_names
  delegated_subnet_names  = var.delegated_subnet_names
  route_table_name        = var.route_table_name
  route_table_route       = var.route_table_route
  location                = var.location
  tags                    = var.tags
  depends_on = [ module.ResourceGroups ]
}