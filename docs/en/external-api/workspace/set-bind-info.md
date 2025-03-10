# [Workspace] Custom Workspace Binding Information

---

<br />**POST /api/v1/workspace/\{workspace_uuid\}/bind_info/set**

## Overview
Set custom binding information for the workspace



## Route Parameters

| Parameter Name        | Type     | Required | Description              |
|:-------------------|:-------|:-----|:----------------|
| workspace_uuid | string | Y | Workspace UUID<br> |


## Body Request Parameters

| Parameter Name        | Type     | Required | Description              |
|:-------------------|:-------|:-----|:----------------|
| name | string |  | Product name<br>Allow empty string: True <br>Example: <<< custom_key.brand_name >>> <br> |
| companyInfo | string |  | Company description<br>Allow empty string: True <br>Example: <<< custom_key.brand_name >>> is a platform designed to address cloud computing and cloud-native era...... <br> |
| emailHeader | string |  | Email header<br>Allow empty string: True <br>Example: Cloud era system observability platform in Chinese cloud era system observability platform <br> |
| emailBottom | string |  | Email footer<br>Allow empty string: True <br>Example: Cloud era system observability platform in Chinese cloud era <br> |
| domain | string |  | Complete domain, excluding protocol, including port if applicable, can be cleared by setting an empty string<br>Allow empty string: True <br>Example: www.baidu.com <br> |

## Additional Parameter Notes



## Response
```shell
 
```