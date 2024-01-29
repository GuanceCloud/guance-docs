# 创建一个 SLO

---

<br />**POST /api/v1/slo/add**

## 概述




## Body 请求参数

| 参数名        | 类型     | 必选   | 说明              |
|:-----------|:-------|:-----|:----------------|
| name | string | Y | SLO 名称<br>允许为空: False <br>最大长度: 256 <br> |
| interval | string | Y | 检测频率<br>允许为空: False <br>可选值: ['5m', '10m'] <br>例子: 5m <br> |
| goal | float | Y | SLO 预期⽬标<br>允许为空: False <br>$greaterThanValue: 0 <br>$lessThanValue: 100 <br>例子: 90.0 <br> |
| minGoal | float | Y | SLO 最低⽬标<br>允许为空: False <br>$greaterThanValue: 0 <br>$lessThanValue: 100 <br>例子: 85.0 <br> |
| sliUUIDs | array | Y | SLI 的 UUID 列表<br>允许为空: False <br>例子: ['rul-aaaaaa', 'rul-bbbbbb'] <br> |
| alertOpt | json | Y | 告警设置<br>允许为空: False <br> |
| alertOpt.silentTimeout | integer | Y | 通知沉默<br>允许为空: False <br>可选值: [900, 1800, 3600, 21600, 43200, 86400] <br>例子: 900 <br> |
| alertOpt.alertTarget | array | Y | 告警通知对象<br>允许为空: False <br>例子: ['notify_aaaaaa', 'notify_bbbbbb'] <br> |
| describe | string |  | slo分组描述信息<br>例子: 这是一个例子 <br>允许为空: False <br>允许空字符串: True <br>最大长度: 3000 <br> |

## 参数补充说明

**参数说明**

| 参数名 | type| 必选 | 说明|
| :---- | :-- | :--- | :------- |
| name      | String| 必选| slo 名称|
| interval  | String| 必选| 检测频率，参数范围：5m、10m|
| goal      | Float | 必须| 目标 取值范围： 0-100，不包括 0、100|
| minGoal   | Float | 必须| 最低目标, 取值范围： 0-100，不包括 0、100，且小于 goal|
| sliUUIDs  | Array[String]| 必须 | SLI 的 uuid 列表（监控器 uuid 列表）|
| alertOpt  | Dict | 必选 | 告警设置|
| alertOpt[#].silentTimeout | integer | 必选 | 通知沉默, 单位秒，参数范围：900, 1800, 3600, 21600, 43200, 86400 |
| alertOpt[#].alertTarget   | Array | 必选 | 告警通知对象|
| describe  | String |  | 描述 |

** 相关 OpenAPI 接口 **

- sliUUIDs，SLI 的 uuid 列表 参考：监控 - 监控器 - 获取监控器列表（可以指定 search 参数根据监控器名称搜索，其他参数省略）取监控器 uuid 字段
- alertOpt[#].alertTarget，告警通知对象 参考：监控 - 通知对象管理 - 获取通知对象列表






## 响应
```shell
 
```




