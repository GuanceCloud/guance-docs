# Create a Notification Target

---

<br />**POST /api/v1/notify_object/create**

## Overview
Create a notification target




## Body Request Parameters

| Parameter Name        | Type     | Required   | Description              |
|:-------------------|:-------|:-----|:----------------|
| type | string | Y | Trigger rule type, default is `trigger`<br>Can be empty: True <br>Optional values: ['dingTalkRobot', 'HTTPRequest', 'wechatRobot', 'mailGroup', 'feishuRobot', 'sms', 'simpleHTTPRequest', 'slackIncomingWebhook'] <br> |
| name | string | Y | Notification target name<br>Can be empty: False <br> |
| optSet | json |  | Alert settings<br>Can be empty: False <br> |
| openPermissionSet | boolean |  | Enable custom permission configuration, (default false: not enabled), if enabled, the operation permissions for this rule will follow permissionSet<br>Can be empty: False <br> |
| permissionSet | array |  | Operation permission configuration, can configure (roles(except owner), member UUID, team UUID)<br>Example: ['wsAdmin', 'acnt_xxxx', 'group_yyyy'] <br>Can be empty: False <br> |

## Additional Parameter Notes


*Data Notes.*

**Request Parameter Explanation: **
| Parameter Name           | type | Description                                                 |
| ---------------- | ---- | ---------------------------------------------------- |
| name       | string | Notification target name |
| type             | string | Trigger rule type                                                 |
| optSet             | dict | Alert settings                                                 |
| openPermissionSet             | boolean | Whether to enable custom permission configuration, default false                                                 |
| permissionSet             | array | Operation permission configuration                                                 |

**1. When `type`=`dingTalkRobot`, parameters for optSet **

| key      | Type   | Required | Description    |
| :------- | :----- | :------- | :------------------ |
| webhook  | String | Required    | DingTalk bot invocation address |
| secret   | String | Required    | DingTalk bot invocation secret key (add bot - security settings - sign) |


**2. When `type`=`HTTPRequest`, parameters for optSet **

| key      | Type   | Required | Description  |
| :------- | :----- | :------- | :----------- |
| url      | String | Required | HTTP invocation address |


**3. When `type`=`wechatRobot`, parameters for optSet **

| key      | Type   | Required | Description  |
| :------- | :----- | :------- | :----------- |
| webhook  | String | Required    | Bot invocation address |

**4. When `type`=`mailGroup`, parameters for optSet **

| key      | Type   | Required | Description  |
| :------- | :----- | :------- | :----------- |
| to  | Array | Required    | Member account list |

**5. When `type`=`feishuRobot`, parameters for optSet **

| key      | Type   | Required | Description    |
| :------- | :----- | :------- | :------------------ |
| webhook  | String | Required    | Lark bot invocation address |
| secret   | String | Required    | Lark bot invocation secret key (add bot - security settings - sign) |

**6. When `type`=`sms`, parameters for optSet **

 | key      | Type   | Required | Description  |
 | :------- | :----- | :------- | :----------- |
 | to  | Array | Required    | Phone number list |

**7. When `type`=`simpleHTTPRequest`, parameters for optSet **

| key      | Type   | Required | Description  |
| :------- | :----- | :------- | :----------- |
| url      | String | Required | HTTP invocation address |

**8. When `type`=`slackIncomingWebhook`, parameters for optSet **

| key      | Type   | Required | Description  |
| :------- | :----- | :------- | :----------- |
| webhook  | String | Required    | Bot invocation address |

**Explanation of permissionSet and openPermissionSet fields (new fields added in iteration on June 26, 2024): **
If the notification target configuration has openPermissionSet enabled, only space owners and those in the roles, teams, or members configured in permissionSet can edit/delete.
If the notification target configuration has openPermissionSet disabled (default), then delete/edit permissions will follow the original interface edit/delete permissions.

The permissionSet field can be configured with role UUIDs (wsAdmin, general, readOnly, role_xxxxx), team UUIDs (group_yyyy), and member UUIDs (acnt_xxx).
Example of permissionSet field:
```
  ["wsAdmin", "general", "group_yyyy", "acnt_xxxx"]

```






## Response
```shell
 
```