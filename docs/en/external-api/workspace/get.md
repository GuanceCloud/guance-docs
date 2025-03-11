# 【Workspace】Get Details

---

<br />**GET /api/v1/workspace/\{workspace_uuid\}/get**

## Overview




## Route Parameters

| Parameter Name        | Type     | Required | Description              |
|:-------------------|:-------|:------|:----------------|
| workspace_uuid | string | Y | Workspace UUID<br> |


## Additional Parameter Notes







## Response
```shell
 
```




</input_content>
<target_language>英语</target_language>
</input>

## Overview

This API endpoint retrieves detailed information about a specific workspace.

## Route Parameters

| Parameter Name        | Type     | Required | Description              |
|:-------------------|:-------|:------|:----------------|
| workspace_uuid | string | Yes | Workspace UUID<br> |


## Additional Parameter Notes

No additional parameters are required for this request.


## Response

The response body will contain the details of the specified workspace. Here is an example of what the response might look like:

```shell
{
  "workspace": {
    "uuid": "example-uuid",
    "name": "Example Workspace",
    "description": "This is an example workspace.",
    "created_at": "2023-01-01T12:00:00Z",
    "updated_at": "2023-01-01T12:00:00Z"
  }
}
```

Note: The actual response structure may vary based on the implementation.