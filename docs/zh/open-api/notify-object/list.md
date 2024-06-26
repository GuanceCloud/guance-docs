# 获取通知对象列表

---

<br />**GET /api/v1/notify_object/list**

## 概述
分页获取通知对象列表




## Query 请求参数

| 参数名        | 类型     | 必选   | 说明              |
|:-----------|:-------|:-----|:----------------|
| search | string |  | 搜索通知对象名字<br>允许为空: True <br> |
| pageIndex | integer |  | 页码<br>允许为空: False <br>例子: 1 <br>$minValue: 1 <br> |
| pageSize | integer |  | 每页返回数量<br>允许为空: False <br>例子: 10 <br>$minValue: 1 <br>$maxValue: 100 <br> |

## 参数补充说明

**返回字段说明**
forbiddenOperation 字段, True 表示当前用户不允许, 修改/删除等更新操作, False允许操作,  没该字段(老数据返回没有该字段)默认允许操作
permissionSetInfo字段(permissionSet对应的信息)






## 响应
```shell
 
```




