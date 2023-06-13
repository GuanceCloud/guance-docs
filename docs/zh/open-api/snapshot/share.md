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
        "shortUrl": "https://t.guance.com/HdPsQ",
        "token": "shared.eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ3c191dWlkIjoid2tzcF8yZGM0MzFkNjY5MzcxMWViOGZmOTdhZWVlMDRiNTRhZiIsInNoYXJlX2NvbmZpZ191dWlkIjoic2hhcmVfMjk4YjJiOTBmMzk0NDkwOTg2ZmI2NmMyYjg3ZDJmODMiLCJleHBpcmF0aW9uQXQiOjE2NDI3NTExMjIsInJlc291cmNlVHlwZSI6InNuYXBzaG90In0.zjNAaVdtflGsZ46i1r9Q3hVHHfLhXRFUyp6wgWIIuoI"
    },
    "errorCode": "",
    "message": "",
    "success": true,
    "traceId": "TRACE-582B86B2-12C4-4A5D-9B26-83A5D527A994"
} 
```




