# 【账号】新增

---

<br />**POST /api/v1/account/add**

## 概述




## Body 请求参数

| 参数名        | 类型     | 必选   | 说明              |
|:-----------|:-------|:-----|:----------------|
| username | string | Y | 登陆账号名(不存在exterId时, 该字段值唯一)<br>例子: test_wang <br>允许为空: True <br>允许空字符串: True <br> |
| password | string | Y | 登陆密码(密码为空字符串时,第三方登录账号应设置密码未空字符串)<br>例子: I am password <br>允许空字符串: True <br>允许为空: True <br> |
| name | string | Y | 昵称<br>例子: test_wang <br>允许为空: False <br>允许空字符串: False <br> |
| email | string | Y | 用户邮箱<br>例子: test_wang@xx.com <br>允许为空: False <br>允许空字符串: True <br>$isEmail: True <br> |
| mobile | string |  | 手机号<br>例子: 1762xxx9836 <br>允许为空: False <br>允许空字符串: False <br> |
| exterId | string |  | 第三方账号系统的唯一标识ID, 当前字段存在时,该字段值唯一(username 字段允许重复)<br>例子: 29ab8d31-ac52-4485-a572-f4cf25d355d9 <br>允许为空: False <br>允许空字符串: False <br> |
| extend | json |  | 额外信息<br>允许为空: True <br> |
| language | string |  | 语言信息<br>允许为空: True <br>允许空字符串: True <br> |
| isDisable | boolean |  | 是否禁用<br>例子: True <br>允许为空: False <br>可选值: [True, False] <br> |

## 参数补充说明







## 响应
```shell
 
```




