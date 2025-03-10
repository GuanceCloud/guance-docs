# Create Auto Discovery Configuration

---

<br />**POST /api/v1/issue_auto_discovery/add**

## Overview




## Body Request Parameters

| Parameter Name        | Type     | Required   | Description              |
|:---------------------|:---------|:----------|:------------------------|
| name | string | Y | Title Name<br>Example: name <br>Allow Null: False <br>Maximum Length: 256 <br> |
| description | string |  | Description<br>Example: description <br>Allow Null: False <br>Allow Empty String: True <br> |
| dqlNamespace | string | Y | Data Scope<br>Example: rum <br>Allow Null: False <br>Optional Values: ['keyevent'] <br> |
| every | integer | Y | Check Frequency (time length in seconds)<br>Example: 300 <br>Allow Null: False <br>$minValue: 300 <br>$maxValue: 3600 <br>Optional Values: [300, 600, 900, 1800, 3600] <br> |
| conditions | string |  | Content within curly braces in DQL query filter conditions<br>Example:  `source` IN ['kube-controller']  <br>Allow Null: False <br>Allow Empty String: True <br> |
| dimensions | array |  | List of Dimension Fields<br>Example: ['chan_xxx1', 'chan_xxx2'] <br>Allow Null: False <br>$minLength: 1 <br> |
| config | json | Y | Issue Definition Configuration<br>Example: {} <br>Allow Null: False <br> |
| config.name | string | Y | Title Name<br>Example: name <br>Allow Null: False <br>Maximum Length: 256 <br> |
| config.level | string |  | Level<br>Example: level <br>Allow Null: False <br>Allow Empty String: True <br> |
| config.channelUUIDs | array |  | List of Channel UUIDs<br>Example: ['chan_xxx1', 'chan_xxx2'] <br>Allow Null: False <br> |
| config.description | string |  | Description<br>Example: description <br>Allow Null: False <br> |
| config.extend | json |  | Additional Extended Information. Refer to the extend field in issue creation; generally not recommended to set via OpenAPI.<br>Example: {} <br>Allow Null: True <br> |

## Additional Parameter Notes





## Request Example
```shell
curl 'https://openapi.<<< custom_key.brand_main_domain >>>/api/v1/issue_auto_discovery/add' \
-H 'Content-Type: application/json' \
-H 'DF-API-KEY: <DF-API-KEY>' \
--data-raw '{"name":"test-core-worker","description":"This is an example for creating a new issue auto discovery rule","every":300,"dqlNamespace":"keyevent","conditions":"`source` = \"lwctest\"","dimensions":["name"],"config":{"name":"Title in issue definition","description":"Description information in issue definition","level":"system_level_0","extend":{"manager":["acnt_e52a5a7b6418464cb2acbeaa199e7fd1"]},"channelUUIDs":["chan_61367ab1e38744738eb0a219dbf8bac1"]}}' \
--insecure
```




## Response
```shell
{"code":200,"content":{"conditions":"`source` = \\"lwctest\\"","config":{"channelUUIDs":["chan_xxx"],"description":"Description information in issue definition","extend":{"manager":["acnt_xxx"]},"level":"system_level_0","name":"Title in issue definition"},"createAt":1735893173,"creator":"wsak_xxxx","declaration":{"asd":"aa,bb,cc,1,True","asdasd":"dawdawd","business":"aaa","dd":"dd","fawf":"afawf","organization":"64fe7b4062f74d0007b46676"},"deleteAt":-1,"description":"This is an example for creating a new issue auto discovery rule","dimensions":["name"],"dqlNamespace":"keyevent","every":300,"id":null,"name":"test-core-worker","status":0,"updateAt":null,"updator":null,"uuid":"iatdc_xxxx","workspaceUUID":"wksp_xxxx"},"errorCode":"","message":"","success":true,"traceId":"4483644685680847012"} 
```