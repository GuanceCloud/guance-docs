# 修改一个/多个成员

---

<br />**POST /api/v1/workspace/member/batch_modify**

## 概述
修改一个/多个成员




## Body 请求参数

| 参数名        | 类型     | 必选   | 说明              |
|:-----------|:-------|:-----|:----------------|
| accountUUIDs | array | Y | 账号列表<br>例子: ['未加入工作空间的账号UUID1', '未加入工作空间的账号UUID2'] <br>允许为空: True <br> |
| roleUUIDs | array | Y | 用户角色uuid列表<br>例子: None <br>允许为空: False <br> |
| onlyModifyRoles | boolean | Y | 是否只修改成员角色, True 不修改团队信息<br>例子: True <br>允许为空: False <br> |
| memberGroupUUIDs | array |  | 团队列表<br>例子: ['xxx', 'xxx'] <br>允许为空: True <br> |
| acntWsNickname | string |  | 账号在该空间的昵称<br>例子: 昵称AAA <br>允许为空: True <br>$maxCustomLength: 128 <br> |

## 参数补充说明

数据说明.*

修改成员角色,roleUUIDs中如果存在需要Token审核的角色,(saas免费版,paas版无需费用中心审核)则必须包含无需审核的角色UUID

- 请求参数说明

| 参数名           | type | 说明                                                 |
| ---------------- | ---- | ---------------------------------------------------- |
| accountUUIDs       | list | 成员账号UUID |
| roleUUIDs             | list | 角色UUID                                              |
| onlyModifyRoles    | boolean | 是否只改动角色信息(true批量修改, false单个修改)                 |
| memberGroupUUIDs       | list  | 单个修改成员是必传团队信息     |
| acntWsNickname       | string  | 账号在空间的昵称     |
------




## 请求例子
```shell
curl 'https://openapi.<<< custom_key.brand_main_domain >>>/api/v1/workspace/member/batch_modify' \
-H 'DF-API-KEY: <DF-API-KEY>' \
-H 'Content-Type: application/json;charset=UTF-8' \
--data-raw '{"accountUUIDs": ["acnt_xxxx32"], "onlyModifyRoles": true, "roleUUIDs": ["general","wsAdmin"]}' \
--compressed 
```




## 响应
```shell
{
    "code": 200,
    "content": {
        "autoLoginUrl": "http://testing-zc-portal.cloudflux.cn/#/signin?from=http:%2F%2Ftesting-zc-portal.cloudflux.cn%2Fportal.html%23%2Finfo%2Flist&ticket=7d628f01-6c63-454a-8cf7-7c30678a9b0d"
    },
    "errorCode": "",
    "message": "",
    "success": true,
    "traceId": "TRACE-F0E7FBC3-3A2B-4843-9B5E-DAD070AB812B"
} 
```




