# 快速列出RUM配置信息

---

<br />**GET /api/v1/rum_cfg/quick_list**

## 概述
列出所有应用简单配置信息




## Query 请求参数

| 参数名        | 类型     | 必选   | 说明              |
|:-----------|:-------|:-----|:----------------|
| appId | commaArray |  | appid<br>允许为空: False <br>例子: app_xxx <br> |

## 参数补充说明


*数据说明.*




## 请求例子
```shell
curl 'https://openapi.guance.com/api/v1/rum_cfg/quick_list?appId=appid_xxx1,appid_xxx2' \
  -H 'Content-Type: application/json' \
  -H 'DF-API-KEY: <DF-API-KEY>' \
  --compressed
```




## 响应
```shell
{
    "code": 200,
    "content": [
        {
            "appId": "appid_xxx1",
            "jsonContent": {
                "name": "lwctest",
                "type": "web"
            },
            "uuid": "appid_xxxx32",
            "workspaceUUID": "wksp_xxxx32"
        },
        {
            "appId": "appid_xxx2",
            "jsonContent": {
                "name": "DataFlux Web",
                "type": "web"
            },
            "uuid": "appid_xxxx32",
            "workspaceUUID": "wksp_xxxx32"
        }
    ],
    "errorCode": "",
    "message": "",
    "success": true,
    "traceId": "TRACE-68EEEB4A-9ABC-4DDB-A72B-40F07F2699A5"
} 
```




