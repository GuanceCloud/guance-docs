# 【管理后台账号】创建

---

<br />**POST /api/v1/super-account/create**

## 概述




## Body 请求参数

| 参数名        | 类型     | 必选   | 说明              |
|:-----------|:-------|:-----|:----------------|
| username | string | Y | 登陆账号<br>例子: supper_man@zhuyun.com <br>允许为空: False <br> |
| password | string | Y | 登陆密码<br>例子: I am password <br>允许为空: False <br> |
| email | None |  | 邮箱地址<br>例子: supper_man@zhuyun.com <br>允许为空: False <br>$isEmail: True <br> |
| name | string |  | 昵称<br>例子: supper_man <br>允许为空: False <br> |
| role | string | Y | 登陆角色(admin/dev)<br>例子: admin <br>允许为空: False <br> |
| mobile | string |  | 手机号<br>允许为空: False <br> |
| extend | json |  | 额外信息<br>允许为空: False <br> |
| language | string |  | 语言信息<br>允许为空: True <br>允许空字符串: True <br> |
| isDisable | boolean |  | 是否禁用<br>例子: True <br>允许为空: False <br>可选值: [True, False] <br> |

## 参数补充说明







## 响应
```shell
 
```




