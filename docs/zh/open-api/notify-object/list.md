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

**响应体参数说明**

| 参数名           | type | 说明                                                 |
| ---------------- | ---- | ---------------------------------------------------- |
| allow_operation       | boolean/None | True: 表示允许当前用户 修改/删除等更新操作, False: 不允许, None: 表示将遵循接口操作权限 |
| permissionSetInfo    | dict | 自定义操作配置相关信息                          |






## 响应
```shell
 
```




