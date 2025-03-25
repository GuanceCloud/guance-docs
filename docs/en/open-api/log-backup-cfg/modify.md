# Modify a single data forwarding rule

---

<br />**POST /api/v1/log_backup_cfg/\{cfg_uuid\}/modify**

## Overview
Modify a single data forwarding rule




## Route Parameters

| Parameter Name        | Type     | Required   | Description              |
|:---------------------|:---------|:-----------|:------------------------|
| cfg_uuid             | string   | Y          | Configuration uuid<br>  |


## Body Request Parameters

| Parameter Name               | Type     | Required   | Description                                                                                         |
|:---------------------------|:---------|:-----------|:---------------------------------------------------------------------------------------------------|
| extend                     | json     |            | Front-end custom data<br>Allow empty: True <br>                                                   |
| syncExtensionField         | boolean  |            | Synchronize backup extension fields, true for synchronization, false for no synchronization, default is no synchronization<br>Allow empty: False <br> |
| openPermissionSet          | boolean  |            | Enable custom permission configuration, (default false: not enabled), after enabling, the permission to read the data of the forwarding rule is based on readPermissionSet (added in iteration on 2025-03-26)<br>Allow empty: False <br> |
| readPermissionSet          | array    |            | Permission configuration for reading data forwarding rule data, configurable roles (excluding owners) (added in iteration on 2025-03-26)<br>Example: ['wsAdmin', 'general'] <br>Allow empty: False <br> |
| accessCfg                  | json     |            | External resource access configuration information<br>Allow empty: False <br>                       |
| accessCfg.provider         | string   |            | Provider<br>Allow empty: False <br>Optional values: ['aliyun', 'aws', 'huawei'] <br>               |
| accessCfg.grantType       | string   |            | Authorization type<br>Allow empty: False <br>Optional values: ['role', 'ram'] <br>                 |
| accessCfg.cloudAccountId  | string   |            | Cloud account ID<br>Allow empty: False <br>                                                      |
| accessCfg.bucket          | string   |            | Bucket<br>Allow empty: False <br>                                                                |
| accessCfg.externalId      | string   |            | External unique identifier ID (external unique identifier ID in aws role authorization method)<br>Allow empty: False <br> |
| accessCfg.role            | string   |            | Role name<br>Allow empty: False <br>                                                             |
| accessCfg.ak              | string   |            | Key Id<br>Allow empty: False <br>                                                                 |
| accessCfg.sk              | string   |            | Key<br>Allow empty: False <br>                                                                    |
| accessCfg.topic           | string   |            | Topic<br>Allow empty: False <br>Allow empty string: True <br>                                     |
| accessCfg.url             | string   |            | Link address (used for kafka)<br>Allow empty: False <br>                                          |
| accessCfg.securityProtocol| string   |            | Security protocol (used for kafka)<br>Allow empty: False <br>Optional values: ['plaintext', 'sasl_plaintext', 'sasl_ssl'] <br> |
| accessCfg.ca              | string   |            | Client ssl certificate content<br>Allow empty: False <br>Allow empty string: True <br>              |
| accessCfg.mechanism       | string   |            | Authentication method<br>Allow empty: False <br>Allow empty string: True <br>Optional values: ['plain', 'scram-sha-256', 'scram-sha-512'] <br> |
| accessCfg.username        | string   |            | Username<br>Allow empty: False <br>Allow empty string: True <br>                                   |
| accessCfg.password        | string   |            | Password<br>Allow empty: False <br>Allow empty string: True <br>                                    |
| accessCfg.region          | string   |            | Region (optional value, if not entered, it will default to the corresponding vendor region matching the current site)<br>Allow empty: False <br> |
| accessCfg.bucketPath      | string   |            | Bucket path<br>Allow empty: False <br>                                                           |

## Supplementary Parameter Explanation





## Request Example
```shell
curl 'https://openapi.<<< custom_key.brand_main_domain >>>/api/v1/log_backup_cfg/lgbp_xxxx32/modify' \
-H 'Accept: application/json, text/plain, */*' \
-H 'Content-Type: application/json;charset=UTF-8' \
-H 'DF-API-KEY: <DF-API-KEY>' \
--data-raw '{"extend":{"filters":[],"filterLogic":"and"},"syncExtensionField":true,"accessCfg":{"cloudAccountId":"f000ee4d7327428da2f53a081e7109bd","bucket":"test-obs01","region":"cn-south-1","provider":"huawei"}}' \
--compressed
```




## Response
```shell
{
    "code": 200,
    "content": {
        "conditions": "{}",
        "createAt": 1697613651,
        "creator": "xxx",
        "dataType": "tracing",
        "deleteAt": -1,
        "extend": {
            "filterLogic": "and",
            "filters": []
        },
        "externalResourceAccessCfgUUID": "erac_xxxx32",
        "id": 686,
        "name": "temp_test",
        "status": 0,
        "storeType": "obs",
        "syncExtensionField": true,
        "taskErrorCode": "",
        "taskStatusCode": -1,
        "updateAt": 1697613856.5497322,
        "updator": "wsak_xxxxx",
        "uuid": "lgbp_xxxx32",
        "workspaceUUID": "wksp_xxxx32"
    },
    "errorCode": "",
    "message": "",
    "success": true,
    "traceId": "TRACE-599A0794-3DD7-4731-BA2F-0A3655C09684"
} 
```