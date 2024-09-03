# 【工作空间】获取空间图片相关资源

---

<br />**POST /api/v1/workspace/\{workspace_uuid\}/get_logo_url**

## 概述
修改当前API Key所属的工作空间信息




## 路由参数

| 参数名        | 类型     | 必选   | 说明              |
|:-----------|:-------|:-----|:----------------|
| workspace_uuid | string | Y | 工作空间UUID<br> |


## Query 请求参数

| 参数名        | 类型     | 必选   | 说明              |
|:-----------|:-------|:-----|:----------------|
| filename | string |  | 文件名<br>例子: logo.png <br>可选值: ['logo.png', 'favicon.ico'] <br> |
| language | string |  | 语言<br>例子: zh <br>可选值: ['zh', 'en'] <br> |

## 参数补充说明







## 响应
```shell
 
```




