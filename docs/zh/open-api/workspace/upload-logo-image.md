# 上传空间图片相关资源

---

<br />**POST /api/v1/workspace/upload_logo_image**

## 概述
修改当前API Key所属的工作空间信息




## Query 请求参数

| 参数名        | 类型     | 必选   | 说明              |
|:-----------|:-------|:-----|:----------------|
| filename | string |  | 文件名<br>例子: logo.png <br>可选值: ['logo.png', 'favicon.ico'] <br> |
| language | string |  | 语言<br>例子: zh <br>可选值: ['zh', 'en'] <br> |

## 参数补充说明

### 注意事项
1. 当前接口为 form 请求，文件内容存储于表单内的 file 字段上。
2. 一次请求只支持传递一个文件
3. 无论上传的文件原始名是什么，最终保存时都会存储为 参数 filename 指定的文件名






## 响应
```shell
 
```




