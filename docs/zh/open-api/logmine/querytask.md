# 【日志logmine】获取Logmine查询任务结果

---

<br />**GET /api/v1/logmine/query_task**

## 概述
查询日志聚类分析结果




## Query 请求参数

| 参数名        | 类型     | 必选   | 说明              |
|:-----------|:-------|:-----|:----------------|
| taskId | string | Y | 任务ID<br> |

## 参数补充说明





## 请求例子
```shell
curl 'https://openapi.guance.com/api/v1/logmine/query_task?taskId=task_xxxxxx' \
-H 'DF-API-KEY: <DF-API-KEY>' \
--compressed 
```




## 响应
```shell
{
    "code": 200,
    "content": {
        "data": [
            {
                "count": 2,
                "docids": [
                    "L_1683535329738_chcbbp44c5rvac7jvckg",
                    "L_1683535036487_chcb9gk4c5rvac7iebag"
                ],
                "message": "{\"caller\":\"traceutil/trace.go:171\",\"detail\":\"{read_only:false; response_revision:12925324; number_of_response:1; }\",\"duration\":\"134.73909ms\",\"end\":\"2023-05-08T08:42:03.814Z\",\"level\":\"info\",\"msg\":\"trace[93927413] transaction\",\"start\":\"2023-05-08T08:42:03.679Z\",\"step_count\":2,\"steps\":[\"trace[93927413] 'process raft request'  (duration: 101.211717ms)\",\"trace[93927413] 'compare'  (duration: 33.280584ms)\"],\"ts\":\"2023-05-08T08:42:03.814Z\"}"
            },
            {
                "count": 1,
                "docids": [
                    "L_1683534719215_chcb70k4c5rvac7hdi60"
                ],
                "message": "{\"caller\":\"traceutil/trace.go:171\",\"detail\":\"{range_begin:/registry/prioritylevelconfigurations/; range_end:/registry/prioritylevelconfigurations0; response_count:0; response_revision:12924596; }\",\"duration\":\"270.428986ms\",\"end\":\"2023-05-08T08:31:58.899Z\",\"level\":\"info\",\"msg\":\"trace[1571945896] range\",\"start\":\"2023-05-08T08:31:58.629Z\",\"step_count\":2,\"steps\":[\"trace[1571945896] 'agreement among raft nodes before linearized reading'  (duration: 151.510788ms)\",\"trace[1571945896] 'count revisions from in-memory index tree'  (duration: 118.630054ms)\"],\"ts\":\"2023-05-08T08:31:58.899Z\"}"
            }
        ],
        "docCount": 3,
        "taskStatus": "ok"
    },
    "errorCode": "",
    "message": "",
    "success": true,
    "traceId": "12356904931261224598"
} 
```




