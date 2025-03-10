# Set Custom Binding Information for Workspace

---

<br />**POST /api/v1/workspace/bind_info/set**

## Overview
Set custom binding information for the workspace



## Body Request Parameters

| Parameter Name        | Type     | Required   | Description              |
|:------------------|:-------|:-----|:----------------|
| name | string | No  | Product name<br>Can be an empty string: True <br>Example: <<< custom_key.brand_name >>> <br> |
| companyInfo | string | No  | Company description<br>Can be an empty string: True <br>Example: <<< custom_key.brand_name >>> is designed to solve issues in cloud computing and cloud-native era...... <br> |
| emailHeader | string | No  | Email header<br>Can be an empty string: True <br>Example: System observability platform of the cloud era in Chinese cloud era system observability platform <br> |
| emailBottom | string | No  | Email footer<br>Can be an empty string: True <br>Example: System observability platform of the cloud era in Chinese cloud era <br> |
| domain | string | No  | Full domain name, excluding protocol, including port if applicable, can be set to an empty string to clear the domain<br>Can be an empty string: True <br>Example: www.baidu.com <br> |

## Additional Parameter Notes



## Response
```shell
 
```