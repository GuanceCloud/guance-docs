# Create a Notification Target

---

<br />**POST /api/v1/notify_object/create**

## Overview
Create a notification target



## Body Request Parameters

| Parameter Name        | Type     | Required   | Description              |
|:---------------------|:---------|:-----------|:-------------------------|
| type | string | Y | Trigger rule type, default is `trigger`<br>Can be empty: True <br>Optional values: ['dingTalkRobot', 'HTTPRequest', 'wechatRobot', 'mailGroup', 'feishuRobot', 'sms', 'simpleHTTPRequest'] <br> |
| name | string | Y | Notification target name<br>Can be empty: False <br> |
| optSet | json |  | Alert settings<br>Can be empty: False <br> |
| openPermissionSet | boolean |  | Enable custom permission configuration, (default false: not enabled), if enabled, the operation permissions for this rule are based on permissionSet<br>Can be empty: False <br> |
| permissionSet | array |  | Operation permission configuration, can configure (roles except owner, member UUID, team UUID)<br>Example: ['wsAdmin', 'acnt_xxxx', 'group_yyyy'] <br>Can be empty: False <br> |

## Additional Parameter Explanation


*Data explanation.*

**Request parameter explanation: **
| Parameter Name           | Type | Description                                                 |
| ------------------------ | ---- | ------------------------------------------------------------ |
| name       | string | Notification target name |
| type             | string | Trigger rule type                                                 |
| optSet             | dict | Alert settings                                                 |
| openPermissionSet             | boolean | Whether to enable custom permission configuration, default is false                                                 |
| permissionSet             | array | Operation permission configuration                                                 |

**1. When `type`=`dingTalkRobot`, parameters of optSet **

| Key      | Type   | Required | Description    |
| :------- | :----- | :------- | :------------- |
| webhook  | String | Required | DingTalk bot invocation URL |
| secret   | String | Required | DingTalk bot invocation secret key (add bot - security settings - sign) |


**2. When `type`=`HTTPRequest`, parameters of optSet **

| Key      | Type   | Required | Description  |
| :------- | :----- | :------- | :----------- |
| url      | String | Required | HTTP invocation URL |


**3. When `type`=`wechatRobot`, parameters of optSet **

| Key      | Type   | Required | Description  |
| :------- | :----- | :------- | :----------- |
| webhook  | String | Required | Bot invocation URL |


**4. When `type`=`mailGroup`, parameters of optSet **

| Key      | Type   | Required | Description  |
| :------- | :----- | :------- | :----------- |
| to  | Array | Required | List of member accounts |


**5. When `type`=`feishuRobot`, parameters of optSet **

| Key      | Type   | Required | Description    |
| :------- | :----- | :------- | :------------- |
| webhook  | String | Required | Lark bot invocation URL |
| secret   | String | Required | Lark bot invocation secret key (add bot - security settings - sign) |


**6. When `type`=`sms`, parameters of optSet **

| Key      | Type   | Required | Description  |
| :------- | :----- | :------- | :----------- |
| to  | Array | Required | List of phone numbers |


**7. When `type`=`simpleHTTPRequest`, parameters of optSet **

| Key      | Type   | Required | Description  |
| :------- | :----- | :------- | :----------- |
| url      | String | Required | HTTP invocation URL |

**Explanation of permissionSet and openPermissionSet fields (new fields added in iteration on 2024-06-26):**
When the notification target configuration has openPermissionSet enabled, only the space owner and members belonging to the roles, teams, or members specified in permissionSet can edit/delete.
When the notification target configuration has openPermissionSet disabled (default), delete/edit permissions follow the original interface edit/delete permissions.

The permissionSet field can be configured with role UUIDs (wsAdmin, general, readOnly, role_xxxxx), team UUIDs (group_yyyy), and member UUIDs (acnt_xxx).
Example of permissionSet field:
```
  ["wsAdmin", "general", "group_yyyy", "acnt_xxxx"]
```






## Response
```shell
 
```