# 【服务性能】导出

---

<br />**GET /api/v1/service_manage/performance/export**

## 概述
服务性能导出




## Query 请求参数

| 参数名        | 类型     | 必选   | 说明              |
|:-----------|:-------|:-----|:----------------|
| start | integer | Y | 时间 开始 单位 ms<br> |
| end | integer | Y | 时间 结束 单位 ms<br> |

## 参数补充说明





## 请求例子
```shell
curl 'https://openapi.<<< custom_key.brand_main_domain >>>/api/v1/service_manage/performance/export?end=1693810693999&start=1693767493000' \
  -H 'DF-API-KEY: <DF-API-KEY>' \
  -o 'servicePerformanceInfo.csv'
  --compressed
```




## 响应
```shell
"服务","平均请求数","平均响应时间","P75响应时间","P99响应时间","错误数","监控器数量","服务状态"
"movies-api-java","0.02 req/s","61.14 ms","55.84 ms","226.47 ms","0(0)%","0","ok"
"anypath","1.54 req/s","192.93 ms","192.98 ms","192.98 ms","135(0.2)%","3","critical"
"a","1.54 req/s","98.31 ms","97.77 ms","97.77 ms","0(0)%","0","critical"
"any","1.54 req/s","10.27 ms","10.2 ms","10.2 ms","0(0)%","0","critical" 
```




