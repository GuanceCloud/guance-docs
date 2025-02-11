# Modify One or More Members

---

<br />**POST /api/v1/workspace/member/batch_modify**

## Overview
Modify one or more members



## Body Request Parameters

| Parameter Name        | Type     | Required | Description              |
|:-------------------|:-------|:-----|:----------------|
| accountUUIDs | array | Y | List of account UUIDs<br>Example: ['Account UUID1 not in workspace', 'Account UUID2 not in workspace'] <br>Can be empty: True <br> |
| roleUUIDs | array | Y | List of user role UUIDs<br>Example: None <br>Can be empty: False <br> |
| onlyModifyRoles | boolean | Y | Whether to only modify member roles, True does not change team information<br>Example: True <br>Can be empty: False <br> |
| memberGroupUUIDs | array |  | List of teams<br>Example: ['xxx', 'xxx'] <br>Can be empty: True <br> |
| acntWsNickname | string |  | Nickname of the account in this workspace<br>Example: NicknameAAA <br>Can be empty: True <br>$maxCustomLength: 128 <br> |

## Additional Parameter Notes

Data description.*

When modifying member roles, if `roleUUIDs` includes roles that require Token review (SAAS Free Plan and PAAS do not require cost center review), then it must include role UUIDs that do not require review.

- Request parameter description

| Parameter Name           | Type | Description                                                 |
| ---------------- | ---- | ---------------------------------------------------- |
| accountUUIDs       | list | Member account UUIDs |
| roleUUIDs             | list | Role UUIDs                                              |
| onlyModifyRoles    | boolean | Whether to only change role information (true for batch modification, false for individual modification)                 |
| memberGroupUUIDs       | list  | Team information is required for individual member modifications     |
| acntWsNickname       | string  | Nickname of the account in the workspace     |
------




## Request Example
```shell
curl 'https://openapi.guance.com/api/v1/workspace/member/batch_modify' \
-H 'DF-API-KEY: <DF-API-KEY>' \
-H 'Content-Type: application/json;charset=UTF-8' \
--data-raw '{"accountUUIDs": ["acnt_xxxx32"], "onlyModifyRoles": true, "roleUUIDs": ["general","wsAdmin"]}' \
--compressed 
```




## Response
```shell
{
    "code": 200,
    "content": {
        "autoLoginUrl": "http://testing-zc-portal.cloudflux.cn/#/signin?from=http:%2F%2Ftesting-zc-portal.cloudflux.cn%2Fportal.html%23%2Finfo%2Flist&ticket=7d628f01-6c63-454a-8cf7-7c30678a9b0d"
    },
    "errorCode": "",
    "message": "",
    "success": true,
    "traceId": "TRACE-F0E7FBC3-3A2B-4843-9B5E-DAD070AB812B"
} 
```