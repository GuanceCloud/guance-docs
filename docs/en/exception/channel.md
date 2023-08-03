# Manage Issue
---

## Overview

After [the Issue is created](./issue.md), in order to present the specific information of Issue to users more intuitively, The feature, Incidents, further manage all Issue generated in the current workspace through **Channels**.

Based on channels, you can customize the range of Issue that you want to pay attention to for subscription, view subscription members or notification objects, use time controls, or reply to Issue in a variety of ways to achieve member collaboration. This article will introduce **how to manage Issue and related operation and configuration at the channel level**.

## Channel List

Enter **Incidents > Channel**, each workspace has the channel **All** by default, and all Issues will be displayed in that channel. You can also customize new channels.

![](img/channel-all.png)

### Create Channel

On the function page **Incidents**, click **Add Channel** at the bottom of the channel list and enter the channel name.

<img src="../img/exception-1.png" width="90%" >

You can also create new channels in the following situations:

- When [replying to Issue](#reply-issue), enter `#` in the reply content and click **Add** to create a new channel;

- Go to **Monitors** page, one of [entries creating Issue](./issue.md#others). In **Event Notice > Channel**. Click **Create Channel** as you need.

## Channel Management

When the channel is created, the channel can be managed as needed. On the right side of the channel list, you can make a series of configurations such as subscription, notification object, filter & search, etc. At the same time, all Issue associated with the current channel will be listed one by one.

### Subscribe to a Channel

At the top left of the Issue list, click :material-bookmark-plus-outline: , and you can select the subscription function on demand.

- Undertake: After subscription, the current channel will receive corresponding notifications whether it posts new events or replies to existing events.

- Participate: After subscription, the current channel will receive notifications if new events are posted.

- Concern: After subscription, you will receive a summary notification of the current channel every morning at 9:00 a.m.

- Nothing: Unsubscribe.


### View Subscription Members

At the top left of the Issue list, click :octicons-people-24: to expand the display page. You can search by entering the name or mailbox of a member in the current workspace to see the subscription role that member is.

<img src="../img/exception-4.png" width="50%" >

### View Notification Objects / Settings

At the top left of the Issue list, click :material-bell: or click **Settings** to expand the display page. You can:

- View and modify the channel name;

- Add channel description to describe the background of current channel creation and the scope of abnormal problem handling;

- Add or delete notification objects; Click **Notification Objects** to view all members in the current workspace. Select a member to add it as a notification object. After selection, the corresponding notification object will receive the delivered new Issue and Issue processing daily notification. Select again to cancel;

- Delete or exit a channel: The channel creator and workspace owner can delete the current channel.

**Note:** The default channel name cannot be changed; and it cannot be deleted and can only exit.

<img src="../img/exception-5.png" width="50%" >

### Time Range Filtering {#time}

By default, all Issues are listed automatically, and you can add time ranges for further filtering.

When the date interval is selected, all audit events in the period are listed according to the selected time range. The default start time is `00:00:00` and the default end time is `23:59:59`.

- After selecting the time range, click **Select Time** to customize the time range;    
- Click **Clear** to empty the time filter.


![](img/exception-2.png)

### Filter & Search

In the Filter and Search field at the top left of the Issue list, enter the corresponding Filter & Search criteria to accurately locate your target Issue.

- Filter criteria: Source, Level, Status, Creator, Updater;

- Search criteria: Issue Title, Issue Description.

> See [Search Instructions](../getting-started/function-details/explorer-search.md#search) for more information.

### Issue Details Page

Click on an Issue in the channel to open its details page, where you can view the [status, level, source, description and attachment](./issue.md#concepts) of the Issue;

You can also change the information here on the details page, see [Permission List](../management/role-list.md).

<img src="../img/exception-6.png" width="70%" >

### Reply to Issue {#reply-issue}

There are two general conditions why Issue has a reply record:

I. A member creates an Issue for the first time or changes the relevant information of Issue status, level and description;

II. Enter the reply manually. In this case, you can refer to the following instructions:

i. If you need to @ `member` in the reply and the `member` name exists, the notification will be triggered automatically; If the `member` name does not exist, the notification will not be triggered;

<img src="../img/exception-7.png" width="70%" >

ii. If you enter `#` in the reply, there are two possible scenarios:

- The channel already exists: Once your reply is created successfully, the Issue will be posted to the corresponding channel for display;

- The channel does not exist: you can choose **Add** in the pop-up window to create a new channel;

<img src="../img/channel-reply.png" width="70%" >

iii. You can add links to your replies or upload pictures, videos, text (CSV/TXT/JSON/PDF, etc.).

#### Modify and Delete Reply

Click the **Edit** and **Delete** button on the right side of the reply.

**Note:** Only the reply creator supports modifying the reply.





