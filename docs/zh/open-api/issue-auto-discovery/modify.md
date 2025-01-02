# 修改自动发现配置

---

<br />**POST /api/v1/issue_auto_discovery/\{cfg_uuid\}/modify**

## 概述




## 路由参数

| 参数名        | 类型     | 必选   | 说明              |
|:-----------|:-------|:-----|:----------------|
| cfg_uuid | string | Y | Issue 自动发现配置UUID<br> |


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
| config.extend | json |  | 额外拓展信息<br>例子: {} <br>允许为空: True <br> |

## 参数补充说明







## 响应
```shell
 
```




