# 导入一个/多个黑名单

---

<br />**POST /api/v1/blacklist/import**

## 概述
导入一个/多个黑名单




## Body 请求参数

| 参数名        | 类型     | 必选   | 说明              |
|:-----------|:-------|:-----|:----------------|
| blacklists | array | Y | 黑名单列表<br>允许为空: False <br> |
| blacklistType | string | Y | 用于区分导入是从日志菜单导入还是管理菜单导入<br>例子: logging <br>可选值: ['logging', 'all'] <br> |

## 参数补充说明





## 请求例子
```shell
curl 'https://openapi.<<< custom_key.brand_main_domain >>>/api/v1/blacklist/import' \
-H 'DF-API-KEY: <DF-API-KEY>' \
-H 'Content-Type: application/json;charset=UTF-8' \
--data-raw '{"blacklists":[{"filters":[{"condition":"and","name":"host","operation":"in","value":["127.0.0.1"]}],"source":"kodo-log","type":"logging"}],"blacklistType":"all"}' \
--compressed
```




## 响应
```shell
{
    "code": 200,
    "content": {
        "blacklists": [
            {
                "filters": [
                    {
                        "condition": "and",
                        "name": "host",
                        "operation": "in",
                        "value": [
                            "127.0.0.1"
                        ]
                    }
                ],
                "source": "kodo-log",
                "type": "logging"
            }
        ]
    },
    "errorCode": "",
    "message": "",
    "success": true,
    "traceId": "TRACE-0CF51995-0D75-4F8E-871F-72B40ABA553D"
} 
```




