# 创建一个通知对象

---

<br />**POST /api/v1/notify_object/create**

## 概述
创建一个通知对象




## Body 请求参数

| 参数名        | 类型     | 必选   | 说明              |
|:-----------|:-------|:-----|:----------------|
| type | string | Y | 触发规则类型, 默认为`trigger`<br>允许为空: True <br>可选值: ['dingTalkRobot', 'HTTPRequest', 'wechatRobot', 'mailGroup', 'feishuRobot', 'sms', 'simpleHTTPRequest', 'slackIncomingWebhook'] <br> |
| name | string | Y | 通知对象名字<br>允许为空: False <br> |
| optSet | json |  | 告警设置<br>允许为空: False <br> |
| openPermissionSet | boolean |  | 开启 自定义权限配置, (默认 false:不开启), 开启后 该规则的操作权限根据 permissionSet<br>允许为空: False <br> |
| permissionSet | array |  | 操作权限配置, 可配置(角色(除拥有者), 成员uuid, 团队uuid)<br>例子: ['wsAdmin', 'acnt_xxxx', 'group_yyyy'] <br>允许为空: False <br> |

## 参数补充说明


*数据说明.*

**请求参数说明: **
| 参数名           | type | 说明                                                 |
| ---------------- | ---- | ---------------------------------------------------- |
| name       | string | 通知对象名称 |
| type             | string | 触发规则类型                                                 |
| optSet             | dict | 告警设置                                                 |
| openPermissionSet             | boolean | 是否开启自定义权限配置, 默认 false                                                 |
| permissionSet             | array | 操作权限配置                                                 |

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

**7. `type`=`simpleHTTPRequest` 时，optSet的参数 **

| key      | 类型   | 是否必须 | 说明  |
| :------- | :----- | :------- | :----------- |
| url      | String | 必须 | HTTP 调⽤地址 |

**8. `type`=`slackIncomingWebhook` 时，optSet的参数 **

| key      | 类型   | 是否必须 | 说明  |
| :------- | :----- | :------- | :----------- |
| webhook  | String | 必须    | 机器⼈调⽤地址 |

**permissionSet, openPermissionSet 字段说明(2024-06-26迭代新增字段): **
通知对象配置 openPermissionSet 开启后,  只有空间拥有者 和属于 permissionSet 配置中的 角色, 团队, 成员才能进行编辑/删除
通知对象配置 openPermissionSet 关闭后(默认), 则删除/编辑权限 遵循 原有接口编辑/删除权限

permissionSet 字段可配置, 角色 UUID(wsAdmin,general, readOnly, role_xxxxx ), 团队 UUID(group_yyyy), 成员 UUID(acnt_xxx)
permissionSet 字段示例:
```
  ["wsAdmin", "general", "group_yyyy", "acnt_xxxx"]

```






## 响应
```shell
 
```




