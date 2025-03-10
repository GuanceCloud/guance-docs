# Add One or More Members (Deployment Plan)

---

<br />**POST /api/v1/workspace/member/batch_add**

## Overview
Add one or more members (supported only in the Deployment Plan)


## Body Request Parameters

| Parameter Name | Type   | Required | Description              |
|:--------------|:-------|:--------|:-------------------------|
| accountUUIDs  | array  | Y       | List of account UUIDs<br>Example: ['acnt_xxxx32'] <br>Allow empty: False <br> |
| roleUUIDs     | array  | Y       | List of user role UUIDs<br>Example: ['general', 'readOnly', 'role_xxxx32'] <br>Allow empty: False <br> |

## Additional Parameter Explanation

- Request parameter description

| Parameter Name | Type  | Description                          |
| -------------- | ----- | ------------------------------------ |
| accountUUIDs   | array | Account UUIDs within the workspace   |
| roleUUIDs      | array | Workspace role UUIDs                 |

- Explanation of roleUUIDs

| Role         | Description        |
|--------------|--------------------|
| wsAdmin      | Administrator role |
| general      | Standard member role |
| readOnly     | Read-only role     |
| role_xxx     | Custom role        |


## Request Example
```shell
curl 'https://openapi.<<< custom_key.brand_main_domain >>>/api/v1/workspace/member/batch_add' \
-H 'DF-API-KEY: <DF-API-KEY>' \
-H 'Content-Type: application/json;charset=UTF-8' \
--data-raw '{"accountUUIDs": ["acnt_xxxx32"], "roleUUIDs": ["general","role_xxxx32"]}' \
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
    "traceId": "TRACE-B6A69C1D-ED27-42C2-93FD-BC943F8675D2"
} 
```