# 分片上传事件初始化

---

<br />**POST /api/v1/rum_sourcemap/multipart_upload_init**

## 概述




## Body 请求参数

| 参数名        | 类型     | 必选   | 说明              |
|:-----------|:-------|:-----|:----------------|
| needCover | boolean |  | 是否强制覆盖已存在的文件, 默认为 false，即不覆盖<br>允许为空: False <br> |
| appId | string | Y | appId<br>允许为空: False <br> |
| version | string |  | 版本<br>允许为空: False <br>允许空字符串: True <br> |
| env | string |  | 环境<br>允许为空: False <br>允许空字符串: True <br> |

## 参数补充说明

注：同一个应用下只能存在一个相同 `version`、`env` 的 sourcemap，您可以通过 `needCover` 参数覆盖已存在的 sourcemap。
如果不覆盖，返回 `uploadId` 为空字符串






## 响应
```shell
 
```




