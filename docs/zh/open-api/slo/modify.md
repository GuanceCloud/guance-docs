# 修改某个 SLO

---

<br />**POST /api/v1/slo/\{slo_uuid\}/modify**

## 概述




## 路由参数

| 参数名        | 类型     | 必选   | 说明              |
|:-----------|:-------|:-----|:----------------|
| slo_uuid | string | Y | 检查器 UUID<br>允许为空: False <br> |


## Body 请求参数

| 参数名        | 类型     | 必选   | 说明              |
|:-----------|:-------|:-----|:----------------|
| interval | string |  | 检测频率<br>允许为空: False <br>可选值: ['5m', '10m'] <br>例子: 5m <br> |
| sliUUIDs | array |  | SLI 的 UUID 列表<br>允许为空: False <br>例子: ['rul-aaaaaa', 'rul-bbbbbb'] <br> |
| alertOpt | json |  | 告警设置<br>允许为空: False <br> |
| alertOpt.silentTimeout | integer | Y | 通知沉默<br>允许为空: False <br>可选值: [900, 1800, 3600, 21600, 43200, 86400] <br>例子: 900 <br> |
| alertOpt.alertTarget | array | Y | 告警通知对象<br>允许为空: False <br>例子: ['notify_aaaaaa', 'notify_bbbbbb'] <br> |
| describe | string |  | SLO 描述信息<br>例子: 这是一个例子 <br>允许为空: False <br>允许空字符串: True <br>最大长度: 3000 <br> |

## 参数补充说明

**参数说明**

`alertOpt` 是非必选参数，但如果需要修改 `alertOpt` 就必须设置 `alertOpt.silentTimeout`、`alertOpt.alertTarget`






## 响应
```shell
 
```




