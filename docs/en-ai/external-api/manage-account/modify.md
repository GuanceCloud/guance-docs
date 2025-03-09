# Modify 【Super Account】

---

<br />**POST /api/v1/super-account/{account_uuid}/modify**

## Overview




## Route Parameters

| Parameter Name        | Type     | Required   | Description              |
|:-------------------|:-------|:-----|:----------------|
| account_uuid | string | Y | UUID of the account<br> |


## Body Request Parameters

| Parameter Name        | Type     | Required   | Description              |
|:-------------------|:-------|:-----|:----------------|
| username | string |  | Login account<br>Example: supper_man@zhuyun.com <br>Can be empty: False <br> |
| password | string |  | Login password<br>Example: I am password <br>Can be empty: False <br> |
| email | None |  | Email address<br>Example: supper_man@zhuyun.com <br>Can be empty: False <br>$isEmail: True <br> |
| name | string |  | Username<br>Example: supper_man <br>Can be empty: False <br> |
| role | string |  | Login role (admin/dev)<br>Example: admin <br>Can be empty: False <br> |
| mobile | string |  | Phone number<br>Can be empty: False <br> |
| exterId | string |  | External ID - This parameter is undefined and may be removed<br>Can be empty: False <br> |
| extend | json |  | Additional information<br>Can be empty: False <br> |

## Additional Parameter Notes







## Response
```shell
 
```