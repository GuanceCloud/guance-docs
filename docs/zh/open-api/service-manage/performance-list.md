# 【服务性能】列出

---

<br />**GET /api/v1/service_manage/performance/list**

## 概述
列出服务清单性能信息




## Query 请求参数

| 参数名        | 类型     | 必选   | 说明              |
|:-----------|:-------|:-----|:----------------|
| start | integer | Y | 时间 开始 单位 ms<br> |
| end | integer | Y | 时间 结束 单位 ms<br> |
| filters | json |  | tag 过滤 跟 搜索 跟es querydata 接口一致<br> |
| order | string |  | 按资源名排序, 格式`[{key:desc/asc}]`<br> |
| pageIndex | integer |  | 页码<br>允许为空: False <br>例子: 10 <br>$minValue: 1 <br> |
| pageSize | integer |  | 每页返回数量<br>允许为空: False <br>例子: 10 <br>$minValue: 1 <br>$maxValue: 100 <br> |

## 参数补充说明


**请求主体参数说明**

filters 示例如下 之前的 search字段兼容到filters 使用正则 `.*serviceName.*`
```json
   {"tags":[{"name":"__tags.__isError.keyword","value":["true"],"operation":"=","condition":"and"},{"condition":"and","name":"__tags.__serviceName","operation":"=~","value":[".*04.*"]}]}
```

** 可选的排序字段 **

| key      | 类型   |
| :------- | :----- |
| key  | 服务名 |
| total_count  | 总请求次数 |
| avg_resp_time  | 平均响应时间 |
| avg_per_second   | 平均每秒请求次数 |
| error_count  | 错误数 |
| error_rate  | 错误率 |
| sum_resp_time   | 总的请求时长 |
| max_duration   | 最长请求时长 |
| p50   | p50 |
| p75   | p75 |
| p90   | p90 |
| p95   | p95 |
| p99   | p99， 默认排序字段，且降序排列 |




## 请求例子
```shell
curl 'https://openapi.<<< custom_key.brand_main_domain >>>/api/v1/service_manage/performance/list?end=1693810693999&start=1693767493000' \
  -H 'Content-Type: application/json' \
  -H 'DF-API-KEY: <DF-API-KEY>' \
  --compressed
```




