# 创建一个Issue消息

---

<br />**POST /api/v1/issue/add**

## 概述




## Body 请求参数

| 参数名        | 类型     | 必选   | 说明              |
|:-----------|:-------|:-----|:----------------|
| name | string | Y | 标题名称<br>例子: name <br>允许为空: False <br>最大长度: 256 <br> |
| level | string | Y | 等级,对应等级配置的uuid<br>例子: level <br>允许为空: False <br> |
| description | string | Y | 描述<br>例子: description <br>允许为空: False <br> |
| attachmentUuids | array |  | 附件上传列表uuid<br>例子: [] <br>允许为空: True <br> |
| extend | json | Y | 额外拓展信息<br>例子: {} <br>允许为空: True <br> |
| resourceType | string |  | 来源类型,没有场景就不需要传<br>例子: resourceType <br>允许为空: False <br>可选值: ['event', 'dashboard', 'viewer'] <br> |
| resourceUUID | string |  | 对应来源的uuid分别 docid,dashboardUUID,dashboardUUID<br>例子: resourceUuid <br>允许为空: False <br>允许空字符串: True <br> |
| resource | string |  | 对应来源带入的来源名称<br>例子: resource <br>允许为空: False <br>允许空字符串: True <br> |
| channelUUIDs | array |  | issue投递追踪频道uuids<br>例子: [] <br>允许为空: True <br> |

## 参数补充说明


**基本参数说明**

|     参数名      | 参数类型 | 是否必填 |                  参数说明                   |
|:---------------:|:--------:|:--------:|:-------------------------------------------:|
|      name       |  string  |    Y     |                issue标题名称                |
|      level      | string  |     Y     |        issue等级 对应配置等级uuid       |
|   decription    |  string  |    Y     |                issue描述信息                |
| attachmentUuids |  array   |    N     |              附件上传列表uuid               |
|     extend      |   json   |    Y     |                  扩展字段，默认传{}                  |
|  resourceType   |  string  |    N     | event:事件；dashboard:仪表板；viewer:查看器 |
|  resourceUUID   |  string  |    N     |     资源关联的uuid     |
|    resource     |  string  |    N     |                对应资源名称                 |
|  channelUUIDs   |  array   |    N     |           期望issue投递的资源列表，默认投递默认空间默认频道  |


**扩展字段extend说明**

**新增场景中，channels和channelUUIDs的作用会默认的向默认频道和追加的频道中进行关联处理**

|  参数名  | 参数类型 | 是否必填 |        参数说明         |
|:--------:|:--------:|:--------:|:-----------------------:|
| channels |  array   |    N     | 期望issue投递的资源列表 |
| members         |     array     |     N     |       期望issue通知的通知对象成员    |




## 请求例子
```shell
curl 'https://openapi.guance.com/api/v1/issue/add' \
-H 'DF-API-KEY: <DF-API-KEY>' \
-H 'Content-Type: application/json;charset=UTF-8' \
--data-raw '{"name":"dcacscsc","level":"system_level_2","description":"<span>cdscascas</span>","extend":{"channels":[{"type":"#","uuid":"chan_d5054276d1a74b518bf1b16f59c26e95"}],"view_isuue_url":"/exceptions/exceptionsTracking?leftActiveKey=ExceptionsTracking&activeName=ExceptionsTracking&w=wksp_ed134a6485c8484dbd0e58ce9a9c6115&classic=exceptions_tracing&issueName=SYS&activeChannel=%7BdefaultChannelUUID%7D&sourceType=exceptions_tracing&__docid=%7BissueUUID%7D"},"attachmentUuids":[]}'\
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
        "level": "system_level_2",
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




