# Share a Snapshot

---

<br />**POST /api/v1/snapshots/\{snapshot_uuid\}/share**

## Overview
Generate a sharing link for the specified snapshot based on `snapshot_uuid`



## Route Parameters

| Parameter Name        | Type     | Required   | Description              |
|:------------------|:-------|:-----|:----------------|
| snapshot_uuid | string | Y | Snapshot UUID<br> |


## Body Request Parameters

| Parameter Name        | Type     | Required   | Description              |
|:------------------|:-------|:-----|:----------------|
| changeTime | boolean |  | Whether to allow the viewer to change the time range, defaults to false<br>Can be null: False <br> |
| expirationAt | integer |  | Expiration time as a timestamp, permanent validity if -1 is passed<br>Example: 1577758776 <br>Can be null: False <br>Can be an empty string: True <br> |
| extractionCode | string |  | Extraction code required for accessing encrypted shares<br>Example: 123455x <br>Can be null: False <br>Can be an empty string: True <br>Maximum length: 12 <br> |
| hiddenTopBar | boolean |  | Whether to hide the top bar, defaults to false<br>Can be null: False <br> |
| showWatermark | boolean |  | Whether to display watermark, defaults to false<br>Can be null: False <br> |
| maskCfg | None |  | <br> |
| maskCfg.fields | string |  | Sensitive fields, multiple fields separated by commas<br>Example: message,host <br>Can be null: False <br>Can be an empty string: True <br> |
| maskCfg.reExprs | array |  | Regular expressions<br>Example: [{'name': 'jjj', 'reExpr': 'ss', 'enable': 0}, {'name': 'lll', 'reExpr': 'ss', 'enable': 1}] <br>Can be null: False <br> |
| ipWhitelistSet | None |  | <br> |
| ipWhitelistSet.isOpen | boolean |  | Whether to enable IP whitelist<br>Can be null: False <br> |
| ipWhitelistSet.type | string |  | Type of IP whitelist, followWorkspace<br>Example: 123455x <br>Can be null: False <br>Can be an empty string: True <br>Maximum length: 12 <br>Optional values: ['followWorkspace', 'custom'] <br> |
| ipWhitelistSet.ipWhitelist | array |  | IP whitelist list, used when type is custom<br>Example: [] <br>Can be null: False <br> |

## Additional Parameter Descriptions


*Request Parameter Descriptions*

| Parameter Name                | Type  | Description          |
|-----------------------|----------|------------------------|
|changeTime             |boolean| Whether to allow the viewer to change the time range|
|expirationAt             |integer| Expiration time as a second-level timestamp, permanent validity if -1 is passed|
|extractionCode   |string     | Extraction code required for accessing encrypted shares, default is public|
|hiddenTopBar   |boolean     | Whether to hide the top bar, defaults to false |
|showWatermark |boolean     | Whether to display watermark|
|maskCfg |dict     | Masking configuration|
|ipWhitelistSet |dict     | Snapshot IP whitelist configuration|

--------------

*maskCfg Internal Field Descriptions*
| Parameter Name                | Type  | Description          |
|-----------------------|----------|------------------------|
|fields             |string| Sensitive fields, multiple fields separated by commas|
|reExprs   |array     | List of regular expressions|

--------------

*maskCfg.reExprs Internal Field Descriptions*
| Parameter Name                | Type  | Description          |
|-----------------------|----------|------------------------|
|name             |string| Name of the sensitive field|
|reExpr   |string     | Regular expression|
|enable   |integer     | Whether enabled 0,1|

--------------

*ipWhitelistSet Internal Field Descriptions*
| Parameter Name                | Type  | Description          |
|-----------------------|----------|------------------------|
|isOpen             |boolean| Whether to enable IP whitelist|
|type   |string     | Type of IP whitelist, follow workspace IP whitelist configuration: followWorkspace, custom: custom|
|ipWhitelist   |boolean     | IP whitelist list, used when type is custom |

--------------




## Request Example
```shell
curl 'https://openapi.guance.com/api/v1/snapshots/snap_xxxx32/share' \
-H 'DF-API-KEY: <DF-API-KEY>' \
-H 'Content-Type: application/json;charset=UTF-8' \
--data-raw '{"changeTime":true,"expirationAt":1730874467,"hiddenTopBar":false,"showWatermark":true,"maskCfg":{"fields":"","reExprs":[]},"ipWhitelistSet":{"isOpen":false},"changeTime":true}' \
--compressed 
```




## Response
```shell
{
    "code": 200,
    "content": {
        "declaration": {
            "asd": "aa,bb,cc,1,True",
            "asdasd": "dawdawd",
            "business": "aaa",
            "dd": "dd",
            "fawf": "afawf",
            "organization": "64fe7b4062f74d0007b46676"
        },
        "isHidden": false,
        "shortUrl": "https://aa.com/rj6mm3",
        "token": "shared.eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ3c191dWlkIjoid2tzcF80YjU3YzdiYWIzOGU0YTJkOTYzMGY2NzVkYzIwMDE1ZCIsInNoYXJlX2NvbmZpZ191dWlkIjoic2hhcmVfNDhiYjBhMTExNDJhNDM0Nzk0NmM4Y2YxOWExZTAxZTYiLCJleHBpcmF0aW9uQXQiOjE3MzA4NzQ0NjcsInJlc291cmNlVHlwZSI6InNuYXBzaG90In0.ZMgLS7S1umNSMA8-zJIGQh4G8cEl4vl5fVHNHoIQrbU"
    },
    "errorCode": "",
    "message": "",
    "success": true,
    "traceId": "TRACE-67FFC05B-64BA-4A56-B831-D3FCEFE4451C"
} 
```