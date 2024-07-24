# Issue-等级 列出

---

<br />**GET /api/v1/issue-level/list**

## 概述




## 参数补充说明





## 请求例子
```shell
curl 'https://openapi.guance.com/api/v1/issue-level/list' \
-H 'DF-API-KEY: <DF-API-KEY>' \
--compressed
```




## 响应
```shell
{
    "code": 200,
    "content": [
        {
            "color": "#E94444",
            "description": "默认等级配置",
            "isDefault": true,
            "name": "P0",
            "uuid": "system_level_0"
        },
        {
            "color": "#FF7931",
            "description": "默认等级配置",
            "isDefault": true,
            "name": "P1",
            "uuid": "system_level_1"
        },
        {
            "color": "#FFB44A",
            "description": "默认等级配置",
            "isDefault": true,
            "name": "P2",
            "uuid": "system_level_2"
        },
        {
            "color": "#C9C9C9",
            "description": "默认等级配置",
            "isDefault": true,
            "name": "P3",
            "uuid": "system_level_3"
        },
        {
            "color": "#E94444",
            "createAt": 1694593524,
            "creator": "acnt_861cf6dd440348648861247ae42909c3",
            "deleteAt": -1,
            "description": "自定义等级描述2",
            "extend": {},
            "id": 3,
            "isDefault": false,
            "name": "custom-1",
            "status": 0,
            "updateAt": 1694593524,
            "updator": "acnt_861cf6dd440348648861247ae42909c3",
            "uuid": "issl_bb535e6616ac47de88fd9ec08787c4c0",
            "workspaceUUID": "wksp_ed134a6485c8484dbd0e58ce9a9c6115"
        }
    ],
    "errorCode": "",
    "message": "",
    "success": true,
    "traceId": "TRACE-2FDDC63E-17AE-41ED-AE63-D2DF2E7BCD51"
} 
```




