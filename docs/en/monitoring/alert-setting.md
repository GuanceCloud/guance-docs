# Alarm Strategy
---

## Overview

Guance supports the alarm policy management of the detection results of the monitor. By sending alarm notification emails or group message notifications, you can know the abnormal data monitored in time, find problems and solve problems.

Note:

- When each monitor is created, an alarm policy must be selected, and "Default" is selected by default;
- When an alarm policy is deleted, the monitor under the deleted alarm policy will be automatically classified under "Default".

## New Alarm Policy

In Guance workspace "Monitoring"-"Alarm Policy Management", click "New Alarm Policy" to add a new alarm policy. You can configure alarm objects and alarm silences for alarm policies.

![](img/monitor2.png)

1）**Name:** Name of the alert policy.

2）**Event Notification Level:** Including information, urgent, important, warning, no data, recovery, no data recovery, no data as recovery. By default, all abnormal event alarm notifications are sent. If necessary, you can customize the event notification level through the list.

- Event Level Details refer to [event level description](monitor/event-level-description.md) 

### Notification Object

3）**Alarm Notification Object:** Alarm Notification supports selecting different notification types and sending alarm notifications to multiple objects. Guance supports various notification types, including "Space Member", "Mail Group", "Nail Robot", "Enterprise WeChat Robot", "Flying Book Robot" and "Webhook Custom".

- Space members: mail notifications, by adding notification objects in "Management"-"Member Management", refer to the "Alarm Sample" in this document.
- Mail Group: Mail Notification, a mail group can add more than one space member, through the "Management"-[Notification Object Management](notify-object.md), add notification objects.
- Dingding robot, enterprise WeChat robot, flying book robot: group notification, add notification object in "Management"-[Notification Object Management](notify-object.md), add notification objects.
- Webhook customization: user-defined, add notification objects in "Management"-[Notification Object Management](notify-object.md), add notification objects.
- SMS: SMS notification, a SMS group can be added to multiple space members by adding notification objects in "Management"-「[[Notification Object Management](notify-object.md). The free version of Guance has no SMS notification, while other versions have SMS notification of 0.1 yuan/article, which is charged on a daily basis and has no free quota.

???+ attention

    - Mail, Dingding, WeChat, Feishu and SMS alarm notifications are all combined and sent every minute, not immediately after generation, and there will be a delay of about one minute;
    - The alarm notifications received by email, Dingding, WeChat and Feishu include Guance Jump Link". Click to jump directly to the corresponding Guance event details. The time range is 15 minutes ahead of the current time, that is, the event at 18:45:00. After clicking the link, jump to the event details page, and the time range is fixed at 4.20 18:30 ~ 4.20 18:45

### Alarm Silence

4）**Alarm silence:** If the same event is not very urgent, but the alarm notification frequency is high, the alarm notification frequency can be reduced by setting alarm silence.

???+ attention

    Events will continue to be generated after the alarm is silenced, but the alarm notification will not be sent again, and the generated events will be stored in the event management

## Alarm Policy List

In the "Alarm Policy" list, all alarm policies in the current workspace are saved. Support to view alarm policy name, associated monitor, alarm silence time and operation.

![](img/monitor12.png)

### Query

The alarm policy list supports searching based on the alarm policy name.

### Association Monitor
Show the number of monitors under the alarm policy. Click the number to jump to the monitor to view the monitor details under the alarm policy.

### Operation instructions

| **Operation** | **Instructions** |
| --- | --- |
| Alarm configuration | Click the button to modify the current alarm policy |
| Delete | When an alarm policy is deleted, the monitor under the deleted alarm policy will be automatically classified under Default |

## Alarm Example

### 1.Create Monitor

n "Monitoring", create a new monitor, click "+ New Monitor", and select the corresponding detection rules (such as threshold detection) to start configuring detection rules. Refer to [threshold detection](monitor/threshold-detection.md).

![](img/monitor10.png)

### 2.Configure Alarm Object

- Add an alarm object

In "Management", enter "Member Management", and click "Add Member". After successful addition, the object that can be used for alarm notification. Refer to [alarm notification object](notify-object.md).

- Configure alarm objects

In "Monitor", select the specified alarm policy for "Alarm Configuration", select relevant notification objects and alarm silence, and click "OK".

![](img/monitor3.png)

### 3.Alarm Notification

After configuring the alarm object, you can receive the alarm notification.

![](img/1-alert-1129.png)

???+ attention

    Click "Go to Guance to View" in the notification content, and you can view the details of abnormal events through Guance APP. Downloading the Guance APP can help you receive the alarm notification of events on your mobile device. For more details, please go to [mobile](../mobile/index.md).


### 4.Alarm Event

In "Monitor", click "View Related Events" to view the corresponding alarm event list in "Events". Refer to [event management](../events/explorer.md).
