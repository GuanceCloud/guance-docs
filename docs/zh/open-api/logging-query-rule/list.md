# 获取数据访问规则列表

---

<br />**GET /api/v1/logging_query_rule/list**

## 概述
列出数据访问规则




## Query 请求参数

| 参数名        | 类型     | 必选   | 说明              |
|:-----------|:-------|:-----|:----------------|
| pageSize | integer |  | 每页返回数量<br>允许为空: False <br>例子: 10 <br> |
| pageIndex | integer |  | 页码<br>允许为空: False <br>例子: 10 <br> |

## 参数补充说明





## 请求例子
```shell
curl 'https://openapi.guance.com/api/v1/logging_query_rule/list?pageIndex=1&pageSize=5' \
-H 'DF-API-KEY: <DF-API-KEY>' \
--compressed
```




## 响应
```shell
{
    "code": 200,
    "content": [
        {
            "conditions": "`host` = wildcard('cvsdbvjk')",
            "createAt": 1695293435,
            "creator": "acnt_c05ef27fe2dd483ca04131a19df7370f",
            "deleteAt": -1,
            "extend": {
                "*host": [
                    "cvsdbvjk"
                ]
            },
            "id": 127,
            "indexes": [
                "default"
            ],
            "logic": "and",
            "memberCount": 29,
            "roleUUIDs": [
                "general"
            ],
            "status": 0,
            "updateAt": 1695293435,
            "updator": "acnt_c05ef27fe2dd483ca04131a19df7370f",
            "uuid": "lqrl_3ca770bfc3354becb13d9f667b071cd2",
            "workspaceUUID": "wksp_ed134a6485c8484dbd0e58ce9a9c6115"
        },
        {
            "conditions": "`app_id` IN ['cccc'] and `_dd` IN ['{\\\"sdk_name\\\":\\\"df_web_logs_sdk\\\",\\\"sdk_version\\\":\\\"2.0.19\\\"}']",
            "createAt": 1695092601,
            "creator": "acnt_861cf6dd440348648861247ae42909c3",
            "deleteAt": -1,
            "extend": {
                "_dd": [
                    "{\\\"sdk_name\\\":\\\"df_web_logs_sdk\\\",\\\"sdk_version\\\":\\\"2.0.19\\\"}"
                ],
                "app_id": [
                    "cccc"
                ]
            },
            "id": 126,
            "indexes": [
                "default"
            ],
            "logic": "and",
            "memberCount": 24,
            "roleUUIDs": [
                "readOnly"
            ],
            "status": 0,
            "updateAt": 1695092601,
            "updator": "acnt_861cf6dd440348648861247ae42909c3",
            "uuid": "lqrl_e31765b0e60d4769aa23cf57bf2df8c3",
            "workspaceUUID": "wksp_ed134a6485c8484dbd0e58ce9a9c6115"
        },
        {
            "conditions": " `browser` IN ['Chrome']  or  `client_ip` IN ['10.113.1.22']  or  `browser_version_major` NOT IN ['116'] ",
            "createAt": 1695091745,
            "creator": "acnt_861cf6dd440348648861247ae42909c3",
            "deleteAt": -1,
            "extend": {
                "-browser_version_major": [
                    "116"
                ],
                "browser": [
                    "Chrome"
                ],
                "client_ip": [
                    "10.113.1.22"
                ]
            },
            "id": 125,
            "indexes": [
                "default"
            ],
            "logic": "or",
            "memberCount": 24,
            "roleUUIDs": [
                "readOnly"
            ],
            "status": 0,
            "updateAt": 1695092025,
            "updator": "acnt_861cf6dd440348648861247ae42909c3",
            "uuid": "lqrl_b8fecbdee06f4bc0a8b2fee020f77a10",
            "workspaceUUID": "wksp_ed134a6485c8484dbd0e58ce9a9c6115"
        },
        {
            "conditions": "`client_ip` IN ['10.113.1.22']",
            "createAt": 1695091650,
            "creator": "acnt_861cf6dd440348648861247ae42909c3",
            "deleteAt": -1,
            "extend": {
                "client_ip": [
                    "10.113.1.22"
                ]
            },
            "id": 124,
            "indexes": [
                "default"
            ],
            "logic": "or",
            "memberCount": 29,
            "roleUUIDs": [
                "general"
            ],
            "status": 0,
            "updateAt": 1695091650,
            "updator": "acnt_861cf6dd440348648861247ae42909c3",
            "uuid": "lqrl_35fe31ab90f84578b676dbad0812d0b9",
            "workspaceUUID": "wksp_ed134a6485c8484dbd0e58ce9a9c6115"
        },
        {
            "conditions": "`ip` IN ['172.16.5.9']",
            "createAt": 1693807151,
            "creator": "acnt_861cf6dd440348648861247ae42909c3",
            "deleteAt": -1,
            "extend": {
                "ip": [
                    "172.16.5.9"
                ]
            },
            "id": 113,
            "indexes": [
                "default"
            ],
            "logic": "and",
            "memberCount": 7,
            "roleUUIDs": [
                "role_3552e414acc0415fa584c2caf0acf3fc"
            ],
            "status": 0,
            "updateAt": 1693807151,
            "updator": "acnt_861cf6dd440348648861247ae42909c3",
            "uuid": "lqrl_795d56c2f557469185db62c74e4942eb",
            "workspaceUUID": "wksp_ed134a6485c8484dbd0e58ce9a9c6115"
        }
    ],
    "errorCode": "",
    "message": "",
    "pageInfo": {
        "count": 5,
        "pageIndex": 1,
        "pageSize": 5,
        "totalCount": 59
    },
    "success": true,
    "traceId": "TRACE-78EEAF86-190D-4ADE-BA43-75962106F329"
} 
```




