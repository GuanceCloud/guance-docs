# Manage Issues
---


After **[Issue Creation Completion](./issue.md)**, to more intuitively present specific Issue information to users, **Incident** further manages all Issues generated within the current workspace through **Channels**.

Based on channels, you can customize the scope of Issues you want to subscribe to, view subscribed members or notification targets, use time widgets, or collaborate through multiple methods such as replying to Issues. This article will introduce <u>how to manage Issues and related operations and configurations at the channel level</u>.

## Channel List

Enter **Incident > Channel**, each workspace defaults to having an **All** channel, where all Issues are displayed within this channel. You can also create a custom channel.


### Create Channel {#create}

Enter **Incident**, below the channel list on the left side of the current page, click **Add Channel**, enter the channel name, and it is added upon completion.

<img src="../img/exception-1.png" width="80%" >

You can also create a new channel in the following paths:

- When [Replying to Issues](#reply-issue), input `#` in the reply content, and select **Add** in the popup window to create a new channel;

- In [Issue's New Entry](./issue.md#others) > Monitoring > Event Notifications > Channel, click the channel dropdown box to create a new channel as needed.

#### Channel List {#list}

- For all created channels, hover over the right side of the channel to choose whether to pin the channel.

<img src="../img/top_channel.png" width="50%" >

- Click multi-select to batch display Issues from multiple channels.

<img src="../img/batch_channel.png" width="50%" >

- Select "Only Show Mine", to view and manage all incident tracking under the current workspace that is personally responsible for.

<img src="../img/own_channel.png" width="60%" >

> If you need to uniformly manage incidents personally responsible for, go to [Personal Center > Incident Tracking Management](../management/index.md#personal_incidents) for viewing.

## Channel Management {#manag}

After creating a channel, you can configure subscriptions, notification targets, filtering, and searching on the right side of the channel list. All Issues under the current channel will be listed, and clicking on a specific Issue opens its detail page.

### Basic Information

You can view or modify the current channel name, add a description for the current channel, detailing the background of its creation and the scope of abnormal problem handling, etc.

**Note**: The default channel name cannot be changed; and the default channel cannot be deleted, only exited.

### Upgrade Channel Notifications {#upgrade}

In the upper left corner of the Issue list, click the icon :material-bell:, or click **Settings**, to expand the display page.

- You can directly select [Notification Strategies](./config-manag.md#reate);

- Select notification targets; click the dropdown box and select a specific notification target to receive updates on Issues in the current channel;

- Upgrade Configuration: Set up so that if a new Issue exceeds a certain number of minutes without assigning a responsible person, an upgrade notification is sent to the corresponding notification target.


<img src="../img/exception-5.png" width="50%" >


### Subscribe to Channels

In the upper left corner of the Issue list, click the icon :material-bookmark-plus-outline:, and you can choose subscription functions as needed.

1. Responsible: After subscribing, you will receive notifications for new Issues, replies to existing Issues, and daily Issue summaries;

2. Participate: After subscribing, you will receive notifications for new Issues;

3. Follow: After subscribing, you will receive a daily Issue summary notification at 9:00 AM;

4. None: Cancel subscription.



### Time Range Filtering {#time}

By default, all Issues are automatically listed, and you can add a time range for further filtering.

After selecting a date range, all audit events within the selected time range will be listed. Default start time `00:00:00`, default end time `23:59:59`.

- After selecting the time range, click **Select Time** to customize the time range;
- Click **Clear** to remove the time filter condition.

<img src="../img/exception-2.png" width="50%" >

### Filter & Search

In the filter and search bar above the Issue list on the left, input the corresponding filter & search conditions to accurately locate your target Issue.

- Filter Conditions: Source, Level, Status, Creator, Updater

- Search Conditions: Issue Title, Issue Description

> For more information about search methods, refer to [Search Instructions](../getting-started/function-details/explorer-search.md#search).

### Issue Correlation Analysis

If the current Issue is already associated with some events, the Icon will be displayed along with the corresponding quantity. Click to jump to the event viewer to display statistics for all related events: including all associated events (whether triggered by incident tracking or subsequently appended in comments).

### Issue Detail Page

Clicking on an Issue within a channel opens its detail page, where you can view the [status, level, source, description, attachments](./issue.md#concepts) of that Issue;

> You can also change the information here. Refer to [Permission List](../management/role-list.md).

<img src="../img/exception-6.png" width="70%" >

### Reply to Issue {#reply-issue}

An Issue typically has a reply record due to two scenarios:

1. A member initially creates an Issue or changes the status, level, or description-related information of the Issue;

2. Manual input of replies. For this case, please refer to the following instructions:

1) If you need to mention a `member` in your reply, and the `member` exists, it will automatically trigger a notification; if the `member` does not exist, no notification will be triggered;


2) If you input `#` in the reply content, there may be two scenarios:

- The channel already exists: once your reply is successfully created, the Issue will be delivered to the corresponding channel for display;

- The channel does not exist: you can select **Add** in the popup window to create a new channel;


3) You can add links or upload images, videos, texts (CSV/TXT/JSON/PDF, etc.) in your reply.

#### Modify, Delete Replies

Click the edit and delete buttons to the right of the **Reply** to **Edit** or **Delete** that particular reply.

**Note**: Only the creator of the reply supports modifying the reply.