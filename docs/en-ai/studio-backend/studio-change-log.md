## 2025-01-08
### OpenAPI
* 【Synthetic Tests - Dial Testing】Added API for modifying dial testing tasks


## 2024-12-25
### OpenAPI
* 【Infrastructure - Resource Catalog】Added interfaces related to the resource viewer (add, delete, modify, query)
* 【Metrics - Aggregated Metrics Generation】Added interfaces for metric rules (add, delete, modify, query)
### Hotfix
* Fixed the regular expression lookahead issue in data access desensitization, snapshot desensitization, and sensitive data desensitization


## 2024-12-11
### OpenAPI
* The type of external event monitors has been changed from `outer_event_checker` to `trigger`


## 2024-11-27
### OpenAPI
* Adjusted parameter structure for alert policy members


## 2024-10-30
### OpenAPI
* Added `name`, `description`, and `filterString` fields to the creation/modification interface for mute rules
### ExternalAPI
* Added an interface for querying DataKit service lists


## 2024-09-04
### OpenAPI
* The "Log - Index" create/modify single bound index configuration interface now includes `iamProjectName`, `projectId`, and `topicId` parameters within `accessCfg` to support binding to Volcano Engine TLS.
* Added `name` and `desc` parameters to the data access creation/modification interface
* The detailed view and list interfaces for data access now return `name` and `desc` fields


## 2024-08-07
### OpenAPI
* The SLO create/modify interface added `tags` and `alertPolicyUUIDs` and deprecated the `alertOpt` parameter.
* The detailed view and list interfaces for SLO now return `tagInfo` and `alertPolicyInfos` fields, discarding the `alertOpt` field