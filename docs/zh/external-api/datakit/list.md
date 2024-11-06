# 在线 Datakit 列表

---

<br />**GET /api/v1/datakit/list**

## 概述




## Query 请求参数

| 参数名        | 类型     | 必选   | 说明              |
|:-----------|:-------|:-----|:----------------|
| workspaceUUID | string |  | 工作空间UUID<br>例子: wksp_xxxxx <br>允许为空: False <br> |
| version | string |  | Datakit版本<br>例子: xxx <br>允许为空: False <br> |
| search | string |  | 主机名、运行ID、IP的搜索<br>允许为空: False <br> |
| searchKeys | string |  | 指定待搜索的字段,默认为`hostName,extend.ip,extend.runtime_id`<br>例子: xxx <br>允许为空: False <br> |
| isOnline | boolean |  | 当天是否活跃<br>例子: xxx <br>允许为空: False <br> |
| lastHeartbeatTime | integer |  | 最后有数据上报的时间范围，单位秒<br>允许为空: False <br>例子: 600 <br>$minValue: 1 <br> |
| pageIndex | integer |  | 页码<br>允许为空: False <br>例子: 10 <br>$minValue: 1 <br> |
| pageSize | integer |  | 每页返回数量<br>允许为空: False <br>例子: 10 <br>$minValue: 1 <br> |

## 参数补充说明





## 请求例子
```shell
curl '<Endpoint>/api/v1/datakit/list?version=1.14.2&pageIndex=1&pageSize=10' \
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
                "arch": "amd64",
                "createAt": 1715326420,
                "creator": "",
                "deleteAt": -1,
                "extend": {
                    "arch": "amd64",
                    "cpu_cores": 0,
                    "datakit_version": "1.14.2",
                    "hostname": "izxxxx",
                    "ip": "",
                    "online_time": 0,
                    "os": "linux",
                    "run_in_container": false,
                    "run_mode": "",
                    "runtime_id": "",
                    "token": "",
                    "upgrader_server": "",
                    "uptime": 0,
                    "usage_cores": 1,
                    "wsuuid": "wksp_4b5xxx"
                },
                "hostName": "izxxxx",
                "id": 10,
                "lastUpdateTime": 1729763119,
                "onlineTime": 816415,
                "os": "linux",
                "status": 0,
                "updateAt": 1729763119,
                "updator": "",
                "usageCores": 1,
                "version": "1.14.2",
                "workspaceName": "【Doris】开发测试一起用_",
                "workspaceUUID": "wksp_4b5xxx"
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
    "traceId": "11166663346088761547"
} 
```




