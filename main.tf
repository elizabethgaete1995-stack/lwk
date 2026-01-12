## Modules
/*
 Call Regions Module
module "azure_regions" {
  source  = "../../Misc/regions"
}

# Call Tags Module
module "tags" {
  source  = "../../Misc/tags"
  #version = ">=1.0.0"

  rsg_name       = var.rsg_name
  inherit        = var.inherit
  product        = var.product
  cost_center    = var.cost_center
  shared_costs   = var.shared_costs
  apm_functional = var.apm_functional
  cia            = var.cia
  custom_tags    = var.custom_tags
  optional_tags  = var.optional_tags
}
*/
## Locals
# Define variables for local scope
locals {
  regions         = var.azure_regions && (var.azure_regions != null || (var.azure_regions != null && local.rsg_lwk != null))
  geo_region = lookup(local.regions, local.location)
  mds_lwk_enabled            = var.analytics_diagnostic_monitor_enabled && (var.analytics_diagnostic_monitor_lwk_id != null || (var.analytics_diagnostic_monitor_lwk_name != null && local.rsg_lwk != null))
  mds_sta_enabled            = var.analytics_diagnostic_monitor_enabled && (var.analytics_diagnostic_monitor_sta_id != null || (var.analytics_diagnostic_monitor_sta_name != null && var.analytics_diagnostic_monitor_sta_rsg != null))
  mds_aeh_enabled            = var.analytics_diagnostic_monitor_enabled && (var.analytics_diagnostic_monitor_aeh_name != null && (var.eventhub_authorization_rule_id != null || (var.analytics_diagnostic_monitor_aeh_namespace != null && var.analytics_diagnostic_monitor_aeh_rsg != null)))
  rsg_lwk                    = var.analytics_diagnostic_monitor_lwk_rsg != null ? var.analytics_diagnostic_monitor_lwk_rsg : var.rsg_name
  location                   = var.location != null ? var.location : data.azurerm_resource_group.rsg_principal.location

}

#DATA
# Get info about curent session
data "azurerm_client_config" "current" {}

# Get and set a resource group for deploy.
data "azurerm_resource_group" "rsg_principal" {
  name = var.rsg_name
}

# Get and set a monitor diagnostic settings
data "azurerm_log_analytics_workspace" "lwk_principal" {
  count = local.mds_lwk_enabled && var.analytics_diagnostic_monitor_lwk_id == null ? 1 : 0

  name                = var.analytics_diagnostic_monitor_lwk_name
  resource_group_name = local.rsg_lwk
}


# Get and set a Storage Account to send logs in monitor diagnostic settings
data "azurerm_storage_account" "mds_sta" {
  count = local.mds_sta_enabled && var.analytics_diagnostic_monitor_sta_id == null ? 1 : 0

  name                = var.analytics_diagnostic_monitor_sta_name
  resource_group_name = var.analytics_diagnostic_monitor_sta_rsg
}

# Get and set a Event Hub Authorization Rule to send logs in monitor diagnostic settings
data "azurerm_eventhub_namespace_authorization_rule" "mds_aeh" {
  count = local.mds_aeh_enabled && var.eventhub_authorization_rule_id == null ? 1 : 0

  name                = var.analytics_diagnostic_monitor_aeh_policy
  resource_group_name = var.analytics_diagnostic_monitor_aeh_rsg
  namespace_name      = var.analytics_diagnostic_monitor_aeh_namespace
}


###################################################
###################################################
# USEFUL CODE #
###################################################
###################################################

# Creata a Log Analytics Workspace
resource "azurerm_log_analytics_workspace" "lwk" {
  name                = join("", [var.app_name, local.geo_region, var.entity,var.environment, var.sequence_number])
  location            = local.location
  resource_group_name = var.rsg_name
  sku                 = var.sku_lwk_name
  daily_quota_gb      = var.daily_quota_gb
  retention_in_days   = var.retention_in_days

  tags = var.inherit ? module.tags.tags : module.tags.tags_complete
}

# Get categories for a Diagnostic Settings of a LWK
data "azurerm_monitor_diagnostic_categories" "lwk" {
  resource_id = resource.azurerm_log_analytics_workspace.lwk.id
}

resource "azurerm_log_analytics_workspace_table" "lwk" {
  for_each = { for tb in var.table : tb.name => tb }
  workspace_id            =  azurerm_log_analytics_workspace.lwk.id
  name                    = each.key
  plan                    = each.value.plan
  total_retention_in_days = each.value.plan != "Basic" ? each.value.total_retention : null
  retention_in_days       = each.value.plan != "Basic" ? each.value.retention : null
}

resource "azurerm_monitor_diagnostic_setting" "mds" {
  count = var.analytics_diagnostic_monitor_enabled ? 1 : 0

  name                           = var.analytics_diagnostic_monitor_name
  target_resource_id             = resource.azurerm_log_analytics_workspace.lwk.id
  log_analytics_workspace_id     = local.mds_lwk_enabled ? (var.analytics_diagnostic_monitor_lwk_id != null ? var.analytics_diagnostic_monitor_lwk_id : data.azurerm_log_analytics_workspace.lwk_principal[0].id) : null
  eventhub_name                  = local.mds_aeh_enabled ? var.analytics_diagnostic_monitor_aeh_name : null
  eventhub_authorization_rule_id = local.mds_aeh_enabled ? (var.eventhub_authorization_rule_id != null ? var.eventhub_authorization_rule_id : data.azurerm_eventhub_namespace_authorization_rule.mds_aeh[0].id) : null
  storage_account_id             = local.mds_sta_enabled ? (var.analytics_diagnostic_monitor_sta_id != null ? var.analytics_diagnostic_monitor_sta_id : data.azurerm_storage_account.mds_sta[0].id) : null

  dynamic "enabled_log" {
    for_each = data.azurerm_monitor_diagnostic_categories.lwk.log_category_types
    content {
      category = enabled_log.value
    }
  }

  dynamic "metric" {
    for_each = data.azurerm_monitor_diagnostic_categories.lwk.metrics
    content {
      category = metric.value
    }
  }
}
