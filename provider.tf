#provider "azurerm" {
#  features {}
#}

terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.105.0"
    }
  }
}

provider "azurerm" {
  features {}

  subscription_id = "" # Add the subscription ID for azure account
}
