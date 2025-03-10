# Get the List of Unresolved Incidents

---

<br />**POST /api/v1/events/abnormal/list**

## Overview
Retrieve a list of unresolved incidents (the most recent event status for the same `df_monitor_checker_event_ref` is not `ok`) within a specified time range. Typically, this query retrieves data from the last 6 hours;

## Body Request Parameters

| Parameter Name        | Type     | Required   | Description              |
|:---------------------|:---------|:-----------|:-------------------------|
| search | string | No | Search incident title<br>Allow empty: False <br> |
| lastStatus | string | No | Last status<br>Allow empty: False <br>Example: critical <br>Possible values: ['critical', 'error', 'warning', 'nodata'] <br> |
| timeRange | array | Yes | Time range, defaults to the last 6 hours, time difference should not exceed 6 hours<br>Allow empty: False <br>$minLength: 2 <br>Maximum length: 2 <br>Example: [1642563283250, 1642563304850] <br> |
| timeRange[*] | integer | Yes | Millisecond-level integer timestamp<br>Allow empty: False <br> |
| filters | array | No | List of filter conditions<br>Allow empty: False <br> |
| offset | integer | No | Offset<br>Allow empty: False <br>Example: 10 <br>$minValue: 0 <br> |
| limit | integer | No | Number of results per page<br>Allow empty: False <br>Example: 10 <br>$minValue: 1 <br>$maxValue: 100 <br> |

## Additional Parameter Explanation

Parameter description:

The base structure of the template includes: view structure (including chart structure, view variable structure, and chart grouping structure)

**Main structure explanation for `filters`**

| Parameter Name             | Type  | Required  | Description          |
|--------------------------|-------|-----------|----------------------|
| condition           |string | No | Relationship with the previous filter condition, possible values: `and`, `or`; default value: `and` |
| filters             |array | No | Sub-filter conditions, equivalent to adding a layer of parentheses; when this parameter exists, only `condition` takes effect, other parameters will be ignored |
| name                |string | No | Field name to filter |
| operation           |string | No | Operator, possible values: `>`, `>=`, `<`, `<=`, `=`, `!=`, `in`, `wildcard`, `query_string`, `exists` |
| value               |array | No | Value list |
| value[#]            |string/int/boolean | No | Can be string/numeric/boolean type; during data comparison, specific elements from `value` are used based on the characteristics of `operation`, for example, if `operation` is `=`, only value[0] is used in the calculation |

** Example of `filters` usage **

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
curl 'https://openapi.<<< custom_key.brand_main_domain >>>/api/v1/events/abnormal/list' \
-H 'DF-API-KEY: <DF-API-KEY>' \
-H 'Content-Type: application/json;charset=UTF-8' \
--data-raw '{"offset": 0, "limit": 10, "timeRange": [1642563283250, 1642563304850]}' \
--compressed 
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
                "df_meta": "{\"alerts_sent\":[],\"check_targets\":[{\"alias\":\"Result\",\"dql\":\"M::`cpu`:(NON_NEGATIVE_DERIVATIVE(`usage_user`) AS `DingTalk`) { `host` = '10-23-190-37' } BY `host`\",\"range\":3600}],\"checker_opt\":{\"id\":\"rul_xxxx32\",\"interval\":60,\"message\":\"{{ df_status }}\\n{{ df_monitor_checker_name }}\\n{{ Result }}\",\"name\":\"cpu\",\"noDataInterval\":0,\"recoverInterval\":0,\"rules\":[{\"conditionLogic\":\"and\",\"conditions\":[{\"alias\":\"Result\",\"operands\":[\"0.01\"],\"operator\":\">=\"}],\"status\":\"critical\"}],\"title\":\"Correct\"},\"dimension_tags\":{\"host\":\"10-23-190-37\"},\"extra_data\":{\"type\":\"simpleCheck\"},\"monitor_opt\":{\"id\":\"monitor_xxxx32\",\"name\":\"Default Group\",\"type\":\"default\"}}",
                "df_monitor_checker_event_ref": "320fed7a6dd82a0bcb2a539248e6bedc",
                "df_status": "critical",
                "df_title": "Correct"
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
                "df_meta": "{\"alerts_sent\":[],\"check_targets\":[{\"alias\":\"Result\",\"dql\":\"M::`cpu`:(NON_NEGATIVE_DERIVATIVE(`usage_user`) AS `DingTalk`) { `host` = '10-23-190-37' } BY `host`\",\"range\":3600}],\"checker_opt\":{\"id\":\"rul_xxxx32\",\"interval\":60,\"message\":\"{{ df_status }}\\n{{ df_monitor_checker_name }}\\n{{ Result }}\",\"name\":\"cpu\",\"noDataInterval\":0,\"recoverInterval\":0,\"rules\":[{\"conditionLogic\":\"and\",\"conditions\":[{\"alias\":\"Result\",\"operands\":[\"0.01\"],\"operator\":\">=\"}],\"status\":\"critical\"}],\"title\":\"Correct\"},\"dimension_tags\":{\"host\":\"10-23-190-37\"},\"extra_data\":{\"type\":\"simpleCheck\"},\"monitor_opt\":{\"id\":\"monitor_xxxx32\",\"name\":\"Default Group\",\"type\":\"default\"}}",
                "df_monitor_checker_event_ref": "899faaa6f042871f32fc58fe53b16e46",
                "df_status": "critical",
                "df_title": "Correct"
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