# List issues

---

<br />**POST /api/v1/issue/list**

## Overview




## Body Request Parameters

| Parameter Name        | Type     | Required   | Description              |
|:-------------------|:-------|:-----|:----------------|
| channelUUID | string |  | Channel UUID<br>Example: chan_xxxxx <br>Can be empty: False <br> |
| filters | array |  | Filtering conditions<br>Example: [{key: xxxx, value: xxx, equal: true}...] <br>Can be empty: False <br> |
| startTime | integer |  | Start time<br>Example: xxxxx <br>Can be empty: False <br> |
| endTime | integer |  | End time<br>Example: xxxxx <br>Can be empty: False <br> |
| search | string |  | Regular search field<br>Example: xxxxx_text <br>Can be empty: False <br>Can be an empty string: True <br> |
| pageSize | integer |  | Number of results per page to return<br>Can be empty: False <br>Example: 10 <br> |
| pageIndex | integer |  | Page number<br>Can be empty: False <br>Example: 10 <br> |

## Additional Parameter Explanations


**Filters filtering condition description**

| Parameter Name      | Parameter Type | Required | Parameter Description                  |
|:-------------------:|:-------------:|:--------:|:------------------------------------:|
| channelUUID   | string  | Y   | Channel uuid                |
| startTime   | int  | F   | Start time               |
| endTime   | int  | F   | End time               |
| pageIndex   | int  | F   | Page index               |
| pageSize   | int  | F   | Number of items per page               |
| search   | string  | F   | Search field (name and description)              |
| filters   | array  | F   | Issue list filtering conditions                |


**Detailed Filters Explanation**

| Parameter Name      | Parameter Type | Parameter Description                  |
|:-------------------:|:-------------:|:------------------------------------:|
| filters.key     | string  | Filtering condition key                          |                       
| filters.value   | string  | Filtering condition value                           |
| filters.equal   | string  | Comparison symbol (true: equals; false: does not equal)   |


**Detailed Filters.Key Explanation**

| Parameter Name      | Description                  |
|:-------------------:|:----------------------------:|
| resource | Resource name            |
| level   | Issue level UUID            |
| statusType   | Issue status [10:Open,15:Working,20:Resolved,25:Closed,30:Pending]       |
| creator   | Creator       |
| updator   | Updator       |

**Filters Example**

```json
[{"key": "statusType", "value": 30, "equal": true}, {"key": "resource", "value": 'dds', "equal": false}]
```




## Request Example
```shell
curl 'https://openapi.<<< custom_key.brand_main_domain >>>/api/v1/issue/list' \
-H 'DF-API-KEY: <DF-API-KEY>' \
-H 'Content-Type: application/json;charset=UTF-8' \
--data-raw '{"pageIndex":1,"pageSize":20,"search":"","filters":[],"channelUUID":"xxxxxxxx"}' \
--compressed
```




## Response
```shell
{
    "code": 200,
    "content": {
        "data": [
            {
                "createAt": 1690424627,
                "creator": "acnt_xxxx32",
                "creatorInfo": {
                    "acntWsNickname": "",
                    "email": "xxx@<<< custom_key.brand_main_domain >>>",
                    "iconUrl": "",
                    "name": "kj1",
                    "username": "xxx@<<< custom_key.brand_main_domain >>>"
                },
                "deleteAt": -1,
                "description": "<span><span><span><span><span data-at-embedded=\"\" data-insert-by=\"@\" data-info=\"{&quot;item&quot;:{&quot;uuid&quot;:&quot;acnt_xxxx32&quot;}}\" contenteditable=\"false\">&nbsp;<span data-v-52ded4e5=\"\"><span data-v-52ded4e5=\"\" class=\"key-word\">@xxx@<<< custom_key.brand_main_domain >>></span></span>&nbsp;</span><span data-at-embedded=\"\" data-insert-by=\"#\" data-info=\"{&quot;item&quot;:{&quot;uuid&quot;:&quot;chan_xxxx32&quot;}}\" contenteditable=\"false\">&nbsp;<span data-v-52ded4e5=\"\"><span data-v-52ded4e5=\"\"><span data-v-52ded4e5=\"\" class=\"key-word\">#jjj</span></span></span>&nbsp;</span>nn</span></span></span></span>",
                "extend": {
                    "channels": [
                        {
                            "exists": true,
                            "type": "#",
                            "uuid": "chan_xxxx32"
                        }
                    ],
                    "members": [
                        {
                            "exists": true,
                            "type": "@",
                            "uuid": "acnt_xxxx32"
                        }
                    ],
                    "sourceLink": "/tracing/service/table?leftActiveKey=Tracing&activeName=LinkToTrackService&w=wksp_xxxx32&time=15m",
                    "text": "@xxx@<<< custom_key.brand_main_domain >>>  #jjj nn"
                },
                "id": 108010,
                "level": 2,
                "name": "bbbb",
                "resource": "APM-http://testing-ft2x-saas.cloudcare.cn/tracing/service/table?leftActiveKey=Tracing&activeName=LinkToTrackService&w=wksp_xxxx32&time=15m",
                "resourceType": "viewer",
                "resourceUUID": "",
                "status": 0,
                "statusType": 30,
                "subIdentify": "",
                "updateAt": 1690424680,
                "updator": "acnt_xxxx32",
                "updatorInfo": {
                    "acntWsNickname": "",
                    "email": "xxx@<<< custom_key.brand_main_domain >>>",
                    "iconUrl": "",
                    "name": "kj1",
                    "username": "xxx@<<< custom_key.brand_main_domain >>>"
                },
                "uuid": "issue_xxxx32",
                "workspaceUUID": "wksp_xxxx32"
            }
        ],
        "pageInfo": {
            "count": 1,
            "pageIndex": 1,
            "pageSize": 20,
            "totalCount": 1
        }
    },
    "errorCode": "",
    "message": "",
    "success": true,
    "traceId": "13848669999527981167"
} 
```