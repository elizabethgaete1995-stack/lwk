terraform {
  backend "azurerm" {
    resource_group_name  = "rg-poc-test-001"
    storage_account_name = "stapocchl001"
    container_name       = "tfstate"
    # key = "app-services/chile.tfstate"
  }
}
