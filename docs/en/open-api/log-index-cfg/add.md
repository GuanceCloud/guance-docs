# Create a single index configuration

---

<br />**POST /api/v1/log_index_cfg/add**

## Overview
Modify the configuration of a single default storage index




## Body Request Parameters

| Parameter Name        | Type     | Required   | Description              |
|:------------------|:-------|:-----|:----------------|
| name | string | Y | Index name<br>Example: xxx <br>Allow empty: False <br>Maximum length: 256 <br> |
| extend | json |  | Front-end custom data<br>Allow empty: True <br> |
| duration | string |  | Data retention period<br>Allow empty: False <br>Example: 7d <br> |
| setting | json |  | Related Configuration information<br>Allow empty: False <br> |
| setting.hot_retention | int |  | Volcengine storage, Standard storage - Hot storage<br>Allow empty: False <br> |
| setting.cold_retention | int |  | Volcengine storage, Infrequent storage - Cold data<br>Allow empty: False <br> |
| setting.archive_retention | int |  | Volcengine storage, Archive storage - Archival data<br>Allow empty: False <br> |

## Additional Parameter Explanation



**1. Request Parameter Explanation**

|  Parameter Name                |   type  | Required  |          Description          |
|-----------------------|----------|----|------------------------|
|name                   |String|Required| Index name|
|extend                   |Json|| Extended information for front-end recall|
|duration                   |Json|| Total storage duration of the index, example: 60d|
|setting                   |Json|| When logs are stored in Volcengine, index configuration information|

--------------

**2. **Explanation of parameters in `setting`

|  Parameter Name                |   type  | Required  |          Description          |
|-----------------------|----------|----|------------------------|
|hot_retention                   |int|Required| Standard storage - Hot data, must be whole hours unit: hours h |
|cold_retention                   |int|| Infrequent storage - Cold data, must be whole hours unit: hours h|
|archive_retention                   |int|| Archive storage - Archival data, must be whole hours unit: hours h|

2.1. Volcengine storage duration restrictions:
      <br/>
Standard storage: Hot data storage, data range: 1-1800 days. If there is infrequent storage, data range: 7-1800 days; if there is archive storage, data range: 30-1800 days.
      <br/>
Infrequent storage: Cold data storage, data range: 30-1800 days.
      <br/>
Archive storage: Archival data storage, data range: 60-1800 days.
      <br/>
2.2. Volcengine storage duration restrictions:
      <br/>
Total storage duration (Standard storage + Infrequent storage + Archive storage) cannot exceed 1800 days.

--------------

**3. **Explanation of parameters in `extend`

|  Parameter Name                |   type  | Required  |          Description          |
|-----------------------|----------|----|------------------------|
|filters                   |Array[dict]|| List of filtering conditions|
|extendFields                   |string|| Index extended field information, multiple fields separated by commas (,)|

--------------

**4. Main structure explanation of `extend.filters`**

|  Parameter Name             |   type  | Required  |          Description          |
|--------------------|----------|----|------------------------|
|condition           |string |  | Relationship with the previous filter condition, optional values: `and`, `or`; default value: `and` |
|name                |string |  | Field name to be filtered |
|operation           |string |  | Operator, optional values:  `in`, `not_in`|
|value               |array |  | Value list |
|value[#]            |string/int/boolean |  | Can be string/numeric/boolean types|

--------------




## Request Example
```shell
curl 'https://openapi.<<< custom_key.brand_main_domain >>>/api/v1/log_index_cfg/add' \
-H 'Accept: application/json, text/plain, */*' \
-H 'Accept-Language: en' \
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