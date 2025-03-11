# Get Event Content

---

<br />**get /api/v1/events/\{doc_id\}/get**

## Overview
Get the specified event content based o `__docid`.




## Routing Parameters

| Parameter Name        | Type     | Required   | Description              |
|:-----------|:-------|:-----|:----------------|
| doc_id | string | Y | Event ID<br> |


## Supplementary Description of Parameters





## Request Example
```shell
curl 'https://openapi.guance.com/api/v1/events/E_c7jodqs24loo3v53qc30/get' \
-H 'DF-API-KEY: <DF-API-KEY>' \
--compressed \
--insecure
```




## Response
```shell
{
    "code": 200,
    "content": {
        "Result": "0.010000123409284342",
        "__docid": "E_c7jodqs24loo3v53qc4g",
        "create_time": 1642563307585,
        "df_date_range": "3600",
        "df_dimension_tags": "{\"host\":\"10-23-190-37\"}",
        "df_event_id": "event-d2366597f7244ae099d3fbda07d8ec5f",
        "df_message": "critical\ncpu\n0.010000123409284342",
        "df_meta": "{\"alerts_sent\":[],\"check_targets\":[{\"alias\":\"Result\",\"dql\":\"M::`cpu`:(NON_NEGATIVE_DERIVATIVE(`usage_user`) AS `钉钉`) { `host` = '10-23-190-37' } BY `host`\",\"range\":3600}],\"checker_opt\":{\"id\":\"rul_3797973b2145425688c0517651f65409\",\"interval\":60,\"message\":\"{{ df_status }}\\n{{ df_monitor_checker_name }}\\n{{ Result }}\",\"name\":\"cpu\",\"noDataInterval\":0,\"recoverInterval\":0,\"rules\":[{\"conditionLogic\":\"and\",\"conditions\":[{\"alias\":\"Result\",\"operands\":[\"0.01\"],\"operator\":\">=\"}],\"status\":\"critical\"}],\"title\":\"对对对\"},\"dimension_tags\":{\"host\":\"10-23-190-37\"},\"extra_data\":{\"type\":\"simpleCheck\"},\"monitor_opt\":{\"id\":\"monitor_3f5e5d2108f74e07b8fb1e7459aae2b8\",\"name\":\"默认分组\",\"type\":\"default\"}}",
        "df_monitor_checker": "custom_metric",
        "df_monitor_checker_event_ref": "899faaa6f042871f32fc58fe53b16e46",
        "df_monitor_checker_id": "rul_3797973b2145425688c0517651f65409",
        "df_monitor_checker_name": "cpu",
        "df_monitor_checker_ref": "17066256a7a65d73af60d5dd09a2b1b8",
        "df_monitor_checker_sub": "check",
        "df_monitor_checker_value": "0.010000123409284342",
        "df_monitor_id": "monitor_3f5e5d2108f74e07b8fb1e7459aae2b8",
        "df_monitor_name": "默认分组",
        "df_monitor_type": "default",
        "df_source": "monitor",
        "df_status": "critical",
        "df_title": "对对对",
        "host": "10-23-190-37",
        "time": 1642563300000
    },
    "errorCode": "",
    "message": "",
    "success": true,
    "traceId": "TRACE-E8A22CA0-6F2C-4DEE-9CE5-A45A08B620D8"
} 
```




