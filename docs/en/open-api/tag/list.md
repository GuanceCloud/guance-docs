# Get Global Tag List

---

<br />**GET /api/v1/tag/list**

## Overview
Get the global tag list


## Query Request Parameters

| Parameter Name        | Type     | Required   | Description              |
|:-------------------|:-------|:-----|:----------------|
| search | string | No  | Search tag name<br>Can be empty: False <br> |
| filter | string | No  | Filter condition<br>Can be empty: False <br>Optional values: ['BoardRefTagObject', 'ViewerRefTagObject', 'CheckerRefTagObject', 'DialingRefTagObject'] <br> |
| pageIndex | integer | Yes  | Page number<br>Can be empty: False <br>Example: 10 <br>$minValue: 1 <br> |
| pageSize | integer | Yes  | Number of items per page<br>Can be empty: False <br>Example: 10 <br>$minValue: 1 <br>$maxValue: 10000 <br> |

## Additional Parameter Explanation

Data description

- Request parameter explanation

| Parameter Name           | Type | Description                                                 |
| ---------------- | ---- | ---------------------------------------------------- |
| filter       | string | Enum values (Dashboard associated tags: BoardRefTagObject, Viewer associated tags: ViewerRefTagObject, Checker associated tags: CheckerRefTagObject)|

------

- Response parameter explanation

| Parameter Name           | Type | Description                                                 |
| ---------------- | ---- | ---------------------------------------------------- |
| name       | string | Tag name |
| description             | string | Field description information                                                 |
| color    | string | Front-end and back-end agreed color type, default, style_key1, style_key2 ~~                |

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
curl 'https://openapi.<<< custom_key.brand_main_domain >>>/api/v1/tag/list?pageIndex=1&pageSize=2' \
-H 'DF-API-KEY: <DF-API-KEY>' \
--compressed
```




## Response
```shell
{
    "code": 200,
    "content": [
        {
            "colour": "style_key3",
            "description": "temp_test",
            "id": "tag_xxxx32",
            "name": "test_ha"
        },
        {
            "colour": "default",
            "description": "",
            "id": "tag_xxxx32",
            "name": "ssssooooo"
        }
    ],
    "errorCode": "",
    "message": "",
    "pageInfo": {
        "count": 2,
        "pageIndex": 1,
        "pageSize": 2,
        "totalCount": 101
    },
    "success": true,
    "traceId": "TRACE-F2F9D0F5-FEF4-4C37-AB9E-B901CD0E5931"
} 
```