# 账号-修改

---

<br />**POST /api/v1/account/\{account_uuid\}/modify**

## 概述




## 路由参数

| 参数名        | 类型     | 必选   | 说明              |
|:-----------|:-------|:-----|:----------------|
| account_uuid | string | Y | 账号的UUID<br> |


## Body 请求参数

| 参数名        | 类型     | 必选   | 说明              |
|:-----------|:-------|:-----|:----------------|
| name | string |  | 昵称<br>例子: supper_man <br>允许为空: False <br> |
| mobile | string |  | 手机号<br>例子: 18621000000 <br>允许为空: False <br>允许空字符串: True <br> |
| username | string |  | 登录账号<br>例子: username <br>允许为空: False <br> |
| email | string |  | 邮箱<br>例子: email <br>允许为空: False <br>允许空字符串: True <br>最大长度: 256 <br> |
| password | string |  | 密码<br>例子: xxxx <br>允许为空: False <br> |
| tokenHoldTime | integer |  | 无操作会话保持时长(秒级单位, 默认1440分钟, 86400秒)<br>例子: 604800 <br>允许为空: False <br>允许空字符串: False <br>$minValue: 1800 <br>$maxValue: 604800 <br> |
| tokenMaxValidDuration | integer |  | 登录会话最大保持时长(秒级单位, 默认7天, 604800秒)<br>例子: 2592000 <br>允许为空: False <br>允许空字符串: False <br>$minValue: 60 <br>$maxValue: 2592000 <br> |
| attributes | json |  | 账号的属性信息(json结构, KV结构, V部分尽量使用字符串)<br>例子: {'部门': 'A部门'} <br>允许为空: False <br> |

## 参数补充说明







## 响应
```shell
 
```




