# 创建一个拨测任务

---

<br />**post /api/v1/dialing_task/add**

## 概述




## Body 请求参数

| 参数名        | 类型     | 必选   | 说明              |
|:-----------|:-------|:-----|:----------------|
| type | string | Y | 拨测类型<br>允许为空: fase <br>$lowerIn: ['http', 'tcp', 'dns', 'browser', 'icmp', 'websocket'] <br> |
| regions | array | Y | 地域列表<br>允许为空: False <br> |
| task | json | Y | 任务配置<br>允许为空: False <br>$maxDictLength: 20000 <br> |
| task.url | string |  | url<br>允许为空: False <br> |
| task.method | string |  | 当type 为 browser时为非必填参数<br>允许为空: False <br> |
| task.name | string | Y | 任务名称<br>允许为空: False <br> |
| task.frequency | string | Y | 拨测频率<br>允许为空: False <br>可选值: ['1m', '5m', '15m', '30m', '1h', '6h', '12h', '24h'] <br> |
| task.advance_options | json |  | advance_options<br>允许为空: False <br> |
| task.advance_options_headless | json |  | browser 的 advance_options 设置<br>允许为空: False <br> |
| task.success_when_logic | string |  | success_when 内条件的逻辑关系, 默认为`and`<br>允许为空: False <br>可选值: ['and', 'or'] <br> |
| task.success_when | array |  | success_when<br>允许为空: False <br> |
| task.enable_traceroute | boolean |  | 路由跟踪<br>允许为空: False <br> |
| task.packet_count | integer |  | 每次拨测发送pings数量<br>允许为空: False <br> |
| task.host | string |  | type=tcp/icmp时，必填参数<br>允许为空: False <br> |
| task.port | string |  | type=tcp时，必填参数<br>允许为空: False <br> |
| task.timeout | string |  | type=tcp/icmp时，选填参数<br>允许为空: False <br> |
| task.message | string |  | type=websocket，必填参数<br>允许为空: False <br> |

## 参数补充说明


*数据说明.*

*相关参数说明*


|  参数名        |   type  | 必选  |          说明          |
|---------------|----------|----|------------------------|
| type          |  string  |  Y | 云拨测类型，可选选项`http`,`tcp`,`dns`, `browser`,`tcp`,`icmp`,'websocket`  |
| regions         |  array  |  Y | 任务执行区域  |
| task         |  json  |  Y | 任务详情  |
| task.name       |  string   |  Y | 任务名称|
| task.url       |  string   |  Y | url|
| task.method       |  string   |  Y | url 请求方法|
| task.status       |  string   |  Y | 任务状态，可选值`ok`,`stop`|
| task.frequency       |  string   |  Y | 任务频率|
| task.advance_options       |  json   |   | |
| task.success_when_logic       |  enum   | N  | 可选值：[`and`, `or`], success_when 参数内的逻辑关系，默认为 `and`|
| task.success_when       |  array   | Y/N  | type=http时，此参数必传，type=browser时为非必传参数|
| task.enable_traceroute  |  boolean  | N  |  type=tcp/icmp时，此参数选填 ｜
| task.packet_count    | integer  ｜ N  | type=icmp时，此参数选填 ｜
| task.host  | string  |  N  |  type=tcp/icmp时，此参数必填  ｜
| task.port  | string  |  N  |  type=tcp时，此参数必填  ｜
| task.timeout  | string  | N  | type=tcp/icmp时，此参数选填  |
| task.message  | string  | Y/N  | type=websocket时，此参数必填  ｜

--------------

