# 分享一个快照

---

<br />**POST /api/v1/snapshots/\{snapshot_uuid\}/share**

## 概述
根据`snapshot_uuid`生成指定快照的分享链接




## 路由参数

| 参数名        | 类型     | 必选   | 说明              |
|:-----------|:-------|:-----|:----------------|
| snapshot_uuid | string | Y | 快照UUID<br> |


## Query 请求参数

| 参数名        | 类型     | 必选   | 说明              |
|:-----------|:-------|:-----|:----------------|
| hiddenTopBar | boolean |  | 是否隐藏侧边栏, 默认为 false<br>允许为空: False <br> |

## 参数补充说明







## 响应
```shell
{
    "code": 200,
    "content": {
        "shortUrl": "https://t.guance.com/HdPsQ"
    },
    "errorCode": "",
    "message": "",
    "success": true,
    "traceId": "TRACE-582B86B2-12C4-4A5D-9B26-83A5D527A994"
} 
```




