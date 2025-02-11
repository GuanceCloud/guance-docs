# Get Single Index/Bind Index Configuration

---

<br />**GET /api/v1/log_index_cfg/\{cfg_uuid\}/get**

## Overview
Retrieve a bound index configuration.

## Route Parameters

| Parameter Name        | Type     | Required | Description              |
|:-------------------|:-------|:-----|:----------------|
| cfg_uuid | string | Y | UUID of the log index configuration |

## Query Request Parameters

| Parameter Name        | Type     | Required | Description              |
|:-------------------|:-------|:-----|:----------------|
| isShowAccessCfg | boolean |  | Whether to display accessCfg |
| isShowFields | boolean |  | Whether to display the fields list |

## Additional Parameter Explanation

**Response Body Structure Explanation**

| Parameter Name                | Type  | Description          |
|-----------------------|----------|------------------------|
| isBindCustomStore         | int | 1: Bound to custom storage index configuration, 0: Default |
| storeType         | string | Storage type ('es': Elasticsearch storage, 'sls': SLS Logstore storage, 'opensearch': OpenSearch storage, 'beaver': LogEase storage) |
| fields         | array | Field mapping configuration |
| accessCfg         | array | Custom storage index permission configuration items |

## Request Example
```shell
curl 'https://openapi.guance.com/api/v1/log_index_cfg/lgim_xxxx32/get' \
-H 'DF-API-KEY: <DF-API-KEY>' \
--compressed
```

## Response
```shell
{
    "code": 200,
    "content": {
        "conditions": "",
        "createAt": 1677665779,
        "creator": "xxx",
        "deleteAt": -1,
        "duration": "",
        "extend": {},
        "exterStoreName": "aa_uuid",
        "exterStoreProject": "",
        "externalResourceAccessCfgUUID": "erac_xxxx32",
        "id": 12,
        "isBindCustomStore": 1,
        "isPublicNetworkAccess": 1,
        "name": "openapi_test",
        "queryType": "logging",
        "region": "",
        "regionInfo": {},
        "setting": {},
        "sortNo": 0,
        "status": 0,
        "storeType": "es",
        "updateAt": 1677665779,
        "updator": "xxx",
        "uuid": "lgim_xxxx32",
        "workspaceUUID": "wksp_xxxx32"
    },
    "errorCode": "",
    "message": "",
    "success": true,
    "traceId": "TRACE-82BF8659-CD28-409B-833B-97AA4758ACA1"
} 
```