# 添加标签

---

<br />**POST /api/v1/tag/create**

## 概述
新建标签




## Body 请求参数

| 参数名        | 类型     | 必选   | 说明              |
|:-----------|:-------|:-----|:----------------|
| name | string | Y | tag标签名<br>允许为空: False <br>最大长度: 50 <br> |
| description | string |  | tag描述<br>允许为空: False <br>最大长度: 100 <br> |
| colour | string |  | tag颜色<br>允许为空: False <br>最大长度: 50 <br> |

## 参数补充说明

数据说明

- 请求参数说明

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
curl 'https://openapi.guance.com/api/v1/tag/create' \
-H 'DF-API-KEY: <DF-API-KEY>' \
-H 'Accept: application/json, text/plain, */*' \
-H 'Accept-Language: zh' \
-H 'Content-Type: application/json;charset=UTF-8' \
--data-raw '{"name":"test_1","description":"temp_test","colour":"style_key3"}' \
--compressed
```




## 响应
```shell
{
    "code": 200,
    "content": {
        "colour": "style_key3",
        "createAt": 1698754975,
        "creator": "wsak_72b16919b18c411496b6dd06fc9ccc72",
        "deleteAt": -1,
        "description": "temp_test",
        "id": 358,
        "name": "test_1",
        "status": 0,
        "updateAt": 1698754975,
        "updator": "wsak_72b16919b18c411496b6dd06fc9ccc72",
        "uuid": "tag_769821ae7f2c435d8ffe6c510cc3d38c",
        "workspaceUUID": "wksp_ed134a6485c8484dbd0e58ce9a9c6115"
    },
    "errorCode": "",
    "message": "",
    "success": true,
    "traceId": "TRACE-DEC68DA3-9AFB-4B56-A57D-530A2B67AFED"
} 
```



