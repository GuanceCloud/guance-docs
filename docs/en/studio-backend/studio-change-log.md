## 2025-03-12
### OpenAPI
* [Synthetic Tests - Testing Tasks] Added an interface to query the default testing node list of the official website.
* [Management - Pipeline] Added `dataType` and `enableByLogBackup` fields for creation/modification interfaces.


## 2025-01-08
### OpenAPI
* [Synthetic Tests - Testing Tasks] Added an interface to modify testing tasks.


## 2024-12-25
### OpenAPI
* [Infrastructure - Resource Catalog] Added resource Explorer related interfaces (add, delete, modify, query).
* [Metrics - Aggregation Generated Metrics] Added metric rules related interfaces (add, delete, modify, query).
### Hotfix
* Fixed the regular expression lookahead issue in data access desensitization, snapshot desensitization, and sensitive data desensitization.


## 2024-12-11
### OpenAPI
* The type of the external event monitor was changed from `outer_event_checker` to `trigger`.


## 2024-11-27
### OpenAPI
* Adjusted the parameter structure of the member type for Alert Strategies.


## 2024-10-30
### OpenAPI
* Added `name`, `description`, and `filterString` fields to the Mute rule creation/modification interface.
### ExternalAPI
* Added a DataKit Service List query interface.


## 2024-09-04
### OpenAPI
* For the LOG index creation/modification single binding index configuration interface, three new parameters were added within `accessCfg`: `iamProjectName`, `projectId`, and `topicId` to support binding to Volcengine TLS.
* Added `name` and `desc` to the data access creation/modification interface.
* Added `name` and `desc` fields to the results returned by the data access detail and list query interfaces.


## 2024-08-07
### OpenAPI
* Added `tags` and `alertPolicyUUIDs` to the SLO creation/modification interface and deprecated the `alertOpt` parameter.
* Added `tagInfo` and `alertPolicyInfos` fields to the results returned by the SLO detail and list query interfaces, discarding the `alertOpt` field.