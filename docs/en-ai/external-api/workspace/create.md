# 【Workspace】Creation

---

<br />**POST /api/v1/workspace/create**

## Overview




## Body Request Parameters

| Parameter Name        | Type     | Required   | Description              |
|:-------------------|:-------|:-------|:----------------|
| isOpenCustomMappingRule | boolean | No | Whether to enable custom mapping rules<br>Example: 0 <br>Can be empty: False <br> |
| maxSearchResultCount | integer | No | Maximum number of search results<br>Example: 0 <br>Can be empty: False <br> |
| name | string | Yes | Name<br>Example: supper_workspace <br>Can be empty: False <br>Maximum length: 256 <br> |
| esIndexMerged | boolean | No | Whether to merge indices, default is true<br>Example: False <br>Can be empty: False <br> |
| leftWildcard | boolean | No | Whether to enable left * matching, default is false, i.e., disabled<br>Example: False <br>Can be empty: False <br> |
| isOpenLogMultipleIndex | boolean | No | Whether to enable multiple log index configuration, default is true, i.e., enabled<br>Example: False <br>Can be empty: False <br> |
| logMultipleIndexCount | int | No | Limit on the number of multiple log indices after enabling multiple log index configuration, at the workspace level<br>Example: 3 <br>Can be empty: False <br> |
| loggingCutSize | int | No | Super large log cut size, transmitted in bytes<br>Example: False <br>Can be empty: False <br> |
| storageTypeUUID | string | No | UUID corresponding to non-primary storage type<br>Example: uuid_xxxxxxxx <br>Can be empty: True <br> |
| durationSet | object | No | Data retention duration information<br> |
| durationSet.rp | string | No | Duration for Time Series RP<br>Example: 30d <br>Can be empty: False <br> |
| durationSet.logging | string | No | Duration for log RP<br>Example: 14d <br>Can be empty: False <br> |
| durationSet.backup_log | string | No | Duration for backup logs<br>Example: 180d <br>Can be empty: False <br> |
| durationSet.security | string | No | Duration for Security Check data<br>Example: 90d <br>Can be empty: False <br> |
| durationSet.keyevent | string | No | Duration for event RP<br>Example: 14d <br>Can be empty: False <br> |
| durationSet.tracing | string | No | Duration for tracing<br>Example: 7d <br>Can be empty: False <br> |
| durationSet.rum | string | No | Duration for RUM<br>Example: 7d <br>Can be empty: False <br> |
| durationSet.apm | string | No | Duration for APM (valid when merging indices)<br>Example: 7d <br>Can be empty: False <br> |
| ownerUuid | string | Yes | Command<br>Can be an empty string: False <br>Example: uuid-001 <br> |
| language | string | No | Language information<br>Can be empty: True <br>Can be an empty string: True <br>Optional values: ['zh', 'en'] <br> |

## Additional Parameter Notes







## Response
```shell
 
```