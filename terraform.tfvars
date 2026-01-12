// DATA
rsg_name       = "rg-poc-test-001"

//location       = "westeurope"

// LWK
sku_lwk_name   = "PerGB2018"

analytics_diagnostic_monitor_enabled = false
analytics_diagnostic_monitor_name    = "lwk-poc-dev-chl-001-adm"


// NAMING VARIABLES
entity         = "lwk"
environment    = "dev"
app_acronym    = "poc"
function_acronym = "crit"
sequence_number = "001"

// TAGGING
app_name ="lwk"
cost_center ="CC-Test" 
tracking_cod ="POC"
# Custom tags
custom_tags = { "1" = "1", "2" = "2" }