# 【服务性能】获取

---

<br />**GET /api/v1/service_manage/performance/get**

## 概述
获取单个服务性能信息




## Query 请求参数

| 参数名        | 类型     | 必选   | 说明              |
|:-----------|:-------|:-----|:----------------|
| start | integer | Y | 时间 开始 单位 ms<br> |
| end | integer | Y | 时间 结束 单位 ms<br> |
| serviceName | string | Y | 服务名称<br>允许为空: False <br>允许为空字符串: False <br> |

## 参数补充说明





## 请求例子
```shell
curl 'https://openapi.<<< custom_key.brand_main_domain >>>/api/v1/service_manage/performance/get?end=1693810693999&start=1693767493000&serviceName=anypath' \
  -H 'Content-Type: application/json' \
  -H 'DF-API-KEY: <DF-API-KEY>' \
  --compressed
```




## 响应
```shell
{
    "code": 200,
    "content": {
        "__docid": "a3d7f56895c1476a411986f1bf59c6d0",
        "avg_per_second": 1.5411574074074075,
        "avg_resp_time": 192929.50521193186,
        "checkerInfo": [
            {
                "name": "测试{{host}}",
                "type": "simpleCheck",
                "uuid": "rul_xxxx32"
            },
            {
                "name": "主机{{host}}高",
                "type": "simpleCheck",
                "uuid": "rul_xxxx32"
            },
            {
                "name": "dcl test",
                "type": "simpleCheck",
                "uuid": "rul_xxxx32"
            }
        ],
        "dfStatus": "critical",
        "env": "test1",
        "error_count": 132,
        "error_rate": 0.001982636907086425,
        "isFavorite": 0,
        "key": "anypath",
        "max_duration": 212448,
        "p50": 192983,
        "p75": 192983,
        "p90": 192983,
        "p95": 192983,
        "p99": 192983,
        "service": "anypath",
        "source_type": "web",
        "sum_resp_time": 12844860598,
        "total_count": 66578,
        "type": "web",
        "uuid": "sman_xxxx32",
        "version": "gin1.1"
    },
    "errorCode": "",
    "message": "",
    "success": true,
    "traceId": "TRACE-9590059F-463F-4669-859F-3E53F020AAEA"
} 
```




