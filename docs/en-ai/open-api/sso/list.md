# Get SAML Mapping List

---

<br />**GET /api/v1/saml/mapping/field/list**

## Overview
Retrieve the list of SAML mappings.

## Query Request Parameters

| Parameter Name | Type   | Required | Description |
|:--------------|:-------|:---------|:------------|
| ssoUUID       | string | No       | Filter by identity provider, SSO configuration UUID.<br>Example: sso_xxx <br>Can be empty: False <br>Maximum length: 48 <br> |
| search        | string | No       | Search, defaults to searching role names, source field names, and source field values.<br>Example: supper_workspace <br>Can be empty: False <br> |
| pageIndex     | integer| No       | Page number.<br>Can be empty: False <br>Example: 10 <br>$minValue: 1 <br> |
| pageSize      | integer| No       | Number of items per page.<br>Can be empty: False <br>Example: 10 <br>$minValue: 1 <br>$maxValue: 100 <br> |

## Additional Parameter Notes

## Request Example
```shell
curl 'https://openapi.guance.com/api/v1/saml/mapping/field/list' \
-H 'DF-API-KEY: <DF-API-KEY>' \
--compressed 
```

## Response
```shell
{
    "code": 200,
    "content": [
        {
            "createAt": 1677826771,
            "creator": "acnt_xxxx32",
            "deleteAt": -1,
            "id": 66,
            "roleInfo": {
                "name": "Administrator",
                "uuid": "wsAdmin"
            },
            "sourceField": "QQ",
            "sourceValue": "qq",
            "status": 0,
            "targetValue": "wsAdmin",
            "updateAt": 1677827772,
            "updator": "acnt_xxxx32",
            "uuid": "fdmp_xxxx32",
            "workspaceUUID": "wksp_xxxx32"
        }
    ],
    "errorCode": "",
    "message": "",
    "pageInfo": {
        "count": 1,
        "pageIndex": 1,
        "pageSize": 10,
        "totalCount": 1
    },
    "success": true,
    "traceId": "TRACE-A9DB3123-FB6D-4595-9784-5A2B9C6C8439"
} 
```