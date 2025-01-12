# 工作空间-创建

---

<br />**post /api/v1/openapi/workspace/create**

## 概述
创建工作空间




## Body 请求参数

| 参数名        | 类型     | 必选   | 说明              |
|:-----------|:-------|:-----|:----------------|
| name | string | Y | 名称<br>例子: supper_workspace <br>允许为空: False <br>最大长度: 256 <br> |
| desc | string |  | 描述<br>例子: 工作空间描述 <br>允许为空: True <br>允许空字符串: True <br> |
| needCreateAk | boolean |  | 是否创建工作空间AK<br>例子: True <br>允许为空: False <br> |
| akName | string |  | 工作空间AK名字<br>例子: True <br>允许为空: False <br> |

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

------




## 请求例子
```shell
curl 'https://openapi.guance.com/api/v1/openapi/workspace/create' \
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
            "acnt_6f2fd4c0766d11ebb56ef2b2c21faf74"
        ],
        "akInfo": {
            "keyId": "wsak_fb0d6f7f2a3447b8871ad9119e4faac5",
            "keySk": "RTkIO2q1WdHLzt8achfAXiZPvl0KrJu4",
            "name": "test_ak"
        },
        "makeResourceExceptionCode": "",
        "ownerInfo": {
            "accountUUID": "acnt_6f2fd4c0766d11ebb56ef2b2c21faf74",
            "email": "88@qq.com",
            "name": "测试"
        },
        "wsInfo": {
            "billingState": "free",
            "cliToken": "wkcli_3b8cd17e24f84c5fa1bfdefc27f492f5",
            "createAt": 1672802266,
            "creator": "wsak_60b430adbf1440ad991a4647e9ef411a",
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
            "dbUUID": "ifdb_683a9d68ce8042289a0fb51eeb85d43f",
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
            "esInstanceUUID": "es_1f32b130567411ec9cfbacde48001122",
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
            "token": "tkn_609ab0912a3f4e08b6d60184454ca59c",
            "updateAt": 1672802266,
            "updator": "wsak_60b430adbf1440ad991a4647e9ef411a",
            "uuid": "wksp_320a93deda9a47549ffb95ce26fc6bb4",
            "versionType": "free"
        }
    },
    "errorCode": "",
    "message": "",
    "success": true,
    "traceId": "TRACE-89835D3F-C614-46AD-A1B8-83CC686DDA7F"
} 
```




