# Online Datakit List

---

<br />**GET /api/v1/datakit/list**

## Overview




## Query Request Parameters

| Parameter Name        | Type     | Required   | Description              |
|:-----------------|:-------|:-----|:----------------|
| workspaceUUID | string | Yes | Workspace UUID<br>Example: wksp_xxxxx <br>Can be empty: False <br> |
| version | string | Yes | Datakit version<br>Example: xxx <br>Can be empty: False <br> |
| search | string | Yes | Search by hostname, runtime ID, or IP<br>Can be empty: False <br> |
| searchKeys | string | Yes | Specify fields to search, default is `hostName,extend.ip,extend.runtime_id`<br>Example: xxx <br>Can be empty: False <br> |
| isOnline | boolean | Yes | Whether active on the current day<br>Example: xxx <br>Can be empty: False <br> |
| lastHeartbeatTime | integer | Yes | Time range of the last data report, in seconds<br>Can be empty: False <br>Example: 600 <br>$minValue: 1 <br> |
| pageIndex | integer | Yes | Page number<br>Can be empty: False <br>Example: 10 <br>$minValue: 1 <br> |
| pageSize | integer | Yes | Number of items per page<br>Can be empty: False <br>Example: 10 <br>$minValue: 1 <br> |

## Additional Parameter Notes





## Request Example
```shell
curl '<Endpoint>/api/v1/datakit/list?version=1.14.2&pageIndex=1&pageSize=10' \
  -H 'Content-Type: application/json' \
  -H 'X-Df-Access-Key: <AK key>' \
  -H 'X-Df-Nonce: <random characters>' \
  -H 'X-Df-Signature: <signature>' \
  -H 'X-Df-Timestamp: <timestamp>'
```




## Response
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
                "workspaceName": "[Doris] Development and Testing Together",
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