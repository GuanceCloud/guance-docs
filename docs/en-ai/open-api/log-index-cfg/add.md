# Create a Single Index Configuration

---

<br />**POST /api/v1/log_index_cfg/add**

## Overview
Modify the configuration of a single default storage index



## Body Request Parameters

| Parameter Name        | Type     | Required   | Description              |
|:------------------|:-------|:-----|:----------------|
| name | string | Y | Index name<br>Example: xxx <br>Can be empty: False <br>Maximum length: 256 <br> |
| extend | json |  | Custom data for frontend<br>Can be empty: True <br> |
| duration | string |  | Data retention duration<br>Can be empty: False <br>Example: 7d <br> |
| setting | json |  | Configuration information<br>Can be empty: False <br> |
| setting.hot_retention | int |  | Volc Engine Storage, Standard Storage - Hot Data<br>Can be empty: False <br> |
| setting.cold_retention | int |  | Volc Engine Storage, Infrequent Storage - Cold Data<br>Can be empty: False <br> |
| setting.archive_retention | int |  | Volc Engine Storage, Archive Storage - Archived Data<br>Can be empty: False <br> |

## Additional Parameter Explanation

**1. Request Parameter Description**

| Parameter Name                | Type  | Required  | Description          |
|-----------------------|----------|----|------------------------|
|name                   |String|Yes| Index name|
|extend                   |Json|| Extended information used for frontend display|
|duration                   |Json|| Total storage duration of the index, example: 60d|
|setting                   |Json|| Index configuration information when logs are stored in Volc Engine Storage|

--------------

**2. Parameter Description within `setting`**

| Parameter Name                | Type  | Required  | Description          |
|-----------------------|----------|----|------------------------|
|hot_retention                   |int|Yes| Standard Storage - Hot Data, must be whole hours Unit: hours h |
|cold_retention                   |int|No| Infrequent Storage - Cold Data, must be whole hours Unit: hours h|
|archive_retention                   |int|No| Archive Storage - Archived Data, must be whole hours Unit: hours h|

2.1 Volc Engine Storage Duration Limitations:
      <br/>
Standard Storage: Hot Data Storage, Data range: 1-1800 days. If there is Infrequent Storage, then the data range: 7-1800 days; if there is Archive Storage, then the data range: 30-1800 days.
      <br/>
Infrequent Storage: Cold Data Storage, Data range: 30-1800 days.
      <br/>
Archive Storage: Archived Data Storage, Data range: 60-1800 days.
      <br/>
2.2 Volc Engine Storage Duration Limitations:
      <br/>
Total storage duration (Standard Storage + Infrequent Storage + Archive Storage) cannot exceed 1800 days.

--------------

**3. Parameter Description within `extend`**

| Parameter Name                | Type  | Required  | Description          |
|-----------------------|----------|----|------------------------|
|filters                   |Array[dict]|| List of filter conditions|

--------------

**4. Structure Description of `extend.filters`**

| Parameter Name             | Type  | Required  | Description          |
|--------------------|----------|----|------------------------|
|condition           |string | No | Relationship with the previous filter condition, possible values: `and`, `or`; default value: `and` |
|name                |string | No | Field name to be filtered |
|operation           |string | No | Operator, possible values: `in`, `not_in`|
|value               |array | No | Value list |
|value[#]            |string/int/boolean | No | Can be string/numeric/boolean type|

--------------



## Request Example
```shell
curl 'https://openapi.guance.com/api/v1/log_index_cfg/add' \
-H 'Accept: application/json, text/plain, */*' \
-H 'Accept-Language: zh' \
-H 'Content-Type: application/json;charset=UTF-8' \
-H 'DF-API-KEY: <DF-API-KEY>' \
--data-raw '{"name": "test_index", "duration":"14d","extend":{"filters":[{"condition":"and","name":"host","operation":"in","value":["custom_host1"]}]}}' \
--compressed
```



## Response
```shell
{
    "code": 200,
    "content": {
        "conditions": "{  `host` in [ 'custom_host1' ] }",
        "createAt": 1698751853,
        "creator": "xxx",
        "deleteAt": -1,
        "duration": "14d",
        "extend": {
            "filters": [
                {
                    "condition": "and",
                    "name": "host",
                    "operation": "in",
                    "value": [
                        "custom_host1"
                    ]
                }
            ]
        },
        "exterStoreName": "",
        "exterStoreProject": "",
        "externalResourceAccessCfgUUID": "",
        "id": null,
        "isBindCustomStore": 0,
        "isPublicNetworkAccess": 0,
        "name": "test_index",
        "queryType": "logging",
        "region": "",
        "setting": {},
        "sortNo": 3,
        "status": 0,
        "storeType": "",
        "updateAt": 1698751853,
        "updator": "xxx",
        "uuid": "lgim_xxxx32",
        "workspaceUUID": "wksp_xxxx32"
    },
    "errorCode": "",
    "message": "",
    "success": true,
    "traceId": "TRACE-600346C3-6C89-4391-9CA3-2152D10149D8"
} 
```