# Modify a Notification Target

---

<br />**POST /api/v1/notify_object/modify**

## Overview
Modify the information of a specified notification target


## Body Request Parameters

| Parameter Name        | Type     | Required | Description              |
|:---------------------|:---------|:---------|:-------------------------|
| notifyObjectUUID     | string   | Y        | Notification target UUID<br>Can be empty: False <br> |
| name                 | string   |          | Notification target name<br>Can be empty: False <br> |
| optSet               | json     |          | Notification settings<br>Can be empty: False <br> |
| openPermissionSet    | boolean  |          | Enable custom permission configuration, (default false: not enabled), after enabling, operation permissions for this rule are based on permissionSet<br>Can be empty: False <br> |
| permissionSet        | array    |          | Operation permission configuration, can configure (role (except owner), member UUID, team UUID)<br>Example: ['wsAdmin', 'acnt_xxxx', 'group_yyyy'] <br>Can be empty: False <br> |

## Additional Parameter Notes



## Response
```shell
 
```