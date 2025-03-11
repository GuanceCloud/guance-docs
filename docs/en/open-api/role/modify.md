# Modify Role

---

<br />**POST /api/v1/role/{role_uuid}/modify**

## Overview
Modify an existing role



## Route Parameters

| Parameter Name | Type   | Required | Description             |
|:------------|:-----|:-------|:----------------------|
| role_uuid  | string | Yes    | Role UUID <br>        |


## Body Request Parameters

| Parameter Name | Type   | Required | Description                                                                                   |
|:-----------|:-----|:-------|:---------------------------------------------------------------------------------------------|
| name      | string | Yes    | Role name <br>Example: Role No.1 <br>Allow null: False <br>Maximum length: 256 <br>           |
| desc      | string | No     | Description of the role <br>Example: CUSTOM <br>Allow null: False <br>Allow empty string: True <br>Maximum length: 3000 <br> |
| keys      | array | No     | Selected permission list, must have at least one permission <br>Example: [] <br>Allow null: False <br> |

## Additional Parameter Notes



## Request Example
```shell
curl 'https://openapi.<<< custom_key.brand_main_domain >>>/api/v1/role/role_xxxx32/modify' \
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