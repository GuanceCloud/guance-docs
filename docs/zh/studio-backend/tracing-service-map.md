# 拓扑图图表接口说明

## 【链路追踪】service map 接口

接口其他相关说明请查阅[【链路追踪】service map （有拓扑关系和统计数据）](../../external-api/tracing/tracing-service-map-v2/)

### 响应结构

```
{
    "code": 200,
    "content": {
        "services": [
            {
                "data": {
                    "key": "demo:test:1.0.1",
                    "version": "1.0.1",
                    "env": "test",
                    "service": "demo",
                    "source_type": "front",
                    "total_count": 6,
                    "avg_per_second": 0.00010100159919198721,
                    "avg_resp_time": 2683676.8333333335,
                    "sum_resp_time": 16102061,
                    "max_duration": 15583923,
                    "p50": 35965,
                    "p75": 99741,
                    "p90": 324608,
                    "p95": 324608,
                    "p99": 324608,
                    "error_count": 0,
                    "error_rate": 0
                },
                "name": "demo:test:1.0.1",
                "type": "front",
                "workspace_uuid": "wksp_xxxx",
                "workspace_name": "测试空间"
            }
        ],
        "maps": []
    },
    "errorCode": "",
    "message": "",
    "success": true,
    "traceId": "159xxxx"
}
```

`data`内字段说明：

| 参数名            | 类型      | 说明                           |
| -------------- | ------- | ---------------------------- |
| key            | string  | 唯一键值，按照service:env:version拼接 |
| version        | string  | 版本号                          |
| env            | string  | 环境                           |
| service        | string  | 服务名称                         |
| source_type    | string  | 服务类型                         |
| total_count    | integer | 总请求数                         |
| avg_per_second | double  | 平均每秒请求数，单位req/s              |
| avg_resp_time  | double  | 平均响应时间，单位μs                  |
| sum_resp_time  | double  | 总响应时间，单位μs                   |
| max_duration   | integer | 最大响应时间                       |
| p50            | integer | P50响应时间，单位μs                 |
| p75            | integer | P75响应时间，单位μs                 |
| p90            | integer | P90响应时间，单位μs                 |
| p95            | integer | P95响应时间，单位μs                 |
| p99            | integer | P99响应时间，单位μs                 |
| error_count    | integer | 错误请求数                        |
| error_rate     | double  | 错误率                          |

## 【服务-性能指标】获取资源调用接口

### 响应结构

```
{
    "maps": [
    ],
    "serviceResource": [
        {
            "service": "demo",
            "resource": "demo.resource",
            "appId": "",
            "checkerInfo": [],
            "status": "ok",
            "__docid": "",
            "data": {
                "total_count": 2,
                "p99": 270.64,
                "error_count": 0,
                "error_rate": 0,
                "avg_per_second": 0.0022222222222222222
            },
            "source_type": "custom"
        }
    ]
}
```

`data`内字段说明

| 参数名            | 类型      | 说明              |
| -------------- | ------- | --------------- |
| total_count    | integer | 总请求数            |
| p99            | double  | P99响应时间，单位μs    |
| error_count    | integer | 错误请求数           |
| error_rate     | double  | 错误率             |
| avg_per_second | double  | 平均每秒请求数，单位req/s |

## 相关字段查询DQL

* 总请求数查询DQL：

  ```
  T::(T::re(`.*`):(`trace_id`){ `source` NOT IN ['service_map', 'tracing_stat', 'service_list_1m', 'service_list_1d', 'service_list_1h', 'profile'] and `service` = 'front-api' } by `trace_id`):(count(`trace_id`))
  ```

* 错误请求数查询DQL：
  
  ```
  T::(T::re(`.*`):(LAST(`status`) as `status`){ `source` NOT IN ['service_map', 'tracing_stat', 'service_list_1m', 'service_list_1d', 'service_list_1h', 'profile'] and `service` = 'front-api' and `status` = 'error' } by `trace_id`):(count(`status`))
  ```

* 总响应时间查询DQL：
  
  ```
  T::(T::re(`.*`):(max(`duration`) as `duration`){ `source` NOT IN ['service_map', 'tracing_stat', 'service_list_1m', 'service_list_1d', 'service_list_1h', 'profile'] and `service` = 'front-api' } by trace_id):(sum(`duration`))
  ```

* 最大响应时间查询DQL：
  
  ```
  T::(T::re(`.*`):(max(`duration`) as `duration`){ `source` NOT IN ['service_map', 'tracing_stat', 'service_list_1m', 'service_list_1d', 'service_list_1h', 'profile'] and `service` = 'front-api' } by trace_id):(max(`duration`))
  ```

* P99响应时间查询DQL：
  
  ```
  T::(T::re(`.*`):(max(`duration`) as `duration`){ `source` NOT IN ['service_map', 'tracing_stat', 'service_list_1m', 'service_list_1d', 'service_list_1h', 'profile'] and `service` = 'front-api' } by trace_id):(percentile(`duration`, 99) as `P99`)
  ```
  
  
