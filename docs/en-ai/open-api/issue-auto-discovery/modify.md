# Modify Auto Discovery Configuration

---

<br />**POST /api/v1/issue_auto_discovery/\{cfg_uuid\}/modify**

## Overview




## Route Parameters

| Parameter Name        | Type     | Required   | Description              |
|:---------------------|:---------|:-----------|:-------------------------|
| cfg_uuid             | string   | Y          | Issue auto discovery configuration UUID<br> |


## Body Request Parameters

| Parameter Name        | Type     | Required   | Description              |
|:---------------------|:---------|:-----------|:-------------------------|
| name                 | string   | Y          | Title name<br>Example: name <br>Can be empty: False <br>Maximum length: 256 <br> |
| description          | string   |            | Description<br>Example: description <br>Can be empty: False <br>Can be an empty string: True <br> |
| dqlNamespace         | string   | Y          | Data scope<br>Example: keyevent <br>Can be empty: False <br>Optional values: ['keyevent'] <br> |
| every                | integer  | Y          | Check frequency (time length in seconds)<br>Example: 300 <br>Can be empty: False <br>$minValue: 300 <br>$maxValue: 3600 <br>Optional values: [300, 600, 900, 1800, 3600] <br> |
| conditions           | string   |            | Content within the curly braces of the DQL query filter conditions<br>Example: `source` IN ['kube-controller'] <br>Can be empty: False <br>Can be an empty string: True <br> |
| dimensions           | array    |            | List of dimension fields<br>Example: ['chan_xxx1', 'chan_xxx2'] <br>Can be empty: False <br>$minLength: 1 <br> |
| config               | json     | Y          | Issue definition configuration<br>Example: {} <br>Can be empty: False <br> |
| config.name          | string   | Y          | Title name<br>Example: name <br>Can be empty: False <br>Maximum length: 256 <br> |
| config.level         | string   |            | Level<br>Example: level <br>Can be empty: False <br>Can be an empty string: True <br> |
| config.channelUUIDs  | array    |            | List of channel UUIDs<br>Example: ['chan_xxx1', 'chan_xxx2'] <br>Can be empty: False <br> |
| config.description   | string   |            | Description<br>Example: description <br>Can be empty: False <br> |
| config.extend        | json     |            | Additional extension information, refer to the extend field in new issue creation, generally not recommended for OpenAPI side settings<br>Example: {} <br>Can be empty: True <br> |

## Additional Parameter Notes





## Request Example
```shell
curl 'https://openapi.guance.com/api/v1/issue_auto_discovery/iatdc_xxxxx/modify' \
-H 'Content-Type: application/json' \
-H 'DF-API-KEY: <DF-API-KEY>' \
--data-raw '{"name":"test-core-worker","description":"This is a test example for creating a new issue auto discovery rule","every":300,"dqlNamespace":"keyevent","conditions":"`source` = \"lwctest\"","dimensions":["name"],"config":{"name":"Title in issue definition","description":"Modified description in issue definition","level":"system_level_0","extend":{"text":"Modified description in issue definition","manager":["acnt_xxx"]},"channelUUIDs":["chan_xxxxx"]}}' \
--insecure
```




## Response
```shell
{
    "code": 200,
    "content": {
        "conditions": "`source` = \"lwctest\"",
        "config": {
            "channelUUIDs": [
                "chan_xxxxx"
            ],
            "description": "Modified description in issue definition",
            "extend": {
                "manager": [
                    "acnt_xxxx"
                ],
                "text": "Modified description in issue definition"
            },
            "level": "system_level_0",
            "name": "Title in issue definition"
        },
        "createAt": 1735893393,
        "creator": "wsak_xxxx",
        "declaration": {
            "organization": "xxx"
        },
        "deleteAt": -1,
        "description": "This is a test example for creating a new issue auto discovery rule",
        "dimensions": [
            "name"
        ],
        "dqlNamespace": "keyevent",
        "every": 300,
        "id": 47,
        "name": "test-core-worker",
        "status": 0,
        "updateAt": 1735893669.0875816,
        "updator": "wsak_xxxx",
        "uuid": "iatdc_xxxx",
        "workspaceUUID": "wksp_xxxxx"
    },
    "errorCode": "",
    "message": "",
    "success": true,
    "traceId": "1634728700182310814"
} 
```