# 修改某台主机一个/多个label

---

<br />**POST /api/v1/object/hosts/\{host\}/label/modify**

## 概述
修改某台主机一个/多个label, 接口调用成功之后, 一般会有不超过5分钟的缓存 




## 路由参数

| 参数名        | 类型     | 必选   | 说明              |
|:-----------|:-------|:-----|:----------------|
| host | string | Y | 主机名<br> |


## Body 请求参数

| 参数名        | 类型     | 必选   | 说明              |
|:-----------|:-------|:-----|:----------------|
| source | string | Y | 数据源<br>例子: HOST <br>允许为空: False <br> |
| labels | array |  | 对象名列表<br>允许为空: False <br> |

## 参数补充说明







## 响应
```shell
{
    "code": 200,
    "content": true,
    "errorCode": "",
    "message": "",
    "success": true,
    "traceId": "TRACE-96EDF6EA-847D-4E23-BE1B-B387257B6BFA"
} 
```




