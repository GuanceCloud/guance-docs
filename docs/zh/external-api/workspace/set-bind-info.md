# 【工作空间】自定义工作空间绑定信息

---

<br />**POST /api/v1/workspace/\{workspace_uuid\}/bind_info/set**

## 概述
设置工作空间自定义绑定信息




## 路由参数

| 参数名        | 类型     | 必选   | 说明              |
|:-----------|:-------|:-----|:----------------|
| workspace_uuid | string | Y | 工作空间UUID<br> |


## Body 请求参数

| 参数名        | 类型     | 必选   | 说明              |
|:-----------|:-------|:-----|:----------------|
| name | string |  | 产品名称<br>允许空字符串: True <br>例子: <<< custom_key.brand_name >>> <br> |
| companyInfo | string |  | 公司描述信息<br>允许空字符串: True <br>例子: <<< custom_key.brand_name >>>是一款旨在解决云计算，以及云原生时代...... <br> |
| emailHeader | string |  | 邮件头部<br>允许空字符串: True <br>例子: 云时代的系统可观测平台中文云时代的系统可观测平台 <br> |
| emailBottom | string |  | 邮件尾部<br>允许空字符串: True <br>例子: 云时代的系统可观测平台中文云时代 <br> |
| domain | string |  | 完整的域名,不包含协议，可包含端口,可设置为空字符串的方式清空域名<br>允许空字符串: True <br>例子: www.baidu.com <br> |

## 参数补充说明







## 响应
```shell
 
```




