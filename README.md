# **Azure Log Analytics Workspace**

## Overview

**IMPORTANT** 
If you want to run this module it is an important requirement to specify the azure provider version, you must set the azure provider version and the terraform version in version.tf file.

This module has been certified with the versions:

| Terraform version | Azure version | 
|:-----:|:-----:|
| 1.8.5 | 3.110.0 |

 
### Acronym
Acronym for the product is **lwk**.

### Description

> A Log Analytics workspace is a unique environment for Azure Monitor log data. Each workspace has its own data repository and configuration, and data sources and solutions are configured to store their data in a particular workspace.

### Dependencies

Resources given by the Cloud Competence Center that must exist before the deployment can take place:
- Azure Subscription.
- Workload resource Group.
- Azure Active Directory Tenant.
- A deployment Service Principal with owner permissions on the resource group.
- Not all tables can update the plan to Basic. Please, check in this document https://learn.microsoft.com/en-us/azure/azure-monitor/logs/basic-logs-azure-tables.

**IMPORTANT** Some resources, such as secret or key, can support a maximum of 15 tags.

## Architecture
![Architecture diagram](documentation/images/architecture_diagram.png "Architecture diagram")
## Networking
![Network diagram](documentation/images/network_diagram.png "Network diagram")
### Target Audience

|Audience |Purpose  |
|--|--|
| Cloud Center of Excellence | Understand the Design of this Service |
| Cybersecurity Hub | Understand how the Security Framework is implemented in this service and who is responsible of each control |
| Service Management Hub | Understand how the Service can be managed according to the Service Management Framework |

## Configuration

