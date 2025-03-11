## 2025-01-08
### OpenAPI
* [Synthetic Tests - Test] Added interface to modify test tasks


## 2024-12-25
### OpenAPI
* [Infrastructure - Resource Catalog] Added interfaces related to resource viewers (create, delete, modify, query)
* [Metrics - Aggregated Metrics Generation] Added interfaces related to metrics rules (create, delete, modify, query)
### Hotfix
* Fixed the regex lookahead issue in data access desensitization, snapshot desensitization, and sensitive data desensitization


## 2024-12-11
### OpenAPI
* Changed the type of external event monitors from `outer_event_checker` to `trigger`


## 2024-11-27
### OpenAPI
* Adjusted parameter structure for member types of alert strategies


## 2024-10-30
### OpenAPI
* Added `name`, `description`, and `filterString` fields to the mute rule creation/modification interface
### ExternalAPI
* Added DataKit list query interface


## 2024-09-04
### OpenAPI
* Added `iamProjectName`, `projectId`, and `topicId` parameters to the `accessCfg` of the log index creation/modification single binding index configuration interface to support binding to Volcano Engine TLS.
* Added `name` and `desc` parameters to the data access creation/modification interface
* Added `name` and `desc` fields to the result returned by the data access detail and list query interfaces


## 2024-08-07
### OpenAPI
* Added `tags` and `alertPolicyUUIDs` to the SLO creation/modification interface and deprecated the `alertOpt` parameter.
* Added `tagInfo` and `alertPolicyInfos` fields to the result returned by the SLO detail and list query interfaces, and removed the `alertOpt` field