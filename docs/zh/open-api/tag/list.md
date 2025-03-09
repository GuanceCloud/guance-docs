# 获取全局标签列表

---

<br />**GET /api/v1/tag/list**

## 概述
获取全局标签列表




## Query 请求参数

| 参数名        | 类型     | 必选   | 说明              |
|:-----------|:-------|:-----|:----------------|
| search | string |  | tag名称搜索<br>允许为空: False <br> |
| filter | string |  | 过滤条件<br>允许为空: False <br>可选值: ['BoardRefTagObject', 'ViewerRefTagObject', 'CheckerRefTagObject', 'DialingRefTagObject'] <br> |
| pageIndex | integer |  | 页码<br>允许为空: False <br>例子: 10 <br>$minValue: 1 <br> |
| pageSize | integer |  | 每页返回数量<br>允许为空: False <br>例子: 10 <br>$minValue: 1 <br>$maxValue: 10000 <br> |

## 参数补充说明

数据说明

- 请求参数说明

| 参数名           | type | 说明                                                 |
| ---------------- | ---- | ---------------------------------------------------- |
| filter       | string | 枚举值(仪表板关联的标签: BoardRefTagObject, 查看器关联的标签: ViewerRefTagObject, 监控器关联的标签: CheckerRefTagObject)|

------

- 响应参数说明

| 参数名           | type | 说明                                                 |
| ---------------- | ---- | ---------------------------------------------------- |
| name       | string | 标签名称 |
| description             | string | 字段描述信息                                                 |
| color    | string | 前后端约定的颜色类型, default,style_key1,style_key2 ~~                |

- 颜色 color 字段 类型颜色对照:
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




## 请求例子
```shell
curl 'https://openapi.<<< custom_key.brand_main_domain >>>/api/v1/tag/list?pageIndex=1&pageSize=2' \
-H 'DF-API-KEY: <DF-API-KEY>' \
--compressed
```




## 响应
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




