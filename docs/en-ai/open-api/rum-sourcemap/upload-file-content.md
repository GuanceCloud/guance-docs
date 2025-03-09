# Upload Single File Content

---

<br />**POST /api/v1/rum_sourcemap/upload_file_content**

## Overview
Used to upload the content of a single sourcemap source file (a single source file after SourceMap decompression)


## Body Request Parameters

| Parameter Name | Type   | Required | Description                                |
|:--------------|:-------|:--------|:------------------------------------------|
| appId         | string | Y       | appId<br>Can be empty: False <br>         |
| version       | string |         | Version<br>Can be empty: False <br>Can be an empty string: True <br> |
| env           | string |         | Environment<br>Can be empty: False <br>Can be an empty string: True <br> |
| filename      | string | Y       | Filename including full relative path<br>Can be empty: False <br>Can be an empty string: True <br> |
| content       | string |         | File content<br>Can be empty: False <br>Can be an empty string: True <br> |

## Additional Parameter Notes

Note: Under the same application, only one sourcemap with the same `version` and `env` can exist. The uploaded file content will directly overwrite the target file.


## Response
```shell
 
```