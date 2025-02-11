# 【Service Performance】List

---

<br />**GET /api/v1/service_manage/performance/list**

## Overview
List performance information of the service list




## Query Request Parameters

| Parameter Name        | Type     | Required   | Description              |
|:------------------|:-------|:-----|:----------------|
| start | integer | Y | Start time, unit ms<br> |
| end | integer | Y | End time, unit ms<br> |
| filters | json |  | Tag filtering, consistent with search and ES querydata interface<br> |
| order | string |  | Sort by resource name, format`[{key:desc/asc}]`<br> |
| pageIndex | integer |  | Page number<br>Cannot be null: False <br>Example: 10 <br>$minValue: 1 <br> |
| pageSize | integer |  | Number of items per page<br>Cannot be null: False <br>Example: 10 <br>$minValue: 1 <br>$maxValue: 100 <br> |

## Additional Parameter Explanation


**Request Body Parameter Explanation**

Example of filters, previous search fields are compatible with filters using regular expression `.*serviceName.*`
```json
   {"tags":[{"name":"__tags.__isError.keyword","value":["true"],"operation":"=","condition":"and"},{"condition":"and","name":"__tags.__serviceName","operation":"=~","value":[".*04.*"]}]}
```

**Optional Sorting Fields**

| key      | Type   |
| :------- | :----- |
| key  | Service name |
| total_count  | Total request count |
| avg_resp_time  | Average response time |
| avg_per_second   | Average requests per second |
| error_count  | Error count |
| error_rate  | Error rate |
| sum_resp_time   | Total request duration |
| max_duration   | Maximum request duration |
| p50   | p50 |
| p75   | p75 |
| p90   | p90 |
| p95   | p95 |
| p99   | p99, default sorting field, descending order |




## Request Example
```shell
curl 'https://openapi.guance.com/api/v1/service_manage/performance/list?end=1693810693999&start=1693767493000' \
  -H 'Content-Type: application/json' \
  -H 'DF-API-KEY: <DF-API-KEY>' \
  --compressed
```




## Response
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
                    "name": "Test {host}",
                    "uuid": "rul_xxxx32",
                    "type": "simpleCheck"
                },
                {
                    "name": "Host {host} High",
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