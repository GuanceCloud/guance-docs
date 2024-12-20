# 【对象分类配置】列出

---

<br />**GET /api/v1/objc_cfg/list**

## 概述
获取对象分类配置列表，当前接口无分页




## Query 请求参数

| 参数名        | 类型     | 必选   | 说明              |
|:-----------|:-------|:-----|:----------------|
| objcGroupUUID | string |  | 业务分组UUID<br>允许为空: False <br>例子: objcg_xxxx <br>允许为空字符串: True <br>最大长度: 64 <br> |
| sourceType | string | Y | 来源类型<br>允许为空: False <br>例子: custom_object <br>可选值: ['object', 'custom_object'] <br> |
| search | string |  | 搜索对象分类名<br>允许为空: False <br>例子: xxx <br> |
| timeRange | string |  | 时间范围<br>例子: [1734402721237, 1734575521237] <br>允许为空: False <br> |

## 参数补充说明





## 请求例子
```shell
curl 'https://openapi.guance.com/api/v1/objc_cfg/list?sourceType=custom_object&timeRange=[1734573756731]' \
-H 'DF-API-KEY: <DF-API-KEY>' \
--compressed
```




## 响应
```shell
{
    "code": 200,
    "content": [
        {
            "uuid": "objc_xxxx",
            "name": "test",
            "alias": "",
            "fields": [
                {
                    "name": "name1"
                },
                {
                    "name": "name2"
                }
            ],
            "filters": [],
            "tableColumns": [],
            "tableDetailViews": [
                {
                    "keys": {},
                    "title": "demo",
                    "required": true,
                    "viewName": "NtpQ 监控视图",
                    "viewType": "dashboard",
                    "timerange": "default"
                }
            ],
            "iconSet": {},
            "objcGroupUUID": "objcg_xxxx",
            "objcGroupInfo": {
                "workspaceUUID": "wksp_xxx",
                "name": "eeee",
                "id": 86,
                "uuid": "objcg_xxxx",
                "status": 0,
                "creator": "acnt_xxxx",
                "updator": "",
                "createAt": 1734512088,
                "deleteAt": -1,
                "updateAt": -1
            }
        }
    ],
    "errorCode": "",
    "message": "",
    "success": true,
    "traceId": "868484794797253491"
} 
```




