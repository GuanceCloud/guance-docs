# 【Login Mapping】映射配置列表

---

<br />**GET /api/v1/login_mapping/field/list**

## 概述




## Query 请求参数

| 参数名        | 类型     | 必选   | 说明              |
|:-----------|:-------|:-----|:----------------|
| search | string |  | 搜索，默认搜索角色名，源字段名和源字段值<br>例子: supper_workspace <br>允许为空: False <br> |
| workspaceUUID | string |  | 工作空间UUID<br>例子: 工作空间UUID <br>允许为空: False <br> |
| pageIndex | integer |  | 页码<br>允许为空: False <br>例子: 10 <br>$minValue: 1 <br> |
| pageSize | integer |  | 每页返回数量<br>允许为空: False <br>例子: 10 <br>$minValue: 1 <br>$maxValue: 100 <br> |

## 参数补充说明





## 请求例子
```shell
curl 'https://openapi.guance.com/api/v1/login_mapping/field/list?pageIndex=1&pageSize=1' \
  -H 'Content-Type: application/json' \
  -H 'X-Df-Access-Key: <AK key>' \
  -H 'X-Df-Nonce: <随机字符>' \
  -H 'X-Df-Signature: <签名>' \
  -H 'X-Df-Timestamp: <时间戳>'
```




## 响应
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
                "workspaceName": "LWC测试B空间",
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




