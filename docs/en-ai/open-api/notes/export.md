# Export a Note

---

<br />**GET /api/v1/notes/\{notes_uuid\}/export**

## Overview
Export the note specified by `notes_uuid` as a template structure.

## Route Parameters

| Parameter Name        | Type     | Required | Description              |
|:------------------|:-------|:-----|:----------------|
| notes_uuid | string | Y | Note UUID<br> |

## Additional Parameter Notes

### Note Template Structure Explanation:

The basic structure of the template includes: view structure (containing only chart structures)

#### **Explanation of the main structure of `templateInfo`**

| Parameter Name                | Type   | Required | Description          |
|-------------------------------|----------|----|------------------------|
| name             | string | Required | Note title |
| main             | json |  | Main structure of exported content |
| main.charts             | array |  | List of chart template structures |
| main.charts[#]             | json |  | Chart template structure |

#### **Structure explanation for `main.charts[#]`**

| Parameter Name                | Type   | Required | Description          |
|-------------------------------|----------|----|------------------------|
| name             | string | Required | Chart name |
| type             | string | Required | Chart type |
| queries             | array[json] | Required | List of query statements for the chart |

#### **For `Time Series Chart` with `type=sequence`, its main structure parameters are as follows:**

| Parameter Name                | Type   | Required | Description          |
|-------------------------------|----------|----|------------------------|
| name             | string | Required | Chart name |
| type             | string | Required | Chart type |
| queries             | array[json] | Required | List of query statements for the chart |

## Request Example
```shell
curl 'https://openapi.<<< custom_key.brand_main_domain >>>/api/v1/notes/notes_xxxx32/export' \
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
                                "content": "Note content"
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