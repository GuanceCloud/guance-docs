# 【管理后台账号】修改

---

<br />**POST /api/v1/super-account/\{account_uuid\}/modify**

## 概述




## 路由参数

| 参数名        | 类型     | 必选   | 说明              |
|:-----------|:-------|:-----|:----------------|
| account_uuid | string | Y | 账号的UUID<br> |


## Body 请求参数

| 参数名        | 类型     | 必选   | 说明              |
|:-----------|:-------|:-----|:----------------|
| username | string |  | 登陆账号<br>例子: supper_man@zhuyun.com <br>允许为空: False <br> |
| password | string |  | 登陆密码<br>例子: I am password <br>允许为空: False <br> |
| email | None |  | 邮箱地址<br>例子: supper_man@zhuyun.com <br>允许为空: False <br>$isEmail: True <br> |
| name | string |  | 用户名<br>例子: supper_man <br>允许为空: False <br> |
| role | string |  | 登陆角色(admin/dev)<br>例子: admin <br>允许为空: False <br> |
| mobile | string |  | 手机号<br>允许为空: False <br> |
| exterId | string |  | 外部ID - 该参数未定 疑似剔除<br>允许为空: False <br> |
| extend | json |  | 额外信息<br>允许为空: False <br> |

## 参数补充说明







## 响应
```shell
 
```




