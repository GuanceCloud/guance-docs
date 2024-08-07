# 创建一个自建节点

---

<br />**POST /api/v1/dialing_region/regist**

## 概述
创建一个自建节点




## Body 请求参数

| 参数名        | 类型     | 必选   | 说明              |
|:-----------|:-------|:-----|:----------------|
| internal | boolean | Y | 国家属性（true为国内，false为海外）<br>允许为空: False <br> |
| isp | string | Y | 运营商<br>允许为空: False <br> |
| country | string | Y | 国家<br>允许为空: False <br> |
| province | string |  | 省份<br>允许为空: True <br> |
| city | string |  | 城市<br>允许为空: True <br> |
| name | string |  | 【拨测节点】昵称<br>允许为空字符串: True <br>允许为空: True <br> |
| company | string |  | 企业信息<br>允许为空: True <br> |
| keycode | string | Y | 【拨测节点】keycode(不可重名)<br>允许为空: False <br> |

## 参数补充说明





## 请求例子
```shell
curl 'https://openapi.guance.com/api/v1/dialing_region/regist' \
-H 'DF-API-KEY: <DF-API-KEY>' \
-H 'Content-Type: application/json;charset=UTF-8' \
--data-raw '{"internal":false,"isp":"telecom","country":"Afghanistan","city":"Shahrak","keycode":"Afghanistan-Shahrak-telecom","name":"test"}' \
--compressed
```




## 响应
```shell
{
    "code": 200,
    "content": {
        "ak": {
            "ak": "4jwIcxedYwSdTsn9rZ0f",
            "external_id": "wksp_ed134a6485c8484dbd0e58ce9a9c6115",
            "owner": "",
            "parent_ak": "ak_c1imts73q2c335d71cn0",
            "sk": "utiGZCqZkEe6ZzKyW30xczv96joMrmvGAfxuJ7Fr",
            "status": "",
            "update_at": 0
        },
        "regionInfo": {
            "city": "Shahrak",
            "company": "",
            "country": "Afghanistan",
            "create_at": 0,
            "external_id": "ak_c1imts73q2c335d71cn0-wksp_ed134a6485c8484dbd0e58ce9a9c6115",
            "heartbeat": 0,
            "internal": false,
            "isp": "telecom",
            "keycode": "Afghanistan-Shahrak-telecom",
            "name": "test",
            "owner": "custom",
            "parent_ak": "",
            "province": "",
            "region": "",
            "status": "",
            "uuid": "reg_cg2britepb7e977fpm8g"
        }
    },
    "errorCode": "",
    "message": "",
    "success": true,
    "traceId": "TRACE-A9074F0D-8F0B-4034-AD9B-9D8A894F1679"
} 
```




