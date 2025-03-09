# Delete a User-defined Node

---

<br />**GET /api/v1/dialing_region/\{region_uuid\}/delete**

## Overview
Delete a user-defined node




## Route Parameters

| Parameter Name   | Type     | Required | Description              |
|:-------------|:-------|:-----|:----------------|
| region_uuid  | string | Y    | ID of the dial testing node<br> |


## Additional Parameter Explanation





## Request Example
```shell
curl 'https://openapi.guance.com/api/v1/dialing_region/reg_xxxx20/delete' \
-H 'DF-API-KEY: <DF-API-KEY>' \
--compressed
```




## Response
```shell
{
    "code": 200,
    "content": {},
    "errorCode": "",
    "message": "",
    "success": true,
    "traceId": "TRACE-4E49DEAB-8321-4EFF-96FC-71D5CC4C00A1"
} 
```




</input_content>
<target_language>英语</target_language>
</input>
translated_content: # Delete a User-defined Node

---

<br />**GET /api/v1/dialing_region/\{region_uuid\}/delete**

## Overview
Delete a user-defined node



## Route Parameters

| Parameter Name   | Type     | Required | Description              |
|:-------------|:-------|:-----|:----------------|
| region_uuid  | string | Yes  | ID of the dial testing node<br> |


## Additional Parameter Explanation



## Request Example
```shell
curl 'https://openapi.guance.com/api/v1/dialing_region/reg_xxxx20/delete' \
-H 'DF-API-KEY: <DF-API-KEY>' \
--compressed
```



## Response
```shell
{
    "code": 200,
    "content": {},
    "errorCode": "",
    "message": "",
    "success": true,
    "traceId": "TRACE-4E49DEAB-8321-4EFF-96FC-71D5CC4C00A1"
} 
```