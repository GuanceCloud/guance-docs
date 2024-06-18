# 【免登录Token】生成token

---

<br />**POST /api/v1/offline_token/temporary_token/create**

## 概述
生成访问token
使用方式: 
1. 页面`url`上添加参数: `gc_route_token=xxxx`; 注意如果是跨域 iframe 嵌套可能会有第三方 cookie 拦截跨域问题。
2. 如果不涉及到页面跳转。页面`url`上添加参数: `ftAuthToken=xxx`。




## Body 请求参数

| 参数名        | 类型     | 必选   | 说明              |
|:-----------|:-------|:-----|:----------------|
| roles | array |  | 角色列表<br>例子: ['readOnly'] <br>允许为空: False <br> |
| roles[*] | string | Y | 角色标识<br>允许为空: False <br>可选值: ['readOnly'] <br> |
| expires | integer | Y | toke多久失效(单位 秒)<br>例子: 3600 <br>允许为空: False <br>$maxValue: 604800 <br>$minValue: 1 <br> |

## 参数补充说明

*参数说明*

--------------

1.支持的角色列表

|  角色标识        |   角色名  |
|---------------|----------|
| readOnly    | 只读角色 |






## 响应
```shell
 
```




