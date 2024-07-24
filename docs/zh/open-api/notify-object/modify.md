# 修改一个通知对象

---

<br />**POST /api/v1/notify_object/modify**

## 概述
修改指定的通知对象信息




## Body 请求参数

| 参数名        | 类型     | 必选   | 说明              |
|:-----------|:-------|:-----|:----------------|
| notifyObjectUUID | string | Y | 检查器UUID<br>允许为空: False <br> |
| name | string |  | 通知对象名字<br>允许为空: False <br> |
| optSet | json |  | 通知设置<br>允许为空: False <br> |
| permissionSet | array |  | 操作权限配置, 可配置(角色(除拥有者), 成员uuid, 团队uuid)<br>例子: ['wsAdmin', 'acnt_xxxx', 'group_yyyy'] <br>允许为空: False <br> |

## 参数补充说明







## 响应
```shell
 
```