```json
{
    "regions": [hangzhou, shanghai],
    "task":{
        "url":"http://example.com/some/api",
        "method":"POST",
        "external_id":"外部系统中给该任务定义的 ID",
        "post_url":" 这个参数由Studio 后端提供 https://dataway.cn?token=tkn_xxx",
        "status":"ok/stop",
        "name":"任务命名",
        "frequency":"1m",
        "regions":"beijing",
        "advance_options":{
              "request_options":{
                  "follow_redirect":true,
                  "headers":{
                      "header1":"value1",
                      "header2":"value2"
                  },
                  "cookies":"",
                  "auth":{
                      "username":"",
                      "password":""
                  }
              },
              "request_body":{
                  "body_type":"text/plain|application/json|text/xml",
                  "body":""
              },
              "certificate":{
                  "ignore_server_certificate_error":false,
                  "private_key":"",
                  "certificate":""
              },
              "proxy":{
                  "url":"",
                  "headers":{
                      "header1":"value1"
                  }
              }
          },
        "success_when_logic": "and",
        "success_when":[
            {
                "body":{
                    "contains":"",
                    "not_contains":"",
                    "is":"",
                    "is_not":"",
                    "match_regex":"",
                    "not_match_regex":""
                },
                "header":{
                    "header-name":{
                        "contains":"",
                        "not_contains":"",
                        "is":"",
                        "is_not":"",
                        "match_regex":"",
                        "not_match_regex":""
                    },
                    "another-header-name":"..."
                },
                "response_time":"100ms",
                "status_code":{
                    "is":"200",
                    "is_not":"400",
                    "match_regex":"ok*",
                    "not_match_regex":"*bad"
                }
            },
            {
                "AND_another_assert":"..."
            }
        ]
    }
}
```

*** task.frequency 参数说明 ***
体验版工作空间的时间频率范围是 30m/1h/6h/12h/24h




## 请求例子
```shell
curl 'https://openapi.guance.com/api/v1/dialing_task/add' \
-H 'DF-API-KEY: <DF-API-KEY>' \
-H 'Content-Type: application/json;charset=UTF-8' \
--data-raw '{"type":"http","regions":["reg_chvefvc4c5rlp90lb1tg"],"task":{"frequency":"1m","method":"GET","url":"https://www.baidu.com","name":"test","advance_options":{"request_options":{"follow_redirect":false,"headers":{},"cookies":"","auth":{"username":"","password":""}},"request_body":{"body_type":"","body":""},"secret":{"not_save":false}},"success_when":[{"body":[{"contains":"200"}]}],"success_when_logic":"and"}}' \
--compressed 
```




## 响应
```shell
{
    "code": 200,
    "content": {
        "createAt": 1686193610,
        "creator": "acnt_861cf6dd440348648861247ae42909c3",
        "deleteAt": -1,
        "id": null,
        "regions": [
            "reg_chvefvc4c5rlp90lb1tg"
        ],
        "status": 0,
        "task": {
            "advance_options": {
                "request_body": {
                    "body": "",
                    "body_type": ""
                },
                "request_options": {
                    "auth": {
                        "password": "",
                        "username": ""
                    },
                    "cookies": "",
                    "follow_redirect": false,
                    "headers": {}
                },
                "secret": {
                    "not_save": false
                }
            },
            "external_id": "dial_408e8fafe88a49a5ba1cfd73910edfdb",
            "frequency": "1m",
            "method": "GET",
            "name": "test",
            "owner_external_id": "wksp_ed134a6485c8484dbd0e58ce9a9c6115",
            "post_url": "http://testing-openway.cloudcare.cn?token=tkn_7ca9b1139db64fa6ac34801145a9cb6e",
            "status": "ok",
            "success_when": [
                {
                    "body": [
                        {
                            "contains": "200"
                        }
                    ]
                }
            ],
            "success_when_logic": "and",
            "url": "https://www.baidu.com"
        },
        "type": "http",
        "updateAt": 1686193610,
        "updator": "acnt_861cf6dd440348648861247ae42909c3",
        "uuid": "dial_408e8fafe88a49a5ba1cfd73910edfdb",
        "workspaceUUID": "wksp_ed134a6485c8484dbd0e58ce9a9c6115"
    },
    "errorCode": "",
    "message": "",
    "success": true,
    "traceId": "712401530723551303"
} 
```



