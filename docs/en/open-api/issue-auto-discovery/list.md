# Auto-Discovery List Configuration

---

<br />**GET /api/v1/issue_auto_discovery/list**

## Overview




## Query Request Parameters

| Parameter Name        | Type     | Required   | Description              |
|:---------------------|:---------|:-----------|:------------------------|
| dqlNamespace         | string   |            | Data scope, multiple values separated by English commas<br>Example: keyevent <br>Can be empty: False <br> |
| isDisable           | string   |            | Filter condition<br>Example: [] <br>Can be empty: False <br>Optional values: ['true', 'false'] <br> |
| search              | string   |            | Search by rule name<br>Example: xxxxx_text <br>Can be empty: False <br>Can be an empty string: True <br> |
| pageSize            | integer  |            | Number of items returned per page<br>Can be empty: False <br>Example: 10 <br> |
| pageIndex           | integer  |            | Page number<br>Can be empty: False <br>Example: 10 <br> |

## Additional Parameter Notes





## Request Example
```shell      
curl 'https://openapi.<<< custom_key.brand_main_domain >>>/api/v1/issue_auto_discovery/list?search=test' \
-H 'Content-Type: application/json' \
-H 'DF-API-KEY: <DF-API-KEY>' \
--insecure
```




## Response
```shell
{"code":200,"content":{"data":[{"conditions":"`df_fault_id` = \\"event-xxxxxx\\"","config":{"channelUUIDs":["chan_xxxxx","chan_xxxxx"],"description":"desc<span data-at-embedded=\\"\\" data-insert-by=\\"@\\" data-info=\\"{&quot;item&quot;:{&quot;uuid&quot;:&quot;acnt_xxxx&quot;,&quot;name&quot;:&quot;gtf&quot;}}\\" contenteditable=\\"false\\">&nbsp;<span data-v-18fda946=\\"\\"><span data-v-18fda946=\\"\\" class=\\"key-word\\">@feifei</span></span>&nbsp;</span><span data-at-embedded=\\"\\" data-insert-by=\\"#\\" data-info=\\"{&quot;item&quot;:{&quot;uuid&quot;:&quot;chan_xxxxx&quot;,&quot;name&quot;:&quot;gary-test-0805&quot;}}\\" contenteditable=\\"false\\">&nbsp;<span data-v-18fda946=\\"\\"><span data-v-18fda946=\\"\\"><span data-v-18fda946=\\"\\" class=\\"key-word\\">#gary-test-0805</span></span></span>&nbsp;</span><span data-at-embedded=\\"\\" data-insert-by=\\"{{\\" data-info=\\"{&quot;item&quot;:{&quot;uuid&quot;:&quot;&quot;,&quot;name&quot;:&quot;df_fault_id&quot;}}\\" contenteditable=\\"false\\">&nbsp;<span data-v-18fda946=\\"\\"><span data-v-18fda946=\\"\\" class=\\"key-word\\">{df_fault_id}</span></span>&nbsp;</span>","extend":{"channels":[{"name":"gary-test-0805","type":"#","uuid":"chan_xxxxx"}],"manager":["group_xxxx"],"members":[{"name":"gtf","type":"@","uuid":"acnt_xxxx"}],"templates":["df_fault_id"],"text":"desc @feifei  #gary-test-0805  {df_fault_id}"},"level":"isslm_xxxxx","name":"123456"},"createAt":1724037276,"creator":"acnt_xxxx","creatorInfo":{"acntWsNickname":"feifei","email":"xxx@<<< custom_key.brand_main_domain >>>","iconUrl":"","mobile":"","name":"gtf","status":0,"username":"xxx@<<< custom_key.brand_main_domain >>>","uuid":"acnt_xxxx","wsAccountStatus":0},"deleteAt":-1,"description":"123","dimensions":["df_fault_id","df_label","host"],"dqlNamespace":"keyevent","every":300,"id":8,"name":"gary-test-0819gary-test-0819","status":2,"updateAt":1725351809,"updator":"acnt_xxxx","updatorInfo":{"acntWsNickname":"","email":"xxx@<<< custom_key.brand_main_domain >>>","iconUrl":"","mobile":"13900079876","name":"hzyyasdaw","status":0,"username":"xxx@<<< custom_key.brand_main_domain >>>","uuid":"acnt_xxxx","wsAccountStatus":0},"uuid":"iatdc_xxxx","workspaceUUID":"wksp_xxxxxxx"}],"declaration":{"organization":"xxx"}},"errorCode":"","message":"","pageInfo":{"count":1,"pageIndex":1,"pageSize":20,"totalCount":1},"success":true,"traceId":"18175587987203682138"} 
```