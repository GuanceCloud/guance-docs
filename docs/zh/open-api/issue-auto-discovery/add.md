# 新建自动发现配置

---

<br />**POST /api/v1/issue_auto_discovery/add**

## 概述




## Body 请求参数

| 参数名        | 类型     | 必选   | 说明              |
|:-----------|:-------|:-----|:----------------|
| name | string | Y | 标题名称<br>例子: name <br>允许为空: False <br>最大长度: 256 <br> |
| description | string |  | 描述<br>例子: description <br>允许为空: False <br>允许为空字符串: True <br> |
| dqlNamespace | string | Y | 数据范围<br>例子: rum <br>允许为空: False <br>可选值: ['keyevent'] <br> |
| every | integer | Y | 检查频率(以秒为单位的时间长度)<br>例子: 300 <br>允许为空: False <br>$minValue: 300 <br>$maxValue: 3600 <br>可选值: [300, 600, 900, 1800, 3600] <br> |
| conditions | string |  | dql查询过滤条件 中的 花括号内容部分<br>例子:  `source` IN ['kube-controller']  <br>允许为空: False <br>允许为空字符串: True <br> |
| dimensions | array |  | 维度字段列表<br>例子: ['chan_xxx1', 'chan_xxx2'] <br>允许为空: False <br>$minLength: 1 <br> |
| config | json | Y | Issue定义配置<br>例子: {} <br>允许为空: False <br> |
| config.name | string | Y | 标题名称<br>例子: name <br>允许为空: False <br>最大长度: 256 <br> |
| config.level | string |  | 等级<br>例子: level <br>允许为空: False <br>允许为空字符串: True <br> |
| config.channelUUIDs | array |  | 频道UUID列表<br>例子: ['chan_xxx1', 'chan_xxx2'] <br>允许为空: False <br> |
| config.description | string |  | 描述<br>例子: description <br>允许为空: False <br> |
| config.extend | json |  | 额外拓展信息,可参考 issue 新建中的 extend 字段，一般不建议OpenAPI侧进行设置<br>例子: {} <br>允许为空: True <br> |

## 参数补充说明





## 请求例子
```shell
curl 'https://openapi.<<< custom_key.brand_main_domain >>>/api/v1/issue_auto_discovery/add' \
-H 'Content-Type: application/json' \
-H 'DF-API-KEY: <DF-API-KEY>' \
--data-raw '{"name":"test-core-worker","description":"这是一个新建issue自动发现规则测试例子","every":300,"dqlNamespace":"keyevent","conditions":"`source` = \"lwctest\"","dimensions":["name"],"config":{"name":"这是issue定义中的标题","description":"这是issue定义中的描述信息","level":"system_level_0","extend":{"manager":["acnt_e52a5a7b6418464cb2acbeaa199e7fd1"]},"channelUUIDs":["chan_61367ab1e38744738eb0a219dbf8bac1"]}}' \
--insecure
```




## 响应
```shell
{"code":200,"content":{"conditions":"`source` = \\"lwctest\\"","config":{"channelUUIDs":["chan_xxx"],"description":"这是issue定义中的描述信息","extend":{"manager":["acnt_xxx"]},"level":"system_level_0","name":"这是issue定义中的标题"},"createAt":1735893173,"creator":"wsak_xxxx","declaration":{"asd":"aa,bb,cc,1,True","asdasd":"dawdawd","business":"aaa","dd":"dd","fawf":"afawf","organization":"64fe7b4062f74d0007b46676"},"deleteAt":-1,"description":"这是一个新建issue自动发现规则测试例子","dimensions":["name"],"dqlNamespace":"keyevent","every":300,"id":null,"name":"test-core-worker","status":0,"updateAt":null,"updator":null,"uuid":"iatdc_xxxx","workspaceUUID":"wksp_xxxx"},"errorCode":"","message":"","success":true,"traceId":"4483644685680847012"} 
```




