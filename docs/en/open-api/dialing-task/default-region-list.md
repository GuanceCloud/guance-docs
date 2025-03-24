# Get the list of official default nodes

---

<br />**GET /api/v1/dialing_task/default_region_list**

## Overview
Get the list of official default nodes




## Additional parameter explanations





## Request example
```shell
curl 'https://openapi.<<< custom_key.brand_main_domain >>>/api/v1/dialing_task/default_region_list' \
-H 'DF-API-KEY: <DF-API-KEY>' \
--compressed
```




## Response
```shell
{
    "code": 200,
    "content": [
        {
            "uuid": "regn_xxxx",
            "province": "",
            "city": "Frankfurt",
            "country": "Germany",
            "name": "Germany - Frankfurt",
            "name_en": "Germany - Frankfurt",
            "extend_info": "",
            "internal": false,
            "keycode": "eu-central-1",
            "isp": "Alibaba Cloud",
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
            "name": "United States - Virginia",
            "name_en": "United States - Virginia",
            "extend_info": "",
            "internal": false,
            "keycode": "us-east-1",
            "isp": "Alibaba Cloud",
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
            "name": "The United States - California",
            "name_en": "The United States - California",
            "extend_info": "",
            "internal": false,
            "keycode": "us-west-1",
            "isp": "Alibaba Cloud",
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