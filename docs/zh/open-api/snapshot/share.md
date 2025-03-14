# 分享一个快照

---

<br />**POST /api/v1/snapshots/\{snapshot_uuid\}/share**

## 概述
根据`snapshot_uuid`生成指定快照的分享链接




## 路由参数

| 参数名        | 类型     | 必选   | 说明              |
|:-----------|:-------|:-----|:----------------|
| snapshot_uuid | string | Y | 快照UUID<br> |


## Body 请求参数

| 参数名        | 类型     | 必选   | 说明              |
|:-----------|:-------|:-----|:----------------|
| changeTime | boolean |  | 是否允许查看者更改时间范围, 默认为 false<br>允许为空: False <br> |
| expirationAt | integer |  | 过期时间为时间戳, 永久有效 传 -1<br>例子: 1577758776 <br>允许为空: False <br>允许为空字符串: True <br> |
| extractionCode | string |  | 创建加密分享时, 访问时的提取码<br>例子: 123455x <br>允许为空: False <br>允许为空字符串: True <br>最大长度: 12 <br> |
| hiddenTopBar | boolean |  | 是否隐藏顶部栏, 默认为 false<br>允许为空: False <br> |
| showWatermark | boolean |  | 是否显示水印, 默认 false<br>允许为空: False <br> |
| maskCfg | None |  | <br> |
| maskCfg.fields | string |  | 脱敏字段, 多个字段用,号分隔<br>例子: message,host <br>允许为空: False <br>允许为空字符串: True <br> |
| maskCfg.reExprs | array |  | 正则表达式<br>例子: [{'name': 'jjj', 'reExpr': 'ss', 'enable': 0}, {'name': 'lll', 'reExpr': 'ss', 'enable': 1}] <br>允许为空: False <br> |
| ipWhitelistSet | None |  | <br> |
| ipWhitelistSet.isOpen | boolean |  | 是否开启 ip 白名单<br>允许为空: False <br> |
| ipWhitelistSet.type | string |  | 开启 ip 白名单的类型, followWorkspace<br>例子: 123455x <br>允许为空: False <br>允许为空字符串: True <br>最大长度: 12 <br>可选值: ['followWorkspace', 'custom'] <br> |
| ipWhitelistSet.ipWhitelist | array |  | ip 白名单列表, 当 type 为 custom 时使用<br>例子: [] <br>允许为空: False <br> |

## 参数补充说明


*请求参数说明*

|  参数名                |   type  |          说明          |
|-----------------------|----------|------------------------|
|changeTime             |boolean| 是否允许查看者更改时间范围|
|expirationAt             |integer| 过期时间为秒级时间戳, 永久有效 传 -1|
|extractionCode   |string     | 创建加密分享时, 访问时的提取码, 默认公开|
|hiddenTopBar   |boolean     | 是否隐藏顶部栏, 默认为 false |
|showWatermark |boolean     | 是否显示水印|
|maskCfg |dict     | 脱敏配置|
|ipWhitelistSet |dict     | 快照 ip 白名单配置|

--------------

*maskCfg 内部字段说明*
|  参数名                |   type  |          说明          |
|-----------------------|----------|------------------------|
|fields             |string| 脱敏字段, 多个字段用,号分隔|
|reExprs   |array     | 正则表达式 列表|

--------------

*maskCfg.reExprs 内部字段说明*
|  参数名                |   type  |          说明          |
|-----------------------|----------|------------------------|
|name             |string| 脱敏字段名称|
|reExpr   |string     | 正则表达式|
|enable   |integer     | 是否开启 0,1|

--------------

*ipWhitelistSet 内部字段说明*
|  参数名                |   type  |          说明          |
|-----------------------|----------|------------------------|
|isOpen             |boolean| 过期时间为秒级时间戳, 永久有效 传 -1|
|type   |string     | 开始 ip 白名单的类型, 跟随空间 ip 白名单配置: followWorkspace, 自定义: custom|
|ipWhitelist   |boolean     | ip 白名单列表, 当 type 为 custom 时使用 |

--------------




## 请求例子
```shell
curl 'https://openapi.<<< custom_key.brand_main_domain >>>/api/v1/snapshots/snap_xxxx32/share' \
-H 'DF-API-KEY: <DF-API-KEY>' \
-H 'Content-Type: application/json;charset=UTF-8' \
--data-raw '{"changeTime":true,"expirationAt":1730874467,"hiddenTopBar":false,"showWatermark":true,"maskCfg":{"fields":"","reExprs":[]},"ipWhitelistSet":{"isOpen":false},"changeTime":true}' \
--compressed 
```




## 响应
```shell
{
    "code": 200,
    "content": {
        "declaration": {
            "asd": "aa,bb,cc,1,True",
            "asdasd": "dawdawd",
            "business": "aaa",
            "dd": "dd",
            "fawf": "afawf",
            "organization": "64fe7b4062f74d0007b46676"
        },
        "isHidden": false,
        "shortUrl": "https://aa.com/rj6mm3",
        "token": "shared.eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ3c191dWlkIjoid2tzcF80YjU3YzdiYWIzOGU0YTJkOTYzMGY2NzVkYzIwMDE1ZCIsInNoYXJlX2NvbmZpZ191dWlkIjoic2hhcmVfNDhiYjBhMTExNDJhNDM0Nzk0NmM4Y2YxOWExZTAxZTYiLCJleHBpcmF0aW9uQXQiOjE3MzA4NzQ0NjcsInJlc291cmNlVHlwZSI6InNuYXBzaG90In0.ZMgLS7S1umNSMA8-zJIGQh4G8cEl4vl5fVHNHoIQrbU"
    },
    "errorCode": "",
    "message": "",
    "success": true,
    "traceId": "TRACE-67FFC05B-64BA-4A56-B831-D3FCEFE4451C"
} 
```




