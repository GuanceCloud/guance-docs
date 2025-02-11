# Issue-Reply List

---

<br />**GET /api/v1/issue/reply/\{issue_uuid\}/list**

## Overview

## Route Parameters

| Parameter Name   | Type   | Required | Description               |
|:-------------|:-----|:-------|:-----------------------|
| issue_uuid   | string | Y      | Issue UUID             |

## Query Request Parameters

| Parameter Name | Type    | Required | Description                                             |
|:-----------|:------|:-----|:---------------------------------------------------|
| ordering   | string |      | Sorting method, e.g., `ordering=-createAt`<br>Optional: False <br> |
| pageSize   | integer |      | Number of items per page<br>Optional: False <br>Example: 10 <br> |
| pageIndex  | integer |      | Page number<br>Optional: False <br>Example: 1 <br> |

## Additional Parameter Notes

## Request Example
```shell
curl 'https://openapi.guance.com/api/v1/issue/reply/issue_xxxx32/list?ordering=-createAt' \
-H 'DF-API-KEY: <DF-API-KEY>' \
--compressed
```

## Response
```shell
{
    "code": 200,
    "content": [
        {
            "attachmentsList": [],
            "content": "Member created an Issue.",
            "createAt": 1690278285,
            "creator": "acnt_xxxx32",
            "creatorInfo": {
                "acntWsNickname": "",
                "email": "88@qq.com",
                "iconUrl": "http://testing-static-res.cloudcare.cn/icon/acnt_xxxx32.png",
                "name": "Test 88",
                "username": "Test"
            },
            "deleteAt": -1,
            "extend": {},
            "id": 313186,
            "is_modify": false,
            "issueUUID": "issue_xxxx32",
            "latest_modify_time": 1690278285,
            "status": 0,
            "type": "change",
            "updateAt": 1690278285,
            "updator": "acnt_xxxx32",
            "updatorInfo": {
                "acntWsNickname": "",
                "email": "88@qq.com",
                "iconUrl": "http://testing-static-res.cloudcare.cn/icon/acnt_xxxx32.png",
                "name": "Test 88",
                "username": "Test"
            },
            "uuid": "repim_xxxx32",
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
    "traceId": "TRACE-463593F6-6084-4675-8EB5-F138D579EA0A"
}
```