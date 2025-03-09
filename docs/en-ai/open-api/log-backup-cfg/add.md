# Create a Single Data Forwarding Rule

---

<br />**POST /api/v1/log_backup_cfg/add**

## Overview
Create a single data forwarding rule



## Body Request Parameters

| Parameter Name        | Type     | Required   | Description              |
|:---------------------|:---------|:----------|:------------------------|
| name | string | Y | Rule name<br>Example: xxx <br>Can be empty: False <br> |
| extend | json |  | Front-end custom data<br>Can be empty: True <br> |
| syncExtensionField | boolean |  | Synchronize backup extension fields, true for synchronization, false for no synchronization, default is no synchronization<br>Can be empty: False <br> |
| storeType | string | Y | Storage type<br>Can be empty: False <br>Optional values: ['guanceObject', 's3', 'obs', 'oss', 'kafka'] <br> |
| dataType | string |  | Data type<br>Can be empty: False <br>Optional values: ['logging', 'tracing', 'rum', 'keyevent'] <br> |
| duration | string |  | Data retention period,<br>Example: 180d <br>Optional values: ['180d', '360d', '720d'] <br> |
| accessCfg | json |  | External resource access configuration information<br>Can be empty: False <br> |
| accessCfg.provider | string |  | Provider<br>Can be empty: False <br>Optional values: ['aliyun', 'aws', 'huawei'] <br> |
| accessCfg.grantType | string |  | Authorization type<br>Can be empty: False <br>Optional values: ['role', 'ram'] <br> |
| accessCfg.cloudAccountId | string |  | Cloud account ID<br>Can be empty: False <br> |
| accessCfg.bucket | string |  | Bucket<br>Can be empty: False <br> |
| accessCfg.externalId | string |  | External unique identifier ID (external unique identifier ID in AWS role authorization method)<br>Can be empty: False <br> |
| accessCfg.role | string |  | Role name<br>Can be empty: False <br> |
| accessCfg.ak | string |  | Access key ID<br>Can be empty: False <br> |
| accessCfg.sk | string |  | Secret key<br>Can be empty: False <br> |
| accessCfg.topic | string |  | Topic<br>Can be empty: False <br>Can be an empty string: True <br> |
| accessCfg.url | string |  | URL address (for Kafka)<br>Can be empty: False <br> |
| accessCfg.securityProtocol | string |  | Security protocol (for Kafka)<br>Can be empty: False <br>Optional values: ['plaintext', 'sasl_plaintext', 'sasl_ssl'] <br> |
| accessCfg.ca | string |  | Client SSL certificate content<br>Can be empty: False <br>Can be an empty string: True <br> |
| accessCfg.mechanism | string |  | Authentication mechanism<br>Can be empty: False <br>Can be an empty string: True <br>Optional values: ['plain', 'scram-sha-256', 'scram-sha-512'] <br> |
| accessCfg.username | string |  | Username<br>Can be empty: False <br>Can be an empty string: True <br> |
| accessCfg.password | string |  | Password<br>Can be empty: False <br>Can be an empty string: True <br> |
| accessCfg.region | string |  | Region (optional values, if not entered, it defaults to the region of the current site's corresponding vendor)<br>Can be empty: False <br> |
| accessCfg.bucketPath | string |  | Bucket path<br>Can be empty: False <br> |

## Additional Parameter Notes



## Request Example
```shell
curl 'https://openapi.guance.com/api/v1/log_backup_cfg/add' \
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