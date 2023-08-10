# 【服务清单】获取

---

<br />**GET /api/v1/service_manage/\{service_uuid\}/get**

## 概述
获取单个服务清单信息




## 路由参数

| 参数名        | 类型     | 必选   | 说明              |
|:-----------|:-------|:-----|:----------------|
| service_uuid | string | Y | 服务对应的uuid<br>例子: xxxx <br>允许空字符串: False <br> |


## Query 请求参数

| 参数名        | 类型     | 必选   | 说明              |
|:-----------|:-------|:-----|:----------------|
| originStr | string |  | 原始字符串传1, 结构化数据传0, 默认为1<br>允许为空: False <br> |

## 参数补充说明


**请求主体结构说明**

|  参数名        |   type  | 必选  |          说明          |
|---------------|----------|----|------------------------|
| service_uuid    |  string  |  Y | 服务清单的唯一uuid, 前缀为 sman_ |
| originStr |  string  |  N | 是否需要返回的 serviceCatelog 为原始字符串, 1为是, 0为否. 默认为1 |

**响应主体结构说明**

|  参数名                |   type  |          说明          |
|-----------------------|----------|------------------------|
|serviceCatelog         |string,dict |  服务清单的原始字符串或者结构化数据 |
|service         |string |  服务名称 |
|type         |string |  服务类型 |




## 请求例子
```shell
curl 'https://openapi.guance.com/api/v1/service_manage/sman_5eaba28c14e94876b4aa0157ecb1e090/get?originStr=0' \
  -H 'Content-Type: application/json' \
  -H 'DF-API-KEY: <DF-API-KEY>' \
  --compressed
```




## 响应
```shell
{
    "code": 200,
    "content": {
        "createAt": 1691233484,
        "service": "kodo",
        "serviceCatelog": {
            "Docs": [
                {
                    "link": "https://www.docs.guance.com",
                    "name": "guance",
                    "provider": "guanceyun"
                },
                {
                    "link": "https://func.guance.com/doc",
                    "name": "func",
                    "provider": "guanceyun"
                }
            ],
            "Repos": [
                {
                    "link": "https://www.guance.com",
                    "name": "guance",
                    "provider": "guanceyun"
                },
                {
                    "link": "https://func.guance.com",
                    "name": "func",
                    "provider": "guanceyun"
                }
            ],
            "Team": {
                "oncall": [
                    "xxx@guance.com"
                ],
                "service": "kodo",
                "team": "guance",
                "type": "custom"
            }
        },
        "type": "custom",
        "updateAt": 1691234734,
        "uuid": "sman_5eaba28c14e94876b4aa0157ecb1e090"
    },
    "errorCode": "",
    "message": "",
    "success": true,
    "traceId": "TRACE-BBA1B402-6CD2-4798-BB6D-C1DCDFA04E41"
} 
```




