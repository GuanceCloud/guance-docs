# Unresolved Event Query

Before querying, please refer to the [Event Field Description](../../events/#fields) for the fields `df_monitor_checker_event_ref`, `df_fault_id`, `df_status`, and `df_fault_status`.

## 1. Query Entry Points

- [OpenAPI 「DQL Data Query」](../../open-api/query-data/query-data-v1/)

- [ExternalAPI 「# 【Data Query】DQL Data Query」](../../external-api/query-data/query-data/)

## 2. Query Statements

### Method One: Using HAVING Clause (Applicable to Doris Engine) - Direct Results

#### Query Structure

```json
{
    "queries": [
        {
            "qtype": "dql",
            "query": {
                "disableMultipleField": False,
                "q": "E::`monitor`:(`__docid`, `df_title`,`df_monitor_checker_event_ref`, `df_fault_id`, `df_status`, `df_fault_status`,`df_fault_start_time`, `df_event_id`) { df_monitor_checker_event_ref = exists() } by `df_monitor_checker_event_ref` having df_fault_status = 'fault' sorder by create_time desc",
                "timeRange": [
                    1724320359294,
                    1724323959294
                ],
                "align_time": True,
                // Specify that sampling is disabled for this query
                "disable_sampling": True,
                // Specify the number of groups to retrieve, i.e., 100 unresolved events
                "slimit": 100,
                "tz": "Asia/Shanghai"
            }
        }
    ]
}
```

### Method Two: Without HAVING Clause (Not Applicable to Doris Engine) - Requires Filtering

1. **Query Structure**

```json
{
    "queries": [
        {
            "qtype": "dql",
            "query": {
                "disableMultipleField": False,
                "q": "E::`monitor`:(`__docid`, `df_title`,`df_monitor_checker_event_ref`, `df_fault_id`, `df_status`, `df_fault_status`,`df_fault_start_time`, `df_event_id`, `create_time`) { df_monitor_checker_event_ref = exists() } by `df_monitor_checker_event_ref` sorder by create_time desc",
                "timeRange": [
                    1724320359294,
                    1724323959294
                ],
                "align_time": True,
                # Specify that sampling is disabled for this query
                "disable_sampling": True,
                # Specify retrieving 1000 trigger objects
                "slimit": 1000,
                "tz": "Asia/Shanghai"
            }
        }
    ]
}
```

2. **Filter DQL Query Results**

Filter the `df_fault_status` field in the query results to retain events where `df_fault_status = fault`. These data points represent the list of unresolved events.

3. **Sort Data by Time Field**

Sort the data by the `time` field in descending order to obtain the final list of unresolved events.

## 3. How to Confirm the Storage Engine Type for Events in the Current Workspace

1. Retrieve workspace storage information via API

- [OpenAPI 「Get Current Workspace Information」](../../open-api/workspace/current/)

- [ExternalAPI 「【Workspace】Get Details」](../../external-api/workspace/get/)

In the API response, the `datastore` field stores the type of storage engine used for all basic data within the current workspace (excluding external indexes). If the value of `keyevent` in `datastore` is `doris`, it indicates that event data uses the `doris` storage engine.

```
Example API Response:
{
    "code": 200,
    "content": {
        "id": 1,
        "uuid": "wksp_xxxxx",
        "name": "[Doris] Workspace Name",
        "versionType": "pay",
        // ......
        "datastore": {
            "backup_log": "doris",
            "custom_object": "doris",
            "keyevent": "doris", // Check this value; if it is doris, it indicates a doris storage engine
            "logging": "doris",
            "metric": "guancedb",
            "network": "doris",
            "object": "doris",
            "object_history": "doris",
            "profiling": "doris",
            "rum": "doris",
            "security": "doris",
            "tracing": "doris"
        },
        // ......
    },
    "errorCode": "",
    "message": "",
    "success": true,
    "traceId": "2956247345653191101"
}
```