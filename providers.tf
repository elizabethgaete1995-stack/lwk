terraform {  
  required_version = ">= 1.8.5"
    required_providers {
    azurerm = {
       source                = "hashicorp/azurerm"
       configuration_aliases = [azurerm]
    }
  }
}
provider "azurerm" {
  version = "=3.110.0"
  subscription_id = "ef0a94be-5750-4ef8-944b-1bbc0cdda800"
  features {}
  skip_provider_registration = "true"
  storage_use_azuread        = false
  use_msi = true  # Solo descomenta si ejecutas en Azure con Managed Identity habilitada  

}  

