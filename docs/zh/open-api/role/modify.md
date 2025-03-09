# 修改角色

---

<br />**POST /api/v1/role/\{role_uuid\}/modify**

## 概述
修改角色




## 路由参数

| 参数名        | 类型     | 必选   | 说明              |
|:-----------|:-------|:-----|:----------------|
| role_uuid | string | Y | 角色UUID<br> |


## Body 请求参数

| 参数名        | 类型     | 必选   | 说明              |
|:-----------|:-------|:-----|:----------------|
| name | string | Y | 角色名<br>例子: 角色1号 <br>允许为空: False <br>最大长度: 256 <br> |
| desc | string |  | 角色的描述信息<br>例子: CUSTOM <br>允许为空: False <br>允许为空字符串: True <br>最大长度: 3000 <br> |
| keys | array |  | 选中的权限列表,必须至少要有一个权限<br>例子: [] <br>允许为空: False <br> |

## 参数补充说明





## 请求例子
```shell
curl 'https://openapi.<<< custom_key.brand_main_domain >>>/api/v1/role/role_xxxx32/modify' \
-H 'Accept: application/json, text/plain, */*' \
-H 'Content-Type: application/json;charset=UTF-8' \
-H 'DF-API-KEY: <DF-API-KEY>' \
--data-raw '{"name":"test_temp_role1","desc":"test","keys":["workspace.readMember","label.labelCfgManage","share.shareManage","snapshot.delete","snapshot.create","log.externalIndexManage"]}' \
--compressed
```




## 响应
```shell
{
    "code": 200,
    "content": true,
    "errorCode": "",
    "message": "",
    "success": true,
    "traceId": "TRACE-647377FA-46A6-419A-AC26-CB0E871DBA28"
} 
```




