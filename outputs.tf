output "lwk_id" {
  value = azurerm_log_analytics_workspace.lwk.id
  description = "Log Analytics Workspace deployed."
}

output "lwk_workspace_id" {
  value = azurerm_log_analytics_workspace.lwk.workspace_id
  description = "Workspace ID of log analytics."
}

output "lwk_name" {
  value = azurerm_log_analytics_workspace.lwk.name
  description = "Name of the Log Analytics Workspace."
}

output "lwk_resource_group" {
  value = azurerm_log_analytics_workspace.lwk.resource_group_name
  description = "Resource Group of Log Analytics."
}

output "lwk_key" {
  value = azurerm_log_analytics_workspace.lwk.primary_shared_key
  description = "Primary Key of Log Analytics."
  sensitive = true
}
