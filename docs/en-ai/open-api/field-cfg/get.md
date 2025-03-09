# Get Field Management

---

<br />**GET /api/v1/field_cfg/\{field_uuid\}/get**

## Overview
Get field management details


## Route Parameters

| Parameter Name        | Type     | Required   | Description              |
|:-------------------|:-------|:-------|:----------------|
| field_uuid         | string | Y      | Field UUID<br> |


## Additional Parameter Explanation



## Request Example
```shell
curl 'https://openapi.guance.com/api/v1/field_cfg/field_0f95016f7254494da088d878ce586477/get' \
-H 'DF-API-KEY: <DF-API-KEY>' \
--compressed
```


## Response
```shell
{"code":200,"content":{"alias":"as_load","aliasEn":"","createAt":1735628856,"creator":"wsak_73a0ad39c352477a9417f633670a0908","declaration":{"business":"","organization":"default_private_organization"},"deleteAt":-1,"desc":"modify_test","descEn":"","fieldSource":"","fieldType":"int","id":1791,"name":"test_load","status":0,"sysField":0,"unit":"custom/[\\"time\\",\\"ns\\"]","updateAt":1735635731,"updator":"wsak_73a0ad39c352477a9417f633670a0908","uuid":"field_0f95016f7254494da088d878ce586477","workspaceUUID":"wksp_05adf2282d0d47f8b79e70547e939617"},"errorCode":"","message":"","success":true,"traceId":"TRACE-7E3C943A-57A0-4CD4-93BA-FCAAEDEF444B"} 
```