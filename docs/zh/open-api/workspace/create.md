# 工作空间-创建

---

<br />**POST /api/v1/workspace/create**

## 概述
创建工作空间.

使用已存在的工作空间 API Key, 创建新工作空间.
新工作空间的拥有者 默认为本次请求 API Key 所属的空间拥有者




## Body 请求参数

| 参数名        | 类型     | 必选   | 说明              |
|:-----------|:-------|:-----|:----------------|
| name | string | Y | 名称<br>例子: supper_workspace <br>允许为空: False <br>最大长度: 256 <br> |
| desc | string |  | 描述<br>例子: 工作空间描述 <br>允许为空: True <br>允许为空字符串: True <br> |
| menuStyle | string |  | 工作空间菜单栏风格, 运维/测试/研发<br>例子: 运维 <br>允许为空: False <br>允许为空字符串: True <br> |
| needCreateAk | boolean |  | 是否创建工作空间AK<br>例子: True <br>允许为空: False <br> |
| akName | string |  | 工作空间AK名字<br>例子: True <br>允许为空: False <br> |
| language | string |  | 工作空间语言<br>允许为空: True <br>允许为空字符串: True <br>可选值: ['zh', 'en'] <br> |

## 参数补充说明


数据说明.*

- 请求参数说明

| 参数名           | type | 说明                                                 |
| ---------------- | ---- | ---------------------------------------------------- |
| name       | string | 新建的空间名称 |
| desc             | string | 新建的空间描述                                                 |
| needCreateAk       | boolean  | 是否需要在新空间创建API KEY     |
| akName            | string  | API KEY的名称                                         |

------

- 响应参数说明

| 参数名           | type | 说明                                                 |
| ---------------- | ---- | ---------------------------------------------------- |
| akInfo       | dict | 新空间的API KEY 信息 |
| ownerInfo             | dict | 新空间的拥有者信息                                                 |
| wsInfo    | dict | 空间相关信息                  |
| versionType    | string | 空间版本类型                  |

------




## 请求例子
```shell
curl 'https://openapi.guance.com/api/v1/workspace/create' \
-H 'Accept: application/json, text/plain, */*' \
-H 'Content-Type: application/json;charset=UTF-8' \
-H 'DF-API-KEY: <DF-API-KEY>' \
--data-raw '{"name":"ws_create_test","desc":"test","needCreateAk":true,"akName":"test_ak"}' \
--compressed
--insecure
```




## 响应
```shell
{
    "code": 200,
    "content": {
        "accountInfo": [
            "acnt_xxxxxx"
        ],
        "akInfo": {
            "keyId": "wsak_xxxxxx",
            "keySk": "xxxxxxxxxxx",
            "name": "test_ak"
        },
        "makeResourceExceptionCode": "",
        "ownerInfo": {
            "accountUUID": "acnt_xxxxxxxxxx",
            "email": "xxxxx@qq.com",
            "name": "测试"
        },
        "wsInfo": {
            "billingState": "free",
            "createAt": 1672802266,
            "creator": "wsak_xxxxx",
            "dashboardUUID": null,
            "datastore": {
                "backup_log": "es",
                "custom_object": "es",
                "keyevent": "es",
                "logging": "es",
                "metric": "influxdb",
                "network": "es",
                "object": "es",
                "object_history": "es",
                "rum": "es",
                "security": "es",
                "tracing": "es"
            },
            "dbUUID": "ifdb_xxxx32",
            "deleteAt": -1,
            "desc": "test",
            "durationSet": {
                "apm": "7d",
                "backup_log": "7d",
                "keyevent": "7d",
                "logging": "7d",
                "network": "1d",
                "rp": "7d"
            },
            "enablePublicDataway": 1,
            "esIndexMerged": 1,
            "esIndexSettings": {},
            "esInstanceUUID": "es_xxxx32",
            "exterId": "",
            "id": null,
            "isLocked": 0,
            "isOpenLogMultipleIndex": false,
            "lockAt": -1,
            "loggingCutSize": 10240,
            "makeResourceExceptionCode": "",
            "name": "ws_create_test",
            "rpName": "rp1",
            "status": 0,
            "supportJsonMessage": 1,
            "updateAt": 1672802266,
            "updator": "wsak_xxxxx",
            "uuid": "wksp_xxxx32",
            "versionType": "free"
        }
    },
    "errorCode": "",
    "message": "",
    "success": true,
    "traceId": "TRACE-89835D3F-C614-46AD-A1B8-83CC686DDA7F"
} 
```