| Tf Name | Default Value | Type |Mandatory |Others |
|:--:|:--:|:--:|:--:|:--|
| rsg_name | n/a | `string` | YES | The name of the resource group in which the Log Analytics workspace is created. |
| location | `null` | `string` | NO | Specifies the supported Azure location where the resource exists. Changing this forces a new product to be created. If not set assumes the location of the rsg_name resource group. |
| sku_lwk_name | n/a | `string` | YES | Specifies the Sku of the Log Analytics Workspace. Possible value PerGB2018. |
| daily_quota_gb | `null` | `number` | NO | The workspace daily quota for ingestion in GB. Defaults to -1 (unlimited) if omitted. |
| retention_in_days | `null` | `number` | NO | The retention in days for the logs in the Log Analytics Workspace. |
| table | `[]` | `list(object({name = string retention = number plan = string total_retention = number}))` | NO | List of tables to update the plan. Not all tables can update the plan to Basic. Please, check in this document https://learn.microsoft.com/en-us/azure/azure-monitor/logs/basic-logs-azure-tables.|
| analytics_diagnostic_monitor_enabled | `false` | `bool` | NO | Enable diagnostic monitor with true or false. |
| analytics_diagnostic_monitor_name | `null` | `string` | NO | The name of the diagnostic monitor. Required if analytics_diagnostic_monitor_enabled is true. |
| analytics_diagnostic_monitor_lwk_id | `null` | `string` | NO | Specifies the Id of a Log Analytics Workspace where Diagnostics Data should be sent. |
| analytics_diagnostic_monitor_lwk_name | `null` | `string` | NO | Specifies the name of a Log Analytics Workspace where Diagnostics Data should be sent. |
| analytics_diagnostic_monitor_lwk_rsg | `null` | `string` | NO | The name of the resource group where the lwk is located. Only applies if analytics_diagnostic_monitor_enabled is true. If not set, it assumes the rsg_name value. |
| eventhub_authorization_rule_id | `null` | `string` | NO | Specifies the id of the Authorization Rule of Event Hub used to send Diagnostics Data. Only applies if defined together with analytics_diagnostic_monitor_aeh_name. |
| analytics_diagnostic_monitor_aeh_namespace | `null` | `string` | NO | Specifies the name of an Event Hub Namespace used to send Diagnostics Data. Only applies if defined together with analytics_diagnostic_monitor_aeh_name and analytics_diagnostic_monitor_aeh_rsg. It will be ignored if eventhub_authorization_rule_id is defined. |
| analytics_diagnostic_monitor_aeh_name | `null` | `string` | NO | Specifies the name of the Event Hub where Diagnostics Data should be sent. Only applies if defined together with analytics_diagnostic_monitor_aeh_rsg and analytics_diagnostic_monitor_aeh_namespace or if defined together eventhub_authorization_rule_id. |
| analytics_diagnostic_monitor_aeh_rsg | `null` | `string` | NO | Specifies the name of the resource group where the Event Hub used to send Diagnostics Data is stored. Only applies if defined together with analytics_diagnostic_monitor_aeh_name and analytics_diagnostic_monitor_aeh_namespace. It will be ignored if eventhub_authorization_rule_id is defined. |
| analytics_diagnostic_monitor_aeh_policy | `"RootManageSharedAccessKey"` | `string` | NO | Specifies the name of the event hub policy used to send diagnostic data. Defaults is RootManageSharedAccessKey. |
| analytics_diagnostic_monitor_sta_id | `null` | `string` | NO | Specifies the id of the Storage Account where logs should be sent. |
| analytics_diagnostic_monitor_sta_name | `null` | `string` | NO | Specifies the name of the Storage Account where logs should be sent. If analytics_diagnostic_monitor_sta_id is not null, it won't be evaluated. Only applies if analytics_diagnostic_monitor_sta_rsg is not null and analytics_diagnostic_monitor_sta_id is null. |
| analytics_diagnostic_monitor_sta_rsg | `null` | `string` | NO | Specifies the name of the resource group where Storage Account is stored. If analytics_diagnostic_monitor_sta_id is not null, it won't be evaluated. Only applies if analytics_diagnostic_monitor_sta_name is not null and analytics_diagnostic_monitor_sta_id is null. |
| entity | n/a | `string` | YES | Santander entity code. Used for Naming. (3 characters). |
| environment | n/a | `string` | YES | Santander environment code. Used for Naming. (2 characters). |
| app_acronym | n/a | `string` | YES | App acronym of the resource. Used for Naming. (6 characters). |
| function_acronym | n/a | `string` | YES| App function of the resource. Used for Naming. (4 characters). |
| sequence_number | n/a | `string` | YES | Sequence number of the resource. Used for Naming. (3 characters). |
| inherit | `true` | `bool` | NO | Inherits resource group tags. Values can be false or true (by default).|
| product | n/a | `string` | YES | The product tag will indicate the product to which the associated resource belongs to. In case shared_costs is Yes, product variable can be empty.|
| cost_center | n/a | `string` | YES | This tag will report the cost center of the resource. In case shared_costs is Yes, cost_center variable can be empty.|
| shared_costs | `"No"` | `string` | NO | Helps to identify costs which cannot be allocated to a unique cost center, therefore facilitates to detect resources which require subsequent cost allocation and cost sharing between different payers. |
| apm_functional | n/a | `string` | YES | Allows to identify to which functional application the resource belong, and its value must match with existing functional application code in Entity application portfolio management (APM) systems. In case shared_costs is Yes, apm_functional variable can be empty.|
| cia | n/a | `string` | YES | Confidentiality-Integrity-Availability. Allows a  proper data classification to be attached to the resource. |
| optional_tags | `{entity = null environment = null APM_technical = null business_service = null service_component = null description = null management_level = null AutoStartStopSchedule = null tracking_code = null Appliance = null Patch = null backup = null bckpolicy = null}` | `object({entity = optional(string) environment = optional(string) APM_technical = optional(string) business_service = optional(string)  service_component = optional(string) description = optional(string) management_level = optional(string) AutoStartStopSchedule = optional(string) tracking_code = optional(string) Appliance = optional(string) Patch = optional(string) backup = optional(string) bckpolicy = optional(string)})` | NO | A object with the [optional tags](https://santandernet.sharepoint.com/sites/SantanderPlatforms/SitePages/Naming_and_Tagging_Building_Block_178930012.aspx?OR=Teams-HL&CT=1716801658655&clickparams=eyJBcHBOYW1lIjoiVGVhbXMtRGVza3RvcCIsIkFwcFZlcnNpb24iOiIyNy8yNDA1MDMwNTAwMCIsIkhhc0ZlZGVyYXRlZFVzZXIiOmZhbHNlfQ%3D%3D#optional-tags). These are: entity: (Optional) this tag allows to identify entity resources in a simpler and more flexible way than naming convention, facilitating cost reporting among others; environment: (Optional) this tag allows to identify to which environment belongs a resource in a simpler and more flexible way than naming convention, which is key, for example, to proper apply cost optimization measures; APM_technical: (Optional) this tag allows to identify to which technical application the resource belong, and its value must match with existing technical application code in entity application portfolio management (APM) systems; business_service: (Optional) this tag allows to identify to which Business Service the resource belongs, and its value must match with Business Service code in entity assets management systems (CMDB); service_component: (Optional) this tag allows to identify to which Service Component th e resource belongs, and its value must match with Business Service code in entity assets management systems (CMDB); description: (Optional) this tag provides additional information about the resource function, the workload to which it belongs, etc; management_level: (Optional) this tag depicts the deployment model of the cloud service (IaaS, CaaS, PaaS and SaaS) and helps generate meaningful cloud adoption KPIs to track cloud strategy implementation, for example: IaaS vs. PaaS; AutoStartStopSchedule: (Optional) this tag facilitates to implement a process to automatically start/stop virtual machines according to a schedule. As part of global FinOps practice, there are scripts available to implement auto start/stop mechanisms; tracking_code: (Optional) this tag will allow matching of resources against other internal inventory systems; Appliance: (Optional) this tag identifies if the IaaS asset is an appliance resource. Hardening and agents installation cannot be installed on this resources; Patch: (Optional) this tag is used to identify all the assets operated by Global Public Cloud team that would be updated in the next maintenance window; backup: (Optional) used to define if backup is needed (yes/no value); bckpolicy: (Optional) (platinium_001, gold_001, silver_001, bonze_001) used to indicate the backup plan required for that resource. |
| custom_tags | `{}` | `map(string)` | NO | Custom (additional) tags for compliant. |

<br>
## Outputs
|Output Name| Output Value | Description |
|:--|:--:|:--:|
| lwk_id | azurerm_log_analytics_workspace.lwk.id | Log Analytics Workspace deployed. |
| lwk_workspace_id | azurerm_log_analytics_workspace.lwk.workspace_id | Workspace ID of log analytics. |
| lwk_name | azurerm_log_analytics_workspace.lwk.name | Name of the Log Analytics Workspace. |
| lwk_resource_group | azurerm_log_analytics_workspace.lwk.resource_group_name | Resource Group of Log Analytics. |
| lwk_key | azurerm_log_analytics_workspace.lwk.primary_shared_key | Primary Key of Log Analytics. |

## Usage
Include the next code into your main.tf file:

```hcl
module "lwk" {
  source  = "<lwk module source>"
  version = "<lwk module version>"

  //DATA
  rsg_name                                    = var.rsg_name                                   # Required
  location                                    = var.location                                   # Optional
  
  //LWK
  sku_lwk_name                                = var.sku_lwk_name                               # Required
  daily_quota_gb                              = var.daily_quota_gb                             # Optional
  retention_in_days                           = var.retention_in_days                          # Optional
  table                                       = var.table                                      # Optional

  //DIAGNOSTIC SETTINGS
  analytics_diagnostic_monitor_enabled        = var.analytics_diagnostic_monitor_enabled       # Optional
  analytics_diagnostic_monitor_name           = var.analytics_diagnostic_monitor_name          # Optional
  analytics_diagnostic_monitor_lwk_id         = var.analytics_diagnostic_monitor_lwk_id        # Optional
  analytics_diagnostic_monitor_lwk_name       = var.analytics_diagnostic_monitor_lwk_name      # Optional
  analytics_diagnostic_monitor_lwk_rsg        = var.analytics_diagnostic_monitor_lwk_rsg       # Optional
  eventhub_authorization_rule_id              = var.eventhub_authorization_rule_id             # Optional
  analytics_diagnostic_monitor_aeh_namespace  = var.analytics_diagnostic_monitor_aeh_namespace # Optional
  analytics_diagnostic_monitor_aeh_name       = var.analytics_diagnostic_monitor_aeh_name      # Optional
  analytics_diagnostic_monitor_aeh_rsg        = var.analytics_diagnostic_monitor_aeh_rsg       # Optional
  analytics_diagnostic_monitor_aeh_policy     = var.analytics_diagnostic_monitor_aeh_policy    # Optional
  analytics_diagnostic_monitor_sta_id         = var.analytics_diagnostic_monitor_sta_id        # Optional
  analytics_diagnostic_monitor_sta_name       = var.analytics_diagnostic_monitor_sta_name      # Optional
  analytics_diagnostic_monitor_sta_rsg        = var.analytics_diagnostic_monitor_sta_rsg       # Optional

  //NAMING VARIABLES  
  entity                                      = var.entity                                     # Required
  environment                                 = var.environment                                # Required
  app_acronym                                 = var.app_acronym                                # Required
  function_acronym                            = var.function_acronym                           # Required
  sequence_number                             = var.sequence_number                            # Required

  //TAGGING
  inherit                                     = var.inherit                                    # Optional
  product                                     = var.product                                    # Required if shared_costs is No
  cost_center                                 = var.cost_center                                # Required if shared_costs is No
  shared_costs                                = var.shared_costs                               # Optional
  apm_functional                              = var.apm_functional                             # Optional
  cia                                         = var.cia                                        # Required
  optional_tags                               = var.optional_tags                              # Optional
  custom_tags                                 = var.custom_tags                                # Optional
}
```

Include the next code into your outputs.tf file:

```hcl
output "lwk_id" {
  value       = module.lwk.lwk_id
  description = "Log Analytics Workspace deployed."
}

output "lwk_workspace_id" {
  value       = module.lwk.lwk_workspace_id
  description = "Workspace ID of log analytics."
}

output "lwk_name" {
  value       = module.lwk.lwk_name
  description = "Name of the Log Analytics Workspace."
}

output "lwk_resource_group" {
  value       = module.lwk.lwk_resource_group
  description = "Resource Group of Log Analytics."
}

output "lwk_key" {
  vvalue      = module.lwk.lwk_key
  description = "Primary Key of Log Analytics."
  sensitive   = true
}
```

You can watch more details about [Azure LWK configuration parameters](/variables.tf).

# **Security Framework**

This section explains how the different aspects to have into account in order to meet the Security Control Framework for this Certified Service. 

## Security Controls based on Security Control Framework

### Foundation (**F**) Controls for Rated Workloads

|SF#|What|How it is implemented in the Product|Who|
|--|:---|:---|:--|
|SF1|Resource Tagging on all resources|Product includes all required tags in the deployment template|CCoE|
|<span style="color:red">SF2</span>|IAM on all accounts|RBAC support included to control plane operations only. <span style="color:red">Data plane operations are secured using master keys or resource tokens.</span>|CCoE|
|<span style="color:red">SF3</span>|MFA on accounts|This is governed by Azure AD, <span style="color:red">this is only enabled for the control plane</span>|Protect|
|SF4|Platform Activity Logs & Security Monitoring|Platform logs and security monitoring provided by Platform|CCoE|
|SF5|Virus/Malware Protection|Doesn't apply since this is a PaaS service, antivirus and malware protection is done by CSP| CSP |
|SF6|Authenticate all connections|Mutual authentication based on Azure AD for **control plane** operations, **data plane** operations are secured using master keys or resource tokens, mutual authentication (server) responsibility of DevOps| CCoE, DevOps|

### Medium (**M**) Controls for Rated Workloads

|SM#|What|How it is implemented in the Product|Who|
|--|:---|:---|:--|
|SM1|Encrypt data at rest using application or server level encryption|<ul><li>Default Azure Storage Encryption is enabled to encrypt data at rest: https://docs.microsoft.com/en-us/azure/storage/common/storage-service-encryption</li><li>Application server level encryption: n/a </li></ul>|CCoE, n/a|
|SM2|Encrypt data in transit over public interconnections|Any traffic to exposed **Control Plane** and **Data Plane** endpoints is over TLS|CCoE|
|SM3|Control resource geography|Certified Product location can be configured using product deployment parameters|DevOps|

### Application (**P**) Controls for Rated Workloads

|SP#|What|How it is implemented in the Product|Who|
|--|:---|:---|:--|
|SP1|Segregation of Duties|The following segregation of duties apply to this product:<ul><li>Service Management is done through **Control Plane** and is responsibility of the DevOps</li><li>Data access (read/write) controlled with **Data Plane** access control</li></ul>|DevOps|
|SP2|Vulnerability Management|This doesn't apply since it's a managed PaaS service, vulnerability management is responsibility of CSP |CSP|
|SP3|Security Configuration & Patch Management|This doesn't apply since it's a managed PaaS service, security configuration & patch management is responsibility of CSP |CSP|
|SP4|Service Logs & Security Monitoring|Product is connected to Log Analytics for activity and security monitoring. Azure Diagnostic Settings are used to track all metrics and logs exposed by the product.|CCoE|
|<span style="color:red">SP5</span>|Privileged Access Management|**Data Plane**: Access to data plane is not considered Privileged Access<br>**Control Plane**:Access to the control plane is considered Privileged Access, <span style="color:red">no integration with PAM systems in place</span>|n/a|
|SP6.1|Isolated environments at network level|Managed Service deployed in an Azure network and can be connected to a private vnet using **Virtual Network Service Endpoints**, access to the public IFA can be controlled using built in firewall rules|Spoke|
|SP6.2|Inbound traffic: WAF and anti-DDoS|Inbound traffic to CosmosDb is controlled by CSP and includes WAF and DDoS protection. |CSP|
|<span style="color:red">SP6.3</span>|Inbound and outbound traffic: CSP Private to Santander On-premises|<span style="color:red">n/a</span>|n/a|
|<span style="color:red">SP6.4</span>|Inbound and outbound traffic: CSP Private zones between entities|<span style="color:red">n/a</span>|n/a|
|<span style="color:red">SP6.5</span>|Inbound traffic: Internet to CSP Public|<span style="color:red">n/a</span>|n/a|
|SP6.6|Outbound traffic: Control routing path and traffic filtering|Doesn't apply since there is no outbound traffic from this product|n/a|
|SP6.7|Control all DNS resolutions and NTP consumption in CSP Private services|n/a|n/a|
|SP7|Advanced Malware Protection|Doesn't apply since this is a managed PaaS service and no IaaS is exposed|n/a|
|<span style="color:red">SP8</span>|Cyber incidents management & Digital evidences gathering|<span style="color:red">n/a</span>||
|SP9|Pentesting|Product exposes IFA for **Data Plane**, penetration testing routines are responsibility of Cybersecurity|Cybersecurity|

# **Exit Plan**

# **Basic tf files description**
This section explain the structure and elements that represent the artifacts of product.
|Folder|Name|Description
|--|:-|--|
|Documentation|network_diagram.png|Network topology diagram.|
|Documentation|architecture_diagram.png|Architecture diagram.|
|Documentation|examples|terraform.tfvars|
|Root|README.md|Product documentation file.|
|Root|CHANGELOG.md|Contains the changes added to the new versions of the modules.|
|Root|main.tf|Terraform file to use in pipeline to build and release a product.|
|Root|outputs.tf|Terraform file to use in pipeline to check output.|
|Root|variables.tf|Terraform file to use in pipeline to configure product.|

### Target Audience
|Audience |Purpose  |
|--|--|
| Cloud Center of Excellence | Understand the Design of this Service. |
| Cybersecurity Hub | Understand how the Security Framework is implemented in this Service and who is responsible of each control. |
| Service Management Hub | Understand how the Service can be managed according to the Service Management Framework. |


# **Links to internal documentation**

**Reference documents** :
- [List of Acronyms](https://santandernet.sharepoint.com/sites/SantanderPlatforms/SitePages/Naming_and_Tagging_Building_Block_178930012.aspx)
- [Product Portfolio](https://github.alm.europe.cloudcenter.corp/pages/sgt-cloudplatform/documentationGlobalHub/eac-az-portfolio.html)


| Template version | 
|:-----:|
| 1.0.14 |
