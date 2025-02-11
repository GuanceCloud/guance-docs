# 【Custom Mapping Rules】Mapping Configuration List

---

<br />**GET /api/v1/login_mapping/field/list**

## Overview




## Query Request Parameters

| Parameter Name        | Type     | Required   | Description              |
|:-------------------|:-------|:-----|:----------------|
| search | string | No  | Search, default search role name, source field name and source field value<br>Example: supper_workspace <br>Can be empty: False <br> |
| pageIndex | integer | No  | Page number<br>Can be empty: False <br>Example: 10 <br>$minValue: 1 <br> |
| pageSize | integer | No  | Number of items returned per page<br>Can be empty: False <br>Example: 10 <br>$minValue: 1 <br>$maxValue: 100 <br> |

## Additional Parameter Notes





## Request Example
```shell
curl 'https://openapi.guance.com/api/v1/login_mapping/field/list?pageIndex=1&pageSize=10&search=lisa-new' \
  -H 'Content-Type: application/json;charset=UTF-8' \
  -H 'DF-API-KEY: <DF-API-KEY>' \
  --compressed
```




## Response
```shell
{
    "code": 200,
    "content": {
        "data": [
            {
                "createAt": 1697427020,
                "creator": "mact_xxxx24",
                "deleteAt": -1,
                "id": 115,
                "isSystem": 1,
                "roles": [
                    {
                        "name": "Administrator",
                        "uuid": "wsAdmin"
                    }
                ],
                "sourceField": "name",
                "sourceValue": "lisa-new",
                "status": 0,
                "targetValues": [
                    "wsAdmin"
                ],
                "updateAt": 1697434009,
                "updator": "mact_738b7d961dfaxxxxx",
                "uuid": "lgmp_dbc32e896c004xxxx",
                "workspaceName": "LWC-SSO-2023-09-25 Test",
                "workspaceUUID": "wksp_xxxx22"
            }
        ],
        "pageInfo": {
            "count": 1,
            "pageIndex": 1,
            "pageSize": 10,
            "totalCount": 1
        }
    },
    "errorCode": "",
    "message": "",
    "success": true,
    "traceId": "44383338767731476"
} 
```