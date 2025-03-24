# Get Data Access Rule List

---

<br />**GET /api/v1/data_query_rule/list**

## Overview
List data access rules of various types



## Query Request Parameters

| Parameter Name        | Type     | Required   | Description              |
|:---------------------|:---------|:-----------|:------------------------|
| type | string | Y | Filter field, type<br>Can be empty: True <br>Optional values: ['logging', 'rum', 'tracing', 'metric'] <br> |
| roleUUIDs | commaArray |  | Filter field, role UUID, comma-separated<br>Can be empty: False <br> |
| indexUUIDs | commaArray |  | Filter field, index UUID, comma-separated<br>Can be empty: False <br> |
| sources | commaArray |  | Filter field, resource name, comma-separated<br>Can be empty: False <br> |
| isMask | string |  | Filter field, whether masked<br>Can be empty: False <br>Optional values: ['true', 'false'] <br> |
| search | string |  | Search name<br>Can be empty: True <br> |
| pageSize | integer |  | Number of items returned per page<br>Can be empty: False <br>Example: 10 <br> |
| pageIndex | integer |  | Page number<br>Can be empty: False <br>Example: 10 <br> |

## Parameter Supplementary Notes



## Request Example
```shell
curl 'https://openapi.<<< custom_key.brand_main_domain >>>/api/v1/data_query_rule/list?type=rum&pageIndex=1&pageSize=2' \
-H 'DF-API-KEY: <DF-API-KEY>' \
--compressed
```




