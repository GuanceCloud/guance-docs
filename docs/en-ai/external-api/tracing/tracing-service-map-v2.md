# [Trace Service Map] (with topology relationship and statistics)

---

<br />**GET /api/v1/tracing/service_map_v2**

## Overview

## Query Request Parameters

| Parameter Name       | Type    | Required | Description                          |
|:-------------------|:-------|:-------|:------------------------------------|
| workspaceUUID      | string | Y     | Workspace ID<br>                    |
| start              | integer| Y     | Start time, in ms<br>               |
| end                | integer| Y     | End time, in ms<br>                 |
| search             | string |       | Filter by service name<br>          |
| filters            | string |       | Tag filter, consistent with the ES querydata interface<br> |
| isServiceSub       | boolean|       | Whether it is a service_sub<br>     |
| serviceMapList     | boolean|       | Whether to list the service topology call relationship<br> |

## Additional Parameter Explanation

Example of filters:
```json
{
    "tags": [
        {
            "name": "__tags.__isError.keyword",
            "value": [
                "true"
            ],
            "operation": "=",
            "condition": "and"
        },
        {
            "condition": "and",
            "name": "__tags.__serviceName",
            "operation": "=~",
            "value": [
                ".*04.*"
            ]
        }
    ]
}
```

## Response
```shell
 
```