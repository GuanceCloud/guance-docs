# 获取官方默认节点列表

---

<br />**GET /api/v1/dialing_task/default_region_list**

## 概述
获取官方默认节点列表




## 参数补充说明





## 请求例子
```shell
curl 'https://openapi.<<< custom_key.brand_main_domain >>>/api/v1/dialing_task/default_region_list' \
-H 'DF-API-KEY: <DF-API-KEY>' \
--compressed
```




## 响应
```shell
{
    "code": 200,
    "content": [
        {
            "uuid": "regn_xxxx",
            "province": "",
            "city": "Frankfurt",
            "country": "Germany",
            "name": "德国-法兰克福",
            "name_en": "Germany - Frankfurt",
            "extend_info": "",
            "internal": false,
            "keycode": "eu-central-1",
            "isp": "aliyun",
            "status": "OK",
            "region": "eu-central-1",
            "owner": "default",
            "heartbeat": 1741330250,
            "company": "",
            "external_id": "",
            "parent_ak": "",
            "create_at": -1
        },
        {
            "uuid": "regn_xxxx",
            "province": "",
            "city": "Virginia",
            "country": "United States of America",
            "name": "美国-弗吉尼亚",
            "name_en": "United States - Virginia",
            "extend_info": "",
            "internal": false,
            "keycode": "us-east-1",
            "isp": "aliyun",
            "status": "OK",
            "region": "us-east-1",
            "owner": "default",
            "heartbeat": 1741330204,
            "company": "",
            "external_id": "",
            "parent_ak": "",
            "create_at": -1
        },
        {
            "uuid": "regn_xxxx",
            "province": "",
            "city": "San Mateo",
            "country": "United States of America",
            "name": "美国-加利福尼亚",
            "name_en": "The United States - California",
            "extend_info": "",
            "internal": false,
            "keycode": "us-west-1",
            "isp": "aliyun",
            "status": "OK",
            "region": "us-west-1",
            "owner": "default",
            "heartbeat": 1741330197,
            "company": "",
            "external_id": "",
            "parent_ak": "",
            "create_at": -1
        }
    ],
    "errorCode": "",
    "message": "",
    "success": true,
    "traceId": "5046882279716230069"
} 
```




