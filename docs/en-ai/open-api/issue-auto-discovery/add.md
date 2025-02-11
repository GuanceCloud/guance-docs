# Create Auto Discovery Configuration

---

<br />**POST /api/v1/issue_auto_discovery/add**

## Overview




## Body Request Parameters

| Parameter Name        | Type     | Required   | Description              |
|:---------------------|:---------|:----------|:-------------------------|
| name | string | Y | Title name<br>Example: name <br>Allow null: False <br>Max length: 256 <br> |
| description | string |  | Description<br>Example: description <br>Allow null: False <br>Allow empty string: True <br> |
| dqlNamespace | string | Y | Data scope<br>Example: rum <br>Allow null: False <br>Optional values: ['keyevent'] <br> |
| every | integer | Y | Check frequency (in seconds)<br>Example: 300 <br>Allow null: False <br>$minValue: 300 <br>$maxValue: 3600 <br>Optional values: [300, 600, 900, 1800, 3600] <br> |
| conditions | string |  | Content within curly braces in the DQL query filter conditions<br>Example: `source` IN ['kube-controller'] <br>Allow null: False <br>Allow empty string: True <br> |
| dimensions | array |  | List of dimension fields<br>Example: ['chan_xxx1', 'chan_xxx2'] <br>Allow null: False <br>$minLength: 1 <br> |
| config | json | Y | Issue definition configuration<br>Example: {} <br>Allow null: False <br> |
| config.name | string | Y | Title name<br>Example: name <br>Allow null: False <br>Max length: 256 <br> |
| config.level | string |  | Level<br>Example: level <br>Allow null: False <br>Allow empty string: True <br> |
| config.channelUUIDs | array |  | List of channel UUIDs<br>Example: ['chan_xxx1', 'chan_xxx2'] <br>Allow null: False <br> |
| config.description | string |  | Description<br>Example: description <br>Allow null: False <br> |
| config.extend | json |  | Additional extension information, refer to the extend field in issue creation, generally not recommended to set from OpenAPI side<br>Example: {} <br>Allow null: True <br> |

## Additional Parameter Notes



## Request Example
```shell
curl 'https://openapi.guance.com/api/v1/issue_auto_discovery/add' \
-H 'Content-Type: application/json' \
-H 'DF-API-KEY: <DF-API-KEY>' \
--data-raw '{"name":"test-core-worker","description":"This is a test example for creating an auto-discovery rule for issues","every":300,"dqlNamespace":"keyevent","conditions":"`source` = \"lwctest\"","dimensions":["name"],"config":{"name":"Title in issue definition","description":"Description in issue definition","level":"system_level_0","extend":{"manager":["acnt_e52a5a7b6418464cb2acbeaa199e7fd1"]},"channelUUIDs":["chan_61367ab1e38744738eb0a219dbf8bac1"]}}' \
--insecure
```




## Response
```shell
{"code":200,"content":{"conditions":"`source` = \\"lwctest\\"","config":{"channelUUIDs":["chan_xxx"],"description":"Description in issue definition","extend":{"manager":["acnt_xxx"]},"level":"system_level_0","name":"Title in issue definition"},"createAt":1735893173,"creator":"wsak_xxxx","declaration":{"asd":"aa,bb,cc,1,True","asdasd":"dawdawd","business":"aaa","dd":"dd","fawf":"afawf","organization":"64fe7b4062f74d0007b46676"},"deleteAt":-1,"description":"This is a test example for creating an auto-discovery rule for issues","dimensions":["name"],"dqlNamespace":"keyevent","every":300,"id":null,"name":"test-core-worker","status":0,"updateAt":null,"updator":null,"uuid":"iatdc_xxxx","workspaceUUID":"wksp_xxxx"},"errorCode":"","message":"","success":true,"traceId":"4483644685680847012"} 
```