## Response
```shell
{
    "code": 200,
    "content": {
        "data": [
            {
                "conditions": "`env` IN ['front'] and `province` IN ['jiangsu']",
                "createAt": 1730532068,
                "creator": "wsak_cd83804176e24ac18a8a683260ab0746",
                "creatorInfo": {
                    "acntWsNickname": "",
                    "email": "wsak_cd83804176e24ac18a8a683260ab0746",
                    "iconUrl": "",
                    "mobile": "",
                    "name": "hd_test",
                    "status": 0,
                    "username": "hd_test",
                    "uuid": "wsak_cd83804176e24ac18a8a683260ab0746",
                    "wsAccountStatus": 0
                },
                "deleteAt": -1,
                "desc": "",
                "extend": {
                    "env": [
                        "front"
                    ],
                    "province": [
                        "jiangsu"
                    ]
                },
                "id": 351,
                "indexes": [],
                "logic": "and",
                "maskFields": "source",
                "memberCount": 2,
                "name": "rum test",
                "reExprs": [
                    {
                        "enable": true,
                        "name": "liuyl",
                        "reExpr": ".*"
                    }
                ],
                "relMemberInfos": [
                    {
                        "acntWsNickname": "",
                        "email": "xxx@<<< custom_key.brand_main_domain >>>",
                        "iconUrl": "http://static.cloudcare.cn:10561/icon/acnt_664f5b3cfe7841a89143817f27267066.png",
                        "mobile": "",
                        "name": "dcl",
                        "status": 0,
                        "username": "xxx@<<< custom_key.brand_main_domain >>>",
                        "uuid": "acnt_664f5b3cfe7841a89143817f27267066",
                        "wsAccountStatus": 0
                    },
                    {
                        "acntWsNickname": "",
                        "email": "xxx@<<< custom_key.brand_main_domain >>>",
                        "iconUrl": "",
                        "mobile": "",
                        "name": "whyPAAS",
                        "status": 0,
                        "username": "xxx@<<< custom_key.brand_main_domain >>>",
                        "uuid": "acnt_dd1bb947d2ac4c96ad99be7aa86c0e43",
                        "wsAccountStatus": 0
                    }
                ],
                "relRoleInfos": [
                    {
                        "name": "gary-test-1016",
                        "status": 0,
                        "uuid": "role_a1e8215c25474f0bb3809f2d56749ed9"
                    },
                    {
                        "name": "Shortcut Customization",
                        "status": 0,
                        "uuid": "role_aa49795a5a5a4753a2a6350ab57f9497"
                    }
                ],
                "roleUUIDs": [
                    "role_a1e8215c25474f0bb3809f2d56749ed9",
                    "role_aa49795a5a5a4753a2a6350ab57f9497"
                ],
                "sources": [
                    "a2727170_7b1a_11ef_9de6_855cb2bccffb"
                ],
                "sourcesWsInfo": {
                    "a2727170_7b1a_11ef_9de6_855cb2bccffb": {
                        "sourcesInfo": {
                            "name": "New Application-hd",
                            "status": 0,
                            "type": "web"
                        },
                        "wsInfo": {
                            "name": "[Doris] Development Testing Together_",
                            "status": 0
                        }
                    }
                },
                "status": 0,
                "type": "rum",
                "updateAt": 1730532376,
                "updator": "wsak_cd83804176e24ac18a8a683260ab0746",
                "updatorInfo": {
                    "acntWsNickname": "",
                    "email": "wsak_cd83804176e24ac18a8a683260ab0746",
                    "iconUrl": "",
                    "mobile": "",
                    "name": "hd_test",
                    "status": 0,
                    "username": "hd_test",
                    "uuid": "wsak_cd83804176e24ac18a8a683260ab0746",
                    "wsAccountStatus": 0
                },
                "uuid": "lqrl_dfe6330883ef4311afae5d380e2294a1",
                "workspaceUUID": "wksp_4b57c7bab38e4a2d9630f675dc20015d"
            },
            {
                "conditions": "",
                "createAt": 1728440913,
                "creator": "acnt_decf86471e4e4210a333b9f49bdec3da",
                "creatorInfo": {
                    "acntWsNickname": "",
                    "email": "xxx@<<< custom_key.brand_main_domain >>>",
                    "iconUrl": "",
                    "mobile": "16543443437",
                    "name": "newadmin-hd",
                    "status": 3,
                    "username": "newadmin-hd",
                    "uuid": "acnt_decf86471e4e4210a333b9f49bdec3da",
                    "wsAccountStatus": 3
                },
                "deleteAt": -1,
                "desc": "",
                "extend": {},
                "id": 296,
                "indexes": [],
                "logic": "and",
                "maskFields": "",
                "memberCount": 17,
                "name": "222",
                "reExprs": [],
                "relMemberInfos": [
                    {
                        "acntWsNickname": "",
                        "email": "xxx@<<< custom_key.brand_main_domain >>>",
                        "iconUrl": "http://static.cloudcare.cn:10561/icon/acnt_664f5b3cfe7841a89143817f27267066.png",
                        "mobile": "",
                        "name": "dcl",
                        "status": 0,
                        "username": "xxx@<<< custom_key.brand_main_domain >>>",
                        "uuid": "acnt_664f5b3cfe7841a89143817f27267066",
                        "wsAccountStatus": 0
                    },
                    {
                        "acntWsNickname": "",
                        "email": "xxx@<<< custom_key.brand_main_domain >>>",
                        "iconUrl": "",
                        "mobile": "",
                        "name": "b",
                        "status": 0,
                        "username": "b",
                        "uuid": "acnt_cf4b33a8fcf245eb90a06e5fce576da6",
                        "wsAccountStatus": 0
                    },
                    {
                        "acntWsNickname": "",
                        "email": "xxx@<<< custom_key.brand_main_domain >>>",
                        "iconUrl": "",
                        "mobile": "",
                        "name": "xujiqiu",
                        "status": 0,
                        "username": "xujiqiu",
                        "uuid": "acnt_886fe1e816a3444bae1ddc3a53dfb0d3",
                        "wsAccountStatus": 0
                    },
                    {
                        "acntWsNickname": "",
                        "email": "xxx@<<< custom_key.brand_main_domain >>>",
                        "iconUrl": "",
                        "mobile": "",
                        "name": "test100",
                        "status": 0,
                        "username": "test100",
                        "uuid": "acnt_2bcb7e2e0bc4414fb0b65017b6fe2b6d",
                        "wsAccountStatus": 0
                    },
                    {
                        "acntWsNickname": "",
                        "email": "xxx@<<< custom_key.brand_main_domain >>>",
                        "iconUrl": "",
                        "mobile": "",
                        "name": "jd",
                        "status": 0,
                        "username": "jd",
                        "uuid": "acnt_29811573510242a8a91843dbb57721b6",
                        "wsAccountStatus": 0
                    },
                    {
                        "acntWsNickname": "",
                        "email": "xxx@<<< custom_key.brand_main_domain >>>",
                        "iconUrl": "",
                        "mobile": "",
                        "name": "gw7",
                        "status": 0,
                        "username": "xxx@<<< custom_key.brand_main_domain >>>",
                        "uuid": "acnt_671f6b0bb58142efb9fd74450b584015",
                        "wsAccountStatus": 0
                    },
                    {
                        "acntWsNickname": "",
                        "email": "xxx@<<< custom_key.brand_main_domain >>>",
                        "iconUrl": "",
                        "mobile": "13966421853",
                        "name": "chaii",
                        "status": 0,
                        "username": "Chloe",
                        "uuid": "acnt_7df07453091748b08f5ea2514f6a22f2",
                        "wsAccountStatus": 0
                    },
                    {
                        "acntWsNickname": "",
                        "email": "xxx@<<< custom_key.brand_main_domain >>>",
                        "iconUrl": "",
                        "mobile": "",
                        "name": "whyPAAS",
                        "status": 0,
                        "username": "xxx@<<< custom_key.brand_main_domain >>>",
                        "uuid": "acnt_dd1bb947d2ac4c96ad99be7aa86c0e43",
                        "wsAccountStatus": 0
                    },
                    {
                        "acntWsNickname": "",
                        "email": "xxx@<<< custom_key.brand_main_domain >>>",
                        "iconUrl": "http://static.cloudcare.cn:10561/icon/acnt_e85847e7fe894ea9938dd29c22bc1f9b.png",
                        "mobile": "10345678901",
                        "name": "I am 66 ya",
                        "status": 0,
                        "username": "66",
                        "uuid": "acnt_e85847e7fe894ea9938dd29c22bc1f9b",
                        "wsAccountStatus": 0
                    },
                    {
                        "acntWsNickname": "",
                        "email": "xxx@<<< custom_key.brand_main_domain >>>",
                        "iconUrl": "",
                        "mobile": "",
                        "name": "xxx@<<< custom_key.brand_main_domain >>>",
                        "status": 0,
                        "username": "yz03",
                        "uuid": "acnt_ab3b0f6304cf4bb687a49541f19be50d",
                        "wsAccountStatus": 0
                    },
                    {
                        "acntWsNickname": "Second Standard User",
                        "email": "xxx@<<< custom_key.brand_main_domain >>>",
                        "iconUrl": "",
                        "mobile": "16332254353",
                        "name": "standB",
                        "status": 0,
                        "username": "xxx@<<< custom_key.brand_main_domain >>>",
                        "uuid": "acnt_629cfa1ef372423b95a93ac15bb0e40b",
                        "wsAccountStatus": 0
                    },
                    {
                        "acntWsNickname": "First Standard User",
                        "email": "xxx@<<< custom_key.brand_main_domain >>>",
                        "iconUrl": "",
                        "mobile": "15435364654",
                        "name": "standA",
                        "status": 0,
                        "username": "xxx@<<< custom_key.brand_main_domain >>>",
                        "uuid": "acnt_4f3302d7503546848266e5eb167fb6a3",
                        "wsAccountStatus": 0
                    },
                    {
                        "acntWsNickname": "",
                        "email": "xxx@<<< custom_key.brand_main_domain >>>",
                        "iconUrl": "",
                        "mobile": "",
                        "name": "xxx@<<< custom_key.brand_main_domain >>>",
                        "status": 0,
                        "username": "18521300004",
                        "uuid": "acnt_a71564d3390f486dba9f7c1580b9e02a",
                        "wsAccountStatus": 0
                    },
                    {
                        "acntWsNickname": "",
                        "email": "xxx@<<< custom_key.brand_main_domain >>>",
                        "iconUrl": "",
                        "mobile": "17621725046",
                        "name": "Jin Lei lll",
                        "status": 0,
                        "username": "Jin Lei lll",
                        "uuid": "acnt_8b4bd2b8782646f3ba8f6554193f5997",
                        "wsAccountStatus": 0
                    },
                    {
                        "acntWsNickname": "",
                        "email": "xxx@<<< custom_key.brand_main_domain >>>",
                        "iconUrl": "",
                        "mobile": "",
                        "name": "lwc_local_test1",
                        "status": 0,
                        "username": "xxx@<<< custom_key.brand_main_domain >>>",
                        "uuid": "acnt_3dfb55c16128420e8ca70756f7292b67",
                        "wsAccountStatus": 0
                    },
                    {
                        "acntWsNickname": "",
                        "email": "xxx@<<< custom_key.brand_main_domain >>>",
                        "iconUrl": "",
                        "mobile": "",
                        "name": "lwc_local_test2",
                        "status": 0,
                        "username": "xxx@<<< custom_key.brand_main_domain >>>",
                        "uuid": "acnt_e2b3368ceb074efe8c6d96cf49362629",
                        "wsAccountStatus": 0
                    },
                    {
                        "acntWsNickname": "",
                        "email": "xxx@<<< custom_key.brand_main_domain >>>",
                        "iconUrl": "",
                        "mobile": "17621725789",
                        "name": "jon_jinlei",
                        "status": 0,
                        "username": "jon_jinlei",
                        "uuid": "acnt_6bfe3b8147364534a7c7ee0dc5294909",
                        "wsAccountStatus": 0
                    }
                ],
                "relRoleInfos": [
                    {
                        "name": "Standard",
                        "status": 0,
                        "uuid": "general"
                    }
                ],
                "roleUUIDs": [
                    "general"
                ],
                "sources": [
                    "a2727170_7b1a_11ef_9de6_855cb2bccffb"
                ],
                "sourcesWsInfo": {
                    "a2727170_7b1a_11ef_9de6_855cb2bccffb": {
                        "sourcesInfo": {
                            "name": "New Application-hd",
                            "status": 0,
                            "type": "web"
                        },
                        "wsInfo": {
                            "name": "[Doris] Development Testing Together_",
                            "status": 0
                        }
                    }
                },
                "status": 2,
                "type": "rum",
                "updateAt": 1730084928,
                "updator": "acnt_57a717791e094f35966907d4cf80b45f",
                "updatorInfo": {
                    "acntWsNickname": "Nickname Nickname Nickname Nickname Nickname Nickname Nickname Nickname Nickname Nickname Nicn Nickname Nic Nickname Nickname Nickname Nickname Nickname Nickname Nickname Nickname Nick",
                    "email": "xxx@<<< custom_key.brand_main_domain >>>",
                    "iconUrl": "http://static.cloudcare.cn:10561/icon/acnt_57a717791e094f35966907d4cf80b45f.png",
                    "mobile": "18511111112",
                    "name": "Modify Modify Modify",
                    "status": 0,
                    "username": "xxx@<<< custom_key.brand_main_domain >>>",
                    "uuid": "acnt_57a717791e094f35966907d4cf80b45f",
                    "wsAccountStatus": 0
                },
                "uuid": "lqrl_36199bc9fe8e4c9a982919584ed55dae",
                "workspaceUUID": "wksp_4b57c7bab38e4a2d9630f675dc20015d"
            }
        ],
        "declaration": {
            "asd": "aa,bb,cc,1,True",
            "asdasd": "dawdawd",
            "business": "aaa",
            "dd": "dd",
            "fawf": "afawf",
            "organization": "64fe7b4062f74d0007b46676"
        }
    },
    "errorCode": "",
    "message": "",
    "pageInfo": {
        "count": 2,
        "pageIndex": 1,
        "pageSize": 2,
        "totalCount": 13
    },
    "success": true,
    "traceId": "TRACE-2876D3FF-291D-48E9-A9B1-E79C4FFA90CC"
} 
```