# 【工作空间】创建

---

<br />**POST /api/v1/workspace/create**

## 概述




## Body 请求参数

| 参数名        | 类型     | 必选   | 说明              |
|:-----------|:-------|:-----|:----------------|
| isOpenCustomMappingRule | boolean |  | 是否开启自定义映射规则<br>例子: 0 <br>允许为空: False <br> |
| maxSearchResultCount | integer |  | 最大搜索结果数量<br>例子: 0 <br>允许为空: False <br> |
| name | string | Y | 名称<br>例子: supper_workspace <br>允许为空: False <br>最大长度: 256 <br> |
| esIndexMerged | boolean |  | 是否聚合索引, 默认为 true<br>例子: False <br>允许为空: False <br> |
| leftWildcard | boolean |  | 是否开启左*匹配, 默认为 false，即关闭状态<br>例子: False <br>允许为空: False <br> |
| isOpenLogMultipleIndex | boolean |  | 是否开启日志多索引配置, 默认为 true，即关闭状态<br>例子: False <br>允许为空: False <br> |
| logMultipleIndexCount | int |  | 开启日志多索引配置后个日志多索引个数限制, 空间级别<br>例子: 3 <br>允许为空: False <br> |
| loggingCutSize | int |  | 超大日志切割单位,传输到位使用byte<br>例子: False <br>允许为空: False <br> |
| storageTypeUUID | string |  | 对应非主存储存储类型的uuid<br>例子: uuid_xxxxxxxx <br>允许为空: True <br> |
| durationSet | object |  | 数据保留时长信息<br> |
| durationSet.rp | string |  | 时间线RP的duration<br>例子: 30d <br>允许为空: False <br> |
| durationSet.logging | string |  | 日志RP的duration<br>例子: 14d <br>允许为空: False <br> |
| durationSet.backup_log | string |  | 备份日志的duration<br>例子: 180d <br>允许为空: False <br> |
| durationSet.security | string |  | 巡检数据的duration<br>例子: 90d <br>允许为空: False <br> |
| durationSet.keyevent | string |  | 事件RP的duration<br>例子: 14d <br>允许为空: False <br> |
| durationSet.tracing | string |  | tracing的duration<br>例子: 7d <br>允许为空: False <br> |
| durationSet.rum | string |  | rum的duration<br>例子: 7d <br>允许为空: False <br> |
| durationSet.apm | string |  | apm的duration(合并索引情况下有效)<br>例子: 7d <br>允许为空: False <br> |
| ownerUuid | string | Y | command<br>允许空字符串: False <br>例子: uuid-001 <br> |
| language | string |  | 语言信息<br>允许为空: True <br>允许空字符串: True <br>可选值: ['zh', 'en'] <br> |

## 参数补充说明







## 响应
```shell
 
```




