# Create a single data forwarding rule

---

<br />**POST /api/v1/log_backup_cfg/add**

## Overview
Create a single data forwarding rule




## Body Request Parameters

| Parameter Name        | Type     | Required   | Description              |
|:-------------------|:-------|:-----|:----------------|
| name | string | Y | Rule name<br>Example: xxx <br>Can be empty: False <br> |
| extend | json |  | Frontend custom data<br>Can be empty: True <br> |
| syncExtensionField | boolean |  | Synchronize backup extension fields, true for synchronization, false for no synchronization, default is no synchronization<br>Can be empty: False <br> |
| openPermissionSet | boolean |  | Enable custom permission configuration, (default false:not enabled), after enabling the read permission for forwarded data is based on readPermissionSet (added in iteration on 2025-03-26)<br>Can be empty: False <br> |
| readPermissionSet | array |  | Permission configuration to read data from the data forwarding rule, can configure roles (except the owner) (added in iteration on 2025-03-26)<br>Example: ['wsAdmin', 'general'] <br>Can be empty: False <br> |
| storeType | string | Y | Storage type<br>Can be empty: False <br>Options: ['guanceObject', 's3', 'obs', 'oss', 'kafka'] <br> |
| dataType | string |  | Data type<br>Can be empty: False <br>Options: ['logging', 'tracing', 'rum', 'keyevent'] <br> |
| duration | string |  | Data retention duration,<br>Example: 180d <br>Options: ['180d', '360d', '720d'] <br> |
| accessCfg | json |  | External resource access configuration information<br>Can be empty: False <br> |
| accessCfg.provider | string |  | Provider<br>Can be empty: False <br>Options: ['aliyun', 'aws', 'huawei'] <br> |
| accessCfg.grantType | string |  | Authorization type<br>Can be empty: False <br>Options: ['role', 'ram'] <br> |
| accessCfg.cloudAccountId | string |  | Cloud account ID<br>Can be empty: False <br> |
| accessCfg.bucket | string |  | Bucket<br>Can be empty: False <br> |
| accessCfg.externalId | string |  | External unique ID (external unique ID in AWS role authorization method)<br>Can be empty: False <br> |
| accessCfg.role | string |  | Role name<br>Can be empty: False <br> |
| accessCfg.ak | string |  | Secret key Id<br>Can be empty: False <br> |
| accessCfg.sk | string |  | Secret key<br>Can be empty: False <br> |
| accessCfg.topic | string |  | Topic<br>Can be empty: False <br>Can be an empty string: True <br> |
| accessCfg.url | string |  | URL address (used for kafka)<br>Can be empty: False <br> |
| accessCfg.securityProtocol | string |  | Security protocol (used for kafka)<br>Can be empty: False <br>Options: ['plaintext', 'sasl_plaintext', 'sasl_ssl'] <br> |
| accessCfg.ca | string |  | Client ssl certificate content<br>Can be empty: False <br>Can be an empty string: True <br> |
| accessCfg.mechanism | string |  | Authentication method<br>Can be empty: False <br>Can be an empty string: True <br>Options: ['plain', 'scram-sha-256', 'scram-sha-512'] <br> |
| accessCfg.username | string |  | Username<br>Can be empty: False <br>Can be an empty string: True <br> |
| accessCfg.password | string |  | Password<br>Can be empty: False <br>Can be an empty string: True <br> |
| accessCfg.region | string |  | Region (optional values, if not entered then defaults to the corresponding vendor region matching the current site)<br>Can be empty: False <br> |
| accessCfg.bucketPath | string |  | Bucket path<br>Can be empty: False <br> |

## Supplementary Parameter Explanation





## Request Example
```shell
curl 'https://openapi.<<< custom_key.brand_main_domain >>>/api/v1/log_backup_cfg/add' \
-H 'Accept: application/json, text/plain, */*' \
-H 'Content-Type: application/json;charset=UTF-8' \
-H 'DF-API-KEY: <DF-API-KEY>' \
--data-raw '{"extend":{"filters":[],"filterLogic":"and"},"syncExtensionField":true,"storeType":"obs","name":"temp_test","dataType":"tracing","accessCfg":{"cloudAccountId":"f000ee4d7327428da2f53a081e7109bd","bucket":"test-obs01-418d","region":"cn-south-1","provider":"huawei"}}' \
--compressed
```




## Response
```shell
{
    "code": 200,
    "content": {
        "conditions": "",
        "createAt": 1697613651,
        "creator": "xxx",
        "dataType": "tracing",
        "deleteAt": -1,
        "extend": {
            "filterLogic": "and",
            "filters": []
        },
        "externalResourceAccessCfgUUID": "erac_xxxx32",
        "id": null,
        "name": "temp_test",
        "status": 0,
        "storeType": "obs",
        "syncExtensionField": true,
        "taskErrorCode": "",
        "taskStatusCode": -1,
        "updateAt": 1697613651,
        "updator": "xxx",
        "uuid": "lgbp_xxxx32",
        "workspaceUUID": "wksp_xxxx32"
    },
    "errorCode": "",
    "message": "",
    "success": true,
    "traceId": "TRACE-31D4417B-2665-4CFA-9BC9-60BD6A540744"
} 
```