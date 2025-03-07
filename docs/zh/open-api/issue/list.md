# issue 列出

---

<br />**POST /api/v1/issue/list**

## 概述




## Body 请求参数

| 参数名        | 类型     | 必选   | 说明              |
|:-----------|:-------|:-----|:----------------|
| channelUUID | string |  | 频道UUID<br>例子: chan_xxxxx <br>允许为空: False <br> |
| filters | array |  | 筛选条件<br>例子: [{key: xxxx, value: xxx, equal: true}...] <br>允许为空: False <br> |
| startTime | integer |  | 开始时间<br>例子: xxxxx <br>允许为空: False <br> |
| endTime | integer |  | 结束时间<br>例子: xxxxx <br>允许为空: False <br> |
| search | string |  | 普通搜索字段<br>例子: xxxxx_text <br>允许为空: False <br>允许为空字符串: True <br> |
| pageSize | integer |  | 每页返回数量<br>允许为空: False <br>例子: 10 <br> |
| pageIndex | integer |  | 页码<br>允许为空: False <br>例子: 10 <br> |

## 参数补充说明


**filters过滤条件说明**

|     参数名      | 参数类型 | 是否必填 |                  参数说明                   |
|:---------------:|:--------:|:--------:|:-------------------------------------------:|
|      channelUUID   |  string  |    Y   |                频道uuid                |
|      startTime   |  int  |    F   |               开始时间               |
|      endTime   |  int  |    F   |               结束时间               |
|      pageIndex   |  int  |    F   |               页码               |
|      pageSize   |  int  |    F   |               每页条数               |
|      search   |  string  |    F   |               搜索字段(名称和描述)              |
|      filters   |  array  |    F   |                issue列表过滤条件                |


**filters详细说明**

|     参数名      | 参数类型 |                  参数说明                   |
|:---------------:|:--------:|:-------------------------------------------:|
|      filters.key     |  string  |  过滤条件key                          |                       
|      filters.value   |  string  |  过滤条件值                           |
|      filters.equal   |  string  |  比较符号 （true:等于；false:不等于）   |


**filters.key详细说明**

|     参数名      |                 说明                   |
|:---------------:|:-------------------------------------------:|
|      resource |            资源名称              |
|      level   |          issue等级uuid            |
|      statusType   |     issue状态 [10:Open,15:Working,20:Resolved,25:Closed,30:Pending]       |
|      creator   |     创建人       |
|      updator   |     更新人       |

**filters示例**

```json
[{"key": "statusType", "value": 30, "equal": true}, {"key": "resource", "value": 'dds', "equal": false}]
```




## 请求例子
```shell
curl 'https://openapi.guance.com/api/v1/issue/list' \
-H 'DF-API-KEY: <DF-API-KEY>' \
-H 'Content-Type: application/json;charset=UTF-8' \
--data-raw '{"pageIndex":1,"pageSize":20,"search":"","filters":[],"channelUUID":"xxxxxxxx"}' \
--compressed
```




## 响应
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
                "resourceType": "viewer",
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




