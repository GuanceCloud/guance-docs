# 【Workspace API Key】Create

---

<br />**POST /api/v1/workspace/accesskey/add**

## Overview




## Body Request Parameters

| Parameter Name        | Type     | Required   | Description              |
|:-------------------|:-------|:-----|:----------------|
| name | string | Y | API Key name information<br>Example: xxx <br>Allow empty: False <br>Maximum length: 256 <br> |
| roleUUIDs | array |  | Specifies the role lists for the API key (excluding owner)<br>Allow empty: False <br> |
| workspaceUUID | string | Y | Specifies the workspace UUID<br>Example: wksp_xxxxx <br>Allow empty: False <br> |

## Additional Parameter Notes







## Response
```shell
 
```




</input_content>