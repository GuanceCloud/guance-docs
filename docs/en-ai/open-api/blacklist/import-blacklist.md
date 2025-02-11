# Import One or More Blacklists

---

<br />**POST /api/v1/blacklist/import**

## Overview
Import one or more blacklists


## Body Request Parameters

| Parameter Name        | Type     | Required | Description              |
|:-------------------|:-------|:-----|:----------------|
| blacklists | array | Y | List of blacklists<br>Allow null: False <br> |
| blacklistType | string | Y | Used to distinguish whether the import is from the log menu or the management menu<br>Example: logging <br>Optional values: ['logging', 'all'] <br> |

## Additional Parameter Notes



## Request Example
```shell
curl 'https://openapi.guance.com/api/v1/blacklist/import' \
-H 'DF-API-KEY: <DF-API-KEY>' \
-H 'Content-Type: application/json;charset=UTF-8' \
--data-raw '{"blacklists":[{"filters":[{"condition":"and","name":"host","operation":"in","value":["127.0.0.1"]}],"source":"kodo-log","type":"logging"}],"blacklistType":"all"}' \
--compressed
```


## Response
```shell
{
    "code": 200,
    "content": {
        "blacklists": [
            {
                "filters": [
                    {
                        "condition": "and",
                        "name": "host",
                        "operation": "in",
                        "value": [
                            "127.0.0.1"
                        ]
                    }
                ],
                "source": "kodo-log",
                "type": "logging"
            }
        ]
    },
    "errorCode": "",
    "message": "",
    "success": true,
    "traceId": "TRACE-0CF51995-0D75-4F8E-871F-72B40ABA553D"
} 
```