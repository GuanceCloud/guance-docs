# Create Role

---

<br />**POST /api/v1/role/add**

## Overview
Create a new role



## Body Request Parameters

| Parameter Name | Type   | Required | Description                                                                 |
|:--------------|:-------|:---------|:-----------------------------------------------------------------------------|
| name          | string | Y        | Role name<br>Example: Role No.1 <br>Allow null: False <br>Maximum length: 256 <br> |
| desc          | string | N        | Description of the role<br>Example: CUSTOM <br>Allow null: False <br>Allow empty string: True <br>Maximum length: 3000 <br> |
| keys          | array  | Y        | List of selected permissions<br>Example: [] <br>Allow null: False <br> |


## Additional Parameter Notes



## Request Example
```shell
curl 'https://openapi.guance.com/api/v1/role/add' \
-H 'Accept: application/json, text/plain, */*' \
-H 'Content-Type: application/json;charset=UTF-8' \
-H 'DF-API-KEY: <DF-API-KEY>' \
--data-raw '{"name":"Custom Management","desc":"test","keys":["workspace.readMember","label.labelCfgManage","log.externalIndexManage"]}' \
--compressed
```



## Response
```shell
{
    "code": 200,
    "content": {
        "createAt": 1722827399,
        "creator": "wsak_xxxx32",
        "declaration": {
            "asd": "aa,bb,cc,1,True",
            "asdasd": "dawdawd",
            "business": "aaa",
            "fawf": "afawf",
            "organization": "64fe7b4062f74d0007b46676"
        },
        "deleteAt": -1,
        "desc": "test",
        "id": null,
        "isSystem": 0,
        "name": "Custom Management",
        "status": 0,
        "updateAt": 1722827399,
        "updator": "wsak_xxxx32",
        "uuid": "role_xxxx32",
        "workspaceUUID": "wksp_xxxx32"
    },
    "errorCode": "",
    "message": "",
    "success": true,
    "traceId": "9008386843384026938"
} 
```