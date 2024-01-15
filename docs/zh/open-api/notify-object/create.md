# 创建一个通知对象

---

<br />**POST /api/v1/notify_object/create**

## 概述
创建一个通知对象




## Body 请求参数

| 参数名        | 类型     | 必选   | 说明              |
|:-----------|:-------|:-----|:----------------|
| type | string | Y | 触发规则类型, 默认为`trigger`<br>允许为空: True <br>可选值: ['dingTalkRobot', 'HTTPRequest', 'wechatRobot', 'mailGroup', 'feishuRobot', 'sms', 'sampleHTTPRequest'] <br> |
| name | string | Y | 通知对象名字<br>允许为空: False <br> |
| optSet | json |  | 告警设置<br>允许为空: False <br> |

## 参数补充说明


*数据说明.*


**1. `type`=`dingTalkRobot` optSet的参数 **

| key      | 类型   | 是否必须 | 说明    |
| :------- | :----- | :------- | :------------------ |
| webhook  | String | 必须    | 钉钉机器⼈调⽤地址 |
| secret   | String | 必须    | 钉钉机器⼈调⽤密钥（添加机器⼈-安全设置-加签） |


**2. `type`=`HTTPRequest` 时，optSet的参数 **

| key      | 类型   | 是否必须 | 说明  |
| :------- | :----- | :------- | :----------- |
| url      | String | 必须 | HTTP 调⽤地址 |


**3. `type`=`wechatRobot` 时，optSet的参数 **

| key      | 类型   | 是否必须 | 说明  |
| :------- | :----- | :------- | :----------- |
| webhook  | String | 必须    | 机器⼈调⽤地址 |

**4. `type`=`mailGroup` 时，optSet的参数 **

| key      | 类型   | 是否必须 | 说明  |
| :------- | :----- | :------- | :----------- |
| to  | Array | 必须    | 成员账号列表 |

**5. `type`=`feishuRobot` optSet的参数 **

| key      | 类型   | 是否必须 | 说明    |
| :------- | :----- | :------- | :------------------ |
| webhook  | String | 必须    | 飞书机器⼈调⽤地址 |
| secret   | String | 必须    | 飞书机器⼈调⽤密钥（添加机器⼈-安全设置-加签） |

**6. `type`=`sms` 时，optSet的参数 **

 | key      | 类型   | 是否必须 | 说明  |
 | :------- | :----- | :------- | :----------- |
 | to  | Array | 必须    | 手机号码列表 |

**7. `type`=`sampleHTTPRequest` 时，optSet的参数 **

| key      | 类型   | 是否必须 | 说明  |
| :------- | :----- | :------- | :----------- |
| url      | String | 必须 | HTTP 调⽤地址 |






## 响应
```shell
 
```




