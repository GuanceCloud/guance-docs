# Modify One or More Labels for a Specific Host

---

<br />**POST /api/v1/object/hosts/\{host\}/label/modify**

## Overview
Modify one or more labels for a specific host. After a successful API call, there may be a cache of up to 5 minutes.

## Route Parameters

| Parameter Name | Type   | Required | Description       |
|:--------------|:-------|:---------|:------------------|
| host          | string | Yes      | Hostname          |

## Body Request Parameters

| Parameter Name | Type   | Required | Description               |
|:--------------|:-------|:---------|:--------------------------|
| source        | string | Yes      | Data source<br>Example: HOST <br>Can be empty: False <br> |
| labels        | array  |          | List of object names<br>Can be empty: False <br> |

## Additional Parameter Notes

## Response
```shell
{
    "code": 200,
    "content": true,
    "errorCode": "",
    "message": "",
    "success": true,
    "traceId": "TRACE-96EDF6EA-847D-4E23-BE1B-B387257B6BFA"
} 
```