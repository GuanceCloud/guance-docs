# Change the Owner of a Specified Workspace (The old owner's account will be directly removed from the current workspace)

---

<br />**POST /api/v1/workspace/\{workspace_uuid\}/owner/transfer**

## Overview




## Route Parameters

| Parameter Name        | Type     | Required   | Description              |
|:-------------------|:-------|:---------|:----------------|
| workspace_uuid | string | Y | Workspace UUID<br> |


## Body Request Parameters

| Parameter Name        | Type     | Required   | Description              |
|:-------------------|:-------|:---------|:----------------|
| accountUUID | string | Y | Account UUID, transfer the owner role to this account<br>Example: acnt_xxx <br>Allow null: True <br>Allow empty string: False <br> |

## Additional Parameter Notes







## Response
```shell
 
```




</input_content>