# 【Login-Free Token】Generate Token

---

<br />**POST /api/v1/offline_token/temporary_token/create**

## Overview
Generate an access token.
Usage: 
1. Add the parameter to the page `url`: `gc_route_token=xxxx`; Note that if it involves cross-domain iframe embedding, there might be issues with third-party cookie interception for cross-origin requests.
2. If no page redirection is involved, add the parameter to the page `url`: `ftAuthToken=xxx`.



## Body Request Parameters

| Parameter Name | Type   | Required | Description              |
|:-----------|:-------|:-----|:----------------|
| roles | array | No | List of roles<br>Example: ['readOnly'] <br>Nullable: False <br> |
| roles[*] | string | Yes | Role identifier<br>Nullable: False <br>Possible values: ['readOnly'] <br> |
| expires | integer | Yes | Token expiration time (in seconds)<br>Example: 3600 <br>Nullable: False <br>$maxValue: 604800 <br>$minValue: 1 <br> |

## Additional Parameter Notes

*Parameter Description*

--------------

1. Supported list of roles

| Role Identifier | Role Name |
|---------------|----------|
| readOnly    | Read-only role |



## Response
```shell
 
```