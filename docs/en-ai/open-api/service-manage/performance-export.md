# [Service Performance] Export

---

<br />**GET /api/v1/service_manage/performance/export**

## Overview
Service performance export



## Query Request Parameters

| Parameter Name | Type   | Required | Description               |
|:-----------|:-------|:-----|:----------------|
| start | integer | Y | Time start, unit ms<br> |
| end | integer | Y | Time end, unit ms<br> |

## Additional Parameter Notes



## Request Example
```shell
curl 'https://openapi.guance.com/api/v1/service_manage/performance/export?end=1693810693999&start=1693767493000' \
  -H 'DF-API-KEY: <DF-API-KEY>' \
  -o 'servicePerformanceInfo.csv'
  --compressed
```



## Response
```shell
"Service","Average Requests","Average Response Time","P75 Response Time","P99 Response Time","Error Count","Monitor Count","Service Status"
"movies-api-java","0.02 req/s","61.14 ms","55.84 ms","226.47 ms","0(0)%","0","ok"
"anypath","1.54 req/s","192.93 ms","192.98 ms","192.98 ms","135(0.2)%","3","critical"
"a","1.54 req/s","98.31 ms","97.77 ms","97.77 ms","0(0)%","0","critical"
"any","1.54 req/s","10.27 ms","10.2 ms","10.2 ms","0(0)%","0","critical" 
```