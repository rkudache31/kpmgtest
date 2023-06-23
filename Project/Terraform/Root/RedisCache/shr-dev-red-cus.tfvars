###############################################################################
# This file contains variable intialization for Redis - Commercial Development
###############################################################################
resource_group_name         = "dev-rg"
provisionresgrp             = false
location                    = "centralus"

################## Virtual Network ##########################
virtual_network_name        = "non-prod-vnet"
vnet_resource_group_name    = "non-prod-vnet-rg"
pe_subnet_name              = "dev-fin-pep-data-sub"

######################## Redis Cache #################################
redis_cache = {
  redis_cache_finshrredcus  =   {
    redis_cache_name                = "dev-fin-shr-red-cus"
    capacity                        = 1
    sku_name                        = "Premium"
    family                          = "P"
    enable_non_ssl_port             = false
    minimum_tls_version             = "1.2"
    public_network_access_enabled   = false
    day_of_week                     = "Sunday"
    start_hour_utc                  = "7"    
  }
}

########################## Tags ##############################
tags = {}