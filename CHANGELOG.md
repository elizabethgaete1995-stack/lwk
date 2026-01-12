# **Changelog**

## **[v2.4.13 (2025-09-18)]**
### Changes
- `Changed` The requirement to have a diagnostic monitor in production has been removed.
- `Updated` CHANGELOG.md.


## **[v2.4.12 (2024-12-17)]**
### Changes
- `Changed` Include a resource to update the plan of the tables.
- `Changed` Upgrade version of azurerm provider to 3.110.0 and 1.8.5 of Terraform
- `Updated` Include variable table
- `Updated` CHANGELOG.md.
- `Updated` README.md.

## **[v2.4.11 (2024-09-09)]**
### Changes
- `Changed` Include retention in days property
- `Updated` CHANGELOG.md.
- `Updated` README.md.


## **[v2.4.10 (2024-07-01)]**
### Changes
- `Changed` the use of Log Analytics in a diagnostic monitor from mandatory to optional.
- `Updated` CHANGELOG.md.
- `Updated` README.md.


## **[v2.4.9 (2024-06-05)]**
### Changes
- `Changed` Logic of Diagnostic Monitor.
- `Updated` CHANGELOG.md.
- `Updated` README.md.

## **[v2.4.8 (2024-05-29)]**
### Changes
- `Changed` the method of obtaining tags from calculation in locals to calling a dedicated tags module.
- `Changed` cia variable from optional to required.
- `Added` tags module call.
- `Added` optional_tags variable.
- `Updated` CHANGELOG.md.
- `Updated` README.md.

## **[v2.4.7 (2024-05-07)]**
### Changes
- `Tested` with terraform v1.7.1 and azure provider v3.90.0.
- `Updated` CHANGELOG.md.
- `Updated` README.md.

## **[v2.4.6 (2024-02-13)]**
### Changes
- `Changed` method to get regions from local variable to region module call.
- `Added` analytics_diagnostic_monitor_lwk_id variable.
- `Updated` CHANGELOG.md.
- `Applied` template v1.0.11.
- `Updated` README.md.
- `Tested` re-apply.

## **[v2.4.5 (2023-11-08)]**
### Changes
- `Added` availability of multiple regions.

## **[v2.4.4 (2023-10-19)]**
### Changes
- `Added` availability of the Sweden Central region.

## [v2.4.3] - 2023-09-28
### Changes
- `Update` Include diagnostic monitor to lwk, sta and eventhub
- `Update` Include outputs lwk_workspace_id and lwk_key
- `Update` CHANGELOG.md
- `Update` README.md

## [v2.4.2] - 2023-09-22
### Changes
- `Update` Include daily quota parameter
- `Update` CHANGELOG.md
- `Update` README.md

## [v2.4.1] - 2023-09-18
### Changes
- `Update` Upgrade versions of terraform and azurerm provider
- `Update` CHANGELOG.md
- `Update` README.md

## [v2.4.0] - 2022-11-11

### Added
- File documentation/examples/terraform.tfvars

## [v2.3.0] - 2022-11-11

### Added
- Variable custom_tags


## [v2.2.0] - 2022-07-04

### Added
- Tag variables cia product, shared_costs, APM_functional, cost_center
- New region centralindia

### Changed
- Variables description and trancking_code from required to optional


## [v1.0.0] - 2022-01-10
First stable version


## [v0.9.0]- 2021-12-28

### Added
- This CHANGELOG file.

### Changed
- Source to localterraform and catalog.

### Removed
- n/a
