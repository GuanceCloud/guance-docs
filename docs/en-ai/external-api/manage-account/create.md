# [Management Backend Account] Creation

---

<br />**POST /api/v1/super-account/create**

## Overview



## Body Request Parameters

| Parameter Name | Type   | Required | Description                                                                 |
|:--------------|:-------|:---------|:-----------------------------------------------------------------------------|
| username      | string | Y        | Login account<br>Example: supper_man@zhuyun.com <br>Allow empty: False       |
| password      | string | Y        | Login password<br>Example: I am password <br>Allow empty: False              |
| email         | None   |          | Email address<br>Example: supper_man@zhuyun.com <br>Allow empty: False <br>$isEmail: True |
| name          | string |          | Nickname<br>Example: supper_man <br>Allow empty: False                       |
| role          | string | Y        | Login role (admin/dev)<br>Example: admin <br>Allow empty: False              |
| mobile        | string |          | Phone number<br>Allow empty: False                                           |
| extend        | json   |          | Additional information<br>Allow empty: False                                 |
| isDisable     | boolean|          | Whether disabled<br>Example: True <br>Allow empty: False <br>Possible values: [True, False] |

## Additional Parameter Notes



## Response
```shell
 
```


Please note that the original text contains some inconsistencies in terms of required fields and data types. For instance, "email" is marked as not allowing empty values but has no "Required" designation, and "extend" is listed as a JSON type without further details. Adjustments may be necessary based on actual API specifications.