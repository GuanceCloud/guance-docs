# 【Workspace】Modification

---

<br />**POST /api/v1/workspace/\{workspace_uuid\}/modify**

## Overview




## Route Parameters

| Parameter Name        | Type     | Required | Description              |
|:-------------------|:-------|:-----|:----------------|
| workspace_uuid | string | Y | Workspace UUID<br> |


## Body Request Parameters

| Parameter Name        | Type     | Required | Description              |
|:-------------------|:-------|:-----|:----------------|
| isOpenCustomMappingRule | boolean |  | Whether to enable custom mapping rules<br>Example: False <br>Can be empty: False <br> |
| maxSearchResultCount | integer |  | Maximum number of search results<br>Example: 0 <br>Can be empty: False <br> |
| name | string |  | Name<br>Example: supper_workspace <br>Can be empty: False <br>Maximum length: 256 <br> |
| esIndexMerged | boolean |  | Whether to aggregate indexes, default is true<br>Example: False <br>Can be empty: False <br> |
| isOpenLogMultipleIndex | boolean |  | Whether to enable multi-index configuration for logs, default is true, i.e., disabled state<br>Example: False <br>Can be empty: False <br> |
| logMultipleIndexCount | int |  | Number of multi-index configurations for logs after enabling, at the workspace level<br>Example: 3 <br>Can be empty: False <br> |
| loggingCutSize | int |  | Unit for cutting oversized logs, transmitted in bytes<br>Example: False <br>Can be empty: False <br> |
| leftWildcard | boolean |  | Whether to enable left * matching, default is false, i.e., disabled state<br>Example: False <br>Can be empty: False <br> |
| durationSet | object |  | Data retention duration information<br> |
| durationSet.rp | string |  | Time Series RP duration<br>Example: 30d <br>Can be empty: False <br> |
| durationSet.logging | string |  | Log RP duration<br>Example: 14d <br>Can be empty: False <br> |
| durationSet.backup_log | string |  | Backup log duration<br>Example: 180d <br>Can be empty: False <br> |
| durationSet.security | string |  | Security Check data duration<br>Example: 90d <br>Can be empty: False <br> |
| durationSet.keyevent | string |  | Event RP duration<br>Example: 14d <br>Can be empty: False <br> |
| durationSet.tracing | string |  | Tracing duration<br>Example: 7d <br>Can be empty: False <br> |
| durationSet.rum | string |  | RUM duration<br>Example: 7d <br>Can be empty: False <br> |
| durationSet.apm | string |  | APM duration (effective when indexes are merged)<br>Example: 7d <br>Can be empty: False <br> |
| disableQueryAcceleration | integer |  | Disable query acceleration<br>Can be empty: True <br>Optional values: [0, 1] <br> |

## Additional Parameter Notes







## Response
```shell
 
```