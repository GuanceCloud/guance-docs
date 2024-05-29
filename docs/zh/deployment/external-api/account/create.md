# 【前台账号】新增

---

<br />**POST /api/v1/account/add**

## 概述




## Body 请求参数

| 参数名        | 类型     | 必选   | 说明              |
|:-----------|:-------|:-----|:----------------|
| username | string | Y | 登陆账号名(不存在exterId时, 该字段值唯一)<br>例子: test_wang <br>允许为空: True <br>允许空字符串: True <br> |
| password | string | Y | 登陆密码(密码为空字符串时,第三方登录账号应设置密码未空字符串)<br>例子: I am password <br>允许空字符串: True <br>允许为空: True <br> |
| name | string | Y | 昵称<br>例子: test_wang <br>允许为空: False <br>允许空字符串: False <br> |
| email | string | Y | 用户邮箱<br>例子: test_wang@xx.com <br>允许为空: False <br>允许空字符串: True <br>$isEmail: True <br> |
| mobile | string |  | 手机号<br>例子: 1762xxx9836 <br>允许为空: False <br>允许空字符串: False <br> |
| exterId | string |  | 第三方账号系统的唯一标识ID, 当前字段存在时,该字段值唯一(username 字段允许重复)<br>例子: 29ab8d31-ac52-4485-a572-f4cf25d355d9 <br>允许为空: False <br>允许空字符串: False <br> |
| extend | json |  | 额外信息<br>允许为空: True <br> |
| language | string |  | 语言信息<br>例子: zh <br>允许为空: True <br>允许空字符串: True <br>可选值: ['zh', 'en'] <br> |
| isDisable | boolean |  | 是否禁用<br>例子: True <br>允许为空: False <br>可选值: [True, False] <br> |
| attributes | json |  | 账号的属性信息(json结构, KV结构, V部分尽量使用字符串)<br>例子: {'部门': 'A部门'} <br>允许为空: False <br> |

## 参数补充说明





## 请求例子
```shell
curl 'http://127.0.0.1:5000/api/v1/account/add' \
  -H 'Content-Type: application/json' \
  -H 'X-Df-Access-Key: abcd' \
  -H 'X-Df-Nonce: 4' \
  -H 'X-Df-Signature: test123' \
  -H 'X-Df-Timestamp: 1715321116' \
  --data-raw $'{ "username": "lwc_xxxx_002@qq.com", "password": "xxx", "name": "lwc_xxxx_002", "email": "lwc_xxxx_002@qq.com"}'
```




## 响应
```shell
{
    "code": 200,
    "content": {
        "attributes": {},
        "canaryPublic": false,
        "createAt": 1715322612,
        "creator": "SYS",
        "deleteAt": -1,
        "email": "xxxx@qq.com",
        "enableMFA": false,
        "extend": null,
        "exterId": "",
        "id": 3026,
        "isUsed": 0,
        "language": "zh",
        "mfaSecret": "*********************",
        "mobile": "",
        "name": "xxxx",
        "nameSpace": "",
        "status": 0,
        "statusPageSubs": 0,
        "timezone": "",
        "tokenHoldTime": 604800,
        "tokenMaxValidDuration": 2592000,
        "updateAt": 1715322612,
        "updator": "SYS",
        "username": "xxxx@qq.com",
        "uuid": "acnt_67792938b21148ff8f2b17afdbd92c27"
    },
    "errorCode": "",
    "message": "",
    "success": true,
    "traceId": "TRACE-9833FF30-E419-42E1-B999-047E609D4EE3"
} 
```




