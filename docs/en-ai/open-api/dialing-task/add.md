# Create a Dial Testing Task

---

<br />**POST /api/v1/dialing_task/add**

## Overview



## Body Request Parameters

| Parameter Name        | Type     | Required   | Description              |
|:---------------------|:--------|:----------|:------------------------|
| type | string | Y | Dial Testing type<br>Can be empty: false <br>$lowerIn: ['http', 'tcp', 'dns', 'browser', 'icmp', 'websocket'] <br> |
| regions | array | Y | Region list<br>Can be empty: false <br> |
| task | json | Y | Task configuration<br>Can be empty: false <br>$maxDictLength: 20000 <br> |
| task.url | string | Y | URL<br>Can be empty: false <br> |
| task.method | string | N | Non-required when type is browser<br>Can be empty: false <br> |
| task.name | string | Y | Task name<br>Can be empty: false <br> |
| task.frequency | string | Y | Dial Testing frequency<br>Can be empty: false <br>Options: ['1m', '5m', '15m', '30m', '1h', '6h', '12h', '24h'] <br> |
| task.advance_options | json | Y | Advanced options<br>Can be empty: false <br> |
| task.advance_options_headless | json | Y | Browser's advanced options settings<br>Can be empty: false <br> |
| task.success_when_logic | string | Y | Logical relationship of conditions within success_when, defaults to `and`<br>Can be empty: false <br>Options: ['and', 'or'] <br> |
| task.success_when | array | Y | Success_when<br>Can be empty: false <br> |
| task.enable_traceroute | boolean | Y | Traceroute<br>Can be empty: false <br> |
| task.packet_count | integer | Y | Number of pings sent each time<br>Can be empty: false <br> |
| task.host | string | Y | Required when type=tcp/icmp<br>Can be empty: false <br> |
| task.port | string | Y | Required when type=tcp<br>Can be empty: false <br> |
| task.timeout | string | N | Optional when type=tcp/icmp<br>Can be empty: false <br> |
| task.message | string | Y | Required when type=websocket<br>Can be empty: false <br> |
| task.post_mode | string | N | Availability judgment mode Default-default Script mode-script<br>Can be empty: false <br> |
| task.post_script | string | N | Script content<br>Can be empty: false <br>Can be an empty string: true <br> |
| tags | array | N | List of tag names<br>Can be empty: false <br>Example: ['xx', 'yy'] <br> |

## Additional Parameter Explanation


*Data Explanation.*

| Parameter Name        | Type  | Required  | Description          |
|-----------------------|------|-----------|----------------------|
| type                  | string | Y | Cloud Dial Testing type, options: `http`, `tcp`, `dns`, `browser`, `tcp`, `icmp`, `websocket`  |
| regions               | array | Y | Task execution regions |
| task                  | json  | Y | Task details |
| task.name             | string | Y | Task name |
| task.url              | string | Y | URL |
| task.method           | string | Y | URL request method |
| task.status           | string | Y | Task status, options: `ok`, `stop` |
| task.frequency        | string | Y | Task frequency |
| task.advance_options  | json   | N | |
| task.success_when_logic | enum | N | Options: [`and`, `or`], logical relationship within success_when parameters, default is `and` |
| task.success_when     | array | Y/N | Required when type=http, optional when type=browser |
| task.enable_traceroute | boolean | N | Optional when type=tcp/icmp |
| task.packet_count     | integer | N | Optional when type=icmp |
| task.host             | string | Y | Required when type=tcp/icmp |
| task.port             | string | Y | Required when type=tcp |
| task.timeout          | string | N | Optional when type=tcp/icmp |
| task.message          | string | Y/N | Required when type=websocket |
| task.post_mode        | string | N | Availability judgment mode Default-default Script mode-script |
| task.post_script      | string | N | Availability judgment script content |
| tags                  | array  | N | Tag list |

*Note*: Specific details of the dial testing task parameters can be found in [Custom Dial Testing](../../integrations/dialtesting_json.md)
--------------

```json
{
    "regions": ["hangzhou", "shanghai"],
    "task":{
        "url":"http://example.com/some/api",
        "method":"POST",
        "external_id":"External ID defined for this task in the external system",
        "post_url":"This parameter is provided by Studio backend https://dataway.cn?token=tkn_xxx",
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
The time frequency range for Free Plan workspaces is 30m/1h/6h/12h/24h



## Request Example
```shell
curl 'https://openapi.guance.com/api/v1/dialing_task/add' \
-H 'DF-API-KEY: <DF-API-KEY>' \
-H 'Content-Type: application/json;charset=UTF-8' \
--data-raw '{"type":"http","regions":["reg_xxxx20"],"task":{"frequency":"1m","method":"GET","url":"https://www.baidu.com","name":"test","advance_options":{"request_options":{"follow_redirect":false,"headers":{},"cookies":"","auth":{"username":"","password":""}},"request_body":{"body_type":"","body":""},"secret":{"not_save":false}},"success_when":[{"body":[{"contains":"200"}]}],"success_when_logic":"and"},"tags":["test"]}' \
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