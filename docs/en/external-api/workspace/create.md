# 【Workspace】Creation

---

<br />**POST /api/v1/workspace/create**

## Overview




## Body Request Parameters

| Parameter Name        | Type     | Required   | Description              |
|:------------------|:-------|:------|:--------------------|
| isOpenCustomMappingRule | boolean |  | Whether to enable custom mapping rules<br>Example: 0 <br>Can be empty: False <br> |
| maxSearchResultCount | integer |  | Maximum number of search results<br>Example: 0 <br>Can be empty: False <br> |
| name | string | Y | Name<br>Example: supper_workspace <br>Can be empty: False <br>Maximum length: 256 <br> |
| esIndexMerged | boolean |  | Whether to merge indexes, default is true<br>Example: False <br>Can be empty: False <br> |
| leftWildcard | boolean |  | Whether to enable left * matching, default is false, i.e., off state<br>Example: False <br>Can be empty: False <br> |
| isOpenLogMultipleIndex | boolean |  | Whether to enable multiple log index configuration, default is true, i.e., closed state<br>Example: False <br>Can be empty: False <br> |
| logMultipleIndexCount | int |  | Limit on the number of multiple log indexes after enabling the multiple log index configuration, workspace level<br>Example: 3 <br>Can be empty: False <br> |
| loggingCutSize | int |  | Super large log cutting unit, transmitted in bytes<br>Example: False <br>Can be empty: False <br> |
| storageTypeUUID | string |  | Corresponding non-primary storage type UUID<br>Example: uuid_xxxxxxxx <br>Can be empty: True <br> |
| durationSet | object |  | Data retention duration information<br> |
| durationSet.rp | string |  | Time Series RP's duration<br>Example: 30d <br>Can be empty: False <br> |
| durationSet.logging | string |  | Log RP's duration<br>Example: 14d <br>Can be empty: False <br> |
| durationSet.backup_log | string |  | Backup log's duration<br>Example: 180d <br>Can be empty: False <br> |
| durationSet.security | string |  | Inspection data's duration<br>Example: 90d <br>Can be empty: False <br> |
| durationSet.keyevent | string |  | Event RP's duration<br>Example: 14d <br>Can be empty: False <br> |
| durationSet.tracing | string |  | Tracing's duration<br>Example: 7d <br>Can be empty: False <br> |
| durationSet.rum | string |  | RUM's duration<br>Example: 7d <br>Can be empty: False <br> |
| durationSet.apm | string |  | APM's duration (valid under merged index conditions)<br>Example: 7d <br>Can be empty: False <br> |
| ownerUuid | string | Y | Workspace owner<br>Allow empty string: False <br>Example: uuid-001 <br> |
| language | string |  | Language information<br>Can be empty: True <br>Allow empty string: True <br>Optional values: ['zh', 'en'] <br> |

## Additional Parameter Notes







## Response
```shell
 
```