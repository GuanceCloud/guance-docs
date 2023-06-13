# 获取频道列表

---

<br />**GET /api/v1/channel/quick_list**

## 概述




## 参数补充说明





## 请求例子
```shell
curl 'https://openapi.guance.com/api/v1/channel/quick_list' \
-H 'DF-API-KEY: <DF-API-KEY>' \
-H 'Content-Type: application/json;charset=UTF-8' \
--compressed 
```




## 响应
```shell
{
    "code": 200,
    "content": [
        {
            "createAt": 1680767371,
            "creator": "acnt_861cf6dd440348648861247ae42909c3",
            "deleteAt": 1680767373,
            "description": "频道的描述信息，外加随机数： `20230406T1549314fPYn0`",
            "id": 38,
            "name": "test频道_20230406T1549314fPYn0",
            "notifyTarget": [],
            "status": 0,
            "subscribeType": "",
            "updateAt": 1681357025,
            "updator": "acnt_7df07453091748b08f5ea2514f6a22f2",
            "uuid": "chan_a074092121c145e5b3a8741c4ea350da",
            "workspaceUUID": "wksp_ed134a6485c8484dbd0e58ce9a9c6115"
        }
    ],
    "errorCode": "",
    "message": "",
    "success": true,
    "traceId": "9262677406670495822"
} 
```




