# 手动恢复一个事件

---

<br />**GET /api/v1/keyevent/restore**

## 概述
根据`monitorCheckerEventRef`恢复指定事件




## Query 请求参数

| 参数名        | 类型     | 必选   | 说明              |
|:-----------|:-------|:-----|:----------------|
| monitorCheckerEventRef | string | Y | 触发对象唯一标识(df_monitor_checker_event_ref)<br>允许为空: False <br> |

## 参数补充说明





## 请求例子
```shell
curl 'https://openapi.<<< custom_key.brand_main_domain >>>/api/v1/keyevent/restore?monitorCheckerEventRef=09e6fdaa5235f1e49014254f7b1653fc' \
-H 'DF-API-KEY: <DF-API-KEY>' \
--compressed 
```




## 响应
```shell
{
    "code": 200,
    "content": true,
    "errorCode": "",
    "message": "",
    "success": true,
    "traceId": "TRACE-EE0CCB94-DE13-4EBE-A89F-49D12CD996C6"
} 
```




