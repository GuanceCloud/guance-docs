# Export a Note

---

<br />**GET /api/v1/notes/\{notes_uuid\}/export**

## Overview
Export the note specified by `notes_uuid` as a template structure.

## Route Parameters

| Parameter Name        | Type     | Required | Description              |
|:------------------|:-------|:-----|:----------------|
| notes_uuid | string | Y | Note UUID |

## Additional Parameter Information

Note template structure description:

The basic structure of the template includes: view structure (only contains chart structure)

**Main structure description of `templateInfo`:**

| Parameter Name                | Type  | Required | Description          |
|-----------------------|----------|----|------------------------|
| name             | string | Yes | Note title |
| main             | json | No | Main structure of the exported content |
| main.charts             | array | No | List of chart template structures |
| main.charts[#]             | json | No | Chart template structure |

**Structure description of `main.charts[#]`:**

| Parameter Name                | Type  | Required | Description          |
|-----------------------|----------|----|------------------------|
| name             | string | Yes | Chart name |
| type             | string | Yes | Chart type |
| queries             | array[json] | Yes | List of query statements for the chart |

**For `Time Series Chart` structure where `type=sequence`, the main structure parameters are as follows:**

| Parameter Name                | Type  | Required | Description          |
|-----------------------|----------|----|------------------------|
| name             | string | Yes | Chart name |
| type             | string | Yes | Chart type |
| queries             | array[json] | Yes | List of query statements for the chart |

## Request Example
```shell
curl 'https://openapi.guance.com/api/v1/notes/notes_xxxx32/export' \
-H 'DF-API-KEY: <DF-API-KEY>' \
--compressed 
```

## Response
```shell
{
    "code": 200,
    "content": {
        "main": {
            "charts": [
                {
                    "extend": {},
                    "name": "",
                    "queries": [
                        {
                            "query": {
                                "content": "note content"
                            }
                        }
                    ],
                    "type": "text"
                }
            ]
        },
        "name": "My Note"
    },
    "errorCode": "",
    "message": "",
    "success": true,
    "traceId": "TRACE-8FD9876D-842E-4E0D-AC9E-F76E98943984"
} 
```