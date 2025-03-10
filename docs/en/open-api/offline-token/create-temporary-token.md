# [Login-Free Token] Generate Token

---

<br />**POST /api/v1/offline_token/temporary_token/create**

## Overview
Generate an access token.
Usage:
1. Add the parameter to the page `url`: `gc_route_token=xxxx`; Note that if it involves cross-origin iframe embedding, there might be third-party cookie interception issues for cross-origin requests.
2. If it does not involve page redirection, add the parameter to the page `url`: `ftAuthToken=xxx`.


## Body Request Parameters

| Parameter Name | Type   | Required | Description               |
|:--------------|:-------|:--------|:--------------------------|
| roles         | array  | No      | List of roles<br>Example: ['readOnly'] <br>Can be empty: False <br> |
| roles[*]      | string | Yes     | Role identifier<br>Can be empty: False <br>Optional values: ['readOnly'] <br> |
| expires       | integer| Yes     | Token expiration time (in seconds)<br>Example: 3600 <br>Can be empty: False <br>$maxValue: 604800 <br>$minValue: 1 <br> |

## Additional Parameter Notes

*Parameter Description*

--------------

1. Supported list of roles

| Role Identifier | Role Name |
|-----------------|-----------|
| readOnly        | Read-only role |



## Response
```shell
 
```