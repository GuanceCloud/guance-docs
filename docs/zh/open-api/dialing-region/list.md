# 获取自建节点列表

---

<br />**GET /api/v1/dialing_region/list**

## 概述
获取自建节点列表




## Query 请求参数

| 参数名        | 类型     | 必选   | 说明              |
|:-----------|:-------|:-----|:----------------|
| isAlive | string |  | 节点状态选择<br>允许为空: True <br>可选值: ['true', 'false'] <br> |

## 参数补充说明





## 请求例子
```shell
curl 'https://openapi.guance.com/api/v1/dialing_region/list' \
-H 'DF-API-KEY: <DF-API-KEY>' \
--compressed
```




## 响应
```shell
{
    "code": 200,
    "content": [
        {
            "city": "Shahrak",
            "company": "",
            "country": "Afghanistan",
            "create_at": 1678032331,
            "external_id": "",
            "heartbeat": -1,
            "internal": false,
            "isp": "telecom",
            "keycode": "Afghanistan-Shahrak-telecom",
            "name": "test",
            "owner": "custom",
            "parent_ak": "",
            "province": "",
            "region": "Afghanistan-Shahrak-telecom",
            "status": "OK",
            "uuid": "reg_xxxx20"
        }
    ],
    "errorCode": "",
    "message": "",
    "success": true,
    "traceId": "TRACE-5010C5BB-64DE-4EFA-B727-D88D5BCC9280"
} 
```




