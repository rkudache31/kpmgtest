################################################################
#This file contains terraform configuration details
################################################################

terraform {
  #Backend Values are Injected through pipeline
  backend "azurerm" {}
}

provider "azurerm" {
  version = "~>3.10.0"
  features {}
}