# 创建一个Issue消息

---

<br />**POST /api/v1/issue/add**

## 概述




## Body 请求参数

| 参数名        | 类型     | 必选   | 说明              |
|:-----------|:-------|:-----|:----------------|
| name | string | Y | 标题名称<br>例子: name <br>允许为空: False <br>最大长度: 256 <br> |
| level | integer | Y | 等级<br>例子: level <br>允许为空: False <br>可选值: [0, 1, 2] <br> |
| description | string | Y | 描述<br>例子: description <br>允许为空: False <br> |
| attachmentUuids | array |  | 附件上传列表uuid<br>例子: [] <br>允许为空: True <br> |
| extend | json | Y | 额外拓展信息<br>例子: {} <br>允许为空: True <br> |
| resourceType | string |  | 来源类型,没有场景就不需要传<br>例子: resourceType <br>允许为空: False <br>可选值: ['event', 'dashboard', 'viewer'] <br> |
| resourceUUID | string |  | 对应来源的uuid分别 docid,dashboardUUID,dashboardUUID<br>例子: resourceUuid <br>允许为空: False <br>允许空字符串: True <br> |
| resource | string |  | 对应来源带入的来源名称<br>例子: resource <br>允许为空: False <br>允许空字符串: True <br> |
| channelUUIDs | array |  | issue投递追踪频道uuids<br>例子: [] <br>允许为空: True <br> |

## 参数补充说明





## 请求例子
```shell
curl 'https://openapi.guance.com/api/v1/issue/add' \
-H 'DF-API-KEY: <DF-API-KEY>' \
-H 'Content-Type: application/json;charset=UTF-8' \
--data-raw '{"name":"dcacscsc","level":2,"description":"<span>cdscascas</span>","extend":{"channels":[{"type":"#","uuid":"chan_d5054276d1a74b518bf1b16f59c26e95"}],"view_isuue_url":"/exceptions/exceptionsTracking?leftActiveKey=ExceptionsTracking&activeName=ExceptionsTracking&w=wksp_ed134a6485c8484dbd0e58ce9a9c6115&classic=exceptions_tracing&issueName=SYS&activeChannel=%7BdefaultChannelUUID%7D&sourceType=exceptions_tracing&__docid=%7BissueUUID%7D"},"attachmentUuids":[]}'\
--compressed 
```




## 响应
```shell
{
    "code": 200,
    "content": {
        "createAt": 1686398344,
        "creator": "acnt_861cf6dd440348648861247ae42909c3",
        "creatorInfo": {
            "acntWsNickname": "",
            "email": "1061379682@qq.com",
            "iconUrl": "",
            "name": "wanglei-testing",
            "username": "1061379682@qq.com"
        },
        "deleteAt": -1,
        "description": "",
        "extend": {
            "channels": [
                {
                    "exists": true,
                    "type": "#",
                    "uuid": "chan_d5054276d1a74b518bf1b16f59c26e95"
                }
            ],
            "view_isuue_url": ""
        },
        "id": 47402,
        "level": 2,
        "name": "dcacscsc",
        "resource": "",
        "resourceType": "",
        "resourceUUID": "",
        "status": 0,
        "statusType": 20,
        "subIdentify": "",
        "updateAt": 1686400483,
        "updator": "acnt_861cf6dd440348648861247ae42909c3",
        "updatorInfo": {
            "acntWsNickname": "",
            "email": "1061379682@qq.com",
            "iconUrl": "",
            "name": "wanglei-testing",
            "username": "1061379682@qq.com"
        },
        "uuid": "issue_7b1f8986a7b44d7a987976fb5c7876fc",
        "workspaceUUID": "wksp_ed134a6485c8484dbd0e58ce9a9c6115"
    },
    "errorCode": "",
    "message": "",
    "success": true,
    "traceId": "1744405827768254151"
} 
```



