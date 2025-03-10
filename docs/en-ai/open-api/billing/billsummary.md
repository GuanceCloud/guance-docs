# Get Cumulative Consumption of Each Billing Item in the Workspace

---

<br />**GET /api/v1/billing/project/summary**

## Overview




## Additional Parameter Notes





## Request Example
```shell
curl 'https://openapi.<<< custom_key.brand_main_domain >>>/api/v1/billing/project/summary' \
-H 'DF-API-KEY: <DF-API-KEY>' \
-H 'Content-Type: application/json;charset=UTF-8' \
--compressed
```




## Response
```shell
{
    "Session Replay": 806.8,
    "Extended Application": 1500.0,
    "Cumulative Consumption": 17211.88,
    "Task Triggers": 73.4,
    "Service Charges": 0,
    "RUM PV Count": 8.81,
    "APM Profile": 14747.72,
    "Network (Host)": 34.0,
    "Inter-region Private Network Traffic Fee": 0,
    "Time Series": 17.81,
    "APM Trace": 0.1,
    "Log Data": 2.86,
    "SMS": 18.7,
    "Synthetic Tests": 0,
    "Backup Log Data": 0.0,
    "Synthetic Tests API Calls": 1.68
} 
```