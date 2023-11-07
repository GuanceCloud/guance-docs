# 新建角色

---

<br />**POST /api/v1/role/add**

## 概述
新建角色




## Body 请求参数

| 参数名        | 类型     | 必选   | 说明              |
|:-----------|:-------|:-----|:----------------|
| name | string | Y | 角色名<br>例子: 角色1号 <br>允许为空: False <br>最大长度: 256 <br> |
| desc | string |  | 角色的描述信息<br>例子: CUSTOM <br>允许为空: False <br>允许空字符串: True <br>最大长度: 3000 <br> |
| keys | array | Y | 选中的权限列表<br>例子: [] <br>允许为空: False <br> |

## 参数补充说明





## 请求例子
```shell
curl 'https://openapi.guance.com/api/v1/role/add' \
-H 'Accept: application/json, text/plain, */*' \
-H 'Content-Type: application/json;charset=UTF-8' \
-H 'DF-API-KEY: <DF-API-KEY>' \
--data-raw '{"name":"test_temp_role1","desc":"test","keys":["workspace.readMember","label.labelCfgManage","log.externalIndexManage"]}' \
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
    "traceId": "TRACE-5CF2E74E-42E8-4E1C-95F0-EF7D00538F26"
} 
```




