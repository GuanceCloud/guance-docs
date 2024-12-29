# 上传单个文件内容

---

<br />**POST /api/v1/rum_sourcemap/upload_file_content**

## 概述
用于上传单个 sourcemap 源文件内容（SourceMap 解压后的单个源文件）




## Body 请求参数

| 参数名        | 类型     | 必选   | 说明              |
|:-----------|:-------|:-----|:----------------|
| appId | string | Y | appId<br>允许为空: False <br> |
| version | string |  | 版本<br>允许为空: False <br>允许为空字符串: True <br> |
| env | string |  | 环境<br>允许为空: False <br>允许为空字符串: True <br> |
| filename | string | Y | 包含完整相对路径的文件名<br>允许为空: False <br>允许为空字符串: True <br> |
| content | string |  | 文件内容<br>允许为空: False <br>允许为空字符串: True <br> |

## 参数补充说明

注：同一个应用下只能存在一个相同 `version`、`env` 的 sourcemap。上传的文件内容直接覆盖目标文件






## 响应
```shell
 
```




