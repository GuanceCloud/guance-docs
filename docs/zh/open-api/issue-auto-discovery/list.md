# 列表自动发现配置

---

<br />**GET /api/v1/issue_auto_discovery/list**

## 概述




## Query 请求参数

| 参数名        | 类型     | 必选   | 说明              |
|:-----------|:-------|:-----|:----------------|
| dqlNamespace | string |  | 数据范围,多值以英文逗号分隔<br>例子: keyevent <br>允许为空: False <br> |
| isDisable | string |  | 筛选条件<br>例子: [] <br>允许为空: False <br>可选值: ['true', 'false'] <br> |
| search | string |  | 根据规则名称搜索<br>例子: xxxxx_text <br>允许为空: False <br>允许为空字符串: True <br> |
| pageSize | integer |  | 每页返回数量<br>允许为空: False <br>例子: 10 <br> |
| pageIndex | integer |  | 页码<br>允许为空: False <br>例子: 10 <br> |

## 参数补充说明





## 请求例子
```shell      
curl 'https://openapi.guance.com/api/v1/issue_auto_discovery/list?search=test' \
-H 'Content-Type: application/json' \
-H 'DF-API-KEY: <DF-API-KEY>' \
--insecure
```




## 响应
```shell
{"code":200,"content":{"data":[{"conditions":"`df_fault_id` = \\"event-xxxxxx\\"","config":{"channelUUIDs":["chan_xxxxx","chan_xxxxx"],"description":"desc<span data-at-embedded=\\"\\" data-insert-by=\\"@\\" data-info=\\"{&quot;item&quot;:{&quot;uuid&quot;:&quot;acnt_xxxx&quot;,&quot;name&quot;:&quot;gtf&quot;}}\\" contenteditable=\\"false\\">&nbsp;<span data-v-18fda946=\\"\\"><span data-v-18fda946=\\"\\" class=\\"key-word\\">@feifei</span></span>&nbsp;</span><span data-at-embedded=\\"\\" data-insert-by=\\"#\\" data-info=\\"{&quot;item&quot;:{&quot;uuid&quot;:&quot;chan_xxxxx&quot;,&quot;name&quot;:&quot;gary-test-0805&quot;}}\\" contenteditable=\\"false\\">&nbsp;<span data-v-18fda946=\\"\\"><span data-v-18fda946=\\"\\"><span data-v-18fda946=\\"\\" class=\\"key-word\\">#gary-test-0805</span></span></span>&nbsp;</span><span data-at-embedded=\\"\\" data-insert-by=\\"{{\\" data-info=\\"{&quot;item&quot;:{&quot;uuid&quot;:&quot;&quot;,&quot;name&quot;:&quot;df_fault_id&quot;}}\\" contenteditable=\\"false\\">&nbsp;<span data-v-18fda946=\\"\\"><span data-v-18fda946=\\"\\" class=\\"key-word\\">{{df_fault_id}}</span></span>&nbsp;</span>","extend":{"channels":[{"name":"gary-test-0805","type":"#","uuid":"chan_xxxxx"}],"manager":["group_xxxx"],"members":[{"name":"gtf","type":"@","uuid":"acnt_xxxx"}],"templates":["df_fault_id"],"text":"desc @feifei  #gary-test-0805  {{df_fault_id}}"},"level":"isslm_xxxxx","name":"123456"},"createAt":1724037276,"creator":"acnt_xxxx","creatorInfo":{"acntWsNickname":"feifei","email":"xxx@xxx.com","iconUrl":"","mobile":"","name":"gtf","status":0,"username":"xxx@xxx.com","uuid":"acnt_xxxx","wsAccountStatus":0},"deleteAt":-1,"description":"123","dimensions":["df_fault_id","df_label","host"],"dqlNamespace":"keyevent","every":300,"id":8,"name":"gary-test-0819gary-test-0819","status":2,"updateAt":1725351809,"updator":"acnt_xxxx","updatorInfo":{"acntWsNickname":"","email":"xx@xx.com","iconUrl":"","mobile":"13900079876","name":"hzyyasdaw","status":0,"username":"xx@xx.com","uuid":"acnt_xxxx","wsAccountStatus":0},"uuid":"iatdc_xxxx","workspaceUUID":"wksp_xxxxxxx"}],"declaration":{"organization":"xxx"}},"errorCode":"","message":"","pageInfo":{"count":1,"pageIndex":1,"pageSize":20,"totalCount":1},"success":true,"traceId":"18175587987203682138"} 
```