## 响应
```shell
{
    "max_duration": 333744,
    "max_total_count": 66596,
    "max_per_second": 1.541574074074074,
    "max_avg_duration": 192929.50521193186,
    "max_sum_duration": 12844860598,
    "max_p50": 192983,
    "max_p75": 192983,
    "max_p90": 192983,
    "max_p95": 192983,
    "max_p99": 235711,
    "buckets": [
        {
            "key": "movies-api-java",
            "version": "1.0",
            "env": "example",
            "service": "movies-api-java",
            "source_type": "web",
            "total_count": 795,
            "avg_per_second": 0.01840277777777778,
            "avg_resp_time": 61268.97735849056,
            "sum_resp_time": 48708837,
            "max_duration": 333744,
            "p50": 51550,
            "p75": 55844,
            "p90": 78459,
            "p95": 99741,
            "p99": 235711,
            "error_count": 0,
            "error_rate": 0,
            "type": "web",
            "checkerInfo": [],
            "dfStatus": "ok",
            "__docid": "",
            "isFavorite": 0,
            "uuid": "sman_xxxx32"
        },
        {
            "key": "anypath",
            "version": "gin1.1",
            "env": "test1",
            "service": "anypath",
            "source_type": "web",
            "total_count": 66578,
            "avg_per_second": 1.5411574074074075,
            "avg_resp_time": 192929.50521193186,
            "sum_resp_time": 12844860598,
            "max_duration": 212448,
            "p50": 192983,
            "p75": 192983,
            "p90": 192983,
            "p95": 192983,
            "p99": 192983,
            "error_count": 132,
            "error_rate": 0.001982636907086425,
            "type": "web",
            "checkerInfo": [
                {
                    "name": "测试{{host}}",
                    "uuid": "rul_xxxx32",
                    "type": "simpleCheck"
                },
                {
                    "name": "主机{{host}}高",
                    "uuid": "rul_xxxx32",
                    "type": "simpleCheck"
                },
                {
                    "name": "dcl test",
                    "uuid": "rul_xxxx32",
                    "type": "simpleCheck"
                }
            ],
            "dfStatus": "critical",
            "__docid": "a3d7f56895c1476a411986f1bf59c6d0",
            "isFavorite": 0,
            "uuid": "sman_xxxx32"
        },
        {
            "key": "a",
            "version": "",
            "env": "test1",
            "service": "a",
            "source_type": "custom",
            "total_count": 66588,
            "avg_per_second": 1.541388888888889,
            "avg_resp_time": 98309.95656875112,
            "sum_resp_time": 6546263388,
            "max_duration": 104943,
            "p50": 97766,
            "p75": 97766,
            "p90": 97766,
            "p95": 97766,
            "p99": 97766,
            "error_count": 0,
            "error_rate": 0,
            "type": "custom",
            "checkerInfo": [],
            "dfStatus": "critical",
            "__docid": "c2b6b30677c4930c3fb2494bd96f309f",
            "isFavorite": 0,
            "uuid": "sman_xxxx32"
        },
        {
            "key": "b",
            "version": "",
            "env": "test1",
            "service": "b",
            "source_type": "custom",
            "total_count": 66596,
            "avg_per_second": 1.541574074074074,
            "avg_resp_time": 50361.48133521533,
            "sum_resp_time": 3353873211,
            "max_duration": 69838,
            "p50": 50529,
            "p75": 50529,
            "p90": 50529,
            "p95": 50529,
            "p99": 50529,
            "error_count": 0,
            "error_rate": 0,
            "type": "custom",
            "checkerInfo": [],
            "dfStatus": "critical",
            "__docid": "7fcd9d572b590cd3c8ef0a24f2f63a54",
            "isFavorite": 0,
            "uuid": "sman_xxxx32"
        },
        {
            "key": "c",
            "version": "",
            "env": "test1",
            "service": "c",
            "source_type": "custom",
            "total_count": 66575,
            "avg_per_second": 1.541087962962963,
            "avg_resp_time": 30253.189996244837,
            "sum_resp_time": 2014106124,
            "max_duration": 44549,
            "p50": 30040,
            "p75": 30040,
            "p90": 30040,
            "p95": 30040,
            "p99": 30040,
            "error_count": 0,
            "error_rate": 0,
            "type": "custom",
            "checkerInfo": [],
            "dfStatus": "critical",
            "__docid": "575104c1b8c0bff66707738e631e5fdf",
            "isFavorite": 0,
            "uuid": "sman_xxxx32"
        },
        {
            "key": "any",
            "version": "",
            "env": "test1",
            "service": "any",
            "source_type": "custom",
            "total_count": 66585,
            "avg_per_second": 1.5413194444444445,
            "avg_resp_time": 10267.040534654952,
            "sum_resp_time": 683630894,
            "max_duration": 25908,
            "p50": 10201,
            "p75": 10201,
            "p90": 10201,
            "p95": 10201,
            "p99": 10201,
            "error_count": 0,
            "error_rate": 0,
            "type": "custom",
            "checkerInfo": [],
            "dfStatus": "critical",
            "__docid": "809baa4e3455d1c5b4967d9c54d9d777",
            "isFavorite": 0,
            "uuid": "sman_xxxx32"
        },
        {
            "key": "r",
            "version": "",
            "env": "test1",
            "service": "r",
            "source_type": "custom",
            "total_count": 66521,
            "avg_per_second": 1.539837962962963,
            "avg_resp_time": 1194.87321297034,
            "sum_resp_time": 79484161,
            "max_duration": 3193,
            "p50": 1200,
            "p75": 1200,
            "p90": 1200,
            "p95": 1200,
            "p99": 1200,
            "error_count": 0,
            "error_rate": 0,
            "type": "custom",
            "checkerInfo": [],
            "dfStatus": "critical",
            "__docid": "5bf8e12a7e1ddf2e8435bc7269761997",
            "isFavorite": 0,
            "uuid": "sman_xxxx32"
        },
        {
            "key": "s",
            "version": "",
            "env": "test1",
            "service": "s",
            "source_type": "custom",
            "total_count": 66548,
            "avg_per_second": 1.540462962962963,
            "avg_resp_time": 1165.196534832001,
            "sum_resp_time": 77541499,
            "max_duration": 6014,
            "p50": 1176,
            "p75": 1176,
            "p90": 1176,
            "p95": 1176,
            "p99": 1176,
            "error_count": 0,
            "error_rate": 0,
            "type": "custom",
            "checkerInfo": [],
            "dfStatus": "critical",
            "__docid": "7326b8bc9cfcc1576535138437371180",
            "isFavorite": 0,
            "uuid": "sman_xxxx32"
        },
        {
            "key": "t",
            "version": "",
            "env": "test1",
            "service": "t",
            "source_type": "custom",
            "total_count": 66588,
            "avg_per_second": 1.541388888888889,
            "avg_resp_time": 1133.408527061933,
            "sum_resp_time": 75471407,
            "max_duration": 2969,
            "p50": 1130,
            "p75": 1130,
            "p90": 1130,
            "p95": 1130,
            "p99": 1130,
            "error_count": 0,
            "error_rate": 0,
            "type": "custom",
            "checkerInfo": [],
            "dfStatus": "critical",
            "__docid": "e691689bc8f07465b0009fa70f3072d0",
            "isFavorite": 0,
            "uuid": "sman_xxxx32"
        }
    ],
    "pageInfo": {
        "pageIndex": 1,
        "pageSize": 50,
        "count": 9,
        "totalCount": 9
    }
} 
```




