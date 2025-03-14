# Notification Grouping
---

## Overview

Sound notification can build a bridge with users. However, a large number of users are being bombarded with messy notifications, and useful information is drowned in unimportant push messages. Especially in the process of system development and operation and maintenance, timely alarm and response are very important, and delaying one more second of troubleshooting time will cause huge losses.

That's why Guance provides multi-channel notification grouping management, which supports you to combine notification information meaningfully and distribute it through multiple channels, thus preventing repeated notifications and inefficient alarms caused by information crossover. Meanwhile, if your application notifications can be managed in groups, it will be easier for you to configure notification objects and alarm mute.

## Precondition

You need to create a [Guance account](https://www.guance.com) and [install DataKit](../../datakit/datakit-install.md) on your host to start the related integration and collect data.

## Custom Grouping

Custom grouping can help you create meaningful notification combinations, such as purpose, notification channels and notification objects, which will help you centrally distribute and manage daily message notifications in a unified way, so that information can reach relevant people more accurately.

### Purpose

Guance supports you to build your own monitor according to your own needs, and uniformly manage the alarm notifications sent by the monitor by adding grouping labels. You can use the custom grouping label function to group notifications of the same attribute or category (such as host, application performance, user experience and SLO), so that notifications of a certain purpose or scope can only be sent to the corresponding person in charge, avoiding unnecessary information crossing and increasing the processing speed of notifications.

<!--
When customizing monitor detection rules, simply "adding grouping labels" can make monitors uniformly associated, and make monitors under the same grouping be centrally managed.

![](../img/5.inform_group_1.png)
-->
In the **Monitors** module, enter **Alarm Policy Management > Create** to configure event notification level, alarm notification members and alarm mute time for monitors under the same group.

![](../img/5.inform_group_2.png)


This allows your notification messages to be aggregated in groups and automatically calculates alerts from Guance, helping you reduce notification entries and centralize related events.
<!--
![](../img/5.inform_group_3.png)
-->

### Notification Objects and Channels


All kinds of messages are overwhelmed in the work, so grouping by notification channels can eliminate redundancy, and meet the communication needs of more scenes with the least number of notifications and richer notification methods.

Through **Monitors > Notification Target Management**, the notification objects of alarm events (including DingTalk robot, WeCom robot, Lark robot, Webhook customization, mail group and SMS group) are set, so that relevant anomaly detection notifications can be pushed to relevant responsible persons in real time.

- Mail groups: You can combine multiple workspace members into notification objects and have notifications distributed by mail;
- DingTalk robot, WeCom robot, Lark robot: You can set the work group as the notification object to realize information synchronization and task distribution in real time;
- Webhook customization: set the notification method and content by yourself to make the notification more flexible;
- SMS: Set up SMS notification to meet the needs of different scenes and different terminal devices, so that notifications have more ways to reach relevant people to ensure real-time.

![](../img/5.inform_group_4.png)

## Unified Management

Unified messaging management is to enable the same combination of notifications to be managed and distributed centrally, and Guance supports the unified configuration of mute rules and notification objects for groups to help you reduce invalid information bombardment.

### Grouping Mute

If the same event is not very urgent, but the alarm notification frequency is high, you can reduce the alarm notification frequency by setting alarm mute. Packet mute of Guance supports setting alarm mute for packets. For packets set to **Alarm Mute**, the associated monitor does not send an alarm notification within the mute time range.

In the **Monitors** function, click **Create Mute Rule** to start creating a new group mute configuration:

![](../img/5.inform_group_5.png)

### Notification Object Management

Facing more and more complex systems, the operation and maintenance support work is continuously subdivided from the initial hardware operation and maintenance. Each subdivided position needs to be responsible for maintaining and ensuring the high availability of a service. Binding the notification of a service to the relevant person in charge can make information pass point to point and increase the effectiveness of notification.

Guance supports the unified configuration of one or more notification objects for monitor groups. You can add **Workpace Member, Mail Group, DingTalk Robot, WeCom Robot, Lark Robot** and **Webhook** as notification objects to realize point-to-point information transmission.

![](../img/5.inform_group_6.png)

