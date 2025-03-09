# 获取字段管理列表

---

<br />**GET /api/v1/field_cfg/list**

## 概述
获取字段管理列表, 包含 内置和自定义 字段配置




## Query 请求参数

| 参数名        | 类型     | 必选   | 说明              |
|:-----------|:-------|:-----|:----------------|
| search | string |  | 字段名称搜索<br>允许为空: False <br> |
| pageIndex | integer |  | 页码<br>允许为空: False <br>例子: 10 <br>$minValue: 1 <br> |
| pageSize | integer |  | 每页返回数量<br>允许为空: False <br>例子: 10 <br>$minValue: 1 <br>$maxValue: 1000 <br> |

## 参数补充说明

数据说明

- 相关响应字段说明

| 参数名           | type | 说明                                                 |
| ---------------- | ---- | ---------------------------------------------------- |
| sysField       | string | 是否是内置字段, 1:内置, 0:自定义. 内置字段不支持修改 |




## 请求例子
```shell
curl 'https://openapi.<<< custom_key.brand_main_domain >>>/api/v1/field_cfg/list?pageIndex=1&pageSize=5' \
-H 'DF-API-KEY: <DF-API-KEY>' \
--compressed
```




## 响应
```shell
{"code":200,"content":{"data":[{"alias":"d","createAt":1735629346,"creator":"acnt_188a1642077c406bb23049a3d33f0d1a","creatorInfo":{"acntWsNickname":"","email":"jlpass@qq.com","iconUrl":"","mobile":"","name":"金金","status":0,"username":"jlpass@qq.com","uuid":"acnt_188a1642077c406bb23049a3d33f0d1a","wsAccountStatus":0},"desc":"","fieldSource":"","fieldType":"","name":"action_id","sysField":0,"unit":"","updateAt":-1,"updator":"","updatorInfo":{},"uuid":"field_e99a8428395e412f90754a090e23243f"},{"alias":"dd","createAt":1735624546,"creator":"acnt_188a1642077c406bb23049a3d33f0d1a","creatorInfo":{"acntWsNickname":"","email":"jlpass@qq.com","iconUrl":"","mobile":"","name":"金金","status":0,"username":"jlpass@qq.com","uuid":"acnt_188a1642077c406bb23049a3d33f0d1a","wsAccountStatus":0},"desc":"","fieldSource":"logging","fieldType":"","name":"sdd","sysField":0,"unit":"","updateAt":-1,"updator":"","updatorInfo":{},"uuid":"field_f9c3a77d0196425eb46b143aaec40aab"},{"alias":"as_load","createAt":1735628856,"creator":"wsak_73a0ad39c352477a9417f633670a0908","creatorInfo":{"acntWsNickname":"","email":"wsak_73a0ad39c352477a9417f633670a0908","iconUrl":"","mobile":"","name":"金磊测试","status":0,"username":"金磊测试","uuid":"wsak_73a0ad39c352477a9417f633670a0908","wsAccountStatus":0},"desc":"modify_test","fieldSource":"","fieldType":"int","name":"test_load","sysField":0,"unit":"custom/[\\"time\\",\\"ns\\"]","updateAt":1735635731,"updator":"wsak_73a0ad39c352477a9417f633670a0908","updatorInfo":{"acntWsNickname":"","email":"wsak_73a0ad39c352477a9417f633670a0908","iconUrl":"","mobile":"","name":"金磊测试","status":0,"username":"金磊测试","uuid":"wsak_73a0ad39c352477a9417f633670a0908","wsAccountStatus":0},"uuid":"field_0f95016f7254494da088d878ce586477"},{"alias":"Profiling 文件大小","createAt":1712750400,"creator":"sys","creatorInfo":{"email":"SYS","mobile":"","name":"SYS","status":0,"username":"SYS","uuid":"","wsAccountStatus":0},"desc":"Profiling 文件大小","fieldSource":"tracing","fieldType":"int","name":"__file_size","sysField":1,"unit":"b","updateAt":1735635601,"updator":"sys","updatorInfo":{"email":"SYS","mobile":"","name":"SYS","status":0,"username":"SYS","uuid":"","wsAccountStatus":0},"uuid":"field_50c1d87e2be3422d975e50fd5cdfc6b2"},{"alias":"数据来源/分类","createAt":1712750400,"creator":"sys","creatorInfo":{"email":"SYS","mobile":"","name":"SYS","status":0,"username":"SYS","uuid":"","wsAccountStatus":0},"desc":"数据来源/分类","fieldSource":"","fieldType":"string","name":"__source","sysField":1,"unit":"","updateAt":1735635601,"updator":"sys","updatorInfo":{"email":"SYS","mobile":"","name":"SYS","status":0,"username":"SYS","uuid":"","wsAccountStatus":0},"uuid":"field_aace43ce78764733a6c4ea81da19d68f"}],"declaration":{"business":"","organization":"default_private_organization"}},"errorCode":"","message":"","pageInfo":{"count":5,"pageIndex":1,"pageSize":5,"totalCount":424},"success":true,"traceId":"TRACE-867A8BDB-A853-4FDD-BE9E-8E528FCB9C35"} 
```




