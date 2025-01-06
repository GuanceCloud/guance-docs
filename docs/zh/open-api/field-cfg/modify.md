# 修改 字段管理

---

<br />**POST /api/v1/field_cfg/\{field_uuid\}/modify**

## 概述
修改 字段管理




## 路由参数

| 参数名        | 类型     | 必选   | 说明              |
|:-----------|:-------|:-----|:----------------|
| field_uuid | string | Y | 字段 UUID<br> |


## Body 请求参数

| 参数名        | 类型     | 必选   | 说明              |
|:-----------|:-------|:-----|:----------------|
| name | string | Y | 字段名称, 同一字段来源(fieldSource), 字段名不能重复<br>允许为空: False <br>允许为空字符串: False <br>最大长度: 256 <br> |
| alias | string | Y | 字段别名<br>允许为空: False <br>允许为空字符串: False <br>最大长度: 256 <br> |
| unit | string |  | 单位信息, fieldType 为 string 时, 单位将置空<br>允许为空: False <br>最大长度: 256 <br>允许为空字符串: True <br> |
| fieldType | string |  | 字段类型<br>例子: time <br>允许为空: False <br>允许为空字符串: True <br>可选值: ['int', 'float', 'boolean', 'string', 'long'] <br> |
| fieldSource | string |  | 字段来源<br>例子: time <br>允许为空: False <br>允许为空字符串: True <br>可选值: ['logging', 'object', 'custom_object', 'keyevent', 'tracing', 'rum', 'security', 'network', 'billing'] <br> |
| desc | string |  | 字段描述信息<br>例子: 主机名称 <br>允许为空: False <br>允许为空字符串: True <br>最大长度: 3000 <br> |
| coverInner | boolean |  | 添加字段名称和系统内置字段同名时是否覆盖,true为覆盖,false不覆盖<br>例子: True <br>允许为空: False <br> |

## 参数补充说明

参数说明: 参考新增接口

```




## 请求例子
```shell
curl 'https://openapi.guance.com/api/v1/field_cfg/field_0f95016f7254494da088d878ce586477/modify' \
-H 'DF-API-KEY: <DF-API-KEY>' \
-H 'Accept: application/json, text/plain, */*' \
-H 'Accept-Language: zh' \
-H 'Content-Type: application/json;charset=UTF-8' \
--data-raw '{"name":"test_load","alias":"as_load","fieldType":"int","desc":"modify_test","fieldSource":"","unit":"custom/[\"time\",\"ns\"]","coverInner":false}' \
--compressed
```




## 响应
```shell
{"code":200,"content":{"alias":"as_load","aliasEn":"","createAt":1735628856,"creator":"wsak_73a0ad39c352477a9417f633670a0908","declaration":{"business":"","organization":"default_private_organization"},"deleteAt":-1,"desc":"modify_test","descEn":"","fieldSource":"","fieldType":"int","id":1791,"name":"test_load","status":0,"sysField":0,"unit":"custom/[\\"time\\",\\"ns\\"]","updateAt":1735635730.899186,"updator":"wsak_73a0ad39c352477a9417f633670a0908","uuid":"field_0f95016f7254494da088d878ce586477","workspaceUUID":"wksp_05adf2282d0d47f8b79e70547e939617"},"errorCode":"","message":"","success":true,"traceId":"TRACE-D11D56A9-BC80-48D4-903C-550D248204BD"} 
```




