# 【Login Mapping】Mapping Configuration List

---

<br />**GET /api/v1/login_mapping/field/list**

## Overview




## Query Request Parameters

| Parameter Name        | Type     | Required   | Description              |
|:-------------------|:-------|:-----|:----------------|
| search | string | No  | Search, default search for role name, source field name, and source field value<br>Example: supper_workspace <br>Allow empty: False <br> |
| workspaceUUID | string | No  | Workspace UUID<br>Example: Workspace UUID <br>Allow empty: False <br> |
| pageIndex | integer | No  | Page index<br>Allow empty: False <br>Example: 10 <br>$minValue: 1 <br> |
| pageSize | integer | No  | Number of results per page<br>Allow empty: False <br>Example: 10 <br>$minValue: 1 <br>$maxValue: 100 <br> |

## Additional Parameter Notes





## Request Example
```shell
curl '<Endpoint>/api/v1/login_mapping/field/list?pageIndex=1&pageSize=1' \
  -H 'Content-Type: application/json' \
  -H 'X-Df-Access-Key: <AK key>' \
  -H 'X-Df-Nonce: <random string>' \
  -H 'X-Df-Signature: <signature>' \
  -H 'X-Df-Timestamp: <timestamp>'
```




## Response
```shell
{
    "code": 200,
    "content": {
        "data": [
            {
                "createAt": 1715323808,
                "creator": "sys",
                "deleteAt": -1,
                "id": 230,
                "isSystem": 1,
                "roles": [
                    {
                        "name": "Read-only",
                        "uuid": "readOnly"
                    }
                ],
                "sourceField": "email2",
                "sourceValue": "xxx@qq.com",
                "status": 0,
                "targetValues": [
                    "readOnly"
                ],
                "updateAt": 1715324192,
                "updator": "sys",
                "uuid": "lgmp_xxxxx",
                "workspaceName": "LWC Test B Workspace",
                "workspaceUUID": "wksp_xxxxx"
            }
        ],
        "pageInfo": {
            "count": 1,
            "pageIndex": 1,
            "pageSize": 1,
            "totalCount": 53
        }
    },
    "errorCode": "",
    "message": "",
    "success": true,
    "traceId": "TRACE-A046B901-DCF9-44BF-AC4C-E48DB7959BF9"
} 
```