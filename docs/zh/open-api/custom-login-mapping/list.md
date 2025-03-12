# 【自定义映射规则】映射配置列表

---

<br />**GET /api/v1/login_mapping/field/list**

## 概述




## Query 请求参数

| 参数名        | 类型     | 必选   | 说明              |
|:-----------|:-------|:-----|:----------------|
| search | string |  | 搜索，默认搜索角色名，源字段名和源字段值<br>例子: supper_workspace <br>允许为空: False <br> |
| pageIndex | integer |  | 页码<br>允许为空: False <br>例子: 10 <br>$minValue: 1 <br> |
| pageSize | integer |  | 每页返回数量<br>允许为空: False <br>例子: 10 <br>$minValue: 1 <br>$maxValue: 100 <br> |

## 参数补充说明





## 请求例子
```shell
curl 'https://openapi.<<< custom_key.brand_main_domain >>>/api/v1/login_mapping/field/list?pageIndex=1&pageSize=10&search=lisa-new' \
  -H 'Content-Type: application/json;charset=UTF-8' \
  -H 'DF-API-KEY: <DF-API-KEY>' \
  --compressed
```




## 响应
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
                "workspaceName": "LWC-SSO-2023-09-25测试",
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




