###################################################
#This file contains terraform configuration details
###################################################

terraform {
  #Backend values are injected throught pipeline
  backend "azurerm" {}
}

provider "azurerm" {
  version = "~>3.50.0"
  features {}
}