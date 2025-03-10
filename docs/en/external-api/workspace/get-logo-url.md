# 【Workspace】Get Workspace Image Resources

---

<br />**POST /api/v1/workspace/{workspace_uuid}/get_logo_url**

## Overview
Modify the information of the workspace associated with the current API Key



## Route Parameters

| Parameter Name        | Type     | Required   | Description              |
|:-------------------|:-------|:-----|:----------------|
| workspace_uuid | string | Y | Workspace UUID<br> |


## Query Request Parameters

| Parameter Name        | Type     | Required   | Description              |
|:-------------------|:-------|:-----|:----------------|
| filename | string |  | Filename<br>Example: logo.png <br>Optional values: ['logo.png', 'favicon.ico'] <br> |
| language | string |  | Language<br>Example: zh <br>Optional values: ['zh', 'en'] <br> |

## Additional Parameter Notes



## Response
```shell
 
```