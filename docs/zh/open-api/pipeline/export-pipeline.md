# 导出 Pipeline 规则

---

<br />**POST /api/v1/pipeline/export**

## 概述
导出一个/多个Pipeline




## Body 请求参数

| 参数名        | 类型     | 必选   | 说明              |
|:-----------|:-------|:-----|:----------------|
| pipelineUUIDs | array | Y | pipeline的uuid数组<br>允许为空: False <br> |

## 参数补充说明





## 请求例子
```shell
curl 'https://openapi.<<< custom_key.brand_main_domain >>>/api/v1/pipeline/export' \
-H 'DF-API-KEY: <DF-API-KEY>' \
-H 'Content-Type: application/json;charset=UTF-8' \
--data-raw '{"pipelineUUIDs":["pl_xxxx32"]}' \
--compressed
```




## 响应
```shell
{
    "code": 200,
    "content": {
        "pipelines": [
            {
                "asDefault": 0,
                "category": "logging",
                "content": "ZW51bWVyYXRl\n",
                "extend": {},
                "isDisable": false,
                "name": "eee",
                "source": [
                    "calico-node"
                ],
                "testData": "W10=\n"
            }
        ]
    },
    "errorCode": "",
    "message": "",
    "success": true,
    "traceId": "TRACE-AB60EC15-0E38-4229-A1E7-3457A9A3974B"
} 
```




