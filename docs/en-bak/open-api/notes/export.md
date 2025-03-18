# Export a Note

---

<br />**get /api/v1/notes/\{notes_uuid\}/export**

## Overview
Export the notes specified by `notes_uuid` as a template structure.




## Routing Parameters

| Parameter Name        | Type     | Required   | Description              |
|:-----------|:-------|:-----|:----------------|
| notes_uuid | string | Y | 笔记UUID<br> |


## Supplementary Description of Parameters


Note template structure description:

The basic structure of the template includes: view structure (only chart structure)

**Description of Body Structure for `templateInfo`**

|  Parameter Name                |   Type  | Required  |          Description          |
|-----------------------|----------|----|------------------------|
|name             |string | Must |  Note title |
|main             |json |  |  Export content body structure |
|main.charts             |array |  |  Chart template structure list |
|main.charts[#]             |json |  |  Chart template structure |

**Description of Body Structure for `main.charts[#]`**

|  Parameter Name                |   Type  | Required  |          Description          |
|-----------------------|----------|----|------------------------|
|name             |string | Must |  Chart name |
|type             |string | Must |  Chart type |
|queries             |array[json] | Must |  Chart query statement structure list |

**`Sequence Diagram` Structure `type=sequence`; The Main Structure Parameters are as Follows:**

|  Parameter Name                |   Type  | Required  |          Description          |
|-----------------------|----------|----|------------------------|
|name             |string | Must |  Chart name |
|type             |string | Must |  Chart type |
|queries             |array[json] | Must |  Chart query statement structure list |




## Request Example
```shell
curl 'https://openapi.guance.com/api/v1/notes/notes_dec0b0bc6e6d4b41aa627132887de4dc/export' \
-H 'DF-API-KEY: <DF-API-KEY>' \
--compressed \
--insecure
```




## Response
```shell
{
    "code": 200,
    "content": {
        "main": {
            "charts": [
                {
                    "extend": {},
                    "name": "",
                    "queries": [
                        {
                            "query": {
                                "content": "笔记内容"
                            }
                        }
                    ],
                    "type": "text"
                }
            ]
        },
        "name": "我的笔记"
    },
    "errorCode": "",
    "message": "",
    "success": true,
    "traceId": "TRACE-8FD9876D-842E-4E0D-AC9E-F76E98943984"
} 
```




