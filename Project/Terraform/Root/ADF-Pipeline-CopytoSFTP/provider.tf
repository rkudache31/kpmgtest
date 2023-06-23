terraform {
  #Backend values are injected through pipeline
  backend "azurerm" {}
}

provider "azurerm" {
    version = "~>3.50.0"
  features {}
}