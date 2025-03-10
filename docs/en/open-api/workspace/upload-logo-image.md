# Upload Workspace Logo Image

---

<br />**POST /api/v1/workspace/upload_logo_image**

## Overview
Modify the workspace information associated with the current API Key.

## Query Request Parameters

| Parameter Name | Type   | Required | Description              |
|:-----------|:-------|:-----|:----------------|
| filename | string | No  | Filename<br>Example: logo.png <br>Possible values: ['logo.png', 'favicon.ico'] <br> |
| language | string | No  | Language<br>Example: zh <br>Possible values: ['zh', 'en'] <br> |

## Additional Parameter Notes

### Precautions
1. This interface is a form request, and the file content is stored in the file field of the form.
2. Only one file can be passed per request.
3. Regardless of the original name of the uploaded file, it will be saved with the filename specified by the parameter filename.

## Response
```shell
 
```