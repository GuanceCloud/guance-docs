# Modify a Single Binding Index Configuration

---

<br />**POST /api/v1/external_log_index_cfg/\{cfg_uuid\}/modify**

## Overview
Modify a custom storage binding index configuration



## Route Parameters

| Parameter Name        | Type     | Required   | Description              |
|:-------------------|:-------|:-----|:----------------|
| cfg_uuid | string | Y | Configuration UUID<br> |


## Body Request Parameters

| Parameter Name        | Type     | Required   | Description              |
|:-------------------|:-------|:-----|:----------------|
| extend | json |  | Frontend custom data<br>Can be empty: True <br> |
| exterStoreName | string | Y | The name of the external storage that maps to the name (SLS type corresponds to StoreName, Volcano Cloud's TLS corresponds to topic_name)<br>Can be empty: False <br> |
| name | string | Y | Index name<br>Example: xxx <br>Can be empty: False <br> |
| exterStoreProject | string |  | The project corresponding to the external storage index (SLS type corresponds to StoreProject, Volcano Cloud's TLS corresponds to project_name)<br>Can be empty: False <br> |
| region | string |  | Specify the region of the external resource<br>Can be empty: False <br> |
| isPublicNetworkAccess | boolean |  | Whether to access via public network, effective when storeType is sls, defaults to False (added in iteration on 2024-07-10)<br>Can be empty: True <br> |
| accessCfg | json | Y | External resource access configuration information<br>Can be empty: False <br> |
| accessCfg.cloudAccountId | string |  | Cloud account ID<br>Can be empty: False <br> |
| accessCfg.ak | string |  | Access Key ID<br>Can be empty: False <br> |
| accessCfg.sk | string |  | Secret Key<br>Can be empty: False <br> |
| accessCfg.url | string |  | URL<br>Can be empty: False <br> |
| accessCfg.username | string |  | Username<br>Can be empty: False <br>Can be an empty string: True <br> |
| accessCfg.password | string |  | Password<br>Can be empty: False <br>Can be an empty string: True <br> |
| accessCfg.iamProjectName | string |  | Volcano Cloud TLS iam_project_name<br>Can be empty: False <br>Can be an empty string: True <br> |
| accessCfg.iamProjectDisplayName | string |  | Display name of Volcano Cloud TLS iam_project_name<br>Can be empty: False <br>Can be an empty string: True <br> |
| accessCfg.projectId | string |  | Volcano Cloud TLS project_id<br>Can be empty: False <br>Can be an empty string: True <br> |
| accessCfg.topicId | string |  | Volcano Cloud TLS topic_id<br>Can be empty: False <br>Can be an empty string: True <br> |
| fields | array |  | List of field mapping configurations to update<br>Can be empty: False <br> |
| fields[*] | None |  | <br> |
| fields[*].field | string | Y | Field name<br>Example: message <br>Can be empty: False <br> |
| fields[*].originalField | string | Y | Original field name<br>Example: content <br>Can be empty: False <br>Can be an empty string: True <br> |

## Additional Parameter Notes



## Request Example
```shell
curl 'https://openapi.guance.com/api/v1/external_log_index_cfg/lgim_xxxx32/modify' \
-H 'DF-API-KEY: <DF-API-KEY>' \
-H 'Content-Type: application/json;charset=UTF-8' \
--data-raw '{"accessCfg":{"url":"aabb.com","username":"test33"},"exterStoreName":"aa_uuid","fields":[{"field":"time","originalField":"time"},{"field":"__docid","originalField":"__docid"},{"field":"message","originalField":"message"}]}' \
--compressed 
```




## Response
```shell
{
    "code": 200,
    "content": true,
    "errorCode": "",
    "message": "",
    "success": true,
    "traceId": "TRACE-63EE56F5-8EFB-4FF9-994D-11848B6EFA80"
} 
```