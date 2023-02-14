# Get a List of Unrecovered Events

---

<br />**post /api/v1/events/abnormal/list**

## Overview
Get the list of unrecovered events within the specified time range (the latest event status of the same `df_monitor_checker_event_ref` is not `ok`), and generally query the data of the last 6 hours;



## Body Request Parameter

| Parameter Name        | Type     | Required   | Description              |
|:-----------|:-------|:-----|:----------------|
| search | string |  | Search event title<br>Allow null: False <br> |
| lastStatus | string |  | Final state<br>Allow null: False <br>Example: critical <br>Optional value: ['critical', 'error', 'warning', 'nodata'] <br> |
| timeRange | array | Y | Time range, the default is the latest 6 hours, and the time difference is no more than 6 hours.<br>Allow null: False <br>$minLength: 2 <br>Maximum length: 2 <br>Example: [1642563283250, 1642563304850] <br> |
| timeRange[*] | integer | Y | Millisecond integer timestamp<br>Allow null: False <br> |
| filters | array |  | Filter criteria list<br>Allow null: False <br> |
| offset | integer |  | Offset<br>Allow null: False <br>Example: 10 <br>$minValue: 0 <br> |
| limit | integer |  | Quantity returned per page<br>Allow null: False <br>Example: 10 <br>$minValue: 1 <br>$maxValue: 100 <br> |

## Supplementary Description of Parameters

Parameter description:

The basic structure of template includes: view structure (including chart structure, view variable structure and chart grouping structure).

**Description of the Body Structure of `filters`**

|  Parameter Name             |   Type  | Required  |          Description          |
|--------------------|----------|----|------------------------|
|condition           |string |  |  Relationship with the previous filter condition, optional values:`and`, `or`; Default: `and` |
|filters             |array |  |  Sub-filter condition is equivalent to adding a layer of parentheses. When the current parameter exists, only `condition` will take effect, and other parameters will be invalid.|
|name                |string |  |  Field name to be filtered |
|operation           |string |  |  Operator, Optional value:  `>`, `>=`, `<`, `<=`, `=`, `!=`, `in`, `wildcard`, `query_string`, `exists`|
|value               |array |  |  Value list |
|value[#]            |string/int/boolean |  | It can be of string/numeric/Boolean type. When comparing data, specific elements are taken from `value` according to the characteristics of `operation`. For example, when `operation` is `=`, only value[0] participates in the operation |

** `filters` Example

``` python
[
  {
      "name": "A",
      "condition": "and",
      "operation": "between",
      "value": [1577410594000, 1577410494000]
  },
  {
      "condition": "and",
      "filters": [
          {
              "name": "tagA",
              "condition": "and",
              "operation": ">",
              "value": 12,
          },
          {
              "name": "tagB",
              "condition": "and",
              "operation": "=",
              "value": ["fff"]
          }
      ],
  },
  {
      "name": "tagC",
      "condition": "and",
      "operation": "=",
      "value": ["ok"]
  }
]
```




## Request Example
```shell
curl 'https://openapi.guance.com/api/v1/events/abnormal/list' \
-H 'DF-API-KEY: <DF-API-KEY>' \
-H 'Content-Type: application/json;charset=UTF-8' \
--data-raw '{"offset": 0, "limit": 10, "timeRange": [1642563283250, 1642563304850]}' \
--compressed \
--insecure
```




## Response
```shell
{
    "code": 200,
    "content": {
        "data": [
            {
                "__docid": "E_c7jodqs24loo3v53qc50",
                "alert_time_ranges": [
                    [
                        1642541760000,
                        null
                    ]
                ],
                "date": 1642563300000,
                "df_dimension_tags": "{\"host\":\"10-23-190-37\"}",
                "df_event_id": "event-6ea0350eda12405dad9c1cba4b28cdc3",
                "df_message": "critical\ncpu\n0.010000123409284342",
                "df_meta": "{\"alerts_sent\":[],\"check_targets\":[{\"alias\":\"Result\",\"dql\":\"M::`cpu`:(NON_NEGATIVE_DERIVATIVE(`usage_user`) AS `钉钉`) { `host` = '10-23-190-37' } BY `host`\",\"range\":3600}],\"checker_opt\":{\"id\":\"rul_e2313e92e30c472ab85e635d85d36e5b\",\"interval\":60,\"message\":\"{{ df_status }}\\n{{ df_monitor_checker_name }}\\n{{ Result }}\",\"name\":\"cpu\",\"noDataInterval\":0,\"recoverInterval\":0,\"rules\":[{\"conditionLogic\":\"and\",\"conditions\":[{\"alias\":\"Result\",\"operands\":[\"0.01\"],\"operator\":\">=\"}],\"status\":\"critical\"}],\"title\":\"对对对\"},\"dimension_tags\":{\"host\":\"10-23-190-37\"},\"extra_data\":{\"type\":\"simpleCheck\"},\"monitor_opt\":{\"id\":\"monitor_3f5e5d2108f74e07b8fb1e7459aae2b8\",\"name\":\"默认分组\",\"type\":\"default\"}}",
                "df_monitor_checker_event_ref": "320fed7a6dd82a0bcb2a539248e6bedc",
                "df_status": "critical",
                "df_title": "对对对"
            },
            {
                "__docid": "E_c7jodqs24loo3v53qc4g",
                "alert_time_ranges": [
                    [
                        1642541760000,
                        null
                    ]
                ],
                "date": 1642563300000,
                "df_dimension_tags": "{\"host\":\"10-23-190-37\"}",
                "df_event_id": "event-d2366597f7244ae099d3fbda07d8ec5f",
                "df_message": "critical\ncpu\n0.010000123409284342",
                "df_meta": "{\"alerts_sent\":[],\"check_targets\":[{\"alias\":\"Result\",\"dql\":\"M::`cpu`:(NON_NEGATIVE_DERIVATIVE(`usage_user`) AS `钉钉`) { `host` = '10-23-190-37' } BY `host`\",\"range\":3600}],\"checker_opt\":{\"id\":\"rul_3797973b2145425688c0517651f65409\",\"interval\":60,\"message\":\"{{ df_status }}\\n{{ df_monitor_checker_name }}\\n{{ Result }}\",\"name\":\"cpu\",\"noDataInterval\":0,\"recoverInterval\":0,\"rules\":[{\"conditionLogic\":\"and\",\"conditions\":[{\"alias\":\"Result\",\"operands\":[\"0.01\"],\"operator\":\">=\"}],\"status\":\"critical\"}],\"title\":\"对对对\"},\"dimension_tags\":{\"host\":\"10-23-190-37\"},\"extra_data\":{\"type\":\"simpleCheck\"},\"monitor_opt\":{\"id\":\"monitor_3f5e5d2108f74e07b8fb1e7459aae2b8\",\"name\":\"默认分组\",\"type\":\"default\"}}",
                "df_monitor_checker_event_ref": "899faaa6f042871f32fc58fe53b16e46",
                "df_status": "critical",
                "df_title": "对对对"
            }
        ],
        "limit": 20,
        "offset": 0,
        "total_count": 2
    },
    "errorCode": "",
    "message": "",
    "success": true,
    "traceId": "TRACE-4D5773BE-88B1-4167-A2F4-603A58404184"
} 
```




