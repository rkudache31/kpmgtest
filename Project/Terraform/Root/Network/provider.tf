terraform {
  #Backend values are injected through pipeline
  backend "azurerm" {}
}

provider "azurerm" {
    version = "~>3.10.0"
  features {}
}