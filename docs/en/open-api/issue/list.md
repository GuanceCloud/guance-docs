# Issue List

---

<br />**POST /api/v1/issue/list**

## Overview




## Body Request Parameters

| Parameter Name        | Type     | Required   | Description              |
|:---------------------|:---------|:-----------|:-------------------------|
| channelUUID          | string   | Yes        | Channel UUID<br>Example: chan_xxxxx <br>Can be empty: False <br> |
| filters              | array    | No         | Filtering conditions<br>Example: [{key: xxxx, value: xxx, equal: true}...] <br>Can be empty: False <br> |
| startTime            | integer  | Yes        | Start time<br>Example: xxxxx <br>Can be empty: False <br> |
| endTime              | integer  | Yes        | End time<br>Example: xxxxx <br>Can be empty: False <br> |
| search               | string   | No         | General search field<br>Example: xxxxx_text <br>Can be empty: False <br>Can be an empty string: True <br> |
| pageSize             | integer  | Yes        | Number of items per page<br>Can be empty: False <br>Example: 10 <br> |
| pageIndex            | integer  | Yes        | Page number<br>Can be empty: False <br>Example: 10 <br> |

## Additional Parameter Descriptions


**Filters Explanation**

| Parameter Name       | Data Type | Required | Description                  |
|:--------------------:|:----------:|:--------:|:----------------------------:|
| channelUUID          | string     | Yes      | Channel UUID                 |
| startTime            | int        | No       | Start time                   |
| endTime              | int        | No       | End time                     |
| pageIndex            | int        | No       | Page number                  |
| pageSize             | int        | No       | Items per page               |
| search               | string     | No       | Search field (name and description) |
| filters              | array      | No       | Issue list filtering conditions |

**Detailed Filters Explanation**

| Parameter Name       | Data Type | Description                  |
|:--------------------:|:----------:|:----------------------------:|
| filters.key          | string     | Filter condition key         |                       
| filters.value        | string     | Filter condition value       |
| filters.equal        | string     | Comparison symbol (true: equals; false: not equals) |

**Detailed Filters.Key Explanation**

| Parameter Name       | Description                  |
|:--------------------:|:----------------------------:|
| resource             | Resource name                |
| level                | Issue level UUID             |
| statusType           | Issue status [10:Open,15:Working,20:Resolved,25:Closed,30:Pending] |
| creator              | Creator                      |
| updator              | Updator                      |

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
                    "email": "962584902@qq.com",
                    "iconUrl": "",
                    "name": "kj1",
                    "username": "962584902@qq.com"
                },
                "deleteAt": -1,
                "description": "<span><span><span><span><span data-at-embedded=\"\" data-insert-by=\"@\" data-info=\"{&quot;item&quot;:{&quot;uuid&quot;:&quot;acnt_xxxx32&quot;}}\" contenteditable=\"false\">&nbsp;<span data-v-52ded4e5=\"\"><span data-v-52ded4e5=\"\" class=\"key-word\">@jiangyd@jiagouyun.com</span></span>&nbsp;</span><span data-at-embedded=\"\" data-insert-by=\"#\" data-info=\"{&quot;item&quot;:{&quot;uuid&quot;:&quot;chan_xxxx32&quot;}}\" contenteditable=\"false\">&nbsp;<span data-v-52ded4e5=\"\"><span data-v-52ded4e5=\"\"><span data-v-52ded4e5=\"\" class=\"key-word\">#jjj</span></span></span>&nbsp;</span>nn</span></span></span></span>",
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
                    "text": "@jiangyd@jiagouyun.com  #jjj nn"
                },
                "id": 108010,
                "level": 2,
                "name": "bbbb",
                "resource": "APM-http://testing-ft2x-saas.cloudcare.cn/tracing/service/table?leftActiveKey=Tracing&activeName=LinkToTrackService&w=wksp_xxxx32&time=15m",
                "resourceType": "Explorer",
                "resourceUUID": "",
                "status": 0,
                "statusType": 30,
                "subIdentify": "",
                "updateAt": 1690424680,
                "updator": "acnt_xxxx32",
                "updatorInfo": {
                    "acntWsNickname": "",
                    "email": "962584902@qq.com",
                    "iconUrl": "",
                    "name": "kj1",
                    "username": "962584902@qq.com"
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