# 【Workspace】Upload Workspace Image Resources

---

<br />**POST /api/v1/workspace/\{workspace_uuid\}/upload_logo_image**

## Overview
Modify the workspace information associated with the current API Key



## Route Parameters

| Parameter Name        | Type     | Required   | Description              |
|:-------------------|:-------|:-----|:----------------|
| workspace_uuid | string | Y | Workspace UUID<br> |


## Query Request Parameters

| Parameter Name        | Type     | Required   | Description              |
|:-------------------|:-------|:-----|:----------------|
| filename | string |  | Filename<br>Example: logo.png <br>Possible values: ['logo.png', 'favicon.ico'] <br> |
| language | string |  | Language<br>Example: zh <br>Possible values: ['zh', 'en'] <br> |

## Additional Parameter Notes

### Precautions
1. This interface is a form request, and file content is stored in the file field within the form.
2. Only one file can be passed per request.
3. Regardless of the original name of the uploaded file, it will be saved with the filename specified by the filename parameter.



## Response
```shell
 
```