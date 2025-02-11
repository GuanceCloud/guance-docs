# Modify Role

---

<br />**POST /api/v1/role/\{role_uuid\}/modify**

## Overview
Modify an existing role



## Route Parameters

| Parameter Name | Type   | Required | Description              |
|:-----------|:-------|:-----|:----------------|
| role_uuid | string | Y | Role UUID<br> |


## Body Request Parameters

| Parameter Name | Type   | Required | Description              |
|:-----------|:-------|:-----|:----------------|
| name | string | Y | Role name<br>Example: Role No.1 <br>Nullable: False <br>Maximum Length: 256 <br> |
| desc | string | N | Description of the role<br>Example: CUSTOM <br>Nullable: False <br>Allows empty string: True <br>Maximum Length: 3000 <br> |
| keys | array | N | Selected permissions list, must contain at least one permission<br>Example: [] <br>Nullable: False <br> |

## Additional Parameter Notes



## Request Example
```shell
curl 'https://openapi.guance.com/api/v1/role/role_xxxx32/modify' \
-H 'Accept: application/json, text/plain, */*' \
-H 'Content-Type: application/json;charset=UTF-8' \
-H 'DF-API-KEY: <DF-API-KEY>' \
--data-raw '{"name":"test_temp_role1","desc":"test","keys":["workspace.readMember","label.labelCfgManage","share.shareManage","snapshot.delete","snapshot.create","log.externalIndexManage"]}' \
--compressed
```




## Response
```shell
{
    "code": 200,
    "content": true,
    "errorCode": "",
    "message": "",
    "success": true,
    "traceId": "TRACE-647377FA-46A6-419A-AC26-CB0E871DBA28"
} 
```