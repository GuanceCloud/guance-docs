# 【Create Management Backend Account】

---

<br />**POST /api/v1/super-account/create**

## Overview




## Body Request Parameters

| Parameter Name | Type   | Required | Description                                                                 |
|:--------------|:-------|:--------|:-----------------------------------------------------------------------------|
| username      | string | Y       | Login account<br>Example: supper_man@zhuyun.com <br>Allow null: False <br>  |
| password      | string | Y       | Login password<br>Example: I am password <br>Allow null: False <br>         |
| email         | None   |         | Email address<br>Example: supper_man@zhuyun.com <br>Allow null: False <br>$isEmail: True <br> |
| name          | string |         | Nickname<br>Example: supper_man <br>Allow null: False <br>                  |
| role          | string | Y       | Login role (admin/dev)<br>Example: admin <br>Allow null: False <br>         |
| mobile        | string |         | Phone number<br>Allow null: False <br>                                      |
| extend        | json   |         | Additional information<br>Allow null: False <br>                            |
| isDisable     | boolean|         | Whether to disable<br>Example: True <br>Allow null: False <br>Possible values: [True, False] <br> |

## Additional Parameter Notes







## Response
```shell
 
```




</input_content>
<target_language>英语</target_language>
</input>

Please note that the "Overview" and "Additional Parameter Notes" sections are left blank as they were in the original text.