###################################################
#This file contains terraform configuration details
###################################################
terraform {
  backend "azurerm" {}
}

provider "azurerm" {
  version = "~>3.52.0"
  features {}
}
