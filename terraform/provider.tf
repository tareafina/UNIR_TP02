terraform {
  required_version = ">= 0.12"
  backend "azurerm" {
    resource_group_name  = "rg-terraform-unir"
    storage_account_name = ""
    container_name       = "tfstate"
    key                  = "tfstate"
  access_key =""
  }
}

provider "azurerm" {
  version = "=2.40.0"
  features {}
  
subscription_id = ""
client_id       = ""
client_secret   = ""
tenant_id       = ""

}
