# 查询所有的issue列表信息数据

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
| search | string |  | 普通搜索字段<br>例子: xxxxx_text <br>允许为空: False <br>允许空字符串: True <br> |
| pageSize | integer |  | 每页返回数量<br>允许为空: False <br>例子: 10 <br> |
| pageIndex | integer |  | 页码<br>允许为空: False <br>例子: 10 <br> |

## 参数补充说明





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
                "creator": "acnt_ff14bbfd73624d799d9560f2ded68154",
                "creatorInfo": {
                    "acntWsNickname": "",
                    "email": "962584902@qq.com",
                    "iconUrl": "",
                    "name": "kj1",
                    "username": "962584902@qq.com"
                },
                "deleteAt": -1,
                "description": "<span><span><span><span><span data-at-embedded=\"\" data-insert-by=\"@\" data-info=\"{&quot;item&quot;:{&quot;uuid&quot;:&quot;acnt_e9194725921b456d9ae5ff268aceca0e&quot;}}\" contenteditable=\"false\">&nbsp;<span data-v-52ded4e5=\"\"><span data-v-52ded4e5=\"\" class=\"key-word\">@jiangyd@jiagouyun.com</span></span>&nbsp;</span><span data-at-embedded=\"\" data-insert-by=\"#\" data-info=\"{&quot;item&quot;:{&quot;uuid&quot;:&quot;chan_279ff258fffd472fa47f61ce1fb9ca5b&quot;}}\" contenteditable=\"false\">&nbsp;<span data-v-52ded4e5=\"\"><span data-v-52ded4e5=\"\"><span data-v-52ded4e5=\"\" class=\"key-word\">#jjj</span></span></span>&nbsp;</span>nn</span></span></span></span>",
                "extend": {
                    "channels": [
                        {
                            "exists": true,
                            "type": "#",
                            "uuid": "chan_279ff258fffd472fa47f61ce1fb9ca5b"
                        }
                    ],
                    "members": [
                        {
                            "exists": true,
                            "type": "@",
                            "uuid": "acnt_e9194725921b456d9ae5ff268aceca0e"
                        }
                    ],
                    "sourceLink": "/tracing/service/table?leftActiveKey=Tracing&activeName=LinkToTrackService&w=wksp_a7baa18031fb4a2db2ad467d384fd804&time=15m",
                    "text": "@jiangyd@jiagouyun.com  #jjj nn"
                },
                "id": 108010,
                "level": 2,
                "name": "bbbb",
                "resource": "APM-http://testing-ft2x-saas.cloudcare.cn/tracing/service/table?leftActiveKey=Tracing&activeName=LinkToTrackService&w=wksp_a7baa18031fb4a2db2ad467d384fd804&time=15m",
                "resourceType": "viewer",
                "resourceUUID": "",
                "status": 0,
                "statusType": 30,
                "subIdentify": "",
                "updateAt": 1690424680,
                "updator": "acnt_ff14bbfd73624d799d9560f2ded68154",
                "updatorInfo": {
                    "acntWsNickname": "",
                    "email": "962584902@qq.com",
                    "iconUrl": "",
                    "name": "kj1",
                    "username": "962584902@qq.com"
                },
                "uuid": "issue_da778a8295ae4292a3d9cf39105183f1",
                "workspaceUUID": "wksp_a7baa18031fb4a2db2ad467d384fd804"
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



