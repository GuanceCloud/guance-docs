# Get a Single Data Forwarding Rule

---

<br />**GET /api/v1/log_backup_cfg/{cfg_uuid}/get**

## Overview
Retrieve a single data forwarding rule


## Route Parameters

| Parameter Name        | Type     | Required | Description              |
|:------------------|:-------|:-----|:----------------|
| cfg_uuid | string | Y | UUID of the forwarding rule<br> |


## Additional Parameter Explanation

**Response Body Structure Explanation**

| Parameter Name                | Type  | Description          |
|-------------------------------|-------|----------------------|
| accessCfg         | dict | Third-party storage configuration information |
| name         | string | Name of the forwarding rule |
| uuid             | string | Unique UUID of the forwarding rule |
| status         | string | Status of the forwarding rule, 0: Enabled, 2: Disabled |
| dataType         | string | Data type |
| conditions         | string | Filtering conditions in DQL format |
| storeType         | string | Storage type |
| externalResourceAccessCfgUUID         | string | UUID of external resource access configuration |
| workspaceUUID             | string | UUID of the workspace where the forwarding rule resides |



## Request Example
```shell
curl 'https://openapi.guance.com/api/v1/log_backup_cfg/lgbp_xxxx32/get' \
-H 'DF-API-KEY: <DF-API-KEY>' \
--compressed
```



## Response
```shell
{
    "code": 200,
    "content": {
        "accessCfg": {
            "bucket": "sdafdasf",
            "cloudAccountId": "f000ee4d7327428da2f53a081e7109bd",
            "dataType": "logging",
            "provider": "huawei",
            "region": "cn-north-4",
            "storeType": "obs"
        },
        "conditions": "",
        "createAt": 1697543205,
        "creator": "acnt_xxxx32",
        "dataType": "logging",
        "deleteAt": -1,
        "extend": {
            "filterLogic": "and",
            "filters": []
        },
        "externalResourceAccessCfgUUID": "erac_xxxx32",
        "id": 684,
        "name": "ssfda***",
        "status": 0,
        "storeType": "obs",
        "syncExtensionField": false,
        "taskErrorCode": "NoSuchBucket",
        "taskStatusCode": 404,
        "updateAt": 1697610912,
        "updator": "acnt_xxxx32",
        "uuid": "lgbp_xxxx32",
        "workspaceUUID": "wksp_xxxx32"
    },
    "errorCode": "",
    "message": "",
    "success": true,
    "traceId": "TRACE-EC139239-C9D7-4A7C-A548-20F97358DF24"
} 
```