# 【Modify Management Backend Account】

---

<br />**POST /api/v1/super-account/\{account_uuid\}/modify**

## Overview




## Route Parameters

| Parameter Name        | Type     | Required   | Description              |
|:-------------------|:-------|:-----|:----------------|
| account_uuid | string | Y | UUID of the account<br> |


## Body Request Parameters

| Parameter Name        | Type     | Required   | Description              |
|:-------------------|:-------|:-----|:----------------|
| username | string |  | Login account<br>Example: supper_man@zhuyun.com <br>Allow null: False <br> |
| password | string |  | Login password<br>Example: I am password <br>Allow null: False <br> |
| email | None |  | Email address<br>Example: supper_man@zhuyun.com <br>Allow null: False <br>$isEmail: True <br> |
| name | string |  | Username<br>Example: supper_man <br>Allow null: False <br> |
| role | string |  | Login role (admin/dev)<br>Example: admin <br>Allow null: False <br> |
| mobile | string |  | Phone number<br>Allow null: False <br> |
| exterId | string |  | External ID - This parameter is uncertain and may be removed<br>Allow null: False <br> |
| extend | json |  | Additional information<br>Allow null: False <br> |

## Additional Parameter Notes







## Response
```shell
 
```