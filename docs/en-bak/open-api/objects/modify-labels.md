# Modify One/More Labels of a Host

---

<br />**post /api/v1/object/hosts/\{host\}/label/modify**

## Overview
Modify one/more labels of a host, and after the interface is successfully called, there will generally be no more than 5 minutes of cache. 




## Routing Parameters

| Parameter Name        | Type     | Required   | Description              |
|:-----------|:-------|:-----|:----------------|
| host | string | Y | 主机名<br> |


## Body Request Parameter

| Parameter Name        | Type     | Required   | Description              |
|:-----------|:-------|:-----|:----------------|
| source | string | Y | Data source<br>Example: HOST <br>Allow null: False <br> |
| labels | array |  | List of object names<br>Allow null: False <br> |

## Supplementary Description of Parameters







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




