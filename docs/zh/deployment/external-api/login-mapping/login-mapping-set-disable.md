# 【Login Mapping】开关状态设置

---

<br />**POST /api/v1/login_mapping/set_disable**

## 概述




## Body 请求参数

| 参数名        | 类型     | 必选   | 说明              |
|:-----------|:-------|:-----|:----------------|
| isDisable | boolean |  | 是否禁用<br>例子: True <br>允许为空: False <br>可选值: [True, False] <br> |
| type | string |  | 启用状态下作用范围类型<br>例子: True <br>允许为空: False <br>可选值: ['ValidOnFirstLogin', 'GlobalValid'] <br> |

## 参数补充说明

* type 参数说明*

|可选值|说明|
|:------|:----------------|
| ValidOnFirstLogin | 表示启用映射配置情况下, 映射配置只在用户首次登录时有效 |
| GlobalValid | 表示启用映射配置情况下, 映射配置在用户每次登录时有效; 作为默认值 |






## 响应
```shell
 
```




