# Get Time Series Trend Chart

---

<br />**GET /api/v1/chart_image/get**

## Overview
Retrieve a time series trend chart based on the specified DQL / PromQL query statement.



## Query Request Parameters

| Parameter Name        | Type     | Required   | Description              |
|:---------------------|:---------|:-----------|:------------------------|
| clientToken          | string   | Y          | Workspace clientToken <br> Example: wctn_xxx <br> Allow empty: False <br> |
| qtype               | string   |            | Query statement type, default is dql <br> Allow empty: False <br> Optional values: ['dql', 'promql'] <br> |
| q                   | string   | Y          | Query statement <br> Example:  <br> Allow empty: False <br> |
| startTime           | integer  | Y          | Start time point, timestamp in seconds <br> Example:  <br> Allow empty: False <br> |
| endTime             | integer  | Y          | End time point, timestamp in seconds <br> Example:  <br> Allow empty: False <br> |
| interval            | integer  |            | Data point interval in seconds <br> Example:  <br> Allow empty: False <br> |
| tz                  | string   |            | Time zone name, default value `Asia/Shanghai`<br> Example: Asia/Shanghai <br> Allow empty: False <br> |

## Additional Parameter Notes

*Query Notes*

--------------

Note: The current interface authenticates through clientToken. It only takes effect when the clientToken is valid. The request header `DF-API-KEY` can be omitted for this interface.




## Request Example
```shell
curl 'https://openapi.<<< custom_key.brand_main_domain >>>/api/v1/chart_image/get?clientToken=xxxxx&qtype=dql&q=M%3A%3A%60cpu%60%3A(avg(%60usage_idle%60))%20BY%20%60host%60&interval=60&startTime=1743391592&endTime=1743392492&tz=Asia%2FShanghai' \
--data ''
```




## Response
```shell
# Response content is image stream data 
```