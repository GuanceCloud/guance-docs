# Modify Tag

---

<br />**POST /api/v1/tag/\{tag_uuid\}/modify**

## Overview
Modify an existing tag



## Route Parameters

| Parameter Name    | Type     | Required | Description              |
|:--------------|:-------|:-----|:----------------|
| tag_uuid | string | Y | Tag UUID<br> |


## Body Request Parameters

| Parameter Name    | Type     | Required | Description              |
|:--------------|:-------|:-----|:----------------|
| name | string |  | Tag name<br>Can be empty: False <br>Maximum length: 50 <br> |
| description | string |  | Tag description<br>Can be empty: False <br>Maximum length: 100 <br> |
| colour | string |  | Tag color<br>Can be empty: False <br>Maximum length: 50 <br> |

## Additional Parameter Notes

Data Description

- Request Parameter Explanation

| Parameter Name   | Type | Description                                                 |
| ---------------- | ---- | ---------------------------------------------------- |
| name       | string | Tag name |
| description             | string | Field description information                                                 |
| color    | string | Predefined color type, default, style_key1, style_key2 ~~                |

- Color field type-color mapping:
```json
{
    "default": {"background": "#CCE6FF", "color": "rgba(0,0,0,0.8)"},
    "style_key1": {"background": "#3333FE", "color": "#FFFFFF"},
    "style_key2": {"background": "#428BCA", "color": "#FFFFFF"},
    "style_key3": {"background": "#364450", "color": "#FFFFFF"},
    "style_key4": {"background": "#E0E1FF", "color": "rgba(0,0,0,0.8)"},
    "style_key5": {"background": "#9400D3", "color": "#FFFFFF"},
    "style_key6": {"background": "#EDDBFF", "color": "rgba(0,0,0,0.8)"},
    "style_key7": {"background": "#CC328B", "color": "#FFF"},
    "style_key8": {"background": "#FCDEF0", "color": "rgba(0,0,0,0.8)"},
    "style_key9": {"background": "#DC143D", "color": "#FFFFFF"},
    "style_key10": {"background": "#FCBABA", "color": "rgba(0,0,0,0.8)"},
    "style_key11": {"background": "#BD0B48", "color": "#FFFFFF"},
    "style_key12": {"background": "#FDECD2", "color": "rgba(0,0,0,0.8)"},
    "style_key13": {"background": "#FFC29C", "color": "rgba(0,0,0,0.8)"},
    "style_key14": {"background": "#ED9120", "color": "#FFFFFF"},
    "style_key15": {"background": "#CD5B44", "color": "#FFFFFF"},
    "style_key16": {"background": "#FAF570", "color": "rgba(0,0,0,0.8)"},
    "style_key17": {"background": "#C29953", "color": "#FFFFFF"},
    "style_key18": {"background": "#02B140", "color": "#FFFFFF"},
    "style_key19": {"background": "#D5F4D5", "color": "rgba(0,0,0,0.8)"},
    "style_key20": {"background": "#009966", "color": "#FFFFFF"},
    "style_key21": {"background": "#023220", "color": "#FFFFFF"},
    "style_key22": {"background": "#E7E7E7", "color": "rgba(0,0,0,0.8)"},
    "style_key23": {"background": "#808080", "color": "#FFFFFF"}
}

```




## Request Example
```shell
curl 'https://openapi.guance.com/api/v1/tag/tag_xxxx32/modify' \
-H 'DF-API-KEY: <DF-API-KEY>' \
-H 'Accept: application/json, text/plain, */*' \
-H 'Accept-Language: en' \
-H 'Content-Type: application/json;charset=UTF-8' \
--data-raw '{"name":"test_15","description":"temp_test_modify","colour":"style_key3"}' \
--compressed
```




## Response
```shell
{
    "code": 200,
    "content": {
        "colour": "style_key3",
        "createAt": 1698754516,
        "creator": "acnt_xxxx32",
        "deleteAt": -1,
        "description": "temp_test_modify",
        "id": 357,
        "name": "test_15",
        "status": 0,
        "updateAt": 1698755100.0688698,
        "updator": "xxxx",
        "uuid": "tag_xxxx32",
        "workspaceUUID": "wksp_xxxx32"
    },
    "errorCode": "",
    "message": "",
    "success": true,
    "traceId": "TRACE-CF5D416A-259C-43B7-A6B0-E8F00E234ED6"
} 
```