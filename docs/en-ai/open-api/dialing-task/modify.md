# Modify a Dial Testing Task

---

<br />**POST /api/v1/dialing_task/\{task_uuid\}/modify**

## Overview



## Route Parameters

| Parameter Name        | Type     | Required   | Description              |
|:------------------|:-------|:-----|:----------------|
| task_uuid | string | Y | ID of the Dial Testing task<br> |


## Body Request Parameters

| Parameter Name        | Type     | Required   | Description              |
|:------------------|:-------|:-----|:----------------|
| regions | array | Y | List of regions<br>Allow null: False <br> |
| task | json | Y | Task configuration<br>Allow null: False <br>$maxDictLength: 65536 <br> |
| task.url | string |  | URL<br>Allow null: False <br> |
| task.method | string |  | Method<br>Allow null: False <br> |
| task.name | string | Y | Task name<br>Allow null: False <br>Maximum length: 256 <br> |
| task.frequency | string | Y | Dial Testing frequency<br>Allow null: False <br>Options: ['1m', '5m', '15m', '30m', '1h', '6h', '12h', '24h'] <br> |
| task.advance_options | json |  | Advanced options<br>Allow null: False <br> |
| task.advance_options_headless | json |  | Browser's advanced options settings<br>Allow null: False <br> |
| task.success_when_logic | string |  | Logical relationship within success_when conditions, default is `and`<br>Allow null: False <br>Options: ['and', 'or'] <br> |
| task.success_when | array |  | success_when<br>Allow null: False <br> |
| task.enable_traceroute | boolean |  | Traceroute<br>Allow null: False <br> |
| task.packet_count | integer |  | Number of pings sent each time<br>Allow null: False <br> |
| task.host | string |  | Required parameter when type=tcp/icmp<br>Allow null: False <br> |
| task.port | string |  | Required parameter when type=tcp<br>Allow null: False <br> |
| task.timeout | string |  | Optional parameter when type=tcp/icmp<br>Allow null: False <br> |
| task.message | string |  | Required parameter when type=websocket<br>Allow null: False <br> |
| tags | array |  | List of tag names<br>Allow null: False <br> |

## Additional Parameter Notes

*Data Description.*

| Parameter Name        | Type  | Required  | Description          |
|-------------------|----------|----|------------------------|
| type          | string  | Y | Dial Testing type, options: `http`,`tcp`,`dns`, `browser`,`icmp`, `websocket`  |
| regions         | array  | Y | Task execution regions  |
| task         | json  | Y | Task details  |
| task.name       | string   | Y | Task name|
| task.url       | string   | Y | URL|
| task.method       | string   | Y | URL request method|
| task.status       | string   | Y | Task status, options: `ok`,`stop`|
| task.frequency       | string   | Y | Task frequency|
| task.advance_options       | json   | N | |
| task.success_when_logic       | enum   | N  | Options: [`and`, `or`], logical relationship within success_when parameters, default is `and`|
| task.success_when       | array   | Y/N  | Required when type=http, optional when type=browser|
| task.enable_traceroute  | boolean  | N  | Optional when type=tcp/icmp |
| task.packet_count    | integer  | N  | Optional when type=icmp |
| task.host  | string  | Y/N  | Required when type=tcp/icmp |
| task.port  | string  | Y/N  | Required when type=tcp |
| task.timeout  | string  | N  | Optional when type=tcp/icmp |
| task.message  | string  | Y/N  | Required when type=websocket |
| tags          | array  | N | Tag list |

*Note*: For specific details of the Dial Testing task parameters inside task, refer to [Custom Dial Testing](../../integrations/dialtesting_json.md)
--------------

```json
{
    "regions": ["hangzhou", "shanghai"],
    "task":{
        "url":"http://example.com/some/api",
        "method":"POST",
        "external_id":"ID defined by external system for this task",
        "post_url":" Provided by Studio backend https://dataway.cn?token=tkn_xxx",
        "status":"ok/stop",
        "name":"Task Naming",
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
                "status_code":[
                    { "is":"200" },
                    { "is_not":"400"},
                    {"match_regex":"ok*"},
                    {"not_match_regex":"*bad"}
                ]
            },
            {
                "AND_another_assert":"..."
            }
        ]
    },
    "tags": ["Tag Name"]
}
```

*** Explanation of task.frequency Parameter ***<br/>
For Free Plan workspaces, the time frequency range is 30m/1h/6h/12h/24h



## Request Example
```shell
curl 'https://openapi.guance.com/api/v1/dialing_task/dial_xxxx32/modify' \
-H 'DF-API-KEY: <DF-API-KEY>' \
-H 'Content-Type: application/json;charset=UTF-8' \
--data-raw '{"regions":["reg_xxxx20"],"task":{"frequency":"1m","method":"GET","url":"https://www.baidu.com","name":"test","advance_options":{"request_options":{"follow_redirect":false,"headers":{},"cookies":"","auth":{"username":"","password":""}},"request_body":{"body_type":"","body":""},"secret":{"not_save":false}},"success_when":[{"body":[{"contains":"200"}]}],"success_when_logic":"and"},"tags":["test"]}' \
--compressed
```



## Response
```shell
{
    "code": 200,
    "content": {
        "createAt": 1686193610,
        "creator": "acnt_xxxx32",
        "deleteAt": -1,
        "id": null,
        "regions": [
            "reg_xxxx20"
        ],
        "status": 0,
        "tagInfo": [
            {
                "id": "tag_xxxx32",
                "name": "test"
            }
        ],
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
            "external_id": "dial_xxxx32",
            "frequency": "1m",
            "method": "GET",
            "name": "test",
            "owner_external_id": "wksp_xxxx32",
            "post_url": "http://testing-openway.cloudcare.cn?token=tkn_xxxxx",
            "status": "ok",
            "tagInfo": [],
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
        "updator": "acnt_xxxx32",
        "uuid": "dial_xxxx32",
        "workspaceUUID": "wksp_xxxx32"
    },
    "errorCode": "",
    "message": "",
    "success": true,
    "traceId": "712401530723551303"
} 
```