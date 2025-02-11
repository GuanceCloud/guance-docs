# 【Workspace】Custom Workspace Binding Information

---

<br />**POST /api/v1/workspace/\{workspace_uuid\}/bind_info/set**

## Overview
Set custom binding information for the workspace



## Route Parameters

| Parameter Name        | Type     | Required | Description              |
|:------------------|:-------|:-----|:----------------|
| workspace_uuid | string | Y | Workspace UUID<br> |


## Body Request Parameters

| Parameter Name        | Type     | Required | Description              |
|:------------------|:-------|:-----|:----------------|
| name | string |  | Product Name<br>Allow empty string: True <br>Example: Guance <br> |
| companyInfo | string |  | Company Description<br>Allow empty string: True <br>Example: Guance is designed to solve observability challenges in cloud computing and cloud-native eras...... <br> |
| emailHeader | string |  | Email Header<br>Allow empty string: True <br>Example: Chinese observable platform of the cloud era, a system observable platform of the cloud era <br> |
| emailBottom | string |  | Email Footer<br>Allow empty string: True <br>Example: Chinese observable platform of the cloud era <br> |
| domain | string |  | Full domain name, excluding protocol, can include port, can be cleared by setting it as an empty string<br>Allow empty string: True <br>Example: www.baidu.com <br> |

## Additional Parameter Notes



## Response
```shell
 
```