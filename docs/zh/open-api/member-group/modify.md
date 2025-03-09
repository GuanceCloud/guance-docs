# 修改一个团队

---

<br />**POST /api/v1/workspace/member_group/\{group_uuid\}/modify**

## 概述
修改一个团队




## 路由参数

| 参数名        | 类型     | 必选   | 说明              |
|:-----------|:-------|:-----|:----------------|
| group_uuid | string | Y | 团队UUID<br> |


## Body 请求参数

| 参数名        | 类型     | 必选   | 说明              |
|:-----------|:-------|:-----|:----------------|
| name | string | Y | 团队名称<br>允许为空: False <br>最大长度: 48 <br> |
| accountUUIDs | array | Y | 账号列表<br>例子: ['xxxx', 'xxx'] <br>允许为空: True <br> |

## 参数补充说明





## 请求例子
```shell
curl 'https://openapi.<<< custom_key.brand_main_domain >>>/api/v1/workspace/member_group/group_xxxx32/modify' \
-H 'DF-API-KEY: <DF-API-KEY>' \
-H 'Content-Type: application/json;charset=UTF-8' \
--data-raw '{"name": "测试222","accountUUIDs": ["acnt_xxxx32"]}' \
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
    "traceId": "TRACE-EC42FB1A-8ABA-45E4-83E1-E2E01661C6B3"
} 
```




