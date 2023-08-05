# 获取服务清单配置

---

<br />**GET /api/v1/tracing/service_catelogs/get**

## 概述
获取服务清单的配置信息




## Query 请求参数

| 参数名        | 类型     | 必选   | 说明              |
|:-----------|:-------|:-----|:----------------|
| service | string | Y | 服务<br>允许为空: False <br> |
| originStr | int | Y | 原始字符串传1, 结构化数据传0<br>允许为空: False <br> |

## 参数补充说明

参数说明:

服务清单的获取, 字段 originStr=1 返回原始字符串, originStr=0 返回结构化数据

**响应主体结构说明**

|  参数名                |   type  |          说明          |
|-----------------------|----------|------------------------|
|serviceCatelog             |string,dict |  服务清单的原始字符串或者结构化数据 |
|updatorInfo             |dict |  服务清单的更新者信息 |




## 请求例子
```shell
curl 'https://openapi.guance.com/api/v1/tracing/service_catelogs/get?service=redis&originStr=1' \
  -H 'DF-API-KEY: <DF-API-KEY>' \
  --compressed \
  --insecure
```




## 响应
```shell
{
    "code": 200,
    "content": {
        "createAt": 1691045022,
        "dfStatus": "ok",
        "serviceCatelog": {
            "Docs": [],
            "Repos": [
                {
                    "link": "http://baidu.com",
                    "name": "aa",
                    "provider": "github"
                },
                {
                    "link": "http://baidu.com",
                    "name": "bb",
                    "provider": "gitlab"
                },
                {
                    "link": "http://baidu.com",
                    "name": "cc",
                    "provider": "gitee"
                }
            ],
            "Team": {
                "oncall": [
                    "test@guance.com"
                ],
                "service": "kodo",
                "team": "测试",
                "type": "custom"
            }
        },
        "updateAt": 1691134038,
        "updatorInfo": {
            "acntWsNickname": "",
            "email": "test@jiagouyun.com",
            "iconUrl": "",
            "name": "test",
            "username": "test@jiagouyun.com"
        },
        "uuid": "sman_aa2e88e705ed45e1961f0f4d6ea5f085"
    },
    "errorCode": "",
    "message": "",
    "success": true,
    "traceId": "TRACE-99418E5E-3139-4787-B1E5-33FAE6C4DB3B"
} 
```




