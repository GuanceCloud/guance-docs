# 获取一个通知对象信息

---

<br />**GET /api/v1/notify_object/get**

## 概述
获取指定的通知对象信息




## Query 请求参数

| 参数名        | 类型     | 必选   | 说明              |
|:-----------|:-------|:-----|:----------------|
| notifyObjectUUID | string | Y | 通知对象UUID<br> |

## 参数补充说明

**返回字段说明**
forbiddenOperation 字段, True 表示当前用户不允许, 修改/删除等更新操作, False允许操作,  没该字段(老数据返回没有该字段)默认允许操作
permissionSetInfo字段(permissionSet对应的信息)






## 响应
```shell
 
```